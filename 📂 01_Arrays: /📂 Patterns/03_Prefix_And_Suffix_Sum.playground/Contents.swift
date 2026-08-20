//============================================================
// Prefix Sum & Suffix Sum - Notes
//============================================================

/*
 Prefix Sum
 ----------
 • Stores cumulative sum from left to right.
 • prefix[i] = Sum of elements from index 0 to i.
 • Used to answer range sum queries efficiently.
 • Build once in O(n), answer queries in O(1).

 Formula
 -------
 prefix[i] = prefix[i - 1] + nums[i]

 Range Sum
 ---------
 If left == 0
     sum = prefix[right]

 Else
     sum = prefix[right] - prefix[left - 1]


 Suffix Sum
 ----------
 • Stores cumulative sum from right to left.
 • suffix[i] = Sum of elements from index i to n-1.
 • Useful when information is needed from the current index to the end.

 Formula
 -------
 suffix[i] = suffix[i + 1] + nums[i]


 Time Complexity
 ---------------
 Build Prefix  : O(n)
 Build Suffix  : O(n)
 Range Query   : O(1)

 Space Complexity
 ----------------
 O(n)


 Used In
 -------
 • Range Sum Query
 • Product of Array Except Self
 • Subarray Sum Problems
 • Prefix/Suffix Based Interview Questions
*/


import Foundation

//============================================================
// 03 Prefix Sum Pattern
//============================================================

var numbers = [2, 4, 6, 8, 10]

print("========== Original Array ==========")
print(numbers)


//------------------------------------------------------------
// 01 Build Prefix Sum Array
//------------------------------------------------------------
// Time : O(n)
// Space: O(n)

func buildPrefixSum(_ nums: [Int]) -> [Int] {

    guard !nums.isEmpty else { return [] }

    var prefix = Array(repeating: 0, count: nums.count)
    var sum = 0

    for i in 0..<nums.count {
        sum += nums[i]
        prefix[i] = sum
    }

    return prefix
}

print()
print("========== Build Prefix Sum ==========")
let prefix = buildPrefixSum(numbers)
print(prefix)


//------------------------------------------------------------
// 02 Range Sum Query
//------------------------------------------------------------
// Time : O(1)
// Space: O(1)

func rangeSum(_ prefix: [Int], _ left: Int, _ right: Int) -> Int {

    guard !prefix.isEmpty else { return 0 }

    if left == 0 {
        return prefix[right]
    }

    return prefix[right] - prefix[left - 1]
}

print()
print("========== Range Sum Query ==========")
print("Range (0,2) =", rangeSum(prefix, 0, 2))
print("Range (1,3) =", rangeSum(prefix, 1, 3))
print("Range (2,4) =", rangeSum(prefix, 2, 4))


//------------------------------------------------------------
// 03 Build Suffix Sum Array
//------------------------------------------------------------
// Time : O(n)
// Space: O(n)

func buildSuffixSum(_ nums: [Int]) -> [Int] {

    guard !nums.isEmpty else { return [] }

    var suffix = Array(repeating: 0, count: nums.count)
    var sum = 0
    var index = nums.count - 1

    while index >= 0 {

        sum += nums[index]
        suffix[index] = sum

        index -= 1
    }

    return suffix
}

print()
print("========== Build Suffix Sum ==========")
let suffix = buildSuffixSum(numbers)
print(suffix)


//------------------------------------------------------------
// 04 Range Suffix Sum Query
//------------------------------------------------------------
// Sum from left index to end
//------------------------------------------------------------
// Time : O(1)
// Space: O(1)

func suffixRangeSum(_ suffix: [Int], _ left: Int) -> Int {

    guard !suffix.isEmpty else { return 0 }

    return suffix[left]
}

print()
print("========== Suffix Range Sum ==========")
print("Range (0,end) =", suffixRangeSum(suffix, 0))
print("Range (2,end) =", suffixRangeSum(suffix, 2))
print("Range (4,end) =", suffixRangeSum(suffix, 4))
