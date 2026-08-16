import Foundation

//============================================================
// Kadane's Algorithm - Notes
//============================================================

/*
 Purpose
 -------
 • Finds the Maximum Sum Contiguous Subarray.

 Idea
 ----
 • Traverse the array once.
 • At each element:
      - Start a new subarray.
      - OR continue the current subarray.
 • Keep track of the maximum sum seen so far.

 Formula
 -------
 currentSum = max(nums[i], currentSum + nums[i])
 maximumSum = max(maximumSum, currentSum)

 Time  : O(n)
 Space : O(1)

 Used In
 -------
 • LC 53 - Maximum Subarray
 • Maximum Circular Subarray

 Remember
 --------
 currentSum -> Best sum ending at current index.
 maximumSum -> Best sum found so far.
*/

var numbers = [-2, 1, -3, 4, -1, 2, 1, -5, 4]

//------------------------------------------------------------
// 01 Kadane's Algorithm
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

func maximumSubarray(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var currentSum = nums[0]
    var maximumSum = nums[0]

    for i in 1..<nums.count {

        currentSum = max(nums[i], currentSum + nums[i])
        maximumSum = max(maximumSum, currentSum)
    }

    return maximumSum
}

print("========== Kadane's Algorithm ==========")
print(maximumSubarray(numbers))


//------------------------------------------------------------
// 02 Kadane's Algorithm (Without max())
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

func maximumSubarrayManual(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var currentSum = nums[0]
    var maximumSum = nums[0]

    for i in 1..<nums.count {

        let sum = currentSum + nums[i]

        if sum > nums[i] {
            currentSum = sum
        } else {
            currentSum = nums[i]
        }

        if currentSum > maximumSum {
            maximumSum = currentSum
        }
    }

    return maximumSum
}

print()
print("========== Kadane's Algorithm (Manual) ==========")
print(maximumSubarrayManual(numbers))
