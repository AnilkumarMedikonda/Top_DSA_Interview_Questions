import Foundation

// Q84 - LeetCode 198: House Robber
//
// Problem:
// Given an array of non-negative integers representing money
// in each house, return the maximum you can rob without
// robbing two adjacent houses.
//
// Example:
// nums = [2, 7, 9, 3, 1]
// Rob 2 + 9 + 1 = 12
//
// Constraints:
// 1 <= nums.count <= 100
// 0 <= nums[i] <= 400
//
// Brute force: recurse over rob/skip at each house. O(2^n) —
// the same suffix is re-solved on every branch. Not
// implemented; the repeated work is exactly what the dp
// transition removes.
//
// Pattern: Dynamic Programming
//
// Key Idea:
// Rob current  → prevTwo + num
// Skip current → prevOne
//
// current = max(prevOne, prevTwo + num)
//
// The i - 2 is what encodes "cannot rob adjacent houses".
//
// State is "best up to i" — cumulative — so the answer is the
// LAST value. Q85's state is "ending at i" and its answer is
// the max of the whole array. That difference is the trap.
//
// Only prevOne and prevTwo are ever read, so the dp array
// collapses into two variables.
//
// Time:  O(n)
// Space: O(1)

func rob(_ nums: [Int]) -> Int {

    if nums.isEmpty {
        return 0
    }

    var prevOne = 0
    var prevTwo = 0

    for num in nums {

        var current = max(prevTwo + num, prevOne)

        prevTwo = prevOne
        prevOne = current
    }

    return prevOne
}

// Trace
//
// nums = [2, 7, 9, 3, 1]
//
// start          prevTwo 0   prevOne 0
// num 2   max(0, 0 + 2) = 2  → prevTwo 0   prevOne 2
// num 7   max(2, 0 + 7) = 7  → prevTwo 2   prevOne 7
// num 9   max(7, 2 + 9) = 11 → prevTwo 7   prevOne 11
// num 3   max(11, 7 + 3) = 11 → prevTwo 11 prevOne 11
// num 1   max(11, 11 + 1) = 12 → prevTwo 11 prevOne 12
//
// Answer: 12

print("\n========== Q84 - House Robber ==========")

print(rob([2, 7, 9, 3, 1]))
// 12

print(rob([1, 2, 3, 1]))
// 4

print(rob([2, 1, 1, 2]))
// 4

print(rob([5]))
// 5

print(rob([Int]()))
// 0

print(rob([0, 0, 0]))
// 0

print(rob([100, 1, 1, 100]))
// 200
