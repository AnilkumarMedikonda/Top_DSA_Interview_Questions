import Foundation

// 03_Strings_And_Hashing_Q20_Q29

//==============================================================
// MARK: - Phase 03. Strings & Hashing
//==============================================================

//==============================================================
// MARK: - Helpers
//==============================================================

func getCharsFrequencyMap(_ str: String) -> [Character: Int] {
    guard !str.isEmpty else { return [:] }
    var frequencyMap = [Character: Int]()

    for ch in str {
        if let count = frequencyMap[ch] {
            frequencyMap[ch] = count + 1
        } else {
            frequencyMap[ch] = 1
        }
    }

    return frequencyMap
}

func getNumbersFrequencyMap(_ numbers: [Int]) -> [Int: Int] {
    var frequencyMap = [Int: Int]()

    for number in numbers {
        if let count = frequencyMap[number] {
            frequencyMap[number] = count + 1
        } else {
            frequencyMap[number] = 1
        }
    }

    return frequencyMap
}

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

func getWords(_ str: String) -> [String] {
    guard !str.isEmpty else { return [] }
    var words = [String]()
    var word = ""

    for ch in str {
        if ch == " " {
            if !word.isEmpty {
                words.append(word)
            }
            word = ""
        } else {
            word.append(ch)
        }
    }

    if !word.isEmpty {
        words.append(word)
    }

    return words
}


//==============================================================
// MARK: - Q20. Valid Anagram
// Difficulty: Easy
// LeetCode: LC242
//==============================================================
//
// Problem:
// Given two strings s and t, return true if t is an anagram of s,
// and false otherwise.
//
// Example:
// Input: s = "anagram", t = "nagaram"
// Output: true
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q20 - Valid Anagram")
print("==============================================================")

// Solution

func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    let sChars = Array(s)
    let tChars = Array(t)
    var countArray = Array(repeating: 0, count: 26)

    for i in 0..<sChars.count {
        if let ascii = sChars[i].asciiValue {
            countArray[Int(ascii) - 97] += 1
        }
        if let ascii = tChars[i].asciiValue {
            countArray[Int(ascii) - 97] -= 1
        }
    }

    for i in 0..<26 {
        if countArray[i] != 0 {
            return false
        }
    }

    return true
}

// Test cases
print("Input: \"anagram\", \"nagaram\" -> \(isAnagram("anagram", "nagaram"))")  // true
print("Input: \"rat\", \"car\" -> \(isAnagram("rat", "car"))")  // false
print("Input: \"\", \"\" -> \(isAnagram("", ""))")  // true
print("Input: \"a\", \"aa\" -> \(isAnagram("a", "aa"))")  // false

print()

//==============================================================
// MARK: - Q21. Group Anagrams
// Difficulty: Medium
// LeetCode: LC049
//==============================================================
//
// Problem:
// Given an array of strings, group the anagrams together. The
// answer may be returned in any order.
//
// Example:
// Input: ["eat", "tea", "tan", "ate", "nat", "bat"]
// Output: [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]
//
// Time: O(n * k)
// Space: O(n * k)
//
//==============================================================

print("\n==============================================================")
print("Q21 - Group Anagrams")
print("==============================================================")

// Solution

func groupAnagrams(_ words: [String]) -> [[String]] {
    guard !words.isEmpty else { return [] }
    var hashMap = [String: [String]]()

    for word in words {
        let key = signature(word)

        if var grouped = hashMap[key] {
            grouped.append(word)
            hashMap[key] = grouped
        } else {
            hashMap[key] = [word]
        }
    }

    var result = [[String]]()

    for (_, grouped) in hashMap {
        result.append(grouped)
    }

    return result
}

// Test cases
print("Input: [\"eat\", \"tea\", \"tan\", \"ate\", \"nat\", \"bat\"] -> \(groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))")  // [["eat", "tea", "ate"], ["tan", "nat"], ["bat"]] in any order

print("Input: [\"abc\", \"bca\", \"cab\", \"xyz\", \"zyx\"] -> \(groupAnagrams(["abc", "bca", "cab", "xyz", "zyx"]))")  // [["abc", "bca", "cab"], ["xyz", "zyx"]] in any order

