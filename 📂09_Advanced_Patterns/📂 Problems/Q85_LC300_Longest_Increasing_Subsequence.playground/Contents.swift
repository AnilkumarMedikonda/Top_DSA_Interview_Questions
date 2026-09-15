import Foundation

// Q85 - LeetCode 300: Longest Increasing Subsequence
//
// Problem:
// Given an integer array nums, return the length of the
// longest strictly increasing subsequence.
//
// A subsequence does not need to be continuous.
// We can skip elements, but the order must remain the same.
//
// Example:
// Input:
// [10, 9, 2, 5, 3, 7, 101, 18]
//
// Output:
// 4
//
// One possible LIS:
// [2, 3, 7, 101]
//
// Pattern:
// Dynamic Programming
//
// Key Idea:
// dp[i] = length of the longest increasing subsequence
// ending at index i.
//
// Every element by itself is an increasing subsequence.
// Therefore, initially dp[i] = 1.
//
// We compare the current element nums[i]
// with every previous element nums[j].
//
// If:
// nums[j] < nums[i]
//
// Then nums[i] can be added after the sequence ending at j.
//
// Formula:
// dp[i] = max(dp[i], dp[j] + 1)
//
// Important:
// nums → actual values
// dp   → length of the best sequence
//
// nums[j] < nums[i]
// → Check whether values are increasing.
//
// dp[j] + 1
// → Take previous sequence length + current element.
//
// Steps:
// 1. Handle empty array
// 2. Create dp array with all values = 1
// 3. Select current index i
// 4. Check every previous index j
// 5. Compare nums[j] and nums[i]
// 6. If nums[j] < nums[i], update dp[i]
// 7. Find maximum value in dp
// 8. Return maximum
//
// Example:
//
// nums = [2, 5, 3, 7]
//
// Initial:
// dp = [1, 1, 1, 1]
//
// Process 5:
// 2 < 5
// dp[1] = max(1, dp[0] + 1)
//       = max(1, 1 + 1)
//       = 2
//
// Process 3:
// 2 < 3
// dp[2] = max(1, dp[0] + 1)
//       = 2
//
// Process 7:
// 2 < 7 → dp = 2
// 5 < 7 → dp = 3
// 3 < 7 → dp = 3
//
// Final:
// dp = [1, 2, 2, 3]
//
// Answer:
// 3
//
// Time: O(n²)
// Space: O(n)
//
// Note:
// There is an O(n log n) solution using Binary Search,
// but this O(n²) DP solution is easier to understand
// and explain in an interview.

func lengthOfLIS(_ nums: [Int]) -> Int {

    // Step 1: Handle empty array
    guard !nums.isEmpty else {
        return 0
    }

    // Step 2: Every element by itself has length 1
    var dp = Array(repeating: 1, count: nums.count)

    // Step 3: Select current element
    for i in 0..<nums.count {

        // Step 4: Check all previous elements
        for j in 0..<i {

            // Step 5: Check increasing order
            if nums[j] < nums[i] {

                // Step 6: Extend the best sequence ending at j
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
    }

    // Step 7: Find the longest sequence
    var maximum = 0

    for num in dp {
        if num > maximum {
            maximum = num
        }
    }

    // Step 8: Return answer
    return maximum
}

// MARK: - Test Cases

print("\n========== Q85 - Longest Increasing Subsequence ==========")

print(lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]))
// Expected: 4

print(lengthOfLIS([0, 1, 0, 3, 2, 3]))
// Expected: 4

print(lengthOfLIS([7, 7, 7, 7, 7]))
// Expected: 1

print(lengthOfLIS([1, 2, 3, 4, 5]))
// Expected: 5

print(lengthOfLIS([5, 4, 3, 2, 1]))
// Expected: 1

print(lengthOfLIS([2, 5, 3, 7]))
// Expected: 3

print(lengthOfLIS([]))
// Expected: 0
