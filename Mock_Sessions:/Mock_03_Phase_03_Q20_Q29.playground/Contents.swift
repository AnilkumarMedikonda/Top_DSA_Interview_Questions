import Foundation

//============================================================
// PHASE 03 — STRINGS AND HASHING (Q20–Q29)
//
// Note on space complexity: several of these are O(1) only
// because the alphabet is fixed (26 lowercase letters). Say
// that out loud in an interview — "O(1), bounded by the
// alphabet" — rather than just "O(1)".
//============================================================


//============================================================
// Q20_LC242_Valid_Anagram
// Pattern: Frequency Count — one array, +1 for s, -1 for t
// Time: O(n)   Space: O(1) — 26 slots, independent of n
// Edge cases: different lengths; every count must return to 0
//============================================================

func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    var array = Array(repeating: 0, count: 26)
    let sWords = Array(s)
    let tWords = Array(t)

    for i in 0..<sWords.count {
        if let asciiValue = sWords[i].asciiValue {
            let index = Int(asciiValue) - 97
            array[index] += 1
        }
        if let asciiValue = tWords[i].asciiValue {
            let index = Int(asciiValue) - 97
            array[index] -= 1
        }
    }

    for i in 0..<26 {
        if array[i] != 0 {
            return false
        }
    }

    return true
}

print("Q20_LC242_Valid_Anagram")
print(isAnagram("anagram", "nagaram")) // true
print(isAnagram("rat", "car"))         // false
print(isAnagram("a", "ab"))            // false — length guard
print()


//============================================================
// Q21_LC049_Group_Anagrams
// Pattern: Frequency Signature + HashMap
// Time: O(n * k)   Space: O(n * k)   — n words, k = word length
//
// NOT O(n log n): that is the SORT-the-word signature. Counting
// avoids the log factor, which is the whole advantage here.
// The "#" separator matters — without it [1,11] and [11,1]
// would produce the same string.
// Edge cases: empty string is its own group; single word
//============================================================

func createSignature(_ s: String) -> String {
    var array = Array(repeating: 0, count: 26)

    for ch in s {
        if let asciiValue = ch.asciiValue {
            let index = Int(asciiValue) - 97
            if index >= 0 && index < 26 {
                array[index] += 1
            }
        }
    }
    var signature = ""

    for i in 0..<26 {
        signature += "\(array[i])"
        signature += "#"
    }

    return signature
}

print(createSignature("anagram") == createSignature("nagaram")) // true
print(createSignature("rat") == createSignature("cat"))         // false — not anagrams
print(createSignature("rat") == createSignature("tar"))         // true

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var hashMap = [String: [String]]()
    var result = [[String]]()

    for i in 0..<strs.count {
        let word = strs[i]
        let signature = createSignature(word)

        if var group = hashMap[signature] {
            group.append(word)
            hashMap[signature] = group
        } else {
            hashMap[signature] = [word]
        }
    }

    for (_, group) in hashMap {
        result.append(group)
    }

    return result
}

print("Q21_LC049_Group_Anagrams")
print(groupAnagrams(["eat","tea","tan","ate","nat","bat"]))
print(groupAnagrams([""]))
print(groupAnagrams(["a"]))
print()


//============================================================
// Q22_LC125_Valid_Palindrome
// Pattern: Two Pointers — skip, then compare
// Time: O(n)   Space: O(n) — Array(s.lowercased()) copies the
// whole string. To claim O(1) you must walk String.Index
// directly and lowercase one character at a time.
// Edge cases: " " -> true; all punctuation -> true
//============================================================

func isPalindrome(_ s: String) -> Bool {
    let words = Array(s.lowercased())
    var left = 0
    var right = words.count - 1

    while left < right {
        if !words[left].isLetter && !words[left].isNumber {
            left += 1
        } else if !words[right].isLetter && !words[right].isNumber {
            right -= 1
        } else {
            if words[left] != words[right] {
                return false
            }
            left += 1
            right -= 1
        }
    }

    return true
}

print("Q22_LC125_Valid_Palindrome")
print(isPalindrome("A man, a plan, a canal: Panama")) // true
print(isPalindrome("race a car"))                     // false
print(isPalindrome(" "))                              // true
print(isPalindrome(".,"))                             // true — no comparable chars
print()


//============================================================
// Q23_LC014_Longest_Common_Prefix
// Pattern: Pairwise fold — shrink the prefix against each word
// Time: O(n * m)   Space: O(m)   — n words, m = prefix length
// Edge cases: no common prefix at all; one word; an empty word
// in the list kills the prefix immediately
//============================================================

