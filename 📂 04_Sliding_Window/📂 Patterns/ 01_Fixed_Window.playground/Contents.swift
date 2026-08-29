//
//  01_Fixed_Window.swift
//  Phase 04 — Sliding Window
//
//  Window is a fixed length k. Build it once, then move it: one element
//  enters, one leaves. Fires when the problem says "exactly k".
//
//      windowSum = windowSum + nums[right] - nums[right - k]
//
//      enters  nums[right]        leaves  nums[right - k]
//      right starts at k, seed the answer from the first window (not 0)
//
//  Only works when the state is reversible. A sum can be un-added; a max
//  cannot — that's why Q38 needs a deque.
//
//  Drills: min sum · target sum exists · index of max window · max average
//  Feeds:  Q33, Q34, Q35, Q38
//

import Foundation

var nums = [2, 1, 5, 1, 3, 2]
var k = 3

// MARK: - Helpers

// Time: O(n) — n = range length, not nums.count
// Space: O(1)
func sumOfElements(nums: [Int], from: Int, to: Int) -> Int {
    guard from >= 0 && to < nums.count && from <= to else {
        return 0
    }

    var sum = 0
    var index = from
    while index <= to {
        sum += nums[index]
        index += 1
    }

    return sum
}

// Time: O(1)
// Space: O(1)
func minOf(a: Int, b: Int) -> Int {
    guard a < b else {
        return b
    }

    return a
}

// MARK: - Drill 1 — Minimum Sum of K Elements

// Time: O(n)
// Space: O(1)
func minimumSumOfKElements(_ nums: [Int], _ k: Int) -> Int {
    guard k > 0 && nums.count >= k else {
        return 0
    }

    var windowSum = sumOfElements(nums: nums, from: 0, to: k - 1)
    var minSum = windowSum

    var right = k
    while right < nums.count {
        windowSum = windowSum + nums[right] - nums[right - k]
        minSum = minOf(a: windowSum, b: minSum)
        right += 1
    }

    return minSum
}
print()
print("minimumSumOfKElements: \(minimumSumOfKElements(nums, k))")

// MARK: - Drill 2 — Contains Window With Target Sum

// Time: O(n) — early exit on the first match
// Space: O(1)
//
// The seed is checked before the loop: window 0 is a valid answer.
func containsWindowWithTargetSum(_ nums: [Int], _ k: Int, _ target: Int) -> Bool {
    guard k > 0 && nums.count >= k else {
        return false
    }

    var windowSum = sumOfElements(nums: nums, from: 0, to: k - 1)
    if windowSum == target {
        return true
    }

    var right = k
    while right < nums.count {
        windowSum = windowSum + nums[right] - nums[right - k]
        if windowSum == target {
            return true
        }
        right += 1
    }

    return false
}
print()
print("containsWindowWithTargetSum: \(containsWindowWithTargetSum(nums, 3, 9))")

// MARK: - Drill 3 — Starting Index of Maximum Window

// Time: O(n)
// Space: O(1)
//
// Two variables update together, so the inline `if` replaces maxOf.
// Strict `>` keeps the EARLIEST start on a tie.
// maxIndex = right - k + 1 is the left edge of the window ending at right.
func startingIndexOfMaximumWindow(_ nums: [Int], _ k: Int) -> Int {
    guard k > 0 && nums.count >= k else {
        return -1
    }

    var windowSum = sumOfElements(nums: nums, from: 0, to: k - 1)
    var maxSum = windowSum
    var maxIndex = 0

    var right = k
    while right < nums.count {
        windowSum = windowSum + nums[right] - nums[right - k]
        if windowSum > maxSum {
            maxSum = windowSum
            maxIndex = right - k + 1
        }
        right += 1
    }

    return maxIndex
}
print()
print("startingIndexOfMaximumWindow: \(startingIndexOfMaximumWindow(nums, k))")

// MARK: - Drill 4 — Max Average (LC 643 — this is Q35)

nums = [1, 12, -5, -6, 50, 3]
k = 4

// Time: O(n)
// Space: O(1)
//
// The loop stays integer — dividing inside would round repeatedly and
// compare Doubles instead of Ints. One division, at the return.
// Double(maxSum) / Double(k), NOT Double(maxSum / k): the second divides
// as Int first, so 51/4 becomes 12 instead of 12.75.
func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
    guard k > 0 && nums.count >= k else {
        return 0.0
    }

    var windowSum = sumOfElements(nums: nums, from: 0, to: k - 1)
    var maxSum = windowSum

    var right = k
    while right < nums.count {
        windowSum = windowSum + nums[right] - nums[right - k]
        if windowSum > maxSum {
            maxSum = windowSum
        }
        right += 1
    }

    return Double(maxSum) / Double(k)
}
print()
print("findMaxAverage: \(findMaxAverage(nums, k))")
