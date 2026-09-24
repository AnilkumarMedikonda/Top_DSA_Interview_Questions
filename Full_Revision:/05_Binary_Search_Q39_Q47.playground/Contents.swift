import Foundation

// 05_Binary_Search_Q39_Q47

//==============================================================
// MARK: - Phase 05. Binary Search
//==============================================================

//==============================================================
// MARK: - Q39. Binary Search
// Difficulty: Easy
// LeetCode: LC704
//==============================================================
//
// Problem:
// Given an array of integers nums sorted in ascending order and
// an integer target, return the index of target if it exists,
// otherwise -1. Must run in O(log n).
//
// Example:
// Input: nums = [-1, 0, 3, 5, 9, 12], target = 9
// Output: 4
//
// Time: O(log n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q39 - Binary Search")
print("==============================================================")

// Solution

func binarySearch(_ nums: [Int], _ target: Int) -> Int {
    var low = 0
    var high = nums.count - 1

    while low <= high {
        let mid = low + (high - low) / 2

        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }

    return -1
}

// Test cases
print("Input: [-1, 0, 3, 5, 9, 12], target = 9 -> \(binarySearch([-1, 0, 3, 5, 9, 12], 9))")  // 4
print("Input: [-1, 0, 3, 5, 9, 12], target = 2 -> \(binarySearch([-1, 0, 3, 5, 9, 12], 2))")  // -1
print("Input: [5], target = 5 -> \(binarySearch([5], 5))")  // 0
print("Input: [], target = 0 -> \(binarySearch([], 0))")  // -1

print()

//==============================================================
// MARK: - Q40. Search Insert Position
// Difficulty: Easy
// LeetCode: LC035
//==============================================================
//
// Problem:
// Given a sorted array of distinct integers nums and a target,
// return the index if target is found, otherwise the index where
// it would be inserted in order. Must run in O(log n).
//
// Example:
// Input: nums = [1, 3, 5, 6], target = 5
// Output: 2
//
// Time: O(log n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q40 - Search Insert Position")
print("==============================================================")

// Solution

func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var low = 0
    var high = nums.count - 1
    var answer = nums.count

    while low <= high {
        let mid = low + (high - low) / 2

        if nums[mid] >= target {
            answer = mid
            high = mid - 1
        } else {
            low = mid + 1
        }
    }

    return answer
}

// Test cases
print("Input: [1, 3, 5, 6], target = 5 -> \(searchInsert([1, 3, 5, 6], 5))")  // 2
print("Input: [1, 3, 5, 6], target = 2 -> \(searchInsert([1, 3, 5, 6], 2))")  // 1
print("Input: [1, 3, 5, 6], target = 7 -> \(searchInsert([1, 3, 5, 6], 7))")  // 4
print("Input: [1, 3, 5, 6], target = 0 -> \(searchInsert([1, 3, 5, 6], 0))")  // 0

print()

//==============================================================
// MARK: - Q41. Search In Rotated Sorted Array
// Difficulty: Medium
// LeetCode: LC033
//==============================================================
//
// Problem:
// Given an array of distinct integers sorted ascending and then
// rotated at an unknown pivot, return the index of target, or -1
// if it is not present. Must run in O(log n).
//
// Example:
// Input: nums = [4, 5, 6, 7, 0, 1, 2], target = 0
// Output: 4
//
// Time: O(log n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q41 - Search In Rotated Sorted Array")
print("==============================================================")

// Solution