func commonPrefix(_ str1: String, _ str2: String) -> String {
    if str1.isEmpty || str2.isEmpty {
        return ""
    }
    let s1Words = Array(str1)
    let s2Words = Array(str2)
    var result = ""
    var i = 0

    while i < s1Words.count && i < s2Words.count {
        if s1Words[i] != s2Words[i] {
            return result
        }
        result += "\(s1Words[i])"
        i += 1
    }

    return result
}

func longestCommonPrefix(_ strs: [String]) -> String {
    var prefix = strs[0]

    for i in 1..<strs.count {
        prefix = commonPrefix(prefix, strs[i])

        // once empty it can never grow back — stop scanning
        if prefix.isEmpty {
            return ""
        }
    }

    return prefix
}

print("Q23_LC014_Longest_Common_Prefix")
print(longestCommonPrefix(["flower","flow","flight"]))                   // "fl"
print(longestCommonPrefix(["dog","racecar","car"]))                      // ""
print(longestCommonPrefix(["interspecies","interstellar","interstate"])) // "inters"
print(longestCommonPrefix(["a"]))                                        // "a"
print(longestCommonPrefix(["","abc"]))                                   // ""
print()


//============================================================
// Q24_LC151_Reverse_Words_in_a_String
// Pattern: Build words, prepend each finished word
// Time: O(n * w)   Space: O(n)   — w = number of words.
// NOT O(n): `word + " " + result` copies the whole result
// every time, so the cost is quadratic in the worst case.
// The O(n) alternative is to collect words into an array and
// join them backwards.
// Edge cases: leading/trailing spaces; multiple spaces between
// words; the final word has no trailing space to trigger it
//============================================================

func reverseWords(_ s: String) -> String {
    var result = ""
    var currentWord = ""

    for ch in s {
        if ch == " " {
            if !currentWord.isEmpty {
                if result.isEmpty {
                    result = currentWord
                } else {
                    result = currentWord + " " + result
                }
            }
            currentWord = ""
        } else {
            currentWord.append(ch)
        }
    }

    // the last word never hits a space, so flush it here
    if !currentWord.isEmpty {
        if result.isEmpty {
            result = currentWord
        } else {
            result = currentWord + " " + result
        }
    }

    return result
}

print("Q24_LC151_Reverse_Words_in_a_String")
print(reverseWords("the sky is blue"))      // "blue is sky the"
print(reverseWords("  hello world  "))      // "world hello"
print(reverseWords("a good   example"))     // "example good a"
print(reverseWords("single"))               // "single"
print()


//============================================================
// Q25_LC347_Top_K_Frequent_Elements
// Pattern: Bucket by Frequency — index IS the count
// Time: O(n)   Space: O(n)
//
// Buckets beat a heap here: a frequency can never exceed n, so
// an array of n+1 lists covers every possible count and one
// backward walk finds the top k without sorting.
// Edge cases: k == nums.count; every element unique; ties at
// the k boundary (LeetCode guarantees the answer is unique)
//============================================================

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var hashMap = [Int: Int]()

    for num in nums {
        if let count = hashMap[num] {
            hashMap[num] = count + 1
        } else {
            hashMap[num] = 1
        }
    }
    var buckets = Array(repeating: [Int](), count: nums.count + 1)

    for (value, count) in hashMap {
        buckets[count].append(value)
    }
    var result = [Int]()
    var j = buckets.count - 1

    while result.count < k && j >= 0 {
        for value in buckets[j] {
            // stop mid-bucket so ties can never over-return
            if result.count == k {
                break
            }
            result.append(value)
        }
        j -= 1
    }

    return result
}

print("Q25_LC347_Top_K_Frequent_Elements")
print(topKFrequent([1,1,1,2,2,3], 2)) // [1,2]
print(topKFrequent([1], 1))           // [1]
print(topKFrequent([4,4,4,6,6,7], 1)) // [4]
print(topKFrequent([1,2], 2))         // [1,2]
print()


//============================================================
// Q26_LC383_Ransom_Note
// Pattern: HashMap Frequency — consume as you go
// Time: O(m + n)   Space: O(1) — bounded by the alphabet
// Edge cases: empty note -> true; empty magazine with a
// non-empty note -> false; repeated letters must be counted,
// not just checked for presence
//============================================================

// Helper — shared with Q29
// Time: O(n)   Space: O(1) bounded by the alphabet
func buildMap(_ s: String) -> [Character: Int] {
    var map = [Character: Int]()

    for ch in s {
        if let count = map[ch] {
            map[ch] = count + 1
        } else {
            map[ch] = 1
        }
    }

    return map
}

