//
//  Q30_LC003_Longest_Substring_Without_Repeating.swift
//  Phase 04 — Sliding Window
//
//  Given a string s, return the length of the longest substring without
//  repeating characters.
//
//  Example:
//      "abcabcbb" → 3    "abc"
//      "bbbbb"    → 1    "b"
//      "pwwkew"   → 3    "wke"  ("pwke" is a subsequence, not a substring)
//      ""         → 0
//
//  Constraints: 0 <= s.length <= 5 * 10^4. Letters, digits, symbols, spaces.
//
//  Substring means contiguous. A subsequence may skip characters; this
//  problem does not allow that.
//
//  Pattern: Variable Window / HashSet Window
//  Edge cases: empty string, all identical, all distinct, duplicate far
//              behind the current window ("abba").
//
//  Alternative (not implemented): HashSet with a one-step shrink — also
//  O(n), but walks left forward one character at a time instead of
//  jumping past the duplicate. Same complexity, more work per duplicate.
//

import Foundation

// MARK: - Helpers

// Time: O(1) — one comparison
// Space: O(1)
func maxOf(_ a: Int, _ b: Int) -> Int {
    guard a > b else {
        return b
    }

    return a
}

// MARK: - Brute Force

// Time: O(n²) — every start, extended until a repeat
// Space: O(k) — k = distinct characters, bounded by the alphabet
//
// Break on the first duplicate: no longer substring from this start can
// be valid. Without the break, a later new character would be recorded
// with a length that spans the duplicate.
func longestSubStringBruteForce(_ s: String) -> Int {
    let chars = Array(s)
    var maxLength = 0

    for i in 0..<chars.count {
        var seen = Set<Character>()

        for j in i..<chars.count {
            let char = chars[j]
            if seen.contains(char) {
                break
            }
            seen.insert(char)

            let currentLength = j - i + 1
            maxLength = maxOf(currentLength, maxLength)
        }
    }

    return maxLength
}

// MARK: - Optimal

// Time: O(n) — one pass, no inner loop
// Space: O(k) — k = distinct characters
//
// lastSeen[char] holds the most recent index of each character. When the
// incoming character was seen before, left jumps straight past that
// occurrence in one step.
//
// maxOf is essential: left only moves FORWARD. If the previous occurrence
// is already behind left it is outside the window and must be ignored.
// Without it, "abba" drags left back to 1 at the final 'a' and the window
// swallows a duplicate.
//
// lastSeen is never cleaned — stale entries for characters outside the
// window stay in the map, and maxOf ignores them.
func longestSubStringOptimal(_ str: String) -> Int {
    let chars = Array(str)
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

// MARK: - Traces

print("brute   \"abcabcbb\": \(longestSubStringBruteForce("abcabcbb"))")

print("brute   \"pwwkew\": \(longestSubStringBruteForce("pwwkew"))")

print("optimal \"abcabcbb\": \(longestSubStringOptimal("abcabcbb"))")

print("optimal \"bbbbb\": \(longestSubStringOptimal("bbbbb"))")

print("optimal \"pwwkew\": \(longestSubStringOptimal("pwwkew"))")

print("optimal \"abba\": \(longestSubStringOptimal("abba"))")

print("optimal empty: \(longestSubStringOptimal(""))")



// MARK: - Alternative — HashSet with one-step shrink (not the kept optimal)

// Time: O(n) — left moves forward at most n times across the whole run
// Space: O(k)
//
// Shrink rule: while INVALID (incoming char already in the window).
// Shrink BEFORE inserting — the duplicate is the character being added.
//
// Correct and O(n), but the inner while removes characters ONE AT A TIME
// until the duplicate is gone. The optimal below jumps past it in a
// single step. Kept here for the contrast; the jump map is what an
// interviewer expects when they ask "can you avoid the inner loop?"

func longestSubStringSet(_ str: String) -> Int {
    let chars = Array(str)
    var seen = Set<Character>()
    var left = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let char = chars[right]

        while seen.contains(char) {
            seen.remove(chars[left])
            left += 1
        }
        seen.insert(char)

        let currentLength = right - left + 1
        maxLength = maxOf(currentLength, maxLength)
    }

    return maxLength
}

print("set     \"abcabcbb\": \(longestSubStringSet("abcabcbb"))")

print("set     \"abba\": \(longestSubStringSet("abba"))")
