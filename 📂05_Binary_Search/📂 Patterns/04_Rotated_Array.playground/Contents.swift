import Foundation

//==============================================================
// MARK: - 04_Rotated_Array
//==============================================================

/*
 Rotated Sorted Array

 Original:  1 2 3 4 5 6 7
 Rotated:   4 5 6 7 1 2 3

 --------------------------------------------------------------
 Key Idea

 One half is ALWAYS sorted.
 Find the sorted half, check whether the target lies inside it.
 If YES  → search that half.
 If NO   → search the other half.
 --------------------------------------------------------------
 Used In
 - LC33  - Search in Rotated Sorted Array
 - LC153 - Find Minimum in Rotated Sorted Array
*/

//==============================================================
// MARK: - Pattern 1 — Search With Target
// T - O(log n), S - O(1)
//==============================================================

func search(_ nums: [Int], _ target: Int) -> Int {
    var low = 0
    var high = nums.count - 1
    while low <= high {
        let mid = low + (high - low) / 2
        if nums[mid] == target {
            return mid
        }
        // Left half sorted
        if nums[low] <= nums[mid] {
            if target >= nums[low] && target < nums[mid] {
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        // Right half sorted
        else {
            if target > nums[mid] && target <= nums[high] {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
    }
    return -1
}

//==============================================================
// MARK: - Pattern 2 — Find Minimum (no target)
// Compare against nums[high], not the index. high = mid, not mid - 1.
// T - O(log n), S - O(1)
//==============================================================

func findMinimum(_ nums: [Int]) -> Int {
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

//==============================================================
// MARK: - Test
//==============================================================

print(search([4,5,6,7,0,1,2], 0))      // 4

print(search([4,5,6,7,0,1,2], 3))      // -1

print(search([6,7,1,2,3,4,5], 3))      // 4

print(search([1], 1))                  // 0

print(search([1], 0))                  // -1

print(findMinimum([4,5,6,7,0,1,2]))    // 0

print(findMinimum([10,20,30,1,5]))     // 1

print(findMinimum([2,1]))              // 1

print(findMinimum([1]))                // 1
