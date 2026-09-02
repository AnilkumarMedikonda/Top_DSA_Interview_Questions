import Foundation

//==============================================================
// Q39 — LC704 Binary Search
//==============================================================
/*
 Given a sorted array of DISTINCT integers (ascending) and a
 target, return the index of target, or -1 if not present.
 Must run in O(log n).

 Example:
   nums = [-1,0,3,5,9,12], target = 9   → 4
   nums = [-1,0,3,5,9,12], target = 2   → -1

 Constraints:
   1 <= nums.count <= 10^4
   -10^4 < nums[i], target < 10^4
   all distinct, sorted ascending

 Pattern: Classic Binary Search — closed interval, exact match.
 Edge cases: single element, target below min, target above max.
*/

//==============================================================
// MARK: - Brute Force
// Linear scan — the O(n) baseline binary search beats.
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
// Closed interval: low <= high, move by mid ± 1.
// T - O(log n), S - O(1)
//==============================================================
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

//==============================================================
// MARK: - Tests
//==============================================================
print("Brute Force")

print(searchBrute([-1,0,3,5,9,12], 9))    // 4

print(searchBrute([-1,0,3,5,9,12], 2))    // -1

print("Optimal")

print(search([-1,0,3,5,9,12], 9))         // 4

print(search([-1,0,3,5,9,12], 2))         // -1

print(search([5], 5))                     // 0

print(search([5], 0))                     // -1

print(search([1,2,3,4,5], 1))             // 0

print(search([1,2,3,4,5], 5))             // 4
