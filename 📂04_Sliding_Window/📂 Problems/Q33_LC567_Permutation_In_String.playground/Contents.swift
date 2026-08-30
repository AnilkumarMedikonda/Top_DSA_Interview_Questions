//
//  Q33_LC567_Permutation_In_String.swift
//
//  Does s2 contain a permutation of s1?
//
//  "ab", "eidbaooo" → true   ("ba" at index 3)
//  "ab", "eidboaoo" → false
//  "ab", "ab"       → true   (equal lengths count — guard must be <=)
//
//  A permutation has the same length as s1, so this is a FIXED window of
//  size s1.count. Slide it and compare frequency maps.
//
//  The == only works because decrement prunes at zero — a leftover
//  ["a": 0] would never match.
//
//  Brute   O(n²·k) / O(k)
//  Optimal O(n·k)  / O(k)   — a matched counter would drop it to O(n)
//
//  Wrong tool: sorting each window (O(n·k log k)); variable window
//  (nothing to shrink toward, the size is given).
//


// MARK: - Brute Force
// For every start index in s2, grow a window and build its frequency
// map from scratch. Stop growing once the window is longer than s1.
// T: O(n * m * 26)   S: O(26) ~ O(1)
// n = s2.count, m = s1.count
func checkInclusionBruteForce(_ s1: String, _ s2: String) -> Bool {

    if s1.count > s2.count {
        return false
    }

    // Map the PATTERN once
    var patternMap = [Character: Int]()
    for char in s1 {
        if let count = patternMap[char] {
            patternMap[char] = count + 1
        } else {
            patternMap[char] = 1
        }
    }

    // Slide over the SEARCH string
    let words = Array(s2)

    for i in 0..<words.count {

        var windowMap = [Character: Int]()

        for j in i..<words.count {

            // Window longer than pattern can never match
            if j - i + 1 > s1.count {
                break
            }

            let char = words[j]
            if let count = windowMap[char] {
                windowMap[char] = count + 1
            } else {
                windowMap[char] = 1
            }

            if windowMap == patternMap {
                return true
            }
        }
    }
    return false
}

// MARK: - Optimised (Fixed-Size Sliding Window)
// Consecutive windows differ by only 2 characters: one enters on the
// right, one leaves on the left. Maintain ONE window map and update
// it per slide instead of rebuilding.
// T: O(26 * n)   S: O(26) ~ O(1)
func checkInclusionOptimised(_ s1: String, _ s2: String) -> Bool {

    if s1.count > s2.count {
        return false
    }

    // Map the PATTERN once
    var patternMap = [Character: Int]()
    for char in s1 {
        if let count = patternMap[char] {
            patternMap[char] = count + 1
        } else {
            patternMap[char] = 1
        }
    }

    // Slide over the SEARCH string
    let words = Array(s2)

    var windowMap = [Character: Int]()
    var left = 0

    for right in 0..<words.count {

        // 1. Add the entering char
        let char = words[right]
        if let count = windowMap[char] {
            windowMap[char] = count + 1
        } else {
            windowMap[char] = 1
        }

        // 2. Shrink when window exceeds PATTERN LENGTH
        //    (window length, NOT map key count)
        while right - left + 1 > s1.count {
            let leftChar = words[left]
            if let count = windowMap[leftChar] {
                if count == 1 {
                    windowMap[leftChar] = nil   // remove key, never leave 0
                } else {
                    windowMap[leftChar] = count - 1
                }
            }
            left += 1
        }

        // 3. Compare FULL maps on every iteration (keys AND counts)
        if windowMap == patternMap {
            return true
        }
    }

    return false
}

// MARK: - Dry Run
// s1 = "ab" -> patternMap = [a:1, b:1]
// s2 = "eidbaooo"
//
// right | char | windowMap after add | shrink?          | compare
// ------|------|---------------------|------------------|--------
//   0   |  e   | [e:1]               | size 1, no       | no
//   1   |  i   | [e:1, i:1]          | size 2, no       | no
//   2   |  d   | [e:1, i:1, d:1]     | drop e -> [i,d]  | no
//   3   |  b   | [i:1, d:1, b:1]     | drop i -> [d,b]  | no
//   4   |  a   | [d:1, b:1, a:1]     | drop d -> [b,a]  | [b:1, a:1] == [a:1, b:1] -> TRUE
//
// s2 = "eidboaoo": the a and b are never adjacent, so no window of
// size 2 ever holds [a:1, b:1] -> loop ends -> false.

