import Foundation

// 04_Sliding_Window_Q30_Q38

//==============================================================
// MARK: - Phase 04. Sliding Window
//==============================================================

//==============================================================
// MARK: - Q30. Longest Substring Without Repeating Characters
// Difficulty: Medium
// LeetCode: LC003
//==============================================================
//
// Problem:
// Given a string s, find the length of the longest substring
// without repeating characters.
//
// Example:
// Input: s = "abcabcbb"
// Output: 3
//
// Time: O(n)
// Space: O(min(n, charset))
//
//==============================================================

print("\n==============================================================")
print("Q30 - Longest Substring Without Repeating Characters")
print("==============================================================")

// Solution

func longestSubstringWithoutRepeatingCharacters(_ s: String) -> Int {
    let chars = Array(s)
    var lastSeen = [Character: Int]()
    var left = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let ch = chars[right]

        if let lastIndex = lastSeen[ch] {
            left = max(left, lastIndex + 1)
        }
        lastSeen[ch] = right

        maxLength = max(right - left + 1, maxLength)
    }

    return maxLength
}

// Test cases
print("Input: \"abcabcbb\" -> \(longestSubstringWithoutRepeatingCharacters("abcabcbb"))")  // 3
print("Input: \"bbbbb\" -> \(longestSubstringWithoutRepeatingCharacters("bbbbb"))")  // 1
print("Input: \"pwwkew\" -> \(longestSubstringWithoutRepeatingCharacters("pwwkew"))")  // 3
print("Input: \"dvdf\" -> \(longestSubstringWithoutRepeatingCharacters("dvdf"))")  // 3
print("Input: \"\" -> \(longestSubstringWithoutRepeatingCharacters(""))")  // 0

print()

//==============================================================
// MARK: - Q31. Longest Repeating Character Replacement
// Difficulty: Medium
// LeetCode: LC424
//==============================================================
//
// Problem:
// Given a string s and an integer k, you may change at most k
// characters to any other uppercase letter. Return the length of
// the longest substring containing the same letter afterwards.
//
// Example:
// Input: s = "AABABBA", k = 1
// Output: 4
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q31 - Longest Repeating Character Replacement")
print("==============================================================")

// Solution

func characterReplacement(_ s: String, _ k: Int) -> Int {
    let chars = Array(s)
    var frequencyMap = [Character: Int]()
    var left = 0
    var maxFreq = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let ch = chars[right]

        if let count = frequencyMap[ch] {
            frequencyMap[ch] = count + 1
            maxFreq = max(count + 1, maxFreq)
        } else {
            frequencyMap[ch] = 1
            maxFreq = max(1, maxFreq)
        }

        while (right - left + 1) - maxFreq > k {
            let leftChar = chars[left]

            if let count = frequencyMap[leftChar] {
                if count == 1 {
                    frequencyMap[leftChar] = nil
                } else {
                    frequencyMap[leftChar] = count - 1
                }
            }
            left += 1
        }

        maxLength = max(right - left + 1, maxLength)
    }

    return maxLength
}

// Test cases
print("Input: \"ABAB\", k = 2 -> \(characterReplacement("ABAB", 2))")  // 4
print("Input: \"AABABBA\", k = 1 -> \(characterReplacement("AABABBA", 1))")  // 4
print("Input: \"AAAA\", k = 2 -> \(characterReplacement("AAAA", 2))")  // 4
print("Input: \"ABCD\", k = 0 -> \(characterReplacement("ABCD", 0))")  // 1
print("Input: \"A\", k = 0 -> \(characterReplacement("A", 0))")  // 1

print()

//==============================================================
// MARK: - Q32. Minimum Window Substring
// Difficulty: Hard
// LeetCode: LC076
//==============================================================
//
// Problem:
// Given two strings s and t, return the minimum window substring
// of s that contains every character of t including duplicates.
// If there is no such substring, return the empty string.
//
// Example:
// Input: s = "ADOBECODEBANC", t = "ABC"
// Output: "BANC"
//
// Time: O(n + m)
// Space: O(m)
//
//==============================================================

print("\n==============================================================")
print("Q32 - Minimum Window Substring")
print("==============================================================")

// Solution

