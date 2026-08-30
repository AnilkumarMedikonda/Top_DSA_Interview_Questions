//
//  Q38_LC239_Sliding_Window_Maximum.swift
//
//  A window of size k slides from left to right over nums. Return the
//  maximum in each window.
//
//  nums = [1,3,-1,-3,5,3,6,7], k = 3  → [3,3,5,5,6,7]
//
//      [1  3 -1]        3
//      [3 -1 -3]        3
//      [-1 -3  5]       5
//      [-3  5  3]       5
//      [5  3  6]        6
//      [3  6  7]        7
//
//  nums = [1], k = 1      → [1]
//  nums = [9,8,7], k = 2  → [9,8]
//
//  Constraints: 1 <= nums.length <= 10^5, -10^4 <= nums[i] <= 10^4,
//               1 <= k <= nums.length
//
//  WHY THE FIXED-WINDOW SKELETON DOESN'T WORK
//  Add-in/subtract-out works for a SUM because addition is reversible —
//  you can un-add what left. A MAX is not: if the element leaving was the
//  max, there is no way to recover the new max without rescanning. That
//  is the entire difficulty of this problem.
//
//  THE DEQUE
//  Holds INDICES, with the values at those indices in decreasing order.
//  Two evictions, answering different questions:
//
//    BACK   — is this still useful?
//             nums[last] <= nums[right] means a bigger element arrived
//             LATER, so the older one can never be the max again. It is
//             dead: it expires sooner and loses every comparison.
//
//    FRONT  — is this still in the window?
//             The window at step right spans right-k+1 ... right.
//             An index below right-k+1 has fallen out.
//
//  Indices, not values, because only an index tells you whether an
//  element is still inside the window.
//
//  WHY O(n) DESPITE THE INNER WHILE
//  Each index is appended exactly once and removed at most once across
//  the whole scan. Total deque work is bounded by 2n, not n per step.
//
//  Brute   O(n·k) / O(1) extra, O(n) output
//  Optimal O(n)   / O(k) deque, O(n) output
//
//  WRONG TOOL
//  · A heap: O(n log k), and removing the outgoing element is awkward —
//    you cannot delete an arbitrary element from a binary heap cheaply.
//  · A monotonic STACK: wrong shape. You need eviction from BOTH ends;
//    a stack only pops from one.
//

import Foundation

// MARK: - Helper

// Time: O(n) — n = range length (to - from + 1)
// Space: O(1)
//
// Returns Int.min on an invalid range, not 0 — 0 is a plausible maximum,
// so returning it would hide the error behind a real-looking answer.
func maxElementsRange(_ nums: [Int], from: Int, to: Int) -> Int {
    guard from >= 0 && to < nums.count && from <= to else { return Int.min }

    var maxElement = Int.min
    var index = from
    while index <= to {
        if nums[index] > maxElement {
            maxElement = nums[index]
        }
        index += 1
    }

    return maxElement
}

// MARK: - Brute Force

// Time: O(n·k) — (n - k + 1) windows, k comparisons each
// Space: O(1) extra, O(n) for the result
func maxSlidingWindowBruteForce(_ nums: [Int], _ k: Int) -> [Int] {
    guard k > 0 && nums.count >= k else { return [] }

    var result = [Int]()
    for start in 0...(nums.count - k) {
        let windowMax = maxElementsRange(nums, from: start, to: start + k - 1)
        result.append(windowMax)
    }

    return result
}

// MARK: - Optimal

// Time: O(n) — each index appended once, removed at most once
// Space: O(k) for the deque, O(n) for the result
//
// Order: evict the back, append right, evict the front, then record.
// `if` not `while` on the front — right advances by one, so at most one
// index can fall out of the window per step.
//
// <= not < on the back eviction: with strict <, equal values both stay
// and dead indices accumulate. The newer equal index expires later, so
// it is the one worth keeping.
func maxSlidingWindowOptimal(_ nums: [Int], _ k: Int) -> [Int] {
    guard k > 0 && nums.count >= k else { return [] }

    var result = [Int]()
    var deque = [Int]()

    for right in 0..<nums.count {
        while let last = deque.last, nums[last] <= nums[right] {
            deque.removeLast()
        }
        deque.append(right)

        if let first = deque.first, first < right - k + 1 {
            deque.removeFirst()
        }

        if right >= k - 1, let first = deque.first {
            result.append(nums[first])
        }
    }

    return result
}

// MARK: - Dry Run
//
// nums = [1,3,-1,-3,5,3,6,7], k = 3
//
// right | num | back evict      | deque (indices) | front evict | record
// ------|-----|-----------------|-----------------|-------------|-------
//   0   |  1  | —               | [0]             | —           |
//   1   |  3  | pop 0 (1<=3)    | [1]             | —           |
//   2   | -1  | —               | [1,2]           | —           | 3
//   3   | -3  | —               | [1,2,3]         | —           | 3
//   4   |  5  | pop 3,2,1       | [4]             | —           | 5
//   5   |  3  | —               | [4,5]           | —           | 5
//   6   |  6  | pop 5,4         | [6]             | —           | 6
//   7   |  7  | pop 6           | [7]             | —           | 7
//
// result = [3,3,5,5,6,7]

// MARK: - Tests

print("--- Brute Force ---")

print("[1,3,-1,-3,5,3,6,7] k=3: \(maxSlidingWindowBruteForce([1, 3, -1, -3, 5, 3, 6, 7], 3))")

print("[9,8,7] k=2: \(maxSlidingWindowBruteForce([9, 8, 7], 2))")


print("--- Optimal ---")

print("[1,3,-1,-3,5,3,6,7] k=3: \(maxSlidingWindowOptimal([1, 3, -1, -3, 5, 3, 6, 7], 3))")

print("[1] k=1: \(maxSlidingWindowOptimal([1], 1))")

print("[9,8,7] k=2: \(maxSlidingWindowOptimal([9, 8, 7], 2))")

print("all equal [5,5,5,5] k=2: \(maxSlidingWindowOptimal([5, 5, 5, 5], 2))")

print("increasing [1,2,3,4] k=2: \(maxSlidingWindowOptimal([1, 2, 3, 4], 2))")

print("whole array [4,2,7] k=3: \(maxSlidingWindowOptimal([4, 2, 7], 3))")