func searchRotatedArray(_ nums: [Int], _ target: Int) -> Int {
    var low = 0
    var high = nums.count - 1

    while low <= high {
        let mid = low + (high - low) / 2

        if nums[mid] == target {
            return mid
        }

        if nums[low] <= nums[mid] {
            if target >= nums[low], target < nums[mid] {
                high = mid - 1
            } else {
                low = mid + 1
            }
        } else {
            if target > nums[mid], target <= nums[high] {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
    }

    return -1
}

// Test cases
print("Input: [4, 5, 6, 7, 0, 1, 2], target = 0 -> \(searchRotatedArray([4, 5, 6, 7, 0, 1, 2], 0))")  // 4
print("Input: [4, 5, 6, 7, 0, 1, 2], target = 3 -> \(searchRotatedArray([4, 5, 6, 7, 0, 1, 2], 3))")  // -1
print("Input: [5, 6, 7, 8, 1, 2, 3, 4], target = 8 -> \(searchRotatedArray([5, 6, 7, 8, 1, 2, 3, 4], 8))")  // 3
print("Input: [3, 1], target = 1 -> \(searchRotatedArray([3, 1], 1))")  // 1
print("Input: [1], target = 1 -> \(searchRotatedArray([1], 1))")  // 0

print()

//==============================================================
// MARK: - Q42. Find Minimum In Rotated Sorted Array
// Difficulty: Medium
// LeetCode: LC153
//==============================================================
//
// Problem:
// Given an array of distinct integers sorted ascending and then
// rotated between 1 and n times, return the minimum element.
// Must run in O(log n).
//
// Example:
// Input: nums = [3, 4, 5, 1, 2]
// Output: 1
//
// Time: O(log n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q42 - Find Minimum In Rotated Sorted Array")
print("==============================================================")

// Solution

func findMin(_ nums: [Int]) -> Int {
    var low = 0
    var high = nums.count - 1

    while low < high {
        let mid = low + (high - low) / 2

        if nums[mid] > nums[high] {
            low = mid + 1
        } else {
            high = mid
        }
    }

    return nums[low]
}

// Test cases
print("Input: [3, 4, 5, 1, 2] -> \(findMin([3, 4, 5, 1, 2]))")  // 1
print("Input: [4, 5, 6, 7, 0, 1, 2] -> \(findMin([4, 5, 6, 7, 0, 1, 2]))")  // 0
print("Input: [11, 13, 15, 17] -> \(findMin([11, 13, 15, 17]))")  // 11
print("Input: [2, 1] -> \(findMin([2, 1]))")  // 1
print("Input: [1] -> \(findMin([1]))")  // 1

print()

//==============================================================
// MARK: - Q43. Search A 2D Matrix
// Difficulty: Medium
// LeetCode: LC074
//==============================================================
//
// Problem:
// Given an m x n matrix where each row is sorted ascending and
// each row's first value is greater than the previous row's last,
// return true if target exists. Must run in O(log(m * n)).
//
// Example:
// Input: matrix = [[1, 3, 5, 7], [10, 11, 16, 20], [23, 30, 34, 60]], target = 3
// Output: true
//
// Time: O(log(m * n))
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q43 - Search A 2D Matrix")
print("==============================================================")

// Solution

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard !matrix.isEmpty, !matrix[0].isEmpty else { return false }
    let rows = matrix.count
    let cols = matrix[0].count
    var low = 0
    var high = rows * cols - 1

    while low <= high {
        let mid = low + (high - low) / 2
        let r = mid / cols
        let c = mid % cols

        if matrix[r][c] == target {
            return true
        } else if matrix[r][c] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }

    return false
}

// Test cases
let matrix43 = [[1, 3, 5, 7], [10, 11, 16, 20], [23, 30, 34, 60]]

print("Input: matrix43, target = 3 -> \(searchMatrix(matrix43, 3))")  // true
print("Input: matrix43, target = 13 -> \(searchMatrix(matrix43, 13))")  // false
print("Input: matrix43, target = 60 -> \(searchMatrix(matrix43, 60))")  // true
print("Input: [[1, 3, 5]], target = 5 -> \(searchMatrix([[1, 3, 5]], 5))")  // true
print("Input: [[1]], target = 2 -> \(searchMatrix([[1]], 2))")  // false

print()

//==============================================================
// MARK: - Q44. Koko Eating Bananas
// Difficulty: Medium
// LeetCode: LC875
//==============================================================
//
// Problem:
// Given piles of bananas and h hours, Koko eats k bananas per
// hour from one pile, finishing a pile early if it has fewer than
// k left. Return the minimum k that finishes all piles in h hours.
//
// Example:
// Input: piles = [3, 6, 7, 11], h = 8
// Output: 4
//
// Time: O(n log m), m = largest pile
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q44 - Koko Eating Bananas")
print("==============================================================")

// Solution

func canFinish(_ piles: [Int], _ speed: Int, _ h: Int) -> Bool {
    var totalHours = 0

    for pile in piles {
        var hours = pile / speed
        if pile % speed != 0 {
            hours += 1
        }
        totalHours += hours
    }

    return totalHours <= h
}

func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    var maxPile = 0

    for pile in piles {
        maxPile = max(pile, maxPile)
    }

    var left = 1
    var right = maxPile
    var answer = maxPile

    while left <= right {
        let mid = left + (right - left) / 2

        if canFinish(piles, mid, h) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return answer
}

// Test cases
print("Input: [3, 6, 7, 11], h = 8 -> \(minEatingSpeed([3, 6, 7, 11], 8))")  // 4
print("Input: [30, 11, 23, 4, 20], h = 5 -> \(minEatingSpeed([30, 11, 23, 4, 20], 5))")  // 30
print("Input: [30, 11, 23, 4, 20], h = 6 -> \(minEatingSpeed([30, 11, 23, 4, 20], 6))")  // 23
print("Input: [1, 1, 1, 1], h = 4 -> \(minEatingSpeed([1, 1, 1, 1], 4))")  // 1
print("Input: [9], h = 3 -> \(minEatingSpeed([9], 3))")  // 3

print()

//==============================================================
// MARK: - Q45. Find Peak Element
// Difficulty: Medium
// LeetCode: LC162
//==============================================================
//
// Problem:
// A peak element is strictly greater than its neighbours. Given
// an integer array nums, return the index of any peak, treating
// nums[-1] and nums[n] as negative infinity. Must run in O(log n).
//
// Example:
// Input: nums = [1, 2, 3, 1]
// Output: 2
//
// Time: O(log n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q45 - Find Peak Element")
print("==============================================================")

// Solution

func findPeakElement(_ nums: [Int]) -> Int {
    var low = 0
    var high = nums.count - 1

    while low < high {
        let mid = low + (high - low) / 2

        if nums[mid] < nums[mid + 1] {
            low = mid + 1
        } else {
            high = mid
        }
    }

    return low
}

// Test cases
print("Input: [1, 2, 3, 1] -> \(findPeakElement([1, 2, 3, 1]))")  // 2
print("Input: [1, 2, 1, 3, 5, 6, 4] -> \(findPeakElement([1, 2, 1, 3, 5, 6, 4]))")  // 1 or 5
print("Input: [1, 2] -> \(findPeakElement([1, 2]))")  // 1
print("Input: [2, 1] -> \(findPeakElement([2, 1]))")  // 0
print("Input: [1] -> \(findPeakElement([1]))")  // 0

print()

//==============================================================
// MARK: - Q46. Capacity To Ship Packages Within D Days
// Difficulty: Medium
// LeetCode: LC1011
//==============================================================
//
// Problem:
// Given package weights shipped in order and a number of days,
// return the least ship capacity that ships everything within
// days. A package cannot be split across days.
//
// Example:
// Input: weights = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], days = 5
// Output: 15
//
// Time: O(n log S), S = sum of weights
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q46 - Capacity To Ship Packages Within D Days")
print("==============================================================")

// Solution

func canShipInDays(_ weights: [Int], _ days: Int, _ capacity: Int) -> Bool {
    var daysNeeded = 1
    var currentLoad = 0

    for weight in weights {
        if currentLoad + weight > capacity {
            daysNeeded += 1
            currentLoad = weight
        } else {
            currentLoad += weight
        }
    }

    return daysNeeded <= days
}

func shipWithinDays(_ weights: [Int], _ days: Int) -> Int {
    var maxWeight = 0
    var totalWeight = 0

    for weight in weights {
        maxWeight = max(weight, maxWeight)
        totalWeight += weight
    }

    var left = maxWeight
    var right = totalWeight
    var answer = totalWeight

    while left <= right {
        let mid = left + (right - left) / 2

        if canShipInDays(weights, days, mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return answer
}

// Test cases
print("Input: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], days = 5 -> \(shipWithinDays([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 5))")  // 15
print("Input: [3, 2, 2, 4, 1, 4], days = 3 -> \(shipWithinDays([3, 2, 2, 4, 1, 4], 3))")  // 6
print("Input: [1, 2, 3, 1, 1], days = 4 -> \(shipWithinDays([1, 2, 3, 1, 1], 4))")  // 3
print("Input: [1, 2, 3, 4, 5], days = 1 -> \(shipWithinDays([1, 2, 3, 4, 5], 1))")  // 15
print("Input: [10], days = 1 -> \(shipWithinDays([10], 1))")  // 10

print()

//==============================================================
// MARK: - Q47. Split Array Largest Sum
// Difficulty: Hard
// LeetCode: LC410
//==============================================================
//
// Problem:
// Given an integer array nums and an integer k, split nums into
// k non-empty contiguous subarrays and return the minimum
// possible value of the largest subarray sum.
//
// Example:
// Input: nums = [7, 2, 5, 10, 8], k = 2
// Output: 18
//
// Time: O(n log S), S = sum of nums
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q47 - Split Array Largest Sum")
print("==============================================================")

// Solution

func canSplitArray(_ nums: [Int], _ maxAllowed: Int, _ k: Int) -> Bool {
    var splits = 1
    var currentSum = 0

    for num in nums {
        if currentSum + num > maxAllowed {
            splits += 1
            currentSum = num
        } else {
            currentSum += num
        }
    }

    return splits <= k
}

func splitArray(_ nums: [Int], _ k: Int) -> Int {
    var maxNum = 0
    var totalSum = 0

    for num in nums {
        maxNum = max(num, maxNum)
        totalSum += num
    }

    var left = maxNum
    var right = totalSum
    var answer = totalSum

    while left <= right {
        let mid = left + (right - left) / 2

        if canSplitArray(nums, mid, k) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return answer
}

// Test cases
print("Input: [7, 2, 5, 10, 8], k = 2 -> \(splitArray([7, 2, 5, 10, 8], 2))")  // 18
print("Input: [1, 2, 3, 4, 5], k = 2 -> \(splitArray([1, 2, 3, 4, 5], 2))")  // 9
print("Input: [1, 4, 4], k = 3 -> \(splitArray([1, 4, 4], 3))")  // 4
print("Input: [1, 2, 3, 4, 5], k = 1 -> \(splitArray([1, 2, 3, 4, 5], 1))")  // 15
print("Input: [1, 1, 1, 1, 1], k = 5 -> \(splitArray([1, 1, 1, 1, 1], 5))")  // 1

print()

//==============================================================
// MARK: - Phase 05. Binary Search Revision Complete
//==============================================================
