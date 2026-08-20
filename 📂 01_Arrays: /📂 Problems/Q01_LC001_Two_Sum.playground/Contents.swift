import Foundation

/*
 Q01 — LC001 Two Sum                                       [Easy]

 Given an array of integers nums and an integer target, return
 indices of the two numbers such that they add up to target.

 Exactly one solution exists. You may not use the same element
 twice. Answer may be returned in any order.

 Example 1:  nums = [2,7,11,15], target = 9  ->  [0,1]
 Example 2:  nums = [3,2,4],     target = 6  ->  [1,2]
 Example 3:  nums = [3,3],       target = 6  ->  [0,1]

 Constraints:
   2 <= nums.length <= 10^4
   -10^9 <= nums[i] <= 10^9
   -10^9 <= target <= 10^9
   Only one valid answer exists.
*/

//============================================================
// MARK: - Brute Force
// Time : O(n²)
// Space: O(1)
// Every pair. Inner loop starts at i+1 so an element is never
// paired with itself.
//============================================================

func twoSumBruteForce(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in (i + 1)..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }
    return []
}

//============================================================
// MARK: - Optimal (Hash Map)
// Time : O(n)
// Space: O(n)
//
// At index i we need `target - nums[i]`. The map holds only
// elements ALREADY seen, so a match is always a different
// index. Check BEFORE inserting — inserting first lets an
// element match itself and returns [0,0].
//============================================================

func twoSumOptimal(_ nums: [Int], _ target: Int) -> [Int] {
    var seen = [Int: Int]()
    for i in 0..<nums.count {
        let complement = target - nums[i]
        if let index = seen[complement] {
            return [index, i]
        }
        seen[nums[i]] = i
    }
    return []
}

//============================================================
// MARK: - Tests
//============================================================

print("========== Brute Force ==========")

print(twoSumBruteForce([2, 7, 11, 15], 9))

print(twoSumBruteForce([3, 2, 4], 6))

print(twoSumBruteForce([3, 3], 6))

print("========== Optimal ==========")

print(twoSumOptimal([2, 7, 11, 15], 9))

print(twoSumOptimal([3, 2, 4], 6))

print(twoSumOptimal([3, 3], 6))
