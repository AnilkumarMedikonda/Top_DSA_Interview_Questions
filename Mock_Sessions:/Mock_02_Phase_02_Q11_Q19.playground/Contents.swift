import Foundation

//============================================================
//
//  MOCK 02 — PHASE 02 (Two Pointers)
//
//  Part 1
//
//  Q11 — LC011 Container With Most Water
//  Q12 — LC015 Three Sum
//  Q13 — LC042 Trapping Rain Water
//
//============================================================



//============================================================
// MARK: - Q11 LC011 Container With Most Water
// Pattern: Two Pointers
// Time: O(n)
// Space: O(1)
//============================================================

/*
 Problem:

 Given an integer array height.

 Return the maximum amount of water a container can store.

 Example:

 Input:
 [1,8,6,2,5,4,8,3,7]

 Output:
 49
*/

var heights = [1,8,6,2,5,4,8,3,7]

func containerWithMostWater(_ heights: [Int]) -> Int {

    guard heights.count > 1 else {
        return 0
    }

    var left = 0
    var right = heights.count - 1

    var maxWater = 0

    while left < right {

        let height = min(heights[left], heights[right])
        let width = right - left

        let water = height * width

        maxWater = max(maxWater, water)

        if heights[left] < heights[right] {
            left += 1
        } else {
            right -= 1
        }
    }

    return maxWater
}

print("========== LC011 ==========")
print(containerWithMostWater(heights))
print()



//============================================================
// MARK: - Q12 LC015 Three Sum
// Pattern: Sorting + Two Pointers
// Time: O(n²)
// Space: O(1)
//============================================================

/*
 Problem:

 Return all unique triplets whose sum equals zero.

 Example:

 Input:
 [-1,0,1,2,-1,-4]

 Output:
 [[-1,-1,2],[-1,0,1]]
*/

var nums = [-1,0,1,2,-1,-4]

