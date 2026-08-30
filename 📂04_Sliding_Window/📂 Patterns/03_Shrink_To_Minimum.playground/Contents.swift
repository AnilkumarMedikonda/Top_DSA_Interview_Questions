//
//  03_Shrink_To_Minimum.swift
//  Phase 04 — Sliding Window
//
//  Same skeleton as 02, opposite move rule.
//
//      02 (longest):   while INVALID  { shrink }        then record
//      03 (shortest):  while VALID    { record, shrink }
//
//  In 02 you shrink to escape an illegal window. Here you shrink to
//  squeeze a legal one, recording each size on the way down until it
//  breaks. Fires on "shortest / minimum ... such that".
//
//  Seed with a sentinel, not 0 — 0 would be permanently unbeatable for a
//  minimum. Convert it at the return.
//
//  Drills: shortest sum ≥ target (Q37/LC209)
//  Feeds:  Q32, Q37
//

import Foundation

// MARK: - Helpers

// Time: O(1)
// Space: O(1)
func minOf(_ a: Int, _ b: Int) -> Int {
    guard a < b else {
        return b
    }

    return a
}

// MARK: - Drill 1 — Minimum Size Subarray Sum (Q37 / LC 209)

// Time: O(n) — each index enters once, leaves once
// Space: O(1) — three integers
//
// Shrink rule: while VALID (sum >= target). Record BEFORE shrinking —
// the three lines inside the while are order-sensitive: measure the
// window that is currently legal, then break it.
//
// minLength starts at Int.max because any real length beats it. 0 would
// never be beaten and the function would always return 0.
func minimumSubarrayLength(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var windowSum = 0
    var minLength = Int.max

    for right in 0..<nums.count {
        windowSum += nums[right]

        while windowSum >= target {
            let currentLength = right - left + 1
            minLength = minOf(currentLength, minLength)

            windowSum -= nums[left]
            left += 1
        }
    }

    return minLength == Int.max ? 0 : minLength
}

print("minimumSubarrayLength target 7 [2,3,1,2,4,3]: \(minimumSubarrayLength([2, 3, 1, 2, 4, 3], 7))")

print("single element clears it, target 4 [1,4,4]: \(minimumSubarrayLength([1, 4, 4], 4))")

print("impossible, target 11 [1,1,1,1,1,1]: \(minimumSubarrayLength([1, 1, 1, 1, 1, 1], 11))")

print("one element, target 6 [10]: \(minimumSubarrayLength([10], 6))")

print("empty, target 5 []: \(minimumSubarrayLength([], 5))")


// MARK: - Drill 2 — Minimum Qualifying Window Sum (variant, not a LeetCode problem)

// Time: O(n)
// Space: O(1)
//
// Same loop as Drill 1, different quantity recorded. The pair exists to
// separate two things that keep getting collapsed:
//     windowSum   the STATE you maintain
//     minLength   the ANSWER you're asked for
// Drill 1 answers with a length, this one with a sum. The loop is identical.
//
// The answer here is bounded below by target — the while condition
// guarantees it. So minSum is either target exactly or the smallest overshoot.

let nums = [2,3,1,2,4,3]
let target = 7

func minimumWindowSum(_ nums: [Int], _ target: Int) -> Int {

    guard !nums.isEmpty else { return 0 }

    var left = 0
    var windowSum = 0
    var minSum = Int.max

    for right in 0..<nums.count {

        windowSum += nums[right]

        while windowSum >= target {

            if windowSum < minSum {
                minSum = windowSum
            }

            windowSum -= nums[left]
            left += 1
        }
    }

    return minSum == Int.max ? 0 : minSum
}

print(minimumWindowSum(nums, target))
