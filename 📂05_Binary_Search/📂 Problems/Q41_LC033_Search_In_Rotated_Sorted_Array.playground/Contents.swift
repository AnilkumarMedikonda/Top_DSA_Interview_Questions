import Foundation

//==============================================================
// Q41 — LC033 Search in Rotated Sorted Array
//==============================================================
/*
 Ascending sorted array of DISTINCT integers, rotated at an
 unknown pivot. Given target, return its index or -1. O(log n).

 Example:
   [4,5,6,7,0,1,2], 0   → 4
   [4,5,6,7,0,1,2], 3   → -1
   [1], 0               → -1

 Constraints:
   1 <= nums.count <= 5000
   all distinct, values in -10^4 ... 10^4
   rotated ascending sort (rotation may be 0)

 Pattern: Rotated Array — one half is always sorted. Find it,
          then decide whether target lies inside that half.
 Trap: comparisons against nums[mid] are strict (< / >) — mid is
       already ruled out at the top.
 Edge cases: not found, single element, pivot at index 0.
*/

//==============================================================
// MARK: - Brute Force
// Linear scan — the O(n) baseline the rotation makes you beat.
// T - O(n), S - O(1)
//==============================================================
func searchBrute(_ nums: [Int], _ target: Int) -> Int {
    for i in 0..<nums.count {
        if nums[i] == target {
            return i
        }
    }
    return -1
}

//==============================================================
// MARK: - Optimal
// Closed interval. Branch on which half is sorted (nums[low] <=
// nums[mid]), then check if target falls in that sorted range.
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
        if nums[low] <= nums[mid] {
            // Left half sorted
            if target >= nums[low] && target < nums[mid] {
                high = mid - 1
            } else {
                low = mid + 1
            }
        } else {
            // Right half sorted
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
// MARK: - Tests
//==============================================================
print("Brute Force")

print(searchBrute([4,5,6,7,0,1,2], 0))   // 4

print("Optimal")

print(search([4,5,6,7,0,1,2], 0))   // 4

print(search([4,5,6,7,0,1,2], 3))   // -1

print(search([1], 0))               // -1

print(search([1], 1))               // 0

print(search([5,1,3], 5))           // 0
