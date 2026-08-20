import Foundation

/*
 Q03 — LC217 Contains Duplicate                            [Easy]

 Given an integer array nums, return true if any value appears at
 least twice in the array, and return false if every element is
 distinct.

 Example 1:  nums = [1,2,3,1]              -> true
             The element 1 occurs at indices 0 and 3.

 Example 2:  nums = [1,2,3,4]              -> false
             All elements are distinct.

 Example 3:  nums = [1,1,1,3,3,4,3,2,4,2]  -> true

 Constraints:
   1 <= nums.length <= 10^5
   -10^9 <= nums[i] <= 10^9
*/

let nums1 = [1, 2, 3, 1]
let nums2 = [1, 1, 1, 3, 3, 4, 3, 2, 4, 2]
let nums3 = [1, 2, 3, 4]
let nums4 = [1, 2, 2]

//============================================================
// MARK: - Brute Force
// Time : O(n²)
// Space: O(1)
//
// Compare every pair. TLE at n = 10^5 (10^10 operations) —
// state it in an interview, do not submit it.
//============================================================

func containsDuplicateBruteForce(_ nums: [Int]) -> Bool {
    for i in 0..<nums.count {
        for j in (i + 1)..<nums.count {
            if nums[i] == nums[j] {
                return true
            }
        }
    }
    return false
}

print("========== Brute Force ==========")

print(containsDuplicateBruteForce(nums1))

print(containsDuplicateBruteForce(nums2))

print(containsDuplicateBruteForce(nums3))

print(containsDuplicateBruteForce(nums4))

//============================================================
// MARK: - Optimal (Set)
// Time : O(n)
// Space: O(n)
//
// The question is "have I seen this value before" — membership,
// not counts. A Set says that; a frequency map would store
// counts we never read.
//
// Early return matters: [1,1,...] exits on the second element
// instead of scanning all 10^5 items.
//
// Note: there is NO O(n) time + O(1) space solution here. If
// asked for O(1) space, sort first and compare adjacent pairs —
// O(n log n) time, O(1) extra. That is the trade.
//============================================================

func containsDuplicateOptimal(_ nums: [Int]) -> Bool {
    var seen = Set<Int>()
    for num in nums {
        if seen.contains(num) {
            return true
        }
        seen.insert(num)
    }
    return false
}

print("========== Optimal ==========")

print(containsDuplicateOptimal(nums1))

print(containsDuplicateOptimal(nums2))

print(containsDuplicateOptimal(nums3))

print(containsDuplicateOptimal(nums4))

//============================================================
// MARK: - Alternative (Dictionary)
// Time : O(n)
// Space: O(n)
//
// Works, but the stored count is never read — a dictionary used
// purely for membership is a Set with extra steps. Kept here to
// mark the distinction: map for "how many", Set for "seen it".
//============================================================

func containsDuplicateDictionary(_ nums: [Int]) -> Bool {
    var counts = [Int: Int]()
    for num in nums {
        if counts[num] != nil {
            return true
        }
        counts[num] = 1
    }
    return false
}

print("========== Dictionary ==========")

print(containsDuplicateDictionary(nums1))

print(containsDuplicateDictionary(nums4))
