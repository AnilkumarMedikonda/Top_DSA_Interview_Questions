//
//  Q22_LC125_Valid_Palindrome
//  Phase 03 — Strings and Hashing
//
//  Return true if s reads the same forwards and backwards after lowercasing
//  and removing every non-alphanumeric character.
//
//  Example:
//  "A man, a plan, a canal: Panama" → true
//  "race a car"                     → false
//  " "                              → true
//
//  Constraints:
//  1 <= s.length <= 2 * 10^5
//  Printable ASCII.
//
//  Pattern: 04_Two_Pointers_On_Strings
//
//  Not the base two-pointer shape — the pointers move CONDITIONALLY. Only the
//  pointer sitting on a character that doesn't qualify advances; when both
//  qualify, compare and move both. That difference is the whole problem.
//  Lowercase once up front rather than per comparison: one allocation
//  instead of n.
//

import Foundation

// MARK: - Brute force
// Build a cleaned copy, then walk it with two pointers.
// T - O(n)  S - O(n) for the cleaned string

func isPalindrome(_ s: String) -> Bool {
    var cleaned = ""

    for ch in s {
        if ch.isLetter || ch.isNumber {
            cleaned.append(ch)
        }
    }

    let chars = Array(cleaned.lowercased())
    var left = 0
    var right = chars.count - 1

    while left < right {
        if chars[left] != chars[right] {
            return false
        }

        left += 1
        right -= 1
    }

    return true
}

// MARK: - Optimal
// Skip in place, no cleaned copy.
// T - O(n)  S - O(n) for the Array conversion

func isPalindromeOptimal(_ s: String) -> Bool {
    let chars = Array(s.lowercased())
    var left = 0
    var right = chars.count - 1

    while left < right {
        if !chars[left].isLetter && !chars[left].isNumber {
            left += 1
        } else if !chars[right].isLetter && !chars[right].isNumber {
            right -= 1
        } else {
            if chars[left] != chars[right] {
                return false
            }
            left += 1
            right -= 1
        }
    }

    return true
}

// MARK: - Tests

print(isPalindromeOptimal("A man, a plan, a canal: Panama"))

print(isPalindromeOptimal("race a car"))

print(isPalindromeOptimal(" "))

print(isPalindromeOptimal(".,"))

print(isPalindromeOptimal("0P"))

print(isPalindromeOptimal("a1a"))

// MARK: - Notes
//
// Approaches:
//   Brute    cleaned copy + two pointers   T O(n)  S O(n) copy
//   Optimal  skip in place                 T O(n)  S O(n) Array
//
// "Optimal" saves the cleaned copy, not the allocation. Array(s.lowercased())
// is still O(n). True O(1) space needs String.Index cursors with formIndex
// and per-character folding — say the trade, don't claim O(1) here.
//
// Digits count. isLetter alone drops 0-9: "0P" strips the 0, leaves "p", and
// wrongly returns true. Needs isLetter || isNumber.
//
// Fold case with lowercased(), never a hand-rolled ASCII ±32 — '0' is 48 and
// 'P' is 80, exactly 32 apart, so "0P" passes a naive fold.
//
// The outer while's left < right is what keeps the skip branches safe. Without
// it, an all-punctuation input runs a pointer off the end.
//
// Edge cases: "" → true (vacuously) · "," → true · single char → true ·
// "0P" → false · "a1a" → true.