func minWindow(_ s: String, _ t: String) -> String {
    guard !t.isEmpty, s.count >= t.count else { return "" }
    var tMap = [Character: Int]()

    for ch in t {
        if let count = tMap[ch] {
            tMap[ch] = count + 1
        } else {
            tMap[ch] = 1
        }
    }

    let sChars = Array(s)
    let required = tMap.count
    var sMap = [Character: Int]()
    var formed = 0
    var left = 0
    var minLength = Int.max
    var minStart = 0

    for right in 0..<sChars.count {
        let ch = sChars[right]

        if let tCount = tMap[ch] {
            if let count = sMap[ch] {
                sMap[ch] = count + 1
            } else {
                sMap[ch] = 1
            }

            if let sCount = sMap[ch], sCount == tCount {
                formed += 1
            }
        }

        while formed == required {
            let length = right - left + 1

            if length < minLength {
                minLength = length
                minStart = left
            }

            let leftChar = sChars[left]

            if let tCount = tMap[leftChar], let sCount = sMap[leftChar] {
                if sCount == tCount {
                    formed -= 1
                }
                sMap[leftChar] = sCount - 1
            }
            left += 1
        }
    }

    guard minLength != Int.max else { return "" }

    return String(sChars[minStart..<minStart + minLength])
}

// Test cases
print("Input: \"ADOBECODEBANC\", \"ABC\" -> \(minWindow("ADOBECODEBANC", "ABC"))")  // "BANC"
print("Input: \"a\", \"a\" -> \(minWindow("a", "a"))")  // "a"
print("Input: \"aa\", \"aa\" -> \(minWindow("aa", "aa"))")  // "aa"
print("Input: \"ab\", \"b\" -> \(minWindow("ab", "b"))")  // "b"
print("Input: \"a\", \"aa\" -> \(minWindow("a", "aa"))")  // ""
print("Input: \"\", \"a\" -> \(minWindow("", "a"))")  // ""

print()

//==============================================================
// MARK: - Q33. Permutation In String
// Difficulty: Medium
// LeetCode: LC567
//==============================================================
//
// Problem:
// Given two strings s1 and s2, return true if s2 contains a
// permutation of s1 as a substring.
//
// Example:
// Input: s1 = "ab", s2 = "eidbaooo"
// Output: true
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q33 - Permutation In String")
print("==============================================================")

// Solution

func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    guard s2.count >= s1.count else { return false }
    var patternMap = [Character: Int]()

    for ch in s1 {
        if let count = patternMap[ch] {
            patternMap[ch] = count + 1
        } else {
            patternMap[ch] = 1
        }
    }

    let chars = Array(s2)
    var windowMap = [Character: Int]()
    var left = 0

    for right in 0..<chars.count {
        let ch = chars[right]

        if let count = windowMap[ch] {
            windowMap[ch] = count + 1
        } else {
            windowMap[ch] = 1
        }

        while right - left + 1 > s1.count {
            let leftChar = chars[left]

            if let count = windowMap[leftChar] {
                if count == 1 {
                    windowMap[leftChar] = nil
                } else {
                    windowMap[leftChar] = count - 1
                }
            }
            left += 1
        }

        if patternMap == windowMap {
            return true
        }
    }

    return false
}

// Test cases
print("Input: \"ab\", \"eidbaooo\" -> \(checkInclusion("ab", "eidbaooo"))")  // true
print("Input: \"ab\", \"eidboaoo\" -> \(checkInclusion("ab", "eidboaoo"))")  // false
print("Input: \"adc\", \"dcda\" -> \(checkInclusion("adc", "dcda"))")  // true
print("Input: \"a\", \"a\" -> \(checkInclusion("a", "a"))")  // true
print("Input: \"abc\", \"ab\" -> \(checkInclusion("abc", "ab"))")  // false

print()

//==============================================================
// MARK: - Q34. Find All Anagrams In A String
// Difficulty: Medium
// LeetCode: LC438
//==============================================================
//
// Problem:
// Given two strings s and p, return an array of all the start
// indices of p's anagrams in s. The answer may be in any order.
//
// Example:
// Input: s = "cbaebabacd", p = "abc"
// Output: [0, 6]
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q34 - Find All Anagrams In A String")
print("==============================================================")

// Solution

