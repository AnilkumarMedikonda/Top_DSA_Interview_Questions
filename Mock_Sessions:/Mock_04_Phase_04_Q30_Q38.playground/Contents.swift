import Foundation

// ==========================================================
// PHASE 04 - SLIDING WINDOW
// Optimal Solutions Revision Playground
// ==========================================================

func maxOf(a: Int, b: Int) -> Int {
    guard a > b else { return b }
    return a
}

func minOf(a: Int, b: Int) -> Int {
    guard a < b else { return b }
    return a
}

// ==========================================================
// MARK: - Q30 LC003 Longest Substring Without Repeating Characters
// Shrink while INVALID (char already in window), record after.
// T - O(n)   S - O(k)
// ==========================================================

func longestSubstringWithoutRepeatingOptimal(_ s: String) -> Int {
    let chars = Array(s)
    var set = Set<Character>()
    var left = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let char = chars[right]

        while set.contains(char) {
            set.remove(chars[left])
            left += 1
        }
        set.insert(char)

        let length = right - left + 1
        maxLength = maxOf(a: length, b: maxLength)
    }

    return maxLength
}

print("Q30")
print(longestSubstringWithoutRepeatingOptimal("abcabcbb"))

// ==========================================================
// MARK: - Q31 LC424 Longest Repeating Character Replacement
// Valid when (windowSize - maxFreq) <= k. maxFreq never recomputed.
// T - O(n)   S - O(k)
// ==========================================================

func longestRepeatingCharacterReplacementOptimal(_ s: String, _ k: Int) -> Int {
    let chars = Array(s)
    var hashMap = [Character: Int]()
    var maxFreq = 0
    var left = 0
    var maxLength = 0

    for right in 0..<chars.count {
        let rightChar = chars[right]
        if let count = hashMap[rightChar] {
            hashMap[rightChar] = count + 1
            maxFreq = maxOf(a: maxFreq, b: count + 1)
        } else {
            hashMap[rightChar] = 1
            maxFreq = maxOf(a: maxFreq, b: 1)
        }

        while right - left + 1 - maxFreq > k {
            let leftChar = chars[left]
            if let count = hashMap[leftChar] {
                if count > 1 {
                    hashMap[leftChar] = count - 1
                } else {
                    hashMap[leftChar] = nil
                }
            }
            left += 1
        }

        let length = right - left + 1
        maxLength = maxOf(a: length, b: maxLength)
    }

    return maxLength
}

print("Q31")
print(longestRepeatingCharacterReplacementOptimal("AABABBA", 1))

// ==========================================================
// MARK: - Q32 LC076 Minimum Window Substring
// Shrink while VALID (formed == required), record BEFORE shrinking.
// formed counts EXACT matches only — >= would overcount duplicates.
// T - O(n + m)   S - O(k)
// ==========================================================

func minimumWindowSubstringOptimal(_ s: String, _ t: String) -> String {
    guard !s.isEmpty, !t.isEmpty else { return "" }

    var tMap = [Character: Int]()
    for char in t {
        if let count = tMap[char] {
            tMap[char] = count + 1
        } else {
            tMap[char] = 1
        }
    }

    let chars = Array(s)
    let required = tMap.count
    var sMap = [Character: Int]()
    var formed = 0
    var left = 0
    var minLength = Int.max
    var minWindow = ""

    for right in 0..<chars.count {
        let char = chars[right]
        if let count = sMap[char] {
            sMap[char] = count + 1
        } else {
            sMap[char] = 1
        }

        if let sCount = sMap[char], let tCount = tMap[char], sCount == tCount {
            formed += 1
        }

        while formed == required {
            let length = right - left + 1
            if length < minLength {
                minLength = length
                minWindow = String(chars[left...right])
            }

            let leftChar = chars[left]
            if let count = sMap[leftChar] {
                sMap[leftChar] = count - 1
            }

            if let sCount = sMap[leftChar], let tCount = tMap[leftChar], sCount < tCount {
                formed -= 1
            }

            left += 1
        }
    }

    return minWindow
}

print("Q32")
print(minimumWindowSubstringOptimal("ADOBECODEBANC", "ABC"))

// ==========================================================
// MARK: - Q33 LC567 Permutation in String
// Fixed window of s1.count. == works only because the prune removes zeros.
// T - O(n·k)   S - O(k)
// ==========================================================

func checkInclusionOptimal(_ s1: String, _ s2: String) -> Bool {
    guard s1.count <= s2.count else { return false }

    var tMap = [Character: Int]()
    for char in s1 {
        if let count = tMap[char] {
            tMap[char] = count + 1
        } else {
            tMap[char] = 1
        }
    }

    let chars = Array(s2)
    var sMap = [Character: Int]()
    var left = 0

    for right in 0..<chars.count {
        let char = chars[right]
        if let count = sMap[char] {
            sMap[char] = count + 1
        } else {
            sMap[char] = 1
        }

        while right - left + 1 > s1.count {
            let leftChar = chars[left]
            if let count = sMap[leftChar] {
                if count > 1 {
                    sMap[leftChar] = count - 1
                } else {
                    sMap[leftChar] = nil
                }
            }
            left += 1
        }

        if tMap == sMap {
            return true
        }
    }

    return false
}

print("Q33")
print(checkInclusionOptimal("ab", "eidbaooo"))

