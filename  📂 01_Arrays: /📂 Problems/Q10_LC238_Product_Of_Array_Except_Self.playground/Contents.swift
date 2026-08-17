import Foundation

/*
 Q10 — LC238 Product of Array Except Self                [Medium]

 Return an array `answer` where answer[i] is the product of every
 element of nums EXCEPT nums[i].

 O(n) time. NO DIVISION.

 Example 1:  nums = [1,2,3,4]        ->  [24,12,8,6]
 Example 2:  nums = [-1,1,0,-3,3]    ->  [0,0,9,0,0]

 Constraints:
   2 <= nums.length <= 10^5
   -30 <= nums[i] <= 30
   Every prefix/suffix product fits in a 32-bit integer.

 Follow-up: O(1) extra space. The OUTPUT array does not count.

 WHY DIVISION IS BANNED:
 "total product / nums[i]" looks obvious and dies on Example 2 —
 a single zero makes the total zero, and you cannot divide by the
 zero element at all. Prefix/suffix sidesteps it entirely.
*/

let nums1 = [1, 2, 3, 4]
let nums2 = [-1, 1, 0, -3, 3]

//============================================================
// MARK: - Approach 1 — Brute Force
// Time : O(n²)
// Space: O(1) extra   (the output array does not count)
//
// TLE at n = 10^5 (10^10 operations). State it, don't submit it.
//============================================================

func productExceptSelfBruteForce(_ nums: [Int]) -> [Int] {

    var result = [Int](repeating: 1, count: nums.count)

    for i in 0..<nums.count {
        var product = 1
        for j in 0..<nums.count {
            if i != j {
                product *= nums[j]
            }
        }
        result[i] = product
    }

    return result
}

//============================================================
// MARK: - Approach 2 — Prefix and Suffix Arrays
// Time : O(n)
// Space: O(n)   (two extra arrays)
//
// answer[i] = (everything LEFT of i) * (everything RIGHT of i)
//
//   nums   = [1,  2,  3,  4]
//   left   = [1,  1,  2,  6]
//   right  = [24, 12, 4,  1]
//   answer = [24, 12, 8,  6]
//
// left[0] and right[n-1] are 1: nothing exists beyond the ends,
// and 1 is the identity for multiplication. That is the detail
// people get wrong.
//============================================================

func productExceptSelfTwoArrays(_ nums: [Int]) -> [Int] {

    let n = nums.count
    var leftArray = [Int](repeating: 1, count: n)
    var rightArray = [Int](repeating: 1, count: n)
    var answer = [Int](repeating: 1, count: n)

    for i in 1..<n {
        leftArray[i] = leftArray[i - 1] * nums[i - 1]
    }

    var j = n - 2

    while j >= 0 {
        rightArray[j] = rightArray[j + 1] * nums[j + 1]
        j -= 1
    }

    for i in 0..<n {
        answer[i] = leftArray[i] * rightArray[i]
    }

    return answer
}

//============================================================
// MARK: - Approach 3 — Two Passes, O(1) Extra (Optimal)
// Time : O(n)
// Space: O(1) extra   ← this is the follow-up
//
// Pass 1 (forward): write the LEFT products straight into answer.
// Pass 2 (backward): carry ONE running right product, multiply it
// into the slot, then absorb nums[j] into it.
//
// ORDER IS CRITICAL in pass 2:
//     answer[j] *= right     // right excludes nums[j]  ✓
//     right *= nums[j]       // now fold nums[j] in
// Reversing these folds nums[j] into its own answer.
//
// This is why the array must be pre-allocated with repeating:
// pass 2 rewrites slots that pass 1 already filled — append
// cannot do that.
//============================================================

func productExceptSelf(_ nums: [Int]) -> [Int] {

    let n = nums.count
    var answer = [Int](repeating: 1, count: n)

    for i in 1..<n {
        answer[i] = answer[i - 1] * nums[i - 1]
    }

    var right = 1
    var j = n - 1

    while j >= 0 {
        answer[j] *= right
        right *= nums[j]
        j -= 1
    }

    return answer
}

//============================================================
// MARK: - Tests
//============================================================

print("========== Brute Force ==========")

print(productExceptSelfBruteForce(nums1))

print(productExceptSelfBruteForce(nums2))

print("========== Two Arrays ==========")

print(productExceptSelfTwoArrays(nums1))

print(productExceptSelfTwoArrays(nums2))

print("========== Optimal ==========")

print(productExceptSelf(nums1))

print(productExceptSelf(nums2))
