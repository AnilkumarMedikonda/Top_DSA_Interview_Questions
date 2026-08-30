//
//  Q31_LC424_Longest_Repeating_Character_Replacement.swift
//  Phase 04 — Sliding Window
//
//  You are given a string s and an integer k. You can choose any character
//  of the string and change it to any other uppercase English character.
//  You can perform this operation at most k times.
//
//  Return the length of the longest substring containing the same letter
//  you can get after performing the above operations.
//
//  Example:
//      s = "ABAB",    k = 2  → 4    replace both A's with B (or both B's with A)
//      s = "AABABBA", k = 1  → 4    replace the one A in "ABBA" → "BBBB"
//      s = "AAAA",    k = 2  → 4    already uniform, no replacements needed
//      s = "ABAB",    k = 0  → 1    no replacements allowed
//
//  Constraints: 1 <= s.length <= 10^5, uppercase English letters only,
//               0 <= k <= s.length
//
//  Key insight: a window is valid when (windowSize - maxFreq) <= k.
//  Keep the most frequent character, replace everything else, and that
//  count of replacements must fit in k.
//
//  Pattern: Variable Window + HashMap Window
//  Edge cases: k = 0, k >= s.length, all identical characters, single char.
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

// Time: O(n²) — every start, extended until the replacement budget breaks
// Space: O(k) — k = distinct characters in the window, bounded by 26
//
// The break is safe: within a fixed start, windowSize grows by 1 each step
// while maxFreq grows by at most 1, so required = windowSize - maxFreq is
// non-decreasing. Once it exceeds k it can never come back under.
func longestRepeatingCharacterReplacementBrute(_ s: String, _ k: Int) -> Int {
    let chars = Array(s)
    var maxLength = 0

    for i in 0..<chars.count {
        var hashMap = [Character: Int]()
        var maxFreq = 0

        for j in i..<chars.count {
            let char = chars[j]
            if let count = hashMap[char] {
                hashMap[char] = count + 1
                maxFreq = maxOf(count + 1, maxFreq)
            } else {
                hashMap[char] = 1
                maxFreq = maxOf(1, maxFreq)
            }

            let currentLength = j - i + 1
            let required = currentLength - maxFreq
            if required > k {
                break
            }

            maxLength = maxOf(currentLength, maxLength)
        }
    }

    return maxLength
}

// MARK: - Optimal

// Time: O(n) — each index enters once and leaves once; maxFreq is never rescanned
// Space: O(k) — k = distinct characters, bounded by 26
//
// Shrink rule: while INVALID ((windowSize - maxFreq) > k). Record after
// shrinking, when the window is legal again.
//
// maxFreq is NEVER recomputed on shrink, and that is deliberate. After a
// shrink it may be stale-high, making the window look valid when it isn't
// — but maxLength can only grow when a genuinely higher maxFreq appears,
// and that update is honest. So the answer is never overstated, and the
// O(26) rescan per shrink is saved.
func longestRepeatingCharacterReplacementOptimal(_ s: String, _ k: Int) -> Int {
    let chars = Array(s)
    var hashMap = [Character: Int]()
    var left = 0
    var maxFreq = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let rightChar = chars[right]
        if let count = hashMap[rightChar] {
            hashMap[rightChar] = count + 1
            maxFreq = maxOf(count + 1, maxFreq)
        } else {
            hashMap[rightChar] = 1
            maxFreq = maxOf(1, maxFreq)
        }

        while (right - left + 1) - maxFreq > k {
            let leftChar = chars[left]
            if let count = hashMap[leftChar] {
                if count > 1 {
                    hashMap[leftChar] = count - 1
                } else {
                    hashMap[leftChar] = nil
                }
            }
            left += 1
        }

        let currentLength = right - left + 1
        maxLength = maxOf(currentLength, maxLength)
    }

    return maxLength
}

// MARK: - Traces

print("brute   \"AABABBA\" k=1: \(longestRepeatingCharacterReplacementBrute("AABABBA", 1))")

print("brute   \"ABAB\" k=2: \(longestRepeatingCharacterReplacementBrute("ABAB", 2))")

print("optimal \"AABABBA\" k=1: \(longestRepeatingCharacterReplacementOptimal("AABABBA", 1))")

print("optimal \"ABAB\" k=2: \(longestRepeatingCharacterReplacementOptimal("ABAB", 2))")

print("optimal \"AAAA\" k=2: \(longestRepeatingCharacterReplacementOptimal("AAAA", 2))")

print("optimal \"ABAB\" k=0: \(longestRepeatingCharacterReplacementOptimal("ABAB", 0))")

print("optimal empty k=1: \(longestRepeatingCharacterReplacementOptimal("", 1))")
