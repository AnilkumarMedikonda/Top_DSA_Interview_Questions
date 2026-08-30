//
//  02_Variable_Window.swift
//  Phase 04 — Sliding Window
//
//  Size is not given. Expand right always; shrink left while the window
//  is invalid; record after shrinking. Fires on "longest ... such that".
//
//      for right in 0..<n
//          add nums[right]
//          while INVALID { remove nums[left]; left += 1 }
//          best = max(best, right - left + 1)
//
//  left is a tracked variable here — in a fixed window it was just
//  right - k + 1.
//
//  O(n) despite the nested while: left only moves forward, at most n
//  times across the whole run.
//
//  Drills: longest sum ≤ limit · longest without repeats (Q30/LC3)
//          · longest with k replacements (Q31/LC424)
//  Feeds:  Q30, Q31, Q36
//

import Foundation

// MARK: - Helpers

// Time: O(1)
// Space: O(1)
func maxOf(_ a: Int, _ b: Int) -> Int {
    guard a > b else {
        return b
    }

    return a
}

// MARK: - Drill 1 — Longest Window With Sum At Most Limit

// Time: O(n) — each index enters once, leaves once
// Space: O(1) — two integers
//
// Shrink rule: while INVALID (sum > target). Record AFTER shrinking.
// `>` not `>=` — sum == target is allowed by "at most".
func longestSubarrayLength(_ nums: [Int], _ target: Int) -> Int {
    var windowSum = 0
    var left = 0
    var maxLength = 0

    for right in 0..<nums.count {
        windowSum += nums[right]

        while windowSum > target {
            windowSum -= nums[left]
            left += 1
        }

        let currentLength = right - left + 1
        maxLength = maxOf(currentLength, maxLength)
    }

    return maxLength
}

print("longestSubarrayLength [2,1,3,2,4] target 6: \(longestSubarrayLength([2, 1, 3, 2, 4], 6))")

print("whole array [1,1,1,1] target 10: \(longestSubarrayLength([1, 1, 1, 1], 10))")

print("nothing fits [9,9,9] target 5: \(longestSubarrayLength([9, 9, 9], 5))")

// MARK: - Drill 2 — Longest Substring Without Repeating (Q30 / LC 3)

// Time: O(n) — each character enters and leaves the set once
// Space: O(k) — k = distinct characters, bounded by the alphabet
//
// Shrink rule: while INVALID (incoming char already in the window).
// Shrink BEFORE inserting — the duplicate is the character being added,
// so the window must be cleared of it first.
//
// This is the intermediate solution. The optimal replaces the inner
// while with a last-index jump map: left = maxOf(left, lastIndex + 1).
// See 05_HashSet_Window.
func lengthOfLongestSubstring(_ s: String) -> Int {
    let chars = Array(s)
    var hashSet = Set<Character>()
    var left = 0
    var maxLength = 0

    for right in 0..<chars.count {
        while hashSet.contains(chars[right]) {
            hashSet.remove(chars[left])
            left += 1
        }
        hashSet.insert(chars[right])

        let currentLength = right - left + 1
        maxLength = maxOf(currentLength, maxLength)
    }

    return maxLength
}

print("lengthOfLongestSubstring \"abcabcbb\": \(lengthOfLongestSubstring("abcabcbb"))")

print("all same \"bbbbb\": \(lengthOfLongestSubstring("bbbbb"))")

print("empty \"\": \(lengthOfLongestSubstring(""))")

// MARK: - Drill 3 — Longest Repeating Character Replacement (Q31 / LC 424)

// Time: O(n) — each character enters and leaves once; maxFreq is never rescanned
// Space: O(k) — k = distinct characters in the window
//
// Valid when (windowSize - maxFreq) <= k: keep the most frequent
// character, replace everything else, and that must fit in k.
//
// maxFreq is NEVER recomputed on shrink, and that's deliberate. After a
// shrink it may be stale-high, which makes the window look valid when it
// isn't — but the recorded answer can only grow when a genuinely higher
// maxFreq appears, and that update is honest. So the answer is never
// overstated, and the O(26) rescan per shrink is saved.
func characterReplacement(_ s: String, _ k: Int) -> Int {
    let chars = Array(s)
    var map = [Character: Int]()
    var left = 0
    var maxFreq = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let rightChar = chars[right]
        if let count = map[rightChar] {
            map[rightChar] = count + 1
            maxFreq = maxOf(maxFreq, count + 1)
        } else {
            map[rightChar] = 1
            maxFreq = maxOf(maxFreq, 1)
        }

        while (right - left + 1) - maxFreq > k {
            let leftChar = chars[left]
            if let count = map[leftChar] {
                if count == 1 {
                    map[leftChar] = nil
                } else {
                    map[leftChar] = count - 1
                }
            }
            left += 1
        }

        let currentLength = right - left + 1
        maxLength = maxOf(currentLength, maxLength)
    }

    return maxLength
}

print("characterReplacement \"AABABBA\" k=1: \(characterReplacement("AABABBA", 1))")

print("all same \"AAAA\" k=2: \(characterReplacement("AAAA", 2))")

print("no replacements \"ABAB\" k=0: \(characterReplacement("ABAB", 0))")

print("empty \"\" k=1: \(characterReplacement("", 1))")
