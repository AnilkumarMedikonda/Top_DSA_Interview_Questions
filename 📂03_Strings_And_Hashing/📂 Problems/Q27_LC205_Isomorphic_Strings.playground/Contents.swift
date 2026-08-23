//
//  Q27_LC205_Isomorphic_Strings
//  Phase 03 — Strings and Hashing
//
//  s and t are isomorphic if the characters in s can be replaced to get t.
//  Every occurrence of a character maps to the same character, order is kept,
//  and no two characters may map to the same character. Self-mapping is fine.
//
//  Example:
//  ("egg", "add")     → true
//  ("foo", "bar")     → false
//  ("paper", "title") → true
//  ("ab", "aa")       → false
//
//  Constraints:
//  1 <= s.length <= 5 * 10^4
//  t.length == s.length
//
//  Pattern: 09_Two_Map_Bijection
//
//  Isomorphic means the two strings have the same SHAPE of repeats: for every
//  pair of positions, "are these two characters equal?" must have the same
//  answer in both strings.
//  Two ways that can break, and both must be caught:
//    one source character → two different targets   ("foo"/"bar")
//    two source characters → the same target        ("ab"/"aa")
//  A single forward map only catches the first. The reverse map catches
//  the second.
//

import Foundation

// MARK: - Brute force
// Compare every pair of positions directly. No maps, no memory.
// T - O(n²)  S - O(n) for the arrays

func isIsomorphicBrute(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    let source = Array(s)
    let target = Array(t)

    for i in 0..<source.count {
        for j in (i + 1)..<source.count {
            let sameInSource = source[i] == source[j]
            let sameInTarget = target[i] == target[j]

            if sameInSource != sameInTarget {
                return false
            }
        }
    }

    return true
}

// MARK: - Optimal
// Same two checks, memoised. Instead of comparing position i against every
// earlier position, remember what each character mapped to last time — the
// dictionary answers it in O(1).
// T - O(n)  S - O(k) distinct characters

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    let source = Array(s)
    let target = Array(t)
    var forward = [Character: Character]()
    var backward = [Character: Character]()

    for i in 0..<source.count {
        let left = source[i]
        let right = target[i]

        if let mapped = forward[left] {
            if mapped != right {
                return false
            }
        } else {
            forward[left] = right
        }

        if let mapped = backward[right] {
            if mapped != left {
                return false
            }
        } else {
            backward[right] = left
        }
    }

    return true
}

// MARK: - Tests

print(isIsomorphicBrute("egg", "add"))

print(isIsomorphicBrute("foo", "bar"))

print(isIsomorphicBrute("ab", "aa"))

print(isIsomorphic("egg", "add"))

print(isIsomorphic("foo", "bar"))

print(isIsomorphic("paper", "title"))

print(isIsomorphic("badc", "baba"))

print(isIsomorphic("ab", "aa"))

print(isIsomorphic("a", "a"))

// MARK: - Notes
//
// Approaches:
//   Brute    every pair of positions      T O(n²)  S O(n)
//   Optimal  forward + backward map       T O(n)   S O(k)
//
// Same relationship as Two Sum: nested loop → dictionary. Remembering what
// you've seen beats re-scanning it.
//
// ("ab", "aa") is the test that proves the backward map earns its place.
// Delete that half and it flips to true.
//
// Use source.count for the loop bound, not s.count — String.count is an O(n)
// walk, the array's is O(1).
//
// Edge cases: single character → true · every character distinct → true ·
// same string twice → true · lengths differ → guard returns false.
