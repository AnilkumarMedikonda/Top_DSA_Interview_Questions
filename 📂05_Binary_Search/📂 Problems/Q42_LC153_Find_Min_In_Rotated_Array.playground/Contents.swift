import Foundation

//==============================================================
// Q42 — LC153 Find Minimum in Rotated Sorted Array
//==============================================================
/*
 Ascending sorted array of DISTINCT integers, rotated at an
 unknown pivot. Return the minimum element. O(log n). No target.

 Example:
   [3,4,5,1,2]       → 1
   [4,5,6,7,0,1,2]   → 0
   [11,13,15,17]     → 11   (rotation 0 — already sorted)
   [1]               → 1
   [2,1]             → 1

 Constraints:
   1 <= nums.count <= 5000
   all distinct, values in -5000 ... 5000
   rotated ascending sort (rotation may be 0)

 Pattern: Rotated Array (minimum) — converge on the pivot by
          comparing nums[mid] with nums[high].
 Traps: compare to nums[high] not nums[low] (breaks on sorted
        input); high = mid not mid - 1 (mid may be the minimum).
 Interval: half-open — low < high, converge, nums[low] on exit.
 Edge cases: rotation 0, single element, two elements.
*/

//==============================================================
// MARK: - Brute Force
// Linear scan tracking the smallest — the O(n) baseline.
// T - O(n), S - O(1)
//==============================================================
func findMinBrute(_ nums: [Int]) -> Int {
    var smallest = nums[0]
    for i in 0..<nums.count {
        if nums[i] < smallest {
            smallest = nums[i]
        }
    }
    return smallest
}

//==============================================================
// MARK: - Optimal
// Half-open interval. nums[mid] > nums[high] → dip is right;
// else mid could be the min → high = mid.
// T - O(log n), S - O(1)
//==============================================================
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

//==============================================================
// MARK: - Tests
//==============================================================
print("Brute Force")

print(findMinBrute([3,4,5,1,2]))       // 1

print("Optimal")

print(findMin([3,4,5,1,2]))       // 1

print(findMin([4,5,6,7,0,1,2]))   // 0

print(findMin([11,13,15,17]))     // 11

print(findMin([2,1]))             // 1

print(findMin([1]))               // 1
