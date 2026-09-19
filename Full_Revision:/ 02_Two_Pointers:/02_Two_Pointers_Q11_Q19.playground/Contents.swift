import Foundation

// 02_Two_Pointers_Q11_Q19

//==============================================================
// MARK: - Phase 02. Two Pointers
//==============================================================

//==============================================================
// MARK: - Q11. Container With Most Water
// Difficulty: Medium
// LeetCode: LC011
//==============================================================
//
// Problem:
// Given an integer array height where height[i] represents the
// height of a vertical line, find two lines that together with
// the x-axis form a container that holds the most water.
//
// Example:
// Input: height = [1, 8, 6, 2, 5, 4, 8, 3, 7]
// Output: 49
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q11 - Container With Most Water")
print("==============================================================")

// Solution

func maxArea(_ heights: [Int]) -> Int {
    guard heights.count > 1 else { return 0 }
    var maxWater = 0
    var left = 0
    var right = heights.count - 1

    while left < right {
        let minHeight = min(heights[left], heights[right])
        let width = right - left
        maxWater = max(width * minHeight, maxWater)

        if heights[left] < heights[right] {
            left += 1
        } else {
            right -= 1
        }
    }

    return maxWater
}

// Test cases
print("Input: [1, 8, 6, 2, 5, 4, 8, 3, 7] -> \(maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]))")  // 49
print("Input: [1, 1] -> \(maxArea([1, 1]))")  // 1
print("Input: [4, 3, 2, 1, 4] -> \(maxArea([4, 3, 2, 1, 4]))")  // 16
print("Input: [1, 2, 1] -> \(maxArea([1, 2, 1]))")  // 2

print()

//==============================================================
// MARK: - Q12. 3Sum
// Difficulty: Medium
// LeetCode: LC015
//==============================================================
//
// Problem:
// Given an integer array nums, return all the triplets
// [nums[i], nums[j], nums[k]] such that i, j, and k are distinct
// and nums[i] + nums[j] + nums[k] == 0.
//
// Example:
// Input: nums = [-1, 0, 1, 2, -1, -4]
// Output: [[-1, -1, 2], [-1, 0, 1]]
//
// Time: O(n^2)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q12 - 3Sum")
print("==============================================================")

// Solution

func threeSum(_ nums: [Int]) -> [[Int]] {
    guard nums.count > 2 else { return [] }
    let sorted = nums.sorted()
    var result = [[Int]]()

    for i in 0..<sorted.count - 2 {
        if i > 0 && sorted[i] == sorted[i-1] {
            continue
        }

        var left = i + 1
        var right = sorted.count - 1

        while left < right {
            let sum = sorted[i] + sorted[left] + sorted[right]

            if sum == 0 {
                result.append([sorted[i], sorted[left], sorted[right]])

                while left < right, sorted[left] == sorted[left + 1] {
                    left += 1
                }
                while left < right, sorted[right] == sorted[right - 1] {
                    right -= 1
                }

                left += 1
                right -= 1
            } else if sum < 0 {
                left += 1
            } else {
                right -= 1
            }
        }
    }

    return result
}

// Test cases
print("Input: [-1, 0, 1, 2, -1, -4] -> \(threeSum([-1, 0, 1, 2, -1, -4]))")  // [[-1, -1, 2], [-1, 0, 1]]
print("Input: [0, 1, 1] -> \(threeSum([0, 1, 1]))")  // []
print("Input: [0, 0, 0] -> \(threeSum([0, 0, 0]))")  // [[0, 0, 0]]
print("Input: [-2, 0, 1, 1, 2] -> \(threeSum([-2, 0, 1, 1, 2]))")  // [[-2, 0, 2], [-2, 1, 1]]
print("Input: [] -> \(threeSum([]))")  // []

print()

