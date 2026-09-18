import Foundation

//==============================================================
// MARK: - 03. Insertion Sort
//==============================================================
//
// IDEA
//
// Grow a sorted prefix. Everything left of i is already in
// order; take nums[i] as the key, shift the larger elements
// one slot right, and drop the key into the gap.
//
// Shift, do not swap. A swap writes twice per step; shifting
// writes once and the key lands exactly once at the end. Same
// O(n²), noticeably fewer writes.
//
// TRACE
//
// [5, 3, 8, 4, 2]
//
// i=1  key 3   5>3 shift   [5,5,8,4,2] → [3,5,8,4,2]
// i=2  key 8   5<8 stop    [3,5,8,4,2]
// i=3  key 4   8>4 shift, 5>4 shift, 3<4 stop → [3,4,5,8,2]
// i=4  key 2   8,5,4,3 all shift → [2,3,4,5,8]
//
// COMPLEXITY
//
// Worst / average: O(n²) — each element shifts past up to i
//                          predecessors
// Best:            O(n)  — sorted input, the while never runs.
//                          This is why libraries fall back to
//                          insertion sort for small subarrays
// Space:           O(1)  — in place
// Stable:          yes   — see the strict > below
//
//==============================================================

func insertionSort(_ nums: inout [Int]) {
    if nums.count < 2 {
        return
    }

    for i in 1..<nums.count {
        let key = nums[i]
        var j = i - 1

        // Strict > is the stability decision: the shift stops at
        // the first element equal to the key, so equal elements
        // are never passed over. Make it >= and it is unstable.
        while j >= 0, nums[j] > key {
            nums[j + 1] = nums[j]
            j -= 1
        }

        nums[j + 1] = key
    }
}

//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== 02 - Insertion Sort ==========")

var nums1 = [5, 3, 8, 4, 2]
insertionSort(&nums1)

print(nums1)
// [2, 3, 4, 5, 8]

var nums2 = [1, 2, 3, 4, 5]
insertionSort(&nums2)

print(nums2)
// [1, 2, 3, 4, 5]   best case, no shifts at all

var nums3 = [5, 4, 3, 2, 1]
insertionSort(&nums3)

print(nums3)
// [1, 2, 3, 4, 5]   worst case, every element shifts to the front

var nums4 = [3, 3, 3]
insertionSort(&nums4)

print(nums4)
// [3, 3,