// MARK: - Complexity
// Brute force: O(n * m * 26) time — for each of n starts, build up to
//   m chars and compare maps bounded by 26 letters. Space O(26).
// Optimised:   O(26 * n) time — one add + one remove per slide, and
//   each map comparison touches at most 26 keys. Space O(26) ~ O(1).

// MARK: - Traps
// 1. Role reversal: s1 is the PATTERN (mapped once), s2 is the SEARCH
//    string (slide over it). Guard is s1.count > s2.count.
// 2. Stale zero keys: when a leaving char's count hits 0, remove the
//    key entirely. [a:1, b:1, e:0] != [a:1, b:1] in Swift's == and
//    every future comparison silently fails.
// 3. Comparing key COUNTS instead of maps: patternMap.count ==
//    windowMap.count matches [e:1, i:1] with [a:1, b:1]. Always use
//    full map equality: windowMap == patternMap.
// 4. Shrink condition is WINDOW LENGTH (right - left + 1 > s1.count),
//    not map key count — "eee" has 3 chars but only 1 key.
// 5. Comparison must be INSIDE the loop — checking only after the
//    loop tests just the final window and misses mid-string matches.
// 6. Brute force: break the inner loop once the window is longer than
//    the pattern — it can never match after that.

// MARK: - Tests

print("--- Brute Force ---")

print("\"ab\" in \"eidbaooo\": \(checkInclusionBruteForce("ab", "eidbaooo"))")

print("\"ab\" in \"eidboaoo\": \(checkInclusionBruteForce("ab", "eidboaoo"))")

print("\"ab\" in \"ab\": \(checkInclusionBruteForce("ab", "ab"))")

print()
print("--- Optimised ---")

print("\"ab\" in \"eidbaooo\": \(checkInclusionOptimised("ab", "eidbaooo"))")

print("\"ab\" in \"eidboaoo\": \(checkInclusionOptimised("ab", "eidboaoo"))")

print("\"ab\" in \"ab\": \(checkInclusionOptimised("ab", "ab"))")

print("\"a\" in \"a\": \(checkInclusionOptimised("a", "a"))")

print("\"a\" in \"b\": \(checkInclusionOptimised("a", "b"))")

print("\"abc\" in \"ab\": \(checkInclusionOptimised("abc", "ab"))")

print("\"adc\" in \"dcda\": \(checkInclusionOptimised("adc", "dcda"))")

print("\"aab\" in \"eidbaaboo\": \(checkInclusionOptimised("aab", "eidbaaboo"))")

print("\"hello\" in \"ooolleoooleh\": \(checkInclusionOptimised("hello", "ooolleoooleh"))")

// MARK: - Interview Q&A
//
// Q1. Why is this a FIXED-size window when Minimum Window Substring
//     (#78-79) was variable-size?
// A1. A permutation of s1 must have exactly s1.count characters, so
//     every candidate window has one known length. Minimum Window asks
//     for the SHORTEST valid window, so its length is unknown and the
//     window must grow and shrink dynamically.
//
// Q2. Why do we compare frequency maps instead of generating
//     permutations of s1 and searching for each?
// A2. s1 of length m has m! permutations — factorial blow-up. All
//     permutations share one property: same characters with same
//     counts. Frequency comparison checks that property in O(26).
//
// Q3. Why must a key be deleted when its count reaches 0?
// A3. Swift dictionary equality compares key sets and values. A stale
//     [e:0] entry makes the window map unequal to the pattern map even
//     when real frequencies match, so matches are silently missed.
//
// Q4. How would you drop the O(26) comparison per slide to O(1)?
// A4. Track a matches counter over the 26 letters (same formed /
//     required idea from Minimum Window). Only the entering and
//     leaving characters can change match status, so update the
//     counter for at most 2 letters per slide and check
//     matches == 26 (or matches == required distinct letters).
//
// Q5. What is the overall complexity of the optimised solution?
// A5. Time O(26 * n): each slide does O(1) map updates plus a map
//     comparison bounded by 26 lowercase letters. Space O(26) ~ O(1)
//     for the two maps. With the matches-counter optimisation, time
//     becomes O(n).