print("Input: [\"\"] -> \(groupAnagrams([""]))")  // [[""]]

print("Input: [\"a\"] -> \(groupAnagrams(["a"]))")  // [["a"]]

print()

//==============================================================
// MARK: - Q22. Valid Palindrome
// Difficulty: Easy
// LeetCode: LC125
//==============================================================
//
// Problem:
// A phrase is a palindrome if, after converting all uppercase
// letters to lowercase and removing all non-alphanumeric
// characters, it reads the same forward and backward.
//
// Example:
// Input: "A man, a plan, a canal: Panama"
// Output: true
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q22 - Valid Palindrome")
print("==============================================================")

// Solution

func isPalindrome(_ str: String) -> Bool {
    let chars = Array(str.lowercased())
    var left = 0
    var right = chars.count - 1

    while left < right {
        if !chars[left].isLetter && !chars[left].isNumber {
            left += 1
        } else if !chars[right].isLetter && !chars[right].isNumber {
            right -= 1
        } else {
            if chars[left] != chars[right] {
                return false
            }
            left += 1
            right -= 1
        }
    }

    return true
}

// Test cases
print("Input: \"A man, a plan, a canal: Panama\" -> \(isPalindrome("A man, a plan, a canal: Panama"))")  // true
print("Input: \"race a car\" -> \(isPalindrome("race a car"))")  // false
print("Input: \" \" -> \(isPalindrome(" "))")  // true
print("Input: \".,\" -> \(isPalindrome(".,"))")  // true
print("Input: \"0P\" -> \(isPalindrome("0P"))")  // false

print()

//==============================================================
// MARK: - Q23. Longest Common Prefix
// Difficulty: Easy
// LeetCode: LC014
//==============================================================
//
// Problem:
// Write a function to find the longest common prefix string
// amongst an array of strings. If there is no common prefix,
// return an empty string.
//
// Example:
// Input: ["flower", "flow", "flight"]
// Output: "fl"
//
// Time: O(n * k)
// Space: O(k)
//
//==============================================================

print("\n==============================================================")
print("Q23 - Longest Common Prefix")
print("==============================================================")

// Solution

func commonPrefix(_ str1: String, _ str2: String) -> String {
    if str1.isEmpty || str2.isEmpty {
        return ""
    }

    let s1Chars = Array(str1)
    let s2Chars = Array(str2)
    var result = ""
    var i = 0

    while i < s1Chars.count, i < s2Chars.count {
        if s1Chars[i] != s2Chars[i] {
            return result
        }
        result.append(s1Chars[i])
        i += 1
    }

    return result
}

func longestCommonPrefix(_ words: [String]) -> String {
    guard !words.isEmpty else { return "" }
    var longPrefix = words[0]

    for i in 1..<words.count {
        longPrefix = commonPrefix(longPrefix, words[i])

        if longPrefix.isEmpty {
            return ""
        }
    }

    return longPrefix
}

// Test cases
print("Input: [\"flower\", \"flow\", \"flight\"] -> \(longestCommonPrefix(["flower", "flow", "flight"]))")  // "fl"
print("Input: [\"dog\", \"racecar\", \"car\"] -> \(longestCommonPrefix(["dog", "racecar", "car"]))")  // ""
print("Input: [\"interspecies\", \"interstellar\", \"interstate\"] -> \(longestCommonPrefix(["interspecies", "interstellar", "interstate"]))")  // "inters"
print("Input: [\"a\"] -> \(longestCommonPrefix(["a"]))")  // "a"
print("Input: [\"\"] -> \(longestCommonPrefix([""]))")  // ""

print()

//==============================================================
// MARK: - Q24. Reverse Words In A String
// Difficulty: Medium
// LeetCode: LC151
//==============================================================
//
// Problem:
// Given an input string s, reverse the order of the words. A word
// is a sequence of non-space characters. Return the words in
// reverse order with a single space between them.
//
// Example:
// Input: "the sky is blue"
// Output: "blue is sky the"
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q24 - Reverse Words In A String")
print("==============================================================")

// Solution

