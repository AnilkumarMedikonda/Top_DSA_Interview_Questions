//
//  02_Character_Frequency
//  Phase 03 — Strings and Hashing
//
//  Count characters into a map (any charset) or a 26-slot array (a–z only).
//  Fires whenever the question is "how many of each" — anagrams, uniqueness,
//  ransom-note style availability. Second pass over the ORIGINAL string
//  preserves input order, which the map can't.
//
//  Feeds: Q20 Valid Anagram, Q25 Top K Frequent,
//         Q26 Ransom Note, Q29 First Unique Character
//

import Foundation

let word = "anagram"

// 1 — base counter. Time O(n), Space O(k) distinct chars
func frequencyMap(_ s: String) -> [Character: Int] {
    var hashMap = [Character: Int]()

    for char in s {
        if let count = hashMap[char] {
            hashMap[char] = count + 1
        } else {
            hashMap[char] = 1
        }
    }

    return hashMap
}

print(frequencyMap(word))

// 2 — earliest SECOND occurrence. Time O(n), Space O(k)
func firstRepeatedCharacter(_ s: String) -> Character? {
    var hashMap = [Character: Int]()

    for ch in s {
        if let _ = hashMap[ch] {
            return ch
        }

        hashMap[ch] = 1
    }

    return nil
}

if let char = firstRepeatedCharacter("programming") {
    print(char)

}

// 3 — 26-slot array, index = ascii - 97. Time O(n), Space O(1)
func lowerCaseCounts(_ s: String) -> [Int] {
    var counts = Array(repeating: 0, count: 26)

    for char in s {
        if let ascii = char.asciiValue {
            let index = Int(ascii) - 97

            if index >= 0 && index < 26 {
                counts[index] += 1
            }
        }
    }

    return counts
}

print(lowerCaseCounts(word))

// 4 — Q29. Second pass over s, not the map, so order holds. Time O(n), Space O(k)
func firstUniqueCharacter(_ s: String) -> Character? {
    let hashMap = frequencyMap(s)

    for ch in s {
        if let count = hashMap[ch], count == 1 {
            return ch
        }
    }

    return nil
}

if let key = firstUniqueCharacter(word) {
    print(key)

}

// 5 — max by count. Ties resolve unpredictably (dictionary order).
// Time O(n), Space O(k)
func mostFrequentCharacter(_ s: String) -> Character? {
    let hashMap = frequencyMap(s)
    var result: Character? = nil
    var maxCount = 0

    for (key, count) in hashMap {
        if count > maxCount {
            maxCount = count
            result = key
        }
    }

    return result
}

if let char = mostFrequentCharacter(word) {
    print(char)

}

// 6 — min by count, same tie caveat. Time O(n), Space O(k)
func leastFrequentCharacter(_ s: String) -> Character? {
    let hashMap = frequencyMap(s)
    var result: Character? = nil
    var minCount = Int.max

    for (key, count) in hashMap {
        if count < minCount {
            minCount = count
            result = key
        }
    }

    return result
}

if let char = leastFrequentCharacter(word) {
    print(char)

}

// 7 — duplicates in input order. Set guards against re-adding.
// Time O(n), Space O(k)
func duplicateCharacters(_ s: String) -> [Character] {
    let hashMap = frequencyMap(s)
    var result = [Character]()
    var seen = Set<Character>()

    for char in s {
        if let count = hashMap[char], count > 1, !seen.contains(char) {
            result.append(char)
            seen.insert(char)
        }
    }

    return result
}

print(duplicateCharacters("programming"))

// 8 — all count-1 chars in input order. Time O(n), Space O(k)
func uniqueCharacters(_ s: String) -> [Character] {
    let hashMap = frequencyMap(s)
    var result = [Character]()

    for char in s {
        if let count = hashMap[char], count == 1 {
            result.append(char)
        }
    }

    return result
}

print(uniqueCharacters("programming"))

// 9 — linear scan, no map. Cheaper than building one for a single query.
// Time O(n), Space O(1)
func containsCharacter(_ s: String, _ target: Character) -> Bool {
    for char in s {
        if char == target {
            return true
        }
    }

    return false
}

print(containsCharacter("banana", "a"))

print(containsCharacter("banana", "z"))

// 10 — absent key returns 0, not nil. Time O(n), Space O(k)
func characterCountLookup(_ s: String, target: Character) -> Int {
    let hashMap = frequencyMap(s)

    if let count = hashMap[target] {
        return count
    }

    return 0
}

print(characterCountLookup("banana", target: "n"))

// 11 — keep first sighting only. Time O(n), Space O(k)
func removeDuplicateCharacters(_ s: String) -> String {
    var seen = Set<Character>()
    var result = ""

    for ch in s {
        if !seen.contains(ch) {
            result += String(ch)
            seen.insert(ch)
        }
    }

    return result
}

print(removeDuplicateCharacters("banana"))

// 12 — sorted() is banned here and ties are unstable.
// Rewrite as bucket-by-count in 08_Bucket_By_Frequency.
// Current: Time O(n + k log k), Space O(n)
