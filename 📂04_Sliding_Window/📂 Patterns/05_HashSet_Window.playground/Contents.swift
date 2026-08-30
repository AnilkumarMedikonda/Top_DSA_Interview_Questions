//
//  05_HashSet_Window.swift
//  Phase 04 — Sliding Window
//
//  Window state is a Set (or a last-index map). Fires on "no repeats"
//  / "all distinct" constraints.
//
//  Feeds: Q30 (LC 3)
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

// MARK: - Drill 1 — HashSet Window (intermediate)

// Time: O(n) — left moves forward at most n times across the whole run
// Space: O(k) — k = distinct characters in the window
//
// Shrink rule: while INVALID (incoming char already in the window).
// Shrink BEFORE inserting — the duplicate is the character being added.
//
// The inner while removes characters ONE AT A TIME until the duplicate
// is gone. If it sat far back, that's many removals. Drill 2 jumps.
func hashSetWindow(_ s: String) -> Int {
    let chars = Array(s)
    var hashSet = Set<Character>()
    var left = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let char = chars[right]

        while hashSet.contains(char) {
            hashSet.remove(chars[left])
            left += 1
        }
        hashSet.insert(char)

        let currentLength = right - left + 1
        maxLength = maxOf(currentLength, maxLength)
    }

    return maxLength
}

print("hashSetWindow \"abcabcbb\": \(hashSetWindow("abcabcbb"))")

print("hashSetWindow \"bbbbb\": \(hashSetWindow("bbbbb"))")

print("hashSetWindow \"pwwkew\": \(hashSetWindow("pwwkew"))")

// MARK: - Drill 2 — Last-Index Jump Map (optimal, Q30 / LC 3)

// Time: O(n) — one pass, no inner loop at all
// Space: O(k) — k = distinct characters
//
// No shrink loop. When the incoming character was seen before, left
// jumps straight past that occurrence in one step.
//
// maxOf is essential: left can only move FORWARD. If the previous
// occurrence is already behind left it is outside the window and must
// be ignored. Without maxOf, "abba" moves left backwards at the final
// 'a' (lastSeen["a"] == 0) and the window swallows a duplicate.
func lengthOfLongestSubstring(_ s: String) -> Int {
    let chars = Array(s)
    var lastSeen = [Character: Int]()
    var left = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let char = chars[right]

        if let lastIndex = lastSeen[char] {
            left = maxOf(left, lastIndex + 1)
        }
        lastSeen[char] = right

        let currentLength = right - left + 1
        maxLength = maxOf(currentLength, maxLength)
    }

    return maxLength
}

print("jump \"abcabcbb\": \(lengthOfLongestSubstring("abcabcbb"))")

print("jump \"bbbbb\": \(lengthOfLongestSubstring("bbbbb"))")

print("jump \"pwwkew\": \(lengthOfLongestSubstring("pwwkew"))")

print("jump \"abba\": \(lengthOfLongestSubstring("abba"))")

print("jump \"\": \(lengthOfLongestSubstring(""))")
