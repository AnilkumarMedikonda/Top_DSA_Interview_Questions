import Foundation

//
//  06_Vertical_Scanning
//  Phase 03 — Strings and Hashing
//
//  Learn to compare characters at the same index across strings.
//
//  1. Start with two strings (commonPrefix).
//  2. Reuse that helper to solve LC14.
//
//  Feeds:
//  • Q23 — LC014 Longest Common Prefix
//

//============================================================
// MARK: - 01. Common Prefix (Two Strings)
// Time: O(min(m, n))
// Space: O(m + n) (Array conversion)
//============================================================

func commonPrefix(_ s1: String, _ s2: String) -> String {

    let a = Array(s1)
    let b = Array(s2)

    var prefix = ""
    var i = 0

    while i < a.count && i < b.count {

        if a[i] != b[i] {
            return prefix
        }

        prefix.append(a[i])
        i += 1
    }

    return prefix
}

print(commonPrefix("flower", "flight"))   // fl
print(commonPrefix("abc", "ab"))          // ab
print(commonPrefix("dog", "cat"))         // ""

//============================================================
// MARK: - 02. Q23 — LC014 Longest Common Prefix
//
// Pattern:
// Horizontal Scanning
//
// Time: O(n × m)
// n = number of strings
// m = shortest/common prefix length
//
// Space: O(m + n)
// (commonPrefix() converts two strings to arrays)
//============================================================

func longestCommonPrefix(_ strs: [String]) -> String {

    guard !strs.isEmpty else { return "" }

    var prefix = strs[0]

    for i in 1..<strs.count {

        prefix = commonPrefix(prefix, strs[i])

        if prefix.isEmpty {
            return ""
        }
    }

    return prefix
}

print(longestCommonPrefix(["flower", "flow", "flight"]))     // fl
print(longestCommonPrefix(["dog", "racecar", "car"]))        // ""
print(longestCommonPrefix(["abc", "ab", "abcd"]))            // ab
print(longestCommonPrefix(["interview", "internet", "internal"])) // inter
print(longestCommonPrefix(["a"]))                            // a
print(longestCommonPrefix([""]))                             // ""
