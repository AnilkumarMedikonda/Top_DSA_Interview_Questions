//
//  Q35_LC643_Max_Average_Subarray.swift
//
//  Find the contiguous subarray of length exactly k with the maximum
//  average, and return that average.
//
//  nums = [1,12,-5,-6,50,3], k = 4  → 12.75    ([12,-5,-6,50] = 51)
//  nums = [5],               k = 1  → 5.0
//  nums = [-1,-2,-3],        k = 2  → -1.5     (all negative)
//
//  Constraints: 1 <= k <= n <= 10^5, -10^4 <= nums[i] <= 10^4
//
//  Fixed window. Track the SUM as Int and divide once at the return —
//  dividing inside the loop rounds repeatedly and compares Doubles.
//  Double(sum) / Double(k), never Double(sum / k): the latter divides
//  as Int first, so 51/4 becomes 12 instead of 12.75.
//
//  Brute   O(n·k) / O(1)
//  Optimal O(n)   / O(1)
//

import Foundation

// MARK: - Helper

// Time: O(n) — n = range length (to - from + 1), not nums.count
// Space: O(1)
func sumOfElementsRange(_ nums: [Int], from: Int, to: Int) -> Int {
    guard from >= 0 && to < nums.count && from <= to else { return 0 }

    var sum = 0
    var index = from
    while index <= to {
        sum += nums[index]
        index += 1
    }

    return sum
}

// MARK: - Brute Force

// Time: O(n·k) — (n - k + 1) windows, k additions each
// Space: O(1)
//
// Last valid start is nums.count - k and it is INCLUSIVE — the window
// occupies start ... start + k - 1, and that last slot must be a real
// index. Using 0..<(count - k) silently drops the final window.
//
// maxSum is seeded from the first window, never 0 — an all-negative
// array has no window summing to 0.
func maxAverageSubarray(_ nums: [Int], _ k: Int) -> Double {
    guard k > 0 && nums.count >= k else { return 0.0 }

    var maxSum = sumOfElementsRange(nums, from: 0, to: k - 1)

    for start in 0...(nums.count - k) {
        let sum = sumOfElementsRange(nums, from: start, to: start + k - 1)
        if sum > maxSum {
            maxSum = sum
        }
    }

    return Double(maxSum) / Double(k)
}

// MARK: - Optimal

// Time: O(n) — k additions to build, then 2 operations per step
// Space: O(1) — two integers
//
// nums[right] enters, nums[right - k] leaves. right starts at k because
// indices 0...k-1 are already summed, which makes right - k equal 0 on
// the first step.
func maxAverageSubarrayOptimal(_ nums: [Int], _ k: Int) -> Double {
    guard k > 0 && nums.count >= k else { return 0.0 }

    var maxSum = sumOfElementsRange(nums, from: 0, to: k - 1)
    var currentSum = maxSum

    for right in k..<nums.count {
        currentSum = currentSum + nums[right] - nums[right - k]
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return Double(maxSum) / Double(k)
}

// MARK: - Tests

print("--- Brute Force ---")

print("[1,12,-5,-6,50,3] k=4: \(maxAverageSubarray([1, 12, -5, -6, 50, 3], 4))")

print("[-1,-2,-3] k=2: \(maxAverageSubarray([-1, -2, -3], 2))")


print("--- Optimal ---")

print("[1,12,-5,-6,50,3] k=4: \(maxAverageSubarrayOptimal([1, 12, -5, -6, 50, 3], 4))")

print("[5] k=1: \(maxAverageSubarrayOptimal([5], 1))")

print("[-1,-2,-3] k=2: \(maxAverageSubarrayOptimal([-1, -2, -3], 2))")

print("[5,5,5] k=3 whole array: \(maxAverageSubarrayOptimal([5, 5, 5], 3))")

print("[0,4,0,3,2] k=1: \(maxAverageSubarrayOptimal([0, 4, 0, 3, 2], 1))")
