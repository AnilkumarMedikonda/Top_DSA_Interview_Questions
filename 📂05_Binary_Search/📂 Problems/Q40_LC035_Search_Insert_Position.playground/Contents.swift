import Foundation

//==============================================================
// Q40 — LC035 Search Insert Position
//==============================================================
/*
 Sorted array of DISTINCT integers, ascending. Return the index
 of target if present; otherwise the index where it would be
 inserted to keep the array sorted. Must run in O(log n).

 Example:
   [1,3,5,6], 5   → 2   (found)
   [1,3,5,6], 2   → 1   (insert between 1 and 3)
   [1,3,5,6], 7   → 4   (past the end)
   [1,3,5,6], 0   → 0   (before everything)

 Constraints:
   1 <= nums.count <= 10^4
   sorted ascending, all distinct
   -10^4 <= target <= 10^4

 Pattern: Boundary Search (lower bound) — first index where
          nums[i] >= target. Found and not-found are one case.
 Edge cases: target past the end (answer = nums.count), insert
             at front, single element.
*/

//==============================================================
// MARK: - Brute Force
// Linear scan for the first index >= target.
// T - O(n), S - O(1)
//==============================================================
func searchInsertBruteForce(_ nums: [Int], _ target: Int) -> Int {
    for i in 0..<nums.count {
        if nums[i] >= target {
            return i
        }
    }
    return nums.count
}

//==============================================================
// MARK: - Optimal (Lower Bound)
// Closed interval, record-and-narrow. answer seeded to nums.count
// so "nothing >= target" returns the past-the-end position.
// T - O(log n), S - O(1)
//==============================================================
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

//==============================================================
// MARK: - Tests
//==============================================================
print("Brute Force")

print(searchInsertBruteForce([1,3,5,6], 5))   // 2

print(searchInsertBruteForce([1,3,5,6], 2))   // 1

print(searchInsertBruteForce([1,3,5,6], 7))   // 4

print(searchInsertBruteForce([1,3,5,6], 0))   // 0

print()
print("Optimal")
print(searchInsert([1,3,5,6], 5))   // 2

print(searchInsert([1,3,5,6], 2))   // 1

print(searchInsert([1,3,5,6], 7))   // 4

print(searchInsert([1,3,5,6], 0))   // 0

print(searchInsert([1], 0))         // 0
