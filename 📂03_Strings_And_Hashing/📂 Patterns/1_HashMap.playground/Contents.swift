//
//  01_HashMap
//  Phase 03 — Strings and Hashing
//
//  Key → value with O(1) average lookup.
//  Use it when the question is "have I seen this, and where?"
//  Replaces the inner loop of a backwards search: O(n²) → O(n).
//  Space is O(k) distinct keys, not O(n) input length.
//
//  Feeds: Q21 Group Anagrams, Q25 Top K Frequent,
//         Q27 Isomorphic Strings, Q28 Word Pattern
//

import Foundation

// Drill 1 — value → index map. Duplicates keep the LAST index.
// Time: O(n)  Space: O(n)
func buildIndexMap(_ nums: [Int]) -> [Int: Int] {
    guard !nums.isEmpty else { return [:] }
    var hashMap = [Int: Int]()

    for i in 0..<nums.count {
        hashMap[nums[i]] = i
    }

    return hashMap
}

let indexInput = [2, 7, 11, 15]

print(buildIndexMap(indexInput))

// Drill 2 — one-pass complement search. Lookup BEFORE insert.
// Time: O(n)  Space: O(n)
func findPairSum(_ nums: [Int], _ target: Int) -> [Int] {
    guard !nums.isEmpty else { return [] }
    var hashMap = [Int: Int]()

    for i in 0..<nums.count {
        let hashTarget = target - nums[i]

        if let index = hashMap[hashTarget] {
            return [index, i]
        }

        hashMap[nums[i]] = i
    }

    return []
}

let pairInput = [2, 7, 11, 15]

print(findPairSum(pairInput, 9))

// Drill 3 — group by key. if var binds a COPY, so write it back.
// Time: O(n)  Space: O(n)
func groupByFirstCharacter(_ words: [String]) -> [Character: [String]] {
    guard !words.isEmpty else { return [:] }
    var hashMap = [Character: [String]]()

    for word in words {
        if let char = word.first {
            if var values = hashMap[char] {
                values.append(word)
                hashMap[char] = values
            } else {
                hashMap[char] = [word]
            }
        }
    }

    return hashMap
}

let groupInput = ["eat", "echo", "tan", "ate", ""]

print(groupByFirstCharacter(groupInput))

// Drill 4 — earliest SECOND occurrence, not earliest repeating value.
// Time: O(n)  Space: O(n)
func firstRepeated(_ nums: [Int]) -> Int? {
    guard !nums.isEmpty else { return nil }
    var hashMap = [Int: Int]()

    for num in nums {
        if let _ = hashMap[num] {
            return num
        }

        hashMap[num] = 1
    }

    return nil
}

let repeatedInput = [2, 7, 11, 15, 7, 2]

if let repeated = firstRepeated(repeatedInput) {
    print("first repeated: \(repeated)")

} else {
    print("first repeated: none")

}