// ==========================================================
// MARK: - Q34 LC438 Find All Anagrams in a String
// Same as Q33, but append left on every match instead of returning.
// T - O(n·k)   S - O(k)
// ==========================================================

func findAnagramsOptimal(_ s: String, _ p: String) -> [Int] {
    guard p.count <= s.count else { return [] }

    var tMap = [Character: Int]()
    for char in p {
        if let count = tMap[char] {
            tMap[char] = count + 1
        } else {
            tMap[char] = 1
        }
    }

    let chars = Array(s)
    var sMap = [Character: Int]()
    var left = 0
    var result = [Int]()

    for right in 0..<chars.count {
        let char = chars[right]
        if let count = sMap[char] {
            sMap[char] = count + 1
        } else {
            sMap[char] = 1
        }

        while right - left + 1 > p.count {
            let leftChar = chars[left]
            if let count = sMap[leftChar] {
                if count > 1 {
                    sMap[leftChar] = count - 1
                } else {
                    sMap[leftChar] = nil
                }
            }
            left += 1
        }

        if tMap == sMap {
            result.append(left)
        }
    }

    return result
}

print("Q34")
print(findAnagramsOptimal("cbaebabacd", "abc"))

// ==========================================================
// MARK: - Q35 LC643 Maximum Average Subarray I
// Fixed window. Divide once, at the return.
// T - O(n)   S - O(1)
// ==========================================================

func sumOfElementsOfRange(_ nums: [Int], from: Int, to: Int) -> Int {
    guard from >= 0 && to < nums.count && from <= to else { return 0 }

    var sum = 0
    var index = from
    while index <= to {
        sum += nums[index]
        index += 1
    }

    return sum
}

func maxAverageSubarrayOptimal(_ nums: [Int], _ k: Int) -> Double {
    guard k > 0 && nums.count >= k else { return 0.0 }

    var maxSum = sumOfElementsOfRange(nums, from: 0, to: k - 1)
    var windowSum = maxSum

    for right in k..<nums.count {
        windowSum = windowSum + nums[right] - nums[right - k]
        maxSum = maxOf(a: windowSum, b: maxSum)
    }

    return Double(maxSum) / Double(k)
}

print("Q35")
print(maxAverageSubarrayOptimal([1, 12, -5, -6, 50, 3], 4))

// ==========================================================
// MARK: - Q36 LC904 Fruits Into Baskets
// Shrink while INVALID (more than k distinct). hashMap.count is the
// distinct check — correct ONLY because the prune removes zeros.
// T - O(n)   S - O(k)
// ==========================================================

func totalFruitOptimal(_ fruits: [Int], _ k: Int) -> Int {
    var hashMap = [Int: Int]()
    var left = 0
    var maxLength = 0

    for right in 0..<fruits.count {
        let fruit = fruits[right]
        if let count = hashMap[fruit] {
            hashMap[fruit] = count + 1
        } else {
            hashMap[fruit] = 1
        }

        while hashMap.count > k {
            let leftFruit = fruits[left]
            if let count = hashMap[leftFruit] {
                if count > 1 {
                    hashMap[leftFruit] = count - 1
                } else {
                    hashMap[leftFruit] = nil
                }
            }
            left += 1
        }

        let length = right - left + 1
        maxLength = maxOf(a: length, b: maxLength)
    }

    return maxLength
}

print("Q36")
print(totalFruitOptimal([1, 2, 3, 2, 2], 2))

// ==========================================================
// MARK: - Q37 LC209 Minimum Size Subarray Sum
// Shrink while VALID (sum >= target), record BEFORE shrinking.
// T - O(n)   S - O(1)
// ==========================================================

func minSubArrayLenOptimal(_ target: Int, _ nums: [Int]) -> Int {
    var sum = 0
    var left = 0
    var minLength = Int.max

    for right in 0..<nums.count {
        sum += nums[right]

        while sum >= target {
            let length = right - left + 1
            minLength = minOf(a: length, b: minLength)

            sum -= nums[left]
            left += 1
        }
    }

    return minLength == Int.max ? 0 : minLength
}

print("Q37")
print(minSubArrayLenOptimal(7, [2, 3, 1, 2, 4, 3]))

print(minSubArrayLenOptimal(11, [1, 1, 1, 1, 1, 1]))

// ==========================================================
// MARK: - Q38 LC239 Sliding Window Maximum
// Deque of INDICES, values decreasing.
// Back evict  = is this still useful?  (smaller and older = dead)
// Front evict = is this still in the window?
// Order: back evict -> append -> front evict -> record.
// T - O(n)   S - O(k) deque, O(n) output
// ==========================================================

func maxSlidingWindowOptimal(_ nums: [Int], _ k: Int) -> [Int] {
    guard k > 0 && nums.count >= k else { return [] }

    var deque = [Int]()
    var result = [Int]()

    for right in 0..<nums.count {
        while let last = deque.last, nums[last] <= nums[right] {
            deque.removeLast()
        }
        deque.append(right)

        if let first = deque.first, first < right - k + 1 {
            deque.removeFirst()
        }

        if right >= k - 1, let first = deque.first {
            result.append(nums[first])
        }
    }

    return result
}

print("Q38")
print(maxSlidingWindowOptimal([1, 3, -1, -3, 5, 3, 6, 7], 3))
