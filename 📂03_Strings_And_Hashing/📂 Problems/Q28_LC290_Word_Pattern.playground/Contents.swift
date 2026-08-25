//
//  Q28_LC290_Word_Pattern
//  Phase 03 — Strings and Hashing
//
//  Return true if s follows pattern — a bijection between each letter in
//  pattern and each non-empty word in s.
//
//  Example:
//  ("abba", "dog cat cat dog")  → true
//  ("abba", "dog cat cat fish") → false
//  ("aaaa", "dog cat cat dog")  → false
//  ("abba", "dog dog dog dog")  → false
//
//  Constraints:
//  1 <= pattern.length <= 300, lowercase letters
//  1 <= s.length <= 3000, lowercase words separated by single spaces
//
//  Pattern: 09_Two_Map_Bijection + 05_Word_Splitting
//
//  Q27 with one type changed: left side Character, right side String.
//  The length guard is load-bearing here, not just an early exit —
//  ("ab", "dog") is 2 letters against 1 word, so without it words[1]
//  is out of range and the function crashes instead of returning false.
//

import Foundation

// MARK: - Helper: manual split
// Buffer, flush on separator, flush after the loop. The isEmpty guard on each
// flush handles leading, trailing and repeated spaces.
// T - O(n)  S - O(n) for the word array

func splitOnSpaces(_ s: String) -> [String] {
    var word = ""
    var words = [String]()

    for char in s {
        if char == " " {
            if !word.isEmpty {
                words.append(word)
                word = ""
            }
        } else {
            word.append(char)
        }
    }

    if !word.isEmpty {
        words.append(word)
    }

    return words
}

// MARK: - Brute force
// No maps. For every pair of positions, the two sides must agree on whether
// their items match: letters[i] == letters[j] exactly when words[i] == words[j].
// A disagreement in either direction breaks the bijection.
// T - O(n²)  S - O(n) for the word array

func wordPatternBrute(_ pattern: String, _ s: String) -> Bool {
    let letters = Array(pattern)
    let words = splitOnSpaces(s)

    guard letters.count == words.count else { return false }

    for i in 0..<letters.count {
        for j in (i + 1)..<letters.count {
            let sameLetter = letters[i] == letters[j]
            let sameWord = words[i] == words[j]

            if sameLetter != sameWord {
                return false
            }
        }
    }

    return true
}

// MARK: - Optimal
// Walk letters and words in lockstep, maintaining both directions of the map.
// T - O(n)  S - O(n) — words array, plus O(k) for the two maps

func wordPattern(_ pattern: String, _ s: String) -> Bool {
    let letters = Array(pattern)
    let words = splitOnSpaces(s)

    guard letters.count == words.count else { return false }

    var forward = [Character: String]()
    var backward = [String: Character]()

    for i in 0..<letters.count {
        let letter = letters[i]
        let word = words[i]

        if let mapped = forward[letter] {
            if mapped != word {
                return false
            }
        } else {
            forward[letter] = word
        }

        if let mapped = backward[word] {
            if mapped != letter {
                return false
            }
        } else {
            backward[word] = letter
        }
    }

    return true
}

// MARK: - Tests

print("brute force")

print(wordPatternBrute("abba", "dog cat cat dog"))

print(wordPatternBrute("abba", "dog cat cat fish"))

print(wordPatternBrute("abba", "dog dog dog dog"))

print("optimal")

print(wordPattern("abba", "dog cat cat dog"))

print(wordPattern("abba", "dog cat cat fish"))

print(wordPattern("aaaa", "dog cat cat dog"))

print(wordPattern("abba", "dog dog dog dog"))

print(wordPattern("a", "dog"))

print(wordPattern("ab", "dog"))

// MARK: - Notes
//
// Approaches:
//   Brute    compare every pair of positions on both sides  T O(n²)  S O(n)
//   Optimal  forward + backward map in one pass             T O(n)   S O(n)
//
// Alternative — canonical index encoding: rewrite each side as its sequence
// of first-occurrence indices ("abba" → 0#1#1#0#) and compare the two strings.
// Canonical by construction, so it catches the reverse direction for free —
// ("abba","dog dog dog dog") gives 0#1#1#0# vs 0#0#0#0#. Needs generics to
// serve both [Character] and [String], and loses the early exit.
//
// Edge cases: ("ab","dog") lengths differ → guard, no crash ·
// single letter and single word → true · every letter distinct → true ·
// all letters same, words differ → false · reverse collision → false.