func threeSum(_ nums: [Int]) -> [[Int]] {

    let nums = nums.sorted()

    var result = [[Int]]()

    guard nums.count >= 3 else {
        return result
    }

    for i in 0..<nums.count-2 {

        if i > 0 && nums[i] == nums[i-1] {
            continue
        }

        var left = i + 1
        var right = nums.count - 1

        while left < right {

            let sum = nums[i] + nums[left] + nums[right]

            if sum == 0 {

                result.append([nums[i], nums[left], nums[right]])

                while left < right &&
                      nums[left] == nums[left + 1] {
                    left += 1
                }

                while left < right &&
                      nums[right] == nums[right - 1] {
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

print("========== LC015 ==========")
print(threeSum(nums))
print()



//============================================================
// MARK: - Q13 LC042 Trapping Rain Water
// Pattern: Two Pointers
// Time: O(n)
// Space: O(1)
//============================================================

/*
 Problem:

 Given n non-negative integers representing an elevation map,
 compute how much water it can trap.

 Example:

 Input:
 [0,1,0,2,1,0,1,3,2,1,2,1]

 Output:
 6
*/

var height = [0,1,0,2,1,0,1,3,2,1,2,1]

func trapRainWater(_ height: [Int]) -> Int {

    guard height.count > 2 else {
        return 0
    }

    var left = 0
    var right = height.count - 1

    var leftMax = 0
    var rightMax = 0

    var water = 0

    while left < right {

        if height[left] < height[right] {

            if height[left] >= leftMax {

                leftMax = height[left]

            } else {

                water += leftMax - height[left]
            }

            left += 1

        } else {

            if height[right] >= rightMax {

                rightMax = height[right]

            } else {

                water += rightMax - height[right]
            }

            right -= 1
        }
    }

    return water
}

print("========== LC042 ==========")
print(trapRainWater(height))
print()



//============================================================

//
// Q14 — LC977 Squares Of A Sorted Array
// Q15 — LC075 Sort Colors
// Q16 — LC031 Next Permutation
//
//============================================================



//============================================================
// MARK: - Q14 LC977 Squares Of A Sorted Array
// Pattern: Two Pointers
// Time: O(n)
// Space: O(n)
//============================================================

/*
 Problem:

 Given an integer array nums sorted in non-decreasing order,
 return an array of the squares of each number sorted
 in non-decreasing order.

 Example:

 Input:
 [-4,-1,0,3,10]

 Output:
 [0,1,9,16,100]
*/

 nums = [-4,-1,0,3,10]

func sortedSquares(_ nums: [Int]) -> [Int] {

    guard nums.count > 1 else {
        return nums.map { $0 * $0 }
    }

    var result = Array(repeating: 0, count: nums.count)

    var left = 0
    var right = nums.count - 1
    var index = nums.count - 1

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

print("========== LC977 ==========")
print(sortedSquares(nums))
print()



//============================================================
// MARK: - Q15 LC075 Sort Colors
// Pattern: Dutch National Flag
// Time: O(n)
// Space: O(1)
//============================================================

/*
 Problem:

 Sort an array containing only
 0,1,2

 Example:

 Input:
 [2,0,2,1,1,0]

 Output:
 [0,0,1,1,2,2]
*/

nums = [2,0,2,1,1,0]

func sortColors(_ nums: inout [Int]) {

    var low = 0
    var mid = 0
    var high = nums.count - 1

    while mid <= high {

        if nums[mid] == 0 {

            nums.swapAt(low, mid)
            low += 1
            mid += 1

        } else if nums[mid] == 1 {

            mid += 1

        } else {

            nums.swapAt(mid, high)
            high -= 1
        }
    }
}

sortColors(&nums)

print("========== LC075 ==========")
print(nums)
print()



//============================================================
// MARK: - Q16 LC031 Next Permutation
// Pattern: Two Pointers
// Time: O(n)
// Space: O(1)
//============================================================

/*
 Problem:

 Rearrange numbers into the next
 lexicographically greater permutation.

 If not possible,
 rearrange into ascending order.

 Example:

 [1,2,3]
 ↓

 [1,3,2]
*/

nums = [1,2,3]

func reverse(_ nums: inout [Int], start: Int) {

    var left = start
    var right = nums.count - 1

    while left < right {

        nums.swapAt(left, right)

        left += 1
        right -= 1
    }
}

func nextPermutation(_ nums: inout [Int]) {

    var pivot = nums.count - 2

    while pivot >= 0 &&
            nums[pivot] >= nums[pivot + 1] {

        pivot -= 1
    }

    if pivot >= 0 {

        var j = nums.count - 1

        while nums[j] <= nums[pivot] {

            j -= 1
        }

        nums.swapAt(pivot, j)
    }

    reverse(&nums, start: pivot + 1)
}

nextPermutation(&nums)

print("========== LC031 ==========")
print(nums)
print()



//============================================================
//
// MOCK 02 — PHASE 02 (Two Pointers)
////
// Q17 — LC189 Rotate Array
// Q18 — LC056 Merge Intervals
// Q19 — LC041 First Missing Positive
//
//============================================================



//============================================================
// MARK: - Q17 LC189 Rotate Array
// Pattern: Array Reversal
// Time: O(n)
// Space: O(1)
//============================================================

/*
 Problem:

 Rotate the array to the right by k steps.

 Example:

 Input:
 nums = [1,2,3,4,5,6,7]
 k = 3

 Output:
 [5,6,7,1,2,3,4]
*/

 nums = [1,2,3,4,5,6,7]
var k = 3

func reverse(_ nums: inout [Int], _ left: Int, _ right: Int) {

    var left = left
    var right = right

    while left < right {

        nums.swapAt(left, right)

        left += 1
        right -= 1
    }
}

func rotate(_ nums: inout [Int], _ k: Int) {

    guard nums.count > 1 else { return }

    let k = k % nums.count

    reverse(&nums, 0, nums.count - 1)
    reverse(&nums, 0, k - 1)
    reverse(&nums, k, nums.count - 1)
}

rotate(&nums, k)

print("========== LC189 ==========")
print(nums)
print()



//============================================================
// MARK: - Q18 LC056 Merge Intervals
// Pattern: Sorting + Interval Merge
// Time: O(n log n)
// Space: O(n)
//============================================================

/*
 Problem:

 Merge all overlapping intervals.

 Example:

 Input:
 [[1,3],[2,6],[8,10],[15,18]]

 Output:
 [[1,6],[8,10],[15,18]]
*/

var intervals = [
    [8,10],
    [1,3],
    [15,18],
    [2,6]
]

intervals.sort { $0[0] < $1[0] }

func mergeIntervals(_ intervals: [[Int]]) -> [[Int]] {

    guard intervals.count > 1 else {
        return intervals
    }

    var result = [[Int]]()

    result.append(intervals[0])

    for i in 1..<intervals.count {

        let last = result.count - 1

        if result[last][1] >= intervals[i][0] {

            result[last][1] = max(result[last][1], intervals[i][1])

        } else {

            result.append(intervals[i])
        }
    }

    return result
}

print("========== LC056 ==========")
print(mergeIntervals(intervals))
print()



//============================================================
// MARK: - Q19 LC041 First Missing Positive
// Pattern: Cyclic Sort
// Time: O(n)
// Space: O(1)
//============================================================

/*
 Problem:

 Return the smallest missing positive integer.

 Example:

 Input:
 [3,4,-1,1]

 Output:
 2
*/

nums = [3,4,-1,1]

func firstMissingPositive(_ nums: inout [Int]) -> Int {

    var index = 0

    while index < nums.count {

        let correctIndex = nums[index] - 1

        if nums[index] > 0 &&
            nums[index] <= nums.count &&
            nums[index] != nums[correctIndex] {

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

print("========== LC041 ==========")

print(firstMissingPositive(&nums))

print(nums)

print()