func reverseWords(_ str: String) -> String {
    guard !str.isEmpty else { return "" }
    var finalWord = ""
    var currentWord = ""

    for ch in str {
        if ch == " " {
            if !currentWord.isEmpty {
                if finalWord.isEmpty {
                    finalWord = currentWord
                } else {
                    finalWord = currentWord + " " + finalWord
                }
            }
            currentWord = ""
        } else {
            currentWord.append(ch)
        }
    }

    if !currentWord.isEmpty {
        if finalWord.isEmpty {
            finalWord = currentWord
        } else {
            finalWord = currentWord + " " + finalWord
        }
    }

    return finalWord
}

// Test cases
print("Input: \"the sky is blue\" -> \(reverseWords("the sky is blue"))")  // "blue is sky the"
print("Input: \"  hello world  \" -> \(reverseWords("  hello world  "))")  // "world hello"
print("Input: \"a good   example\" -> \(reverseWords("a good   example"))")  // "example good a"
print("Input: \"a\" -> \(reverseWords("a"))")  // "a"
print("Input: \"   \" -> \(reverseWords("   "))")  // ""

print()

//==============================================================
// MARK: - Q25. Top K Frequent Elements
// Difficulty: Medium
// LeetCode: LC347
//==============================================================
//
// Problem:
// Given an integer array nums and an integer k, return the k most
// frequent elements. The answer may be returned in any order.
//
// Example:
// Input: nums = [1, 1, 1, 2, 2, 3], k = 2
// Output: [1, 2]
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q25 - Top K Frequent Elements")
print("==============================================================")

// Solution

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    let numberMap = getNumbersFrequencyMap(nums)
    var countArray = Array(repeating: [Int](), count: nums.count + 1)

    for (key, value) in numberMap {
        countArray[value].append(key)
    }

    var result = [Int]()
    var j = countArray.count - 1

    while j >= 0, result.count < k {
        for value in countArray[j] {
            if result.count == k {
                break
            }
            result.append(value)
        }
        j -= 1
    }

    return result
}

// Test cases
print("Input: [1, 1, 1, 2, 2, 3], k = 2 -> \(topKFrequent([1, 1, 1, 2, 2, 3], 2))")  // [1, 2]
print("Input: [1], k = 1 -> \(topKFrequent([1], 1))")  // [1]
print("Input: [1, 2], k = 2 -> \(topKFrequent([1, 2], 2))")  // [1, 2] in any order
print("Input: [-1, -1, -2, -2, -2, 3], k = 2 -> \(topKFrequent([-1, -1, -2, -2, -2, 3], 2))")  // [-2, -1]
print("Input: [4, 4, 4, 5, 5, 6, 6, 6], k = 1 -> \(topKFrequent([4, 4, 4, 5, 5, 6, 6, 6], 1))")  // [4] or [6]

print()

//==============================================================
// MARK: - Q26. Ransom Note
// Difficulty: Easy
// LeetCode: LC383
//==============================================================
//
// Problem:
// Given two strings ransomNote and magazine, return true if
// ransomNote can be constructed using the letters from magazine.
// Each letter in magazine can only be used once.
//
// Example:
// Input: ransomNote = "a", magazine = "b"
// Output: false
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q26 - Ransom Note")
print("==============================================================")

// Solution

func canConstruct(_ ransom: String, _ magazine: String) -> Bool {
    var availableMap = getCharsFrequencyMap(magazine)

    for ch in ransom {
        if let count = availableMap[ch] {
            if count == 0 {
                return false
            }
            availableMap[ch] = count - 1
        } else {
            return false
        }
    }

    return true
}

// Test cases
print("Input: \"a\", \"b\" -> \(canConstruct("a", "b"))")  // false
print("Input: \"aa\", \"ab\" -> \(canConstruct("aa", "ab"))")  // false
print("Input: \"aa\", \"aab\" -> \(canConstruct("aa", "aab"))")  // true
print("Input: \"\", \"abc\" -> \(canConstruct("", "abc"))")  // true
print("Input: \"abc\", \"aabbcc\" -> \(canConstruct("abc", "aabbcc"))")  // true

print()

//==============================================================
// MARK: - Q27. Isomorphic Strings
// Difficulty: Easy
// LeetCode: LC205
//==============================================================
//
// Problem:
// Given two strings s and t, determine if they are isomorphic.
// Two strings are isomorphic if the characters in s can be replaced
// to get t while preserving order and a one-to-one mapping.
//
// Example:
// Input: s = "egg", t = "add"
// Output: true
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q27 - Isomorphic Strings")
print("==============================================================")