func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    var availableMap = buildMap(magazine)

    for ch in ransomNote {
        if let count = availableMap[ch] {
            if count == 1 {
                availableMap[ch] = nil
            } else {
                availableMap[ch] = count - 1
            }
        } else {
            return false
        }
    }

    return true
}

print("Q26_LC383_Ransom_Note")
print(canConstruct("a", "b"))      // false
print(canConstruct("aa", "ab"))    // false
print(canConstruct("aa", "aab"))   // true
print(canConstruct("", "abc"))     // true
print(canConstruct("abc", ""))     // false
print()


//============================================================
// Q27_LC205_Isomorphic_Strings
// Pattern: Two-Map Bijection
// Time: O(n)   Space: O(1) — bounded by the character set
//
// ONE map is not enough. s->t alone accepts "ab"/"aa", because
// nothing stops two source characters mapping onto the same
// target. The reverse map is what enforces one-to-one.
// Edge cases: "ab"/"aa"; "badc"/"baba"; different lengths
//============================================================

func isIsomorphic(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    var sMap = [Character: Character]()
    var tMap = [Character: Character]()
    let sWords = Array(s)
    let tWords = Array(t)

    for i in 0..<sWords.count {
        let left = sWords[i]
        let right = tWords[i]

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

print("Q27_LC205_Isomorphic_Strings")
print(isIsomorphic("egg", "add"))      // true
print(isIsomorphic("foo", "bar"))      // false
print(isIsomorphic("paper", "title"))  // true
print(isIsomorphic("badc", "baba"))    // false
print(isIsomorphic("ab", "aa"))        // false — needs the reverse map
print()


//============================================================
// Q28_LC290_Word_Pattern
// Pattern: Two-Map Bijection — same shape as Q27, but the
// right-hand side is words instead of characters
// Time: O(n)   Space: O(n) — the words array is genuinely O(n)
// Edge cases: counts differ ("aaaa" vs 2 words); same word for
// two different letters ("abba" / "dog dog dog dog")
//============================================================

// Helper — manual split, no built-in components(separatedBy:)
func getWords(_ s: String) -> [String] {
    var words = [String]()
    var word = ""

    for ch in s {
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

func wordPattern(_ pattern: String, _ s: String) -> Bool {
    let chars = Array(pattern)
    let words = getWords(s)

    guard chars.count == words.count else { return false }

    var pMap = [Character: String]()
    var wMap = [String: Character]()

    for i in 0..<chars.count {
        let ch = chars[i]
        let word = words[i]

        if let mapped = pMap[ch] {
            if mapped != word {
                return false
            }
        } else {
            pMap[ch] = word
        }

        if let mapped = wMap[word] {
            if mapped != ch {
                return false
            }
        } else {
            wMap[word] = ch
        }
    }

    return true
}

print("Q28_LC290_Word_Pattern")
print(wordPattern("abba", "dog cat cat dog"))  // true
print(wordPattern("abba", "dog cat cat fish")) // false
print(wordPattern("aaaa", "dog cat cat dog"))  // false
print(wordPattern("abba", "dog dog dog dog"))  // false
print(wordPattern("a", "dog dog"))             // false — count guard
print()


//============================================================
// Q29_LC387_First_Unique_Character_in_a_String
// Pattern: HashMap Frequency — count first, then scan in order
// Time: O(n)   Space: O(1) — bounded by the alphabet
//
// Two passes are required. A single pass cannot know a
// character is unique until the whole string has been read.
// Edge cases: no unique character -> -1; single character -> 0
//============================================================

func firstUniqChar(_ s: String) -> Int {
    let map = buildMap(s)
    let words = Array(s)

    for i in 0..<words.count {
        if let count = map[words[i]], count == 1 {
            return i
        }
    }

    return -1
}

print("Q29_LC387_First_Unique_Character_in_a_String")
print(firstUniqChar("leetcode"))      // 0
print(firstUniqChar("loveleetcode"))  // 2
print(firstUniqChar("aabb"))          // -1
print(firstUniqChar("z"))             // 0
print()


//============================================================
// PATTERN SUMMARY — Phase 03
//
// Fixed-array frequency count   Q20
// Signature + HashMap group     Q21
// Two pointers on a string      Q22
// Character-by-character fold   Q23, Q24
// Bucket by frequency           Q25
// HashMap frequency consume     Q26, Q29
// Two-map bijection             Q27, Q28
//
// Wrong-tool traps in this phase
//   Q21  sorting each word (O(k log k)) when counting is O(k)
//   Q24  concatenating onto the front — quadratic, not linear
//   Q25  reaching for a heap when buckets give O(n)
//   Q27  one map instead of two — accepts "ab"/"aa"
//   Q29  trying to answer in one pass
//============================================================
