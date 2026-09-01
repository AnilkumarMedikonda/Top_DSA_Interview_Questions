import Foundation

//==============================================================
// MARK: - 05_Binary_Search_On_Slope
//==============================================================

/*
 Find Peak Element

 A peak is an element strictly greater than both neighbours.
 Off-the-edge neighbours count as -infinity, so the ends can be peaks.

 --------------------------------------------------------------
 Key Idea

 Unsorted input, but the slope is monotonic enough to halve.
 Compare mid with mid + 1 and walk uphill — a peak always waits
 in the rising direction.

 nums[mid] < nums[mid + 1]  → uphill,  peak is to the right → low = mid + 1
 else                       → downhill or at peak           → high = mid
 --------------------------------------------------------------
 Used In
 - LC162 - Find Peak Element
*/

//==============================================================
// MARK: - Template
// nums[mid + 1] is always safe: low < high ⇒ mid < high ⇒ mid + 1 ≤ high.
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
// MARK: - Test
//==============================================================

print(findPeakElement([1,2,3,1]))        // 2

print(findPeakElement([1,2,1,3,5,6,4]))  // 1 or 5

print(findPeakElement([1]))              // 0

print(findPeakElement([1,2]))            // 1

print(findPeakElement([2,1]))            // 0
