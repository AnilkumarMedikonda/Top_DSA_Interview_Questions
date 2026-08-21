//
//  03_String_Traversal
//  Phase 03 — Strings and Hashing
//
//  Swift String is not integer-indexable and count is O(n).
//  index(_:offsetBy:) inside a loop is O(i) per call — an O(n) scan becomes
//  O(n²). Convert to [Character] once, then index freely.
//  Foundation for every problem in this phase.
//
//  Feeds: Q22 Valid Palindrome, Q24 Reverse Words, Q29 First Unique Character
//

import Foundation

let vowelSet: Set<Character> = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

// 1 — forward, no index needed. Time O(n), Space O(1)
func forwardTraversal(_ s: String) {
    for ch in s {
        print(ch)

    }
}

forwardTraversal("Swift")

// 2 — reverse. Array conversion is what keeps this O(n) instead of O(n²).
// Time O(n), Space O(n)
func reverseTraversal(_ s: String) {
    let chars = Array(s)
    var i = chars.count - 1

    while i >= 0 {
        print(chars[i])

        i -= 1
    }
}

reverseTraversal("Swift")

// 3 — random access. Array index is O(1); String index is O(i).
// Time O(n) to convert, O(1) per access
func characterAt(_ s: String, _ position: Int) -> Character? {
    let chars = Array(s)

    if position < 0 || position >= chars.count {
        return nil
    }

    return chars[position]
}

if let ch = characterAt("Swift", 2) {
    print(ch)

}

// 4 — index with character. Time O(n), Space O(n)
func printIndexAndCharacter(_ s: String) {
    let chars = Array(s)

    for i in 0..<chars.count {
        print("\(i) -> \(chars[i])")

    }
}

printIndexAndCharacter("Swift")

// 5 — first vowel position, nil if none. Time O(n), Space O(n)
func firstVowelIndex(_ s: String) -> Int? {
    let chars = Array(s)

    for i in 0..<chars.count {
        if vowelSet.contains(chars[i]) {
            return i
        }
    }

    return nil
}

if let position = firstVowelIndex("Swift") {
    print("first vowel at \(position)")

}

// 6 — every other character. Time O(n), Space O(n)
func evenIndexCharacters(_ s: String) {
    let chars = Array(s)
    var i = 0

    while i < chars.count {
        print(chars[i])

        i += 2
    }
}

evenIndexCharacters("Swift")

// 7 — vowel count. Set lookup, not string scan. Time O(n), Space O(1)
func countVowels(_ s: String) -> Int {
    var count = 0

    for ch in s {
        if vowelSet.contains(ch) {
            count += 1
        }
    }

    return count
}

print(countVowels("Swift"))

// 8 — consonants: letters that are not vowels. Time O(n), Space O(1)
func countConsonants(_ s: String) -> Int {
    var count = 0

    for ch in s {
        if ch.isLetter && !vowelSet.contains(ch) {
            count += 1
        }
    }

    return count
}

print(countConsonants("Swift 5"))

// 9 — digits. Time O(n), Space O(1)
func countDigits(_ s: String) -> Int {
    var count = 0

    for ch in s {
        if ch.isNumber {
            count += 1
        }
    }

    return count
}

print(countDigits("Swift 5"))

// 10 — uppercase. Time O(n), Space O(1)
func countUppercase(_ s: String) -> Int {
    var count = 0

    for ch in s {
        if ch.isUppercase {
            count += 1
        }
    }

    return count
}

print(countUppercase("Swift"))

// 11 — lowercase. Time O(n), Space O(1)
func countLowercase(_ s: String) -> Int {
    var count = 0

    for ch in s {
        if ch.isLowercase {
            count += 1
        }
    }

    return count
}

print(countLowercase("Swift"))
