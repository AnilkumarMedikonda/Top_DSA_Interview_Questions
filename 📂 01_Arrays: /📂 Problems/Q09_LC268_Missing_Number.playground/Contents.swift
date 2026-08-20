import Foundation

/*
 Q09 — LC268 Missing Number                                [Easy]

 Given an array nums containing n distinct numbers in the range
 [0, n], return the only number in the range that is missing.

 Note the range is [0, n] INCLUSIVE — that is n + 1 possible
 values for n slots, which is why exactly one is missing.

 Example 1:  nums = [3,0,1]              ->  2
 Example 2:  nums = [0,1]                ->  2
 Example 3:  nums = [9,6,4,2,3,5,7,0,1]  ->  8

 Constraints:
   n == nums.length
   1 <= n <= 10^4
   0 <= nums[i] <= n
   All the numbers of nums are unique.

 Follow-up: O(1) extra space, O(n) runtime.
*/

let nums1 = [3, 0, 1]
let nums2 = [0, 1]
let nums3 = [9, 6, 4, 2, 3, 5, 7, 0, 1]
let nums4 = [1]          // 0 is missing — the edge case
let nums5 = [0]          // 1 is missing

//============================================================
// MARK: - Approach 1 — Set
// Time : O(n)
// Space: O(n)
//
// Loop 0...n, not 1...n. The range is inclusive of zero, so a
// loop starting at 1 misses the case where 0 itself is absent
// and only works by falling through to a default return.
//============================================================

func missingNumberUsingSet(_ nums: [Int]) -> Int {

    let n = nums.count
    let seen = Set(nums)

    for num in 0...n {
        if !seen.contains(num) {
            return num
        }
    }

    return -1   // unreachable given the constraints
}

//============================================================
// MARK: - Approach 2 — Sum Formula
// Time : O(n)
// Space: O(1)
//
// Expected sum of 0...n minus the actual sum leaves exactly the
// missing value. Starting the expected loop at 1 is fine —
// adding zero changes nothing.
//
// The closed form is n * (n + 1) / 2. On much larger n that
// product can overflow BEFORE the subtraction runs, which is the
// standard follow-up question. Not a risk at n <= 10^4.
//============================================================

func missingNumberUsingSum(_ nums: [Int]) -> Int {

    let n = nums.count
    var expectedSum = 0

    for num in 1...n {
        expectedSum += num
    }

    var actualSum = 0

    for num in nums {
        actualSum += num
    }

    return expectedSum - actualSum
}

//============================================================
// MARK: - Approach 3 — XOR (Optimal)
// Time : O(n)
// Space: O(1)
//
// a ^ a == 0 and a ^ 0 == a.
//
// XOR every index 0...n together with every value in the array.
// Each number that IS present appears twice — once as an index,
// once as a value — and cancels itself out. The missing one has
// no partner and survives alone.
//
// Cannot overflow at any n, unlike the sum approach.
//============================================================

func missingNumber(_ nums: [Int]) -> Int {

    var result = nums.count

    for i in 0..<nums.count {
        result ^= i
        result ^= nums[i]
    }

    return result
}

//============================================================
// MARK: - Tests
//============================================================

print("========== Set ==========")

print(missingNumberUsingSet(nums1))

print(missingNumberUsingSet(nums2))

print(missingNumberUsingSet(nums3))

print(missingNumberUsingSet(nums4))

print(missingNumberUsingSet(nums5))

print("========== Sum Formula ==========")

print(missingNumberUsingSum(nums1))

print(missingNumberUsingSum(nums2))

print(missingNumberUsingSum(nums3))

print(missingNumberUsingSum(nums4))

print(missingNumberUsingSum(nums5))

print("========== XOR ==========")

print(missingNumber(nums1))

print(missingNumber(nums2))

print(missingNumber(nums3))

print(missingNumber(nums4))

print(missingNumber(nums5))
