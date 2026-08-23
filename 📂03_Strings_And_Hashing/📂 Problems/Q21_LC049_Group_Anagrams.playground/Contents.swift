//
//  Q21_LC049_Group_Anagrams
//  Phase 03 — Strings and Hashing
//
//  Given an array of strings, group the anagrams together.
//  Return the groups in any order.
//
//  Example:
//  Input:  ["eat","tea","tan","ate","nat","bat"]
//  Output: [["eat","tea","ate"], ["tan","nat"], ["bat"]]
//
//  Constraints:
//  1 <= strs.count <= 10^4
//  0 <= strs[i].count <= 100
//  Lowercase English letters only.
//
//  Pattern: 07_Frequency_Signature + 01_HashMap
//
//  Q20 compares two words; this GROUPS n of them. Comparison is O(n²) by
//  nature — so stop comparing. Map each word to a key that identifies its
//  anagram class and let the dictionary do the matching.
//  A [Character: Int] cannot be that key: Dictionary is Equatable but not
//  Hashable, and its iteration order isn't stable. The 26-slot array can,
//  because its order is fixed by definition.
//

import Foundation

let words = ["eat", "tea", "tan", "ate", "nat", "bat"]

// MARK: - Helper: canonical key
// The "#" is mandatory — without it [1, 11] and [11, 1] both encode to "111".
// T - O(k)  S - O(1)

func signature(_ str: String) -> String {
    var counts = Array(repeating: 0, count: 26)

    for ch in str {
        if let ascii = ch.asciiValue {
            let index = Int(ascii) - 97

            if index >= 0 && index < 26 {
                counts[index] += 1
            }
        }
    }

    var key = ""

    for i in 0..<26 {
        key += "\(counts[i])"
        key += "#"
    }

    return key
}

print(signature("eat") == signature("tea"))

// MARK: - Brute force
// Compare every word against every other. `used` stops a word landing in more
// than one group; the group is seeded with the word itself. keyI is hoisted
// out of the inner loop — recomputing it per j costs a factor of n for nothing.
// T - O(n²·k)  S - O(n·k) — times out at n = 10^4

func groupAnagramsBrute(_ words: [String]) -> [[String]] {
    var groups = [[String]]()
    var used = Array(repeating: false, count: words.count)

    for i in 0..<words.count {
        if used[i] {
            continue
        }

        var group = [words[i]]
        let keyI = signature(words[i])
        used[i] = true

        for j in (i + 1)..<words.count {
            if used[j] {
                continue
            }

            if keyI == signature(words[j]) {
                group.append(words[j])
                used[j] = true
            }
        }

        groups.append(group)
    }

    return groups
}

print(groupAnagramsBrute(words))

// MARK: - Optimal
// One pass, each word placed directly into its bucket. No word is ever
// compared to another — that's what removes the n² factor.
// if var binds a COPY of the array, so append then write it back.
// T - O(n·k)  S - O(n·k)

func groupAnagrams(_ words: [String]) -> [[String]] {
    var hashMap = [String: [String]]()

    for word in words {
        let key = signature(word)

        if var group = hashMap[key] {
            group.append(word)
            hashMap[key] = group
        } else {
            hashMap[key] = [word]
        }
    }

    var groups = [[String]]()

    for (_, value) in hashMap {
        groups.append(value)
    }

    return groups
}

print(groupAnagrams(words))

print(groupAnagrams([""]))

print(groupAnagrams([]))

// MARK: - Notes
//
// Approaches:
//   Brute    pairwise signature compare   T O(n²·k)      S O(n·k)
//   Better   sorted string as the key     T O(n·k log k) S O(n·k)
//   Optimal  count signature as the key   T O(n·k)       S O(n·k)
//
// Group order is unspecified — dictionary iteration has none, and LeetCode
// accepts any order. Word order WITHIN a group is input order.
//
// No empty guards anywhere. An empty input array skips the loop and returns
// []; an empty word gets the all-zeros key and forms its own class. Guarding
// signature() on "" would break [""] by handing it the key "" instead.
//
// Follow-up — Unicode: the 26-slot signature breaks (asciiValue is nil, the
// index goes out of range). Sort the characters instead, O(k log k) per word.
//
// Edge cases: [] → [] · [""] → [[""]] · single word · all anagrams → one group.