func findAnagrams(_ s: String, _ p: String) -> [Int] {
    guard s.count >= p.count else { return [] }
    var patternMap = [Character: Int]()

    for ch in p {
        if let count = patternMap[ch] {
            patternMap[ch] = count + 1
        } else {
            patternMap[ch] = 1
        }
    }

    let chars = Array(s)
    var windowMap = [Character: Int]()
    var left = 0
    var result = [Int]()

    for right in 0..<chars.count {
        let ch = chars[right]

        if let count = windowMap[ch] {
            windowMap[ch] = count + 1
        } else {
            windowMap[ch] = 1
        }

        while right - left + 1 > p.count {
            let leftChar = chars[left]

            if let count = windowMap[leftChar] {
                if count == 1 {
                    windowMap[leftChar] = nil
                } else {
                    windowMap[leftChar] = count - 1
                }
            }
            left += 1
        }

        if patternMap == windowMap {
            result.append(left)
        }
    }

    return result
}

// Test cases
print("Input: \"cbaebabacd\", \"abc\" -> \(findAnagrams("cbaebabacd", "abc"))")  // [0, 6]
print("Input: \"abab\", \"ab\" -> \(findAnagrams("abab", "ab"))")  // [0, 1, 2]
print("Input: \"aaaaa\", \"aa\" -> \(findAnagrams("aaaaa", "aa"))")  // [0, 1, 2, 3]
print("Input: \"a\", \"a\" -> \(findAnagrams("a", "a"))")  // [0]
print("Input: \"\", \"a\" -> \(findAnagrams("", "a"))")  // []

print()

//==============================================================
// MARK: - Q35. Maximum Average Subarray I
// Difficulty: Easy
// LeetCode: LC643
//==============================================================
//
// Problem:
// Given an integer array nums and an integer k, find the
// contiguous subarray of length k with the maximum average value
// and return that value.
//
// Example:
// Input: nums = [1, 12, -5, -6, 50, 3], k = 4
// Output: 12.75
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q35 - Maximum Average Subarray I")
print("==============================================================")

// Solution

func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
    guard k > 0, nums.count >= k else { return 0.0 }
    var windowSum = 0

    for i in 0..<k {
        windowSum += nums[i]
    }

    var maxSum = windowSum

    for right in k..<nums.count {
        windowSum += nums[right] - nums[right - k]
        maxSum = max(windowSum, maxSum)
    }

    return Double(maxSum) / Double(k)
}

// Test cases
print("Input: [1, 12, -5, -6, 50, 3], k = 4 -> \(findMaxAverage([1, 12, -5, -6, 50, 3], 4))")  // 12.75
print("Input: [0, 1, 1, 3, 3], k = 4 -> \(findMaxAverage([0, 1, 1, 3, 3], 4))")  // 2.0
print("Input: [-1, -2, -3, -4], k = 2 -> \(findMaxAverage([-1, -2, -3, -4], 2))")  // -1.5
print("Input: [5], k = 1 -> \(findMaxAverage([5], 1))")  // 5.0

print()

//==============================================================
// MARK: - Q36. Fruit Into Baskets
// Difficulty: Medium
// LeetCode: LC904
//==============================================================
//
// Problem:
// Given an integer array fruits where fruits[i] is the type of
// fruit on tree i, return the maximum number of fruits you can
// pick moving right, using two baskets that each hold one type.
//
// Example:
// Input: fruits = [1, 2, 1]
// Output: 3
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q36 - Fruit Into Baskets")
print("==============================================================")

// Solution

func totalFruit(_ fruits: [Int]) -> Int {
    let basketLimit = 2
    var basketMap = [Int: Int]()
    var uniqueTypes = 0
    var left = 0
    var maxFruits = 0

    for right in 0..<fruits.count {
        let fruit = fruits[right]

        if let count = basketMap[fruit] {
            basketMap[fruit] = count + 1
        } else {
            basketMap[fruit] = 1
            uniqueTypes += 1
        }

        while uniqueTypes > basketLimit {
            let leftFruit = fruits[left]

            if let count = basketMap[leftFruit] {
                if count > 1 {
                    basketMap[leftFruit] = count - 1
                } else {
                    basketMap[leftFruit] = nil
                    uniqueTypes -= 1
                }
            }
            left += 1
        }

        maxFruits = max(right - left + 1, maxFruits)
    }

    return maxFruits
}

