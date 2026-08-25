//
//  Q24_LC151_Reverse_Words
//  Phase 03 — Strings and Hashing
//
//  Reverse the order of words in s. Words are separated by one or more
//  spaces. Return them joined by a SINGLE space, no leading or trailing.
//
//  Example:
//  "the sky is blue"  → "blue is sky the"
//  "  hello world  "  → "world hello"
//  "a good   example" → "example good a"
//
//  Constraints:
//  1 <= s.length <= 10^4
//  Letters, digits, and spaces. At least one word.
//
//  Pattern: 05_Word_Splitting
//
//  The reversal is trivial; the tokenising is the problem. Leading, trailing
//  and repeated spaces are all handled by one rule: only flush the buffer when
//  it isn't empty — inside the loop AND at the end.
//  Joining rule: separator before each word except the first. Check
//  result.isEmpty to decide, and wrap the WHOLE append in it, not just part.
//

import Foundation

// MARK: - Manual — no split
// Prepend each finished word, so the reversal falls out of the loop.
// Prepending rebuilds the accumulated string each time, so it's O(n·k), not
// O(n). The array version (collect, then walk backwards) is O(n).
// T - O(n·k)  S - O(n)

func reverseWords(_ s: String) -> String {
    var word = ""
    var result = ""

    for char in s {
        if char == " " {
            if !word.isEmpty {
                if result.isEmpty {
                    result = word
                } else {
                    result = word + " " + result
                }

                word = ""
            }
        } else {
            word.append(char)
        }
    }

    if !word.isEmpty {
        if result.isEmpty {
            result = word
        } else {
            result = word + " " + result
        }
    }

    return result
}

// MARK: - Using split
// split(separator:) drops empty subsequences, so the space cases are free.
// Banned in this repo — kept as a correctness oracle for the manual version.
// Returns [Substring], which holds a reference to the original storage.
// T - O(n)  S - O(n)

func reverseWords2(_ s: String) -> String {
    let words = s.split(separator: " ")
    var result = ""
    var i = words.count - 1

    while i >= 0 {
        if result.isEmpty {
            result = String(words[i])
        } else {
            result += " " + String(words[i])
        }

        i -= 1
    }

    return result
}

// MARK: - Tests

print(reverseWords("the sky is blue"))

print(reverseWords("  hello world  "))

print(reverseWords("a good   example"))

print(reverseWords("a"))

print(reverseWords("   "))

print(reverseWords2("the sky is blue"))

print(reverseWords2("  hello world  "))

print(reverseWords2("a good   example"))

// MARK: - Notes
//
// Approaches:
//   Manual prepend     T O(n·k)  S O(n)   — no stdlib
//   Manual + array     T O(n)    S O(n)   — collect words, walk backwards
//   split/reversed     T O(n)    S O(n)   — one-liner, banned here
//
// The one-liner is s.split(separator: " ").reversed().joined(separator: " ").
// Say it out loud in an interview, then write the manual version — LC151 is
// chosen precisely to test the space handling, so the built-in answers a
// question they didn't ask.
//
// Follow-up — O(1) extra space: reverse the whole character array, then
// reverse each word in place, then compact the spaces.
//
// Edge cases: "   " → "" · "a" → "a" · leading/trailing spaces dropped ·
// runs of spaces collapse to one.