//==============================================================
// MARK: - Q13. Trapping Rain Water
// Difficulty: Hard
// LeetCode: LC042
//==============================================================
//
// Problem:
// Given n non-negative integers representing an elevation map,
// compute how much water it can trap after raining.
//
// Example:
// Input: height = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
// Output: 6
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q13 - Trapping Rain Water")
print("==============================================================")

// Solution

func trap(_ heights: [Int]) -> Int {
    guard heights.count > 2 else { return 0 }
    var totalWater = 0
    var left = 0
    var right = heights.count - 1
    var leftMax = 0
    var rightMax = 0

    while left < right {
        if heights[left] < heights[right] {
            if heights[left] > leftMax {
                leftMax = heights[left]
            } else {
                totalWater += leftMax - heights[left]
            }
            left += 1
        } else {
            if heights[right] > rightMax {
                rightMax = heights[right]
            } else {
                totalWater += rightMax - heights[right]
            }
            right -= 1
        }
    }

    return totalWater
}

// Test cases
print("Input: [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1] -> \(trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]))")  // 6
print("Input: [4, 2, 0, 3, 2, 5] -> \(trap([4, 2, 0, 3, 2, 5]))")  // 9
print("Input: [1, 2, 3, 4, 5] -> \(trap([1, 2, 3, 4, 5]))")  // 0
print("Input: [5, 4, 3, 2, 1] -> \(trap([5, 4, 3, 2, 1]))")  // 0
print("Input: [1, 1] -> \(trap([1, 1]))")  // 0

print()

//==============================================================
// MARK: - Q14. Squares Of A Sorted Array
// Difficulty: Easy
// LeetCode: LC977
//==============================================================
//
// Problem:
// Given an integer array nums sorted in non-decreasing order,
// return an array of the squares of each number sorted in
// non-decreasing order.
//
// Example:
// Input: nums = [-4, -1, 0, 3, 10]
// Output: [0, 1, 9, 16, 100]
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q14 - Squares Of A Sorted Array")
print("==============================================================")

// Solution

func sortedSquares(_ nums: [Int]) -> [Int] {
    guard !nums.isEmpty else { return [] }
    var result = Array(repeating: 0, count: nums.count)
    var index = nums.count - 1
    var left = 0
    var right = nums.count - 1

    while left <= right {
        let leftSquare = nums[left] * nums[left]
        let rightSquare = nums[right] * nums[right]

        if leftSquare > rightSquare {
            result[index] = leftSquare
            left += 1
        } else {
            result[index] = rightSquare
            right -= 1
        }

        index -= 1
    }

    return result
}

// Test cases
print("Input: [-4, -1, 0, 3, 10] -> \(sortedSquares([-4, -1, 0, 3, 10]))")  // [0, 1, 9, 16, 100]
print("Input: [-7, -3, 2, 3, 11] -> \(sortedSquares([-7, -3, 2, 3, 11]))")  // [4, 9, 9, 49, 121]
print("Input: [0] -> \(sortedSquares([0]))")  // [0]
print("Input: [-5] -> \(sortedSquares([-5]))")  // [25]

print()

//==============================================================
// MARK: - Q15. Sort Colors
// Difficulty: Medium
// LeetCode: LC075
//==============================================================
//
// Problem:
// Given an array nums with n objects colored red, white, or blue,
// sort them in-place so that objects of the same color are adjacent,
// with colors in the order 0, 1, and 2.
//
// Example:
// Input: nums = [2, 0, 2, 1, 1, 0]
// Output: [0, 0, 1, 1, 2, 2]
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q15 - Sort Colors")
print("==============================================================")

// Solution

func sortColors(_ colors: inout [Int]) {
    var low = 0
    var mid = 0
    var high = colors.count - 1

    while mid <= high {
        if colors[mid] == 0 {
            colors.swapAt(mid, low)
            low += 1
            mid += 1
        } else if colors[mid] == 1 {
            mid += 1
        } else {
            colors.swapAt(mid, high)
            high -= 1
        }
    }
}

