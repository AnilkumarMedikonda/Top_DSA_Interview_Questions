import Foundation

/*
 Q04 — LC053 Maximum Subarray                            [Medium]

 Given an integer array nums, find the subarray with the largest
 sum, and return its sum.

 Example 1:  nums = [-2,1,-3,4,-1,2,1,-5,4]  ->  6
             The subarray [4,-1,2,1] has the largest sum 6.

 Example 2:  nums = [1]                      ->  1

 Example 3:  nums = [5,4,-1,7,8]             ->  23
             The whole array has the largest sum 23.

 Constraints:
   1 <= nums.length <= 10^5
   -10^4 <= nums[i] <= 10^4

 Follow-up: try a divide and conquer solution, which is subtler.
*/

let nums1 = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
let nums2 = [1]
let nums3 = [5, 4, -1, 7, 8]
let nums4 = [-3, -1, -2]

//============================================================
// MARK: - Brute Force
// Time : O(n²)
// Space: O(1)
//
// Every start index i, extending j to the end, carrying a
// running sum. TLE at n = 10^5 — state it, do not submit it.
//============================================================

func maxSubArrayBruteForce(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    var maxSum = nums[0]
    for i in 0..<nums.count {
        var sum = 0
        for j in i..<nums.count {
            sum += nums[j]
            if sum > maxSum {
                maxSum = sum
            }
        }
    }
    return maxSum
}

print("========== Brute Force ==========")

print(maxSubArrayBruteForce(nums1))

print(maxSubArrayBruteForce(nums2))

print(maxSubArrayBruteForce(nums3))

print(maxSubArrayBruteForce(nums4))

//============================================================
// MARK: - Optimal (Kadane)
// Time : O(n)
// Space: O(1)
//
// Carry the best sum ENDING AT the current index. At each step
// there are only two options: extend the previous run, or start
// fresh here. A negative running sum is dead weight, so drop it.
//
// currentSum > 0  ->  extending helps
// currentSum <= 0 ->  the run is a liability, restart at nums[i]
//
// Initialise to nums[0], NEVER 0. With 0, an all-negative array
// returns 0 — a subarray that does not exist. nums4 proves it.
//============================================================

func maxSubArray(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    var maxSum = nums[0]
    var currentSum = nums[0]
    for i in 1..<nums.count {
        if currentSum > 0 {
            currentSum += nums[i]
        } else {
            currentSum = nums[i]
        }
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }
    return maxSum
}

print("========== Optimal (Kadane) ==========")

print(maxSubArray(nums1))

print(maxSubArray(nums2))

print(maxSubArray(nums3))

print(maxSubArray(nums4))
