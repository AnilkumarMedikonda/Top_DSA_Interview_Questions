//
//  Q29_LC387_First_Unique_Character
//  Phase 03 — Strings and Hashing
//
//  Return the INDEX of the first non-repeating character in s.
//  Return -1 if there isn't one.
//
//  Example:
//  "leetcode"     → 0
//  "loveleetcode" → 2
//  "aabb"         → -1
//
//  Constraints:
//  1 <= s.length <= 10^5
//  Lowercase English letters only.
//
//  Pattern: 02_Character_Frequency
//
//  Two passes: count, then find. The second pass must walk the STRING, not the
//  map — the answer is an index, and a dictionary has no order, so the first
//  key you iterate is not the first character in the input.
//

import Foundation

// MARK: - Helper

func buildFreqMap(_ s: String) -> [Character: Int] {
    var freqMap = [Character: Int]()

    for char in s {
        if let count = freqMap[char] {
            freqMap[char] = count + 1
        } else {
            freqMap[char] = 1
        }
    }

    return freqMap
}

// MARK: - Brute force
// For each position, scan the rest of the string for a duplicate.
// T - O(n²)  S - O(n) for the array

func firstUniqCharBrute(_ s: String) -> Int {
    let chars = Array(s)

    for i in 0..<chars.count {
        var isUnique = true

        for j in 0..<chars.count {
            if i != j && chars[i] == chars[j] {
                isUnique = false
                break
            }
        }

        if isUnique {
            return i
        }
    }

    return -1
}

// MARK: - Optimal
// Pass 1 counts. Pass 2 walks the string in order and returns the first index
// whose character has count 1.
// T - O(n)  S - O(1), 26 letters

func firstUniqChar(_ s: String) -> Int {
    let map = buildFreqMap(s)
    let chars = Array(s)

    for i in 0..<chars.count {
        if let count = map[chars[i]], count == 1 {
            return i
        }
    }

    return -1
}

// MARK: - Tests

print(firstUniqCharBrute("leetcode"))

print(firstUniqChar("leetcode"))

print(firstUniqChar("loveleetcode"))

print(firstUniqChar("aabb"))

print(firstUniqChar("z"))

// MARK: - Notes
//
// Approaches:
//   Brute    scan the rest of the string per position   T O(n²)  S O(n)
//   Optimal  count, then walk the string again          T O(n)   S O(1)
//
// Wrong-tool trap: iterating the map in pass 2. It finds A unique character,
// not the FIRST one — dictionary order is unspecified. Same reason Q21's
// group order can't be relied on.
//
// The 26-slot array works here too and makes the O(1) space explicit; the
// dictionary version generalises to any character set.
//
// Edge cases: single character → 0 · no unique character → -1 ·
// unique character last → returns the final index.