// Test cases
var colors1 = [2, 0, 2, 1, 1, 0]
sortColors(&colors1)
print("Input: [2, 0, 2, 1, 1, 0] -> \(colors1)")  // [0, 0, 1, 1, 2, 2]

var colors2 = [2, 0, 1]
sortColors(&colors2)
print("Input: [2, 0, 1] -> \(colors2)")  // [0, 1, 2]

var colors3 = [0]
sortColors(&colors3)
print("Input: [0] -> \(colors3)")  // [0]

var colors4 = [1]
sortColors(&colors4)
print("Input: [1] -> \(colors4)")  // [1]

var colors5 = [2, 2, 1, 1, 0, 0]
sortColors(&colors5)
print("Input: [2, 2, 1, 1, 0, 0] -> \(colors5)")  // [0, 0, 1, 1, 2, 2]

print()

//==============================================================
// MARK: - Q16. Next Permutation
// Difficulty: Medium
// LeetCode: LC031
//==============================================================
//
// Problem:
// Given an array of integers nums, rearrange it into the
// lexicographically next greater permutation of numbers. If such
// an arrangement is not possible, rearrange it into the lowest
// possible order.
//
// Example:
// Input: nums = [1, 2, 3]
// Output: [1, 3, 2]
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q16 - Next Permutation")
print("==============================================================")

// Solution

func reverseArray(_ nums: inout [Int], _ left: Int, _ right: Int) {
    var left = left
    var right = right

    while left < right {
        nums.swapAt(left, right)
        left += 1
        right -= 1
    }
}

func nextPermutation(_ nums: inout [Int]) {
    var pivot = nums.count - 2

    while pivot >= 0, nums[pivot] >= nums[pivot + 1] {
        pivot -= 1
    }

    if pivot >= 0 {
        var j = nums.count - 1
        while j >= 0, nums[pivot] >= nums[j] {
            j -= 1
        }
        nums.swapAt(j, pivot)
    }

    reverseArray(&nums, pivot + 1, nums.count - 1)
}

// Test cases
var permutation1 = [1, 2, 3]
nextPermutation(&permutation1)
print("Input: [1, 2, 3] -> \(permutation1)")  // [1, 3, 2]

var permutation2 = [3, 2, 1]
nextPermutation(&permutation2)
print("Input: [3, 2, 1] -> \(permutation2)")  // [1, 2, 3]

var permutation3 = [1, 1, 5]
nextPermutation(&permutation3)
print("Input: [1, 1, 5] -> \(permutation3)")  // [1, 5, 1]

var permutation4 = [1, 3, 2]
nextPermutation(&permutation4)
print("Input: [1, 3, 2] -> \(permutation4)")  // [2, 1, 3]

var permutation5 = [1]
nextPermutation(&permutation5)
print("Input: [1] -> \(permutation5)")  // [1]

print()

//==============================================================
// MARK: - Q17. Rotate Array
// Difficulty: Medium
// LeetCode: LC189
//==============================================================
//
// Problem:
// Given an integer array nums, rotate the array to the right by
// k steps.
//
// Example:
// Input: nums = [1, 2, 3, 4, 5, 6, 7], k = 3
// Output: [5, 6, 7, 1, 2, 3, 4]
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q17 - Rotate Array")
print("==============================================================")

// Solution

func rotate(_ nums: inout [Int], _ k: Int) {
    guard nums.count > 1 else { return }
    let shift = k % nums.count
    guard shift > 0 else { return }

    reverseArray(&nums, 0, nums.count - 1)
    reverseArray(&nums, 0, shift - 1)
    reverseArray(&nums, shift, nums.count - 1)
}

// Test cases
var rotate1 = [1, 2, 3, 4, 5, 6, 7]
rotate(&rotate1, 3)
print("Input: [1, 2, 3, 4, 5, 6, 7], k = 3 -> \(rotate1)")  // [5, 6, 7, 1, 2, 3, 4]

var rotate2 = [-1, -100, 3, 99]
rotate(&rotate2, 2)
print("Input: [-1, -100, 3, 99], k = 2 -> \(rotate2)")  // [3, 99, -1, -100]

