
//
//  Q23_LC014_Longest_Common_Prefix
//  Phase 03 — Strings and Hashing
//
//  Find the longest string that starts every word in the array.
//  Return "" if there isn't one.
//
//  Example:
//  ["flower","flow","flight"] → "fl"
//  ["dog","racecar","car"]    → ""
//  ["abc","ab"]               → "ab"
//
//  Constraints:
//  1 <= strs.length <= 200
//  0 <= strs[i].length <= 200
//  Lowercase English letters.
//
//  Pattern: 06_Vertical_Scanning
//
//  Every other problem in this phase walks ALONG one string. This walks
//  ACROSS the array: fix a column index, check that position in every word,
//  advance only when all agree.
//  The length check must come BEFORE the character read, or a shorter word
//  indexes out of range.
//




// T - O(min(m, n))  S - O(min(m, n))
func commonPrefix(_ str1: String, _ str2: String) -> String {
    let a = Array(str1)
    let b = Array(str2)
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

// Brute force — every pair, keep the shortest prefix.
// Safe because pairwise prefixes nest: if P is common to all, it's a prefix
// of every pairwise prefix, so the shortest pairwise prefix IS P.
// T - O(n²·m)  S - O(m)
func longestCommonPrefixBrute(_ strs: [String]) -> String {
    guard !strs.isEmpty else { return "" }

    var longestPrefix = strs[0]

    for i in 0..<strs.count {
        for j in (i + 1)..<strs.count {
            let prefix = commonPrefix(strs[i], strs[j])

            if prefix.count < longestPrefix.count {
                longestPrefix = prefix
            }
        }
    }

    return longestPrefix
}

// Horizontal fold. T - O(S)  S - O(k)
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


print("BruetForec")

print(longestCommonPrefixBrute(["flower", "flow", "flight"]))

print(longestCommonPrefixBrute(["dog", "racecar", "car"]))

print(longestCommonPrefixBrute(["abc"]))

print(longestCommonPrefixBrute(["abc", "ab"]))

print(longestCommonPrefixBrute(["", "abc"]))

print(longestCommonPrefix([]))

print()

print()
print(longestCommonPrefix(["flower", "flow", "flight"]))

print(longestCommonPrefix(["dog", "racecar", "car"]))

print(longestCommonPrefix(["abc"]))

print(longestCommonPrefix(["abc", "ab"]))

print(longestCommonPrefix(["", "abc"]))

print(longestCommonPrefix([]))
