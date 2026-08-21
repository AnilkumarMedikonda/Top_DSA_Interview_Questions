//
//  07_Frequency_Signature
//  Phase 03 — Strings and Hashing
//
//  Reduce a word to a canonical KEY — two words share a key iff they're
//  anagrams. Count into 26 fixed slots, then encode with a delimiter.
//
//  Fires when you need to GROUP by anagram class, not just compare two words.
//  Comparing two words is frequencyMap(s) == frequencyMap(t); a Dictionary is
//  Equatable but not Hashable, so it can't be a key. The 26-slot array can,
//  because its order is fixed by definition rather than by iteration.
//
//  O(k) per word — beats the sorted-string key at O(k log k), and no sort.
//
//  Feeds: Q21 Group Anagrams
//

import Foundation

// 1 — canonical key. The "#" is mandatory: without it [1, 11] and [11, 1]
// both encode to "111" and two non-anagrams collide.
// Time O(k), Space O(1) — 26 slots regardless of word length
func signature(_ s: String) -> String {
    var counts = Array(repeating: 0, count: 26)

    for ch in s {
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

print(signature("eat") == signature("tan"))

print(signature("eat") == signature("eatt"))

print(signature(""))


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


// MARK: - Brute force
// Compare every word against every other. `used` stops a word landing in more
// than one group; the group is seeded with the word itself.
// Signature of strs[i] is hoisted out of the inner loop — recomputing it per j
// costs a factor of n for nothing.
// Time O(n²·k), Space O(n·k) — times out at n = 10^4
func groupAnagramsBrute(_ strs: [String]) -> [[String]] {
    var used = [Bool](repeating: false, count: strs.count)
    var groups = [[String]]()

    for i in 0..<strs.count {
        if used[i] {
            continue
        }

        let keyI = signature(strs[i])
        var group = [strs[i]]
        used[i] = true

        for j in (i + 1)..<strs.count {
            if used[j] {
                continue
            }

            if keyI == signature(strs[j]) {
                group.append(strs[j])
                used[j] = true
            }
        }

        groups.append(group)
    }

    return groups
}

// MARK: - Optimised
// Bucket by canonical key. No word is ever compared to another — the
// dictionary does the matching, which is what removes the n² factor.
// Group order is unspecified (dictionary has none); word order within a group
// is input order.
// Time O(n·k), Space O(n·k)
func groupAnagrams(_ strs: [String]) -> [[String]] {
    var buckets = [String: [String]]()

    for word in strs {
        let key = signature(word)

        if var bucket = buckets[key] {
            bucket.append(word)
            buckets[key] = bucket
        } else {
            buckets[key] = [word]
        }
    }

    var result = [[String]]()

    for (_, bucket) in buckets {
        result.append(bucket)
    }

    return result
}

// MARK: - Tests

print(groupAnagramsBrute(["eat", "tea", "tan", "ate", "nat", "bat"]))

print(groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))

print(groupAnagrams([""]))

print(groupAnagrams(["a"]))
