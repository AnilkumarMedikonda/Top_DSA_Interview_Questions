//
//  Q37_LC209_Min_Size_Subarray_Sum.swift
//
//  Given an array of POSITIVE integers and a positive target, return the
//  minimal length of a contiguous subarray whose sum is >= target.
//  Return 0 if no such subarray exists.
//
//  target = 7,  nums = [2,3,1,2,4,3]     → 2   [4,3]
//  target = 4,  nums = [1,4,4]           → 1   [4]
//  target = 11, nums = [1,1,1,1,1,1]     → 0   total is 6, impossible
//
//  Constraints: 1 <= target <= 10^9, 1 <= nums.length <= 10^5,
//               1 <= nums[i] <= 10^4
//
//  SHRINK RULE
//  While VALID (sum >= target). Record BEFORE shrinking — measure the
//  window that is currently legal, then break it. This is the opposite
//  of the "longest" problems, which shrink while INVALID and record after.
//
//  WHY POSITIVE VALUES MATTER
//  Adding an element can only increase the sum; removing one can only
//  decrease it. That monotonicity is what makes shrink-while-valid
//  terminate correctly. With negatives, a shorter window could become
//  valid again after the sum drops, and the approach breaks.
//
//  SENTINEL
//  minLength starts at Int.max — any real length beats it. Seeding 0
//  would never be beaten and the function would always return 0. Convert
//  the sentinel at the return.
//
//  Brute   O(n²) / O(1)
//  Optimal O(n)  / O(1)
//
//  FOLLOW-UP (not implemented)
//  O(n log n): build prefix sums, then for each i binary-search the
//  smallest j where prefix[j] - prefix[i] >= target. Only works because
//  the values are positive, so the prefix array is increasing.
//

import Foundation

// MARK: - Helper

// Time: O(1)
// Space: O(1)
func minOf(_ a: Int, _ b: Int) -> Int {
    guard a < b else {
        return b
    }

    return a
}

// MARK: - Brute Force

// Time: O(n²) — every start, extended until the target is reached
// Space: O(1)
//
// The break is safe: once the sum reaches target, extending further only
// makes the window longer, so nothing shorter comes from this start.
func minSubArrayLenBruteForce(_ target: Int, _ nums: [Int]) -> Int {
    var minLength = Int.max

    for i in 0..<nums.count {
        var sum = 0

        for j in i..<nums.count {
            sum += nums[j]

            if sum >= target {
                let length = j - i + 1
                minLength = minOf(length, minLength)
                break
            }
        }
    }

    return minLength == Int.max ? 0 : minLength
}

// MARK: - Optimal

// Time: O(n) — each index enters once and leaves once
// Space: O(1) — three integers
func minSubArrayLenOptimal(_ target: Int, _ nums: [Int]) -> Int {
    var minLength = Int.max
    var sum = 0
    var left = 0

    for right in 0..<nums.count {
        sum += nums[right]

        while sum >= target {
            let length = right - left + 1
            minLength = minOf(length, minLength)

            sum -= nums[left]
            left += 1
        }
    }

    return minLength == Int.max ? 0 : minLength
}

// MARK: - Tests

print("--- Brute Force ---")

print("target 7 [2,3,1,2,4,3]: \(minSubArrayLenBruteForce(7, [2, 3, 1, 2, 4, 3]))")

print("target 11 [1,1,1,1,1,1]: \(minSubArrayLenBruteForce(11, [1, 1, 1, 1, 1, 1]))")


print("--- Optimal ---")

print("target 7 [2,3,1,2,4,3]: \(minSubArrayLenOptimal(7, [2, 3, 1, 2, 4, 3]))")

print("target 4 [1,4,4]: \(minSubArrayLenOptimal(4, [1, 4, 4]))")

print("target 11 [1,1,1,1,1,1]: \(minSubArrayLenOptimal(11, [1, 1, 1, 1, 1, 1]))")

print("target 6 [10]: \(minSubArrayLenOptimal(6, [10]))")

print("target 5 []: \(minSubArrayLenOptimal(5, []))")
