import Foundation

//==============================================================
// Q45 — LC162 Find Peak Element
//==============================================================
/*
 Find any peak element and return its index. A peak is strictly
 greater than both neighbours; off-the-edge neighbours count as
 -infinity, so the ends can be peaks. O(log n).

 Pattern: Binary Search on Slope
 Idea:
   nums[mid] < nums[mid + 1]  → increasing → peak is RIGHT → low = mid + 1
   nums[mid] > nums[mid + 1]  → decreasing → peak is LEFT (incl. mid) → high = mid
 Interval: half-open — low < high, return low.
 Safe: nums[mid + 1] never out of bounds since mid < high.

 Time  — Brute: O(n)   Optimal: O(log n)
 Space — O(1)
 Edge cases: single element, peak at front, peak at end.
*/

//==============================================================
// MARK: - Brute Force
// T - O(n), S - O(1)
//==============================================================
func peakElementBruteForce(_ nums: [Int]) -> Int {
    let n = nums.count
    if n == 1 {
        return 0
    }
    if nums[0] > nums[1] {
        return 0
    }
    for i in 1..<n - 1 {
        if nums[i] > nums[i - 1] && nums[i] > nums[i + 1] {
            return i
        }
    }
    if nums[n - 1] > nums[n - 2] {
        return n - 1
    }
    return -1
}

//==============================================================
// MARK: - Optimal
// T - O(log n), S - O(1)
//==============================================================
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

//==============================================================
// MARK: - Tests
//==============================================================
print("Brute Force")

print(peakElementBruteForce([1,2,3,1]))          // 2

print(peakElementBruteForce([1,2,1,3,5,6,4]))    // 1 or 5

print(peakElementBruteForce([1]))                // 0

print(peakElementBruteForce([5,4,3,2]))          // 0

print(peakElementBruteForce([1,2,3,4]))          // 3

print("Optimal")

print(findPeakElement([1,2,3,1]))             // 2

print(findPeakElement([1,2,1,3,5,6,4]))       // 1 or 5

print(findPeakElement([1]))                   // 0

print(findPeakElement([5,4,3,2]))             // 0

print(findPeakElement([1,2,3,4]))             // 3
