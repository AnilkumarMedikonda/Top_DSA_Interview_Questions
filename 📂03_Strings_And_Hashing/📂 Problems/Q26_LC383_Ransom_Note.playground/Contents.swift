//
//  Q26_LC383_Ransom_Note
//  Phase 03 — Strings and Hashing
//
//  Return true if ransomNote can be built from the letters in magazine.
//  Each magazine letter is usable at most once.
//
//  Example:
//  ("a", "b")    → false
//  ("aa", "ab")  → false
//  ("aa", "aab") → true
//
//  Constraints:
//  1 <= ransomNote.length, magazine.length <= 10^5
//  Lowercase English letters only.
//
//  Pattern: 02_Character_Frequency
//
//  Not an anagram check. Anagram is symmetric — same characters both ways.
//  This is ONE-DIRECTIONAL containment: every note character must be
//  available, and magazine leftovers are fine. Iterate the NOTE, check the
//  magazine. Iterating the magazine misses note characters that aren't in it
//  at all.
//

import Foundation

// MARK: - Helper

func buildMapFreq(_ str: String) -> [Character: Int] {
    var hashMap = [Character: Int]()

    for ch in str {
        if let count = hashMap[ch] {
            hashMap[ch] = count + 1
        } else {
            hashMap[ch] = 1
        }
    }

    return hashMap
}

// MARK: - Brute force
// Two maps. For each note character, require the magazine to hold at least
// as many. Correct, but builds a map you never really need.
// T - O(n + m)  S - O(1), 26 letters

func canConstructBrute(_ ransomNote: String, _ magazine: String) -> Bool {
    let needed = buildMapFreq(ransomNote)
    let available = buildMapFreq(magazine)

    for (ch, required) in needed {
        if let stock = available[ch] {
            if stock < required {
                return false
            }
        } else {
            return false
        }
    }

    return true
}

// MARK: - Optimal
// One map — the magazine — spent down as the note consumes it.
// Pruning at zero is what makes the check trivial: once a letter runs out its
// key is gone, so `if let` failing means "unavailable". No > 0 test needed.
// T - O(n + m)  S - O(1), 26 letters

func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    var available = buildMapFreq(magazine)

    for ch in ransomNote {
        if let count = available[ch] {
            if count == 1 {
                available[ch] = nil
            } else {
                available[ch] = count - 1
            }
        } else {
            return false
        }
    }

    return true
}

// MARK: - Tests
print("Bruetforec")
print(canConstructBrute("aa", "aab"))

print()
print("Optimal")

print(canConstruct("aab", "aaabc"))

print(canConstruct("aa", "ab"))

print(canConstruct("aa", "aab"))

print(canConstruct("aa", "aaa"))

print(canConstruct("ab", "a"))

print(canConstruct("", "abc"))

print(canConstruct("abc", ""))

// MARK: - Notes
//
// Approaches:
//   Brute    scan the magazine per note character   T O(n·m)  S O(1)
//   Better   two frequency maps, compare counts     T O(n+m)  S O(1)
//   Optimal  one map, decrement and prune           T O(n+m)  S O(1)
//
// Same big-O for the last two — the win is one allocation instead of two, and
// the prune idiom is what Phase 04's sliding window is built on.
//
// Free early exit: if ransomNote.count > magazine.count it can't work.
//
// Wrong-tool trap: comparing the two maps with == (the Q20 move). That demands
// equality, so ("aa","aaa") wrongly fails — the magazine is allowed extras.
//
// Edge cases: ("", "abc") → true (nothing to build) · ("abc", "") → false ·
// note longer than magazine → false · magazine has surplus → still true.
