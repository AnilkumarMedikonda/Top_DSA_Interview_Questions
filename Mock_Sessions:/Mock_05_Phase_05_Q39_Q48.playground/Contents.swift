import Foundation

//==============================================================
// Phase 05 — Binary Search Mock (Q39–Q47)
// 60 min • No hints • No notes • Blind rewrite
// Result: 9/9 recalled correct. Q41 fixed post-review (>→<).
//==============================================================

//--------------------------------------------------------------
// Q39 — LC704 Binary Search
// T - O(log n), S - O(1)
//--------------------------------------------------------------
func search(_ nums: [Int], _ target: Int) -> Int {
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

print("Q39")

print(search([-1,0,3,5,9,12], 9))   // 4

print(search([-1,0,3,5,9,12], 2))   // -1

print(search([5], 5))               // 0

print(search([5], -5))              // -1

//--------------------------------------------------------------
// Q40 — LC035 Search Insert Position (lower bound)
// T - O(log n), S - O(1)
//--------------------------------------------------------------
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var answer = nums.count
    var low = 0
    var high = nums.count - 1
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

print("Q40")

print(searchInsert([1,3,5,6], 5))   // 2

print(searchInsert([1,3,5,6], 2))   // 1

print(searchInsert([1,3,5,6], 7))   // 4

print(searchInsert([1,3,5,6], 0))   // 0

//--------------------------------------------------------------
// Q41 — LC033 Search in Rotated Sorted Array
// FIX: right-sorted branch was nums[mid] > target — must be <.
// T - O(log n), S - O(1)
//--------------------------------------------------------------
func searchRotated(_ nums: [Int], _ target: Int) -> Int {
    var low = 0
    var high = nums.count - 1
    while low <= high {
        let mid = low + (high - low) / 2
        if nums[mid] == target {
            return mid
        }
        if nums[low] <= nums[mid] {
            // Left half sorted
            if nums[low] <= target && target < nums[mid] {
                high = mid - 1
            } else {
                low = mid + 1
            }
        } else {
            // Right half sorted
            if nums[mid] < target && target <= nums[high] {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
    }
    return -1
}

print("Q41")

print(searchRotated([4,5,6,7,0,1,2], 0))   // 4

print(searchRotated([4,5,6,7,0,1,2], 3))   // -1

print(searchRotated([5,6,7,1,2,3,4], 3))   // 5   regression: right-sorted branch

print(searchRotated([1], 0))               // -1

print(searchRotated([1], 1))               // 0

//--------------------------------------------------------------
// Q42 — LC153 Find Minimum in Rotated Sorted Array
// T - O(log n), S - O(1)
//--------------------------------------------------------------
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

print("Q42")

print(findMin([3,4,5,1,2]))        // 1

print(findMin([4,5,6,7,0,1,2]))    // 0

print(findMin([11,13,15,17]))      // 11

//--------------------------------------------------------------
// Q43 — LC074 Search a 2D Matrix
// T - O(log(m * n)), S - O(1)
//--------------------------------------------------------------
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard !matrix.isEmpty && !matrix[0].isEmpty else { return false }
    let rows = matrix.count
    let columns = matrix[0].count
    var low = 0
    var high = rows * columns - 1
    while low <= high {
        let mid = low + (high - low) / 2
        let r = mid / columns
        let c = mid % columns
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

print("Q43")

print(searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3))    // true

print(searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13))   // false

//--------------------------------------------------------------
// Q44 — LC875 Koko Eating Bananas
// T - O(n log(maxPile)), S - O(1)
//--------------------------------------------------------------
func canFinish(_ piles: [Int], _ k: Int, _ h: Int) -> Bool {
    var totalHours = 0
    for pile in piles {
        var hour = pile / k
        if pile % k != 0 {
            hour += 1
        }
        totalHours += hour
    }
    return totalHours <= h
}

func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    var maxPile = piles[0]
    for pile in piles {
        if pile > maxPile {
            maxPile = pile
        }
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

print("Q44")

print(minEatingSpeed([3,6,7,11], 8))          // 4

print(minEatingSpeed([30,11,23,4,20], 5))     // 30

print(minEatingSpeed([30,11,23,4,20], 6))     // 23

//--------------------------------------------------------------
// Q45 — LC162 Find Peak Element
// T - O(log n), S - O(1)
//--------------------------------------------------------------
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

print("Q45")

print(findPeakElement([1,2,3,1]))             // 2

print(findPeakElement([1,2,1,3,5,6,4]))       // 1 or 5

//--------------------------------------------------------------
// Q46 — LC1011 Capacity to Ship Packages Within D Days
// T - O(n log(sum)), S - O(1)
//--------------------------------------------------------------
func canShip(_ weights: [Int], _ days: Int, _ capacity: Int) -> Bool {
    var totalDays = 1
    var totalWeight = 0
    for weight in weights {
        if totalWeight + weight > capacity {
            totalWeight = weight
            totalDays += 1
        } else {
            totalWeight += weight
        }
    }
    return totalDays <= days
}

func shipWithinDays(_ weights: [Int], _ days: Int) -> Int {
    var maxWeight = weights[0]
    var totalWeight = 0
    for weight in weights {
        if weight > maxWeight {
            maxWeight = weight
        }
        totalWeight += weight
    }
    var left = maxWeight
    var right = totalWeight
    var answer = maxWeight
    while left <= right {
        let mid = left + (right - left) / 2
        if canShip(weights, days, mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return answer
}

print("Q46")

print(shipWithinDays([1,2,3,4,5,6,7,8,9,10], 5))   // 15

print(shipWithinDays([3,2,2,4,1,4], 3))            // 6

print(shipWithinDays([1,2,3,1,1], 4))              // 3

//--------------------------------------------------------------
// Q47 — LC410 Split Array Largest Sum
// T - O(n log(sum)), S - O(1)
//--------------------------------------------------------------
func canSplit(_ nums: [Int], _ m: Int, _ maxSum: Int) -> Bool {
    var subArray = 1
    var currentSum = 0
    for num in nums {
        if currentSum + num > maxSum {
            currentSum = num
            subArray += 1
        } else {
            currentSum += num
        }
    }
    return subArray <= m
}

func splitArray(_ nums: [Int], _ m: Int) -> Int {
    var maxSum = nums[0]
    var totalSum = 0
    for num in nums {
        if num > maxSum {
            maxSum = num
        }
        totalSum += num
    }
    var left = maxSum
    var right = totalSum
    var answer = totalSum
    while left <= right {
        let mid = left + (right - left) / 2
        if canSplit(nums, m, mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return answer
}

print("Q47")

print(splitArray([7,2,5,10,8], 2))      // 18

print(splitArray([1,2,3,4,5], 2))       // 9

print(splitArray([1,4,4], 3))           // 4
