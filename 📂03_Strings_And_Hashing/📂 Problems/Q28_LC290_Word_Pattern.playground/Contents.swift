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
//  <what changes from Q27, and why the length guard is load-bearing here>
//

import Foundation

// MARK: - Helper: manual split
// T - O(?)  S - O(?)

func splitOnSpaces(_ s: String) -> [String] {

    return []
}

// MARK: - Optimal
// <one line: what it does>
// T - O(?)  S - O(?)

func wordPattern(_ pattern: String, _ s: String) -> Bool {

    return true
}

// MARK: - Tests

print(wordPattern("abba", "dog cat cat dog"))

print(wordPattern("abba", "dog cat cat fish"))

print(wordPattern("aaaa", "dog cat cat dog"))

print(wordPattern("abba", "dog dog dog dog"))

print(wordPattern("a", "dog"))

print(wordPattern("ab", "dog"))

// MARK: - Notes
//
// Approaches:
//   Brute    <what>   T O(?)  S O(?)
//   Optimal  <what>   T O(?)  S O(?)
//
// <the alternative: canonical index encoding — one line on why it works>
//
// Edge cases: <fill in>