// Test cases
print("Input: [1, 2, 1] -> \(totalFruit([1, 2, 1]))")  // 3
print("Input: [0, 1, 2, 2] -> \(totalFruit([0, 1, 2, 2]))")  // 3
print("Input: [1, 2, 3, 2, 2] -> \(totalFruit([1, 2, 3, 2, 2]))")  // 4
print("Input: [1, 1, 2, 3] -> \(totalFruit([1, 1, 2, 3]))")  // 2
print("Input: [] -> \(totalFruit([]))")  // 0

print()

//==============================================================
// MARK: - Q37. Minimum Size Subarray Sum
// Difficulty: Medium
// LeetCode: LC209
//==============================================================
//
// Problem:
// Given an array of positive integers nums and a positive integer
// target, return the minimal length of a subarray whose sum is
// greater than or equal to target. Return 0 if there is none.
//
// Example:
// Input: target = 7, nums = [2, 3, 1, 2, 4, 3]
// Output: 2
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q37 - Minimum Size Subarray Sum")
print("==============================================================")

// Solution

func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
    var windowSum = 0
    var left = 0
    var minLength = Int.max

    for right in 0..<nums.count {
        windowSum += nums[right]

        while windowSum >= target {
            minLength = min(right - left + 1, minLength)
            windowSum -= nums[left]
            left += 1
        }
    }

    return minLength == Int.max ? 0 : minLength
}

// Test cases
print("Input: target = 7, [2, 3, 1, 2, 4, 3] -> \(minSubArrayLen(7, [2, 3, 1, 2, 4, 3]))")  // 2
print("Input: target = 4, [1, 4, 4] -> \(minSubArrayLen(4, [1, 4, 4]))")  // 1
print("Input: target = 11, [1, 2, 3, 4, 5] -> \(minSubArrayLen(11, [1, 2, 3, 4, 5]))")  // 3
print("Input: target = 15, [1, 2, 3, 4, 5] -> \(minSubArrayLen(15, [1, 2, 3, 4, 5]))")  // 5
print("Input: target = 100, [1, 2, 3] -> \(minSubArrayLen(100, [1, 2, 3]))")  // 0

print()

//==============================================================
// MARK: - Q38. Sliding Window Maximum
// Difficulty: Hard
// LeetCode: LC239
//==============================================================
//
// Problem:
// Given an array nums and a window of size k sliding from left to
// right, return an array of the maximum value in each window.
//
// Example:
// Input: nums = [1, 3, -1, -3, 5, 3, 6, 7], k = 3
// Output: [3, 3, 5, 5, 6, 7]
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q38 - Sliding Window Maximum")
print("==============================================================")

// Solution

func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    guard k > 0, nums.count >= k else { return [] }
    var deque = [Int]()
    var head = 0
    var result = [Int]()

    for right in 0..<nums.count {
        while deque.count > head, nums[deque[deque.count - 1]] <= nums[right] {
            deque.removeLast()
        }
        deque.append(right)

        if deque[head] <= right - k {
            head += 1
        }

        if right >= k - 1 {
            result.append(nums[deque[head]])
        }
    }

    return result
}

// Test cases
print("Input: [1, 3, -1, -3, 5, 3, 6, 7], k = 3 -> \(maxSlidingWindow([1, 3, -1, -3, 5, 3, 6, 7], 3))")  // [3, 3, 5, 5, 6, 7]
print("Input: [4, 3, 2, 1], k = 2 -> \(maxSlidingWindow([4, 3, 2, 1], 2))")  // [4, 3, 2]
print("Input: [1, 2, 3, 4], k = 2 -> \(maxSlidingWindow([1, 2, 3, 4], 2))")  // [2, 3, 4]
print("Input: [9, 11], k = 2 -> \(maxSlidingWindow([9, 11], 2))")  // [11]
print("Input: [1, -1], k = 1 -> \(maxSlidingWindow([1, -1], 1))")  // [1, -1]
print("Input: [], k = 0 -> \(maxSlidingWindow([], 0))")  // []

print()

//==============================================================
// MARK: - Phase 04. Sliding Window Revision Complete
//==============================================================