// Solution

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    let sChars = Array(s)
    let tChars = Array(t)
    var sMap = [Character: Character]()
    var tMap = [Character: Character]()

    for i in 0..<sChars.count {
        let left = sChars[i]
        let right = tChars[i]

        if let mapped = sMap[left] {
            if mapped != right {
                return false
            }
        } else {
            sMap[left] = right
        }

        if let mapped = tMap[right] {
            if mapped != left {
                return false
            }
        } else {
            tMap[right] = left
        }
    }

    return true
}

// Test cases
print("Input: \"egg\", \"add\" -> \(isIsomorphic("egg", "add"))")  // true
print("Input: \"foo\", \"bar\" -> \(isIsomorphic("foo", "bar"))")  // false
print("Input: \"paper\", \"title\" -> \(isIsomorphic("paper", "title"))")  // true
print("Input: \"a\", \"a\" -> \(isIsomorphic("a", "a"))")  // true
print("Input: \"ab\", \"aa\" -> \(isIsomorphic("ab", "aa"))")  // false

print()

//==============================================================
// MARK: - Q28. Word Pattern
// Difficulty: Easy
// LeetCode: LC290
//==============================================================
//
// Problem:
// Given a pattern and a string s, find if s follows the same
// pattern. There must be a one-to-one correspondence between a
// letter in pattern and a non-empty word in s.
//
// Example:
// Input: pattern = "abba", s = "dog cat cat dog"
// Output: true
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q28 - Word Pattern")
print("==============================================================")

// Solution

func wordPattern(_ pattern: String, _ str: String) -> Bool {
    let words = getWords(str)
    let chars = Array(pattern)

    guard words.count == chars.count else { return false }

    var wordMap = [String: Character]()
    var charMap = [Character: String]()

    for i in 0..<words.count {
        let word = words[i]
        let ch = chars[i]

        if let mapped = wordMap[word] {
            if mapped != ch {
                return false
            }
        } else {
            wordMap[word] = ch
        }

        if let mapped = charMap[ch] {
            if mapped != word {
                return false
            }
        } else {
            charMap[ch] = word
        }
    }

    return true
}

// Test cases
print("Input: \"abba\", \"dog cat cat dog\" -> \(wordPattern("abba", "dog cat cat dog"))")  // true
print("Input: \"abba\", \"dog cat cat fish\" -> \(wordPattern("abba", "dog cat cat fish"))")  // false
print("Input: \"aaaa\", \"dog cat cat dog\" -> \(wordPattern("aaaa", "dog cat cat dog"))")  // false
print("Input: \"abba\", \"dog dog dog dog\" -> \(wordPattern("abba", "dog dog dog dog"))")  // false
print("Input: \"abc\", \"dog cat\" -> \(wordPattern("abc", "dog cat"))")  // false

print()

//==============================================================
// MARK: - Q29. First Unique Character In A String
// Difficulty: Easy
// LeetCode: LC387
//==============================================================
//
// Problem:
// Given a string s, find the first non-repeating character and
// return its index. If it does not exist, return -1.
//
// Example:
// Input: "leetcode"
// Output: 0
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q29 - First Unique Character In A String")
print("==============================================================")

// Solution

func firstUniqChar(_ str: String) -> Int {
    let frequencyMap = getCharsFrequencyMap(str)
    let chars = Array(str)

    for i in 0..<chars.count {
        if let count = frequencyMap[chars[i]], count == 1 {
            return i
        }
    }

    return -1
}

// Test cases
print("Input: \"leetcode\" -> \(firstUniqChar("leetcode"))")  // 0
print("Input: \"loveleetcode\" -> \(firstUniqChar("loveleetcode"))")  // 2
print("Input: \"aabb\" -> \(firstUniqChar("aabb"))")  // -1
print("Input: \"a\" -> \(firstUniqChar("a"))")  // 0
print("Input: \"\" -> \(firstUniqChar(""))")  // -1

print()

//==============================================================
// MARK: - Phase 03. Strings & Hashing Revision Complete
//==============================================================