var rotate3 = [1, 2]
rotate(&rotate3, 3)
print("Input: [1, 2], k = 3 -> \(rotate3)")  // [2, 1]

var rotate4 = [1]
rotate(&rotate4, 0)
print("Input: [1], k = 0 -> \(rotate4)")  // [1]

print()

//==============================================================
// MARK: - Q18. Merge Intervals
// Difficulty: Medium
// LeetCode: LC056
//==============================================================
//
// Problem:
// Given an array of intervals where intervals[i] = [start, end],
// merge all overlapping intervals.
//
// Example:
// Input: intervals = [[1, 3], [2, 6], [8, 10], [15, 18]]
// Output: [[1, 6], [8, 10], [15, 18]]
//
// Time: O(n log n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q18 - Merge Intervals")
print("==============================================================")

// Solution

func merge(_ intervals: [[Int]]) -> [[Int]] {
    guard intervals.count > 1 else { return intervals }
    let sortIntervals = intervals.sorted(by: { $0[0] < $1[0] })
    var result = [[Int]]()
    result.append(sortIntervals[0])

    var index = 1

    while index < sortIntervals.count {
        let last = result.count - 1

        if result[last][1] >= sortIntervals[index][0] {
            result[last][1] = max(result[last][1], sortIntervals[index][1])
        } else {
            result.append(sortIntervals[index])
        }

        index += 1
    }

    return result
}

// Test cases
print("Input: [[1, 3], [2, 6], [8, 10], [15, 18]] -> \(merge([[1, 3], [2, 6], [8, 10], [15, 18]]))")  // [[1, 6], [8, 10], [15, 18]]
print("Input: [[1, 4], [4, 5]] -> \(merge([[1, 4], [4, 5]]))")  // [[1, 5]]
print("Input: [[1, 3]] -> \(merge([[1, 3]]))")  // [[1, 3]]
print("Input: [[1, 10], [2, 3], [4, 8], [9, 12]] -> \(merge([[1, 10], [2, 3], [4, 8], [9, 12]]))")  // [[1, 12]]
print("Input: [] -> \(merge([]))")  // []

print()

//==============================================================
// MARK: - Q19. First Missing Positive
// Difficulty: Hard
// LeetCode: LC041
//==============================================================
//
// Problem:
// Given an unsorted integer array nums, return the smallest
// positive integer that is not present in nums.
//
// Example:
// Input: nums = [3, 4, -1, 1]
// Output: 2
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q19 - First Missing Positive")
print("==============================================================")

// Solution

func firstMissingPositive(_ nums: inout [Int]) -> Int {
    var index = 0

    while index < nums.count {
        let correctIndex = nums[index] - 1

        if nums[index] > 0, nums[index] <= nums.count, nums[index] != nums[correctIndex] {
            nums.swapAt(index, correctIndex)
        } else {
            index += 1
        }
    }

    index = 0

    while index < nums.count {
        if nums[index] != index + 1 {
            return index + 1
        }
        index += 1
    }

    return nums.count + 1
}

// Test cases
var missing1 = [1, 2, 0]
print("Input: [1, 2, 0] -> \(firstMissingPositive(&missing1))")  // 3

var missing2 = [3, 4, -1, 1]
print("Input: [3, 4, -1, 1] -> \(firstMissingPositive(&missing2))")  // 2

var missing3 = [7, 8, 9, 11, 12]
print("Input: [7, 8, 9, 11, 12] -> \(firstMissingPositive(&missing3))")  // 1

var missing4 = [1]
print("Input: [1] -> \(firstMissingPositive(&missing4))")  // 2

var missing5 = [1, 2, 3, 4, 5]
print("Input: [1, 2, 3, 4, 5] -> \(firstMissingPositive(&missing5))")  // 6

print()

//==============================================================
// MARK: - Phase 02. Two Pointers Revision Complete
//==============================================================
