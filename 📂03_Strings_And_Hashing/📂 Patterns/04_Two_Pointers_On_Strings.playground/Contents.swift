//
//  04_Two_Pointers_On_Strings
//  Phase 03 — Strings and Hashing
//
//  Two indices converge from both ends of [Character].
//  Base form moves both every iteration; the conditional form moves only the
//  pointer sitting on a character that doesn't qualify.
//  left only ever += 1, right only ever -= 1.
//
//  Feeds: Q22 Valid Palindrome
//

import Foundation

// 1 — print from both ends. Time O(n), Space O(n)
func printFromBothEnds(_ s: String) {
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        print("left  -- \(chars[left])")

        print("right -- \(chars[right])")

        left += 1
        right -= 1
    }
}

printFromBothEnds("Swift")

// 2 — palindrome, exact comparison. Empty string is true.
// Time O(n), Space O(n)
func isPalindrome(_ s: String) -> Bool {
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        if chars[left] != chars[right] {
            return false
        }

        left += 1
        right -= 1
    }

    return true
}

print(isPalindrome("racecar"))

// 3 — count matching pairs. left < right, or the middle char pairs with itself.
// Time O(n), Space O(n)
func countMatchingPairs(_ s: String) -> Int {
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1
    var count = 0

    while left < right {
        if chars[left] == chars[right] {
            count += 1
        }

        left += 1
        right -= 1
    }

    return count
}

print(countMatchingPairs("abcba"))

// 4 — reverse in place, manual swap. Time O(n), Space O(n)
func reverseString(_ s: String) -> String {
    var chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        let temp = chars[left]
        chars[left] = chars[right]
        chars[right] = temp

        left += 1
        right -= 1
    }

    return String(chars)
}

print(reverseString("hello"))

// 5 — conditional skip: only the pointer on a non-letter moves.
// Time O(n), Space O(n)
func reverseOnlyLetters(_ s: String) -> String {
    var chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        if !chars[left].isLetter {
            left += 1
        } else if !chars[right].isLetter {
            right -= 1
        } else {
            let temp = chars[left]
            chars[left] = chars[right]
            chars[right] = temp

            left += 1
            right -= 1
        }
    }

    return String(chars)
}

print(reverseOnlyLetters("a-bcd"))

// 6 — same skip shape, Set membership as the test.
// Time O(n), Space O(n)
func reverseVowels(_ s: String) -> String {
    let vowels: Set<Character> = ["A", "E", "I", "O", "U", "a", "e", "i", "o", "u"]
    var chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        if !vowels.contains(chars[left]) {
            left += 1
        } else if !vowels.contains(chars[right]) {
            right -= 1
        } else {
            let temp = chars[left]
            chars[left] = chars[right]
            chars[right] = temp

            left += 1
            right -= 1
        }
    }

    return String(chars)
}

print(reverseVowels("hello"))

print(reverseVowels("leetcode"))

// 7 — Q22. Skip non-alphanumeric, fold case before comparing.
// lowercased() on Character returns String — compare those, don't hand-roll
// an ASCII ±32 fold ("0P" would pass).
// Time O(n), Space O(n)
func isCleanPalindrome(_ s: String) -> Bool {
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        if !chars[left].isLetter && !chars[left].isNumber {
            left += 1
        } else if !chars[right].isLetter && !chars[right].isNumber {
            right -= 1
        } else {
            if chars[left].lowercased() != chars[right].lowercased() {
                return false
            }

            left += 1
            right -= 1
        }
    }

    return true
}

print(isCleanPalindrome("A man, a plan, a canal: Panama"))

print(isCleanPalindrome("race a car"))

print(isCleanPalindrome(".,"))

print(isCleanPalindrome("0P"))

// 8 — LC680, one deletion allowed. At the first mismatch there are only two
// options: drop the left char or the right one. Two subrange checks, no
// recursion, still O(n).
// Time O(n), Space O(n)
func isPalindromeRange(_ chars: [Character], _ start: Int, _ end: Int) -> Bool {
    var left = start
    var right = end

    while left < right {
        if chars[left] != chars[right] {
            return false
        }

        left += 1
        right -= 1
    }

    return true
}

func validPalindromeII(_ s: String) -> Bool {
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1

    while left < right {
        if chars[left] == chars[right] {
            left += 1
            right -= 1
        } else {
            return isPalindromeRange(chars, left + 1, right)
                || isPalindromeRange(chars, left, right - 1)
        }
    }

    return true
}

print(validPalindromeII("aba"))

print(validPalindromeII("abca"))

print(validPalindromeII("abc"))

print(validPalindromeII("deeee"))
