import Foundation

//==============================================================
// MARK: - 01. Bubble Sort
//==============================================================
//
// IDEA
//
// Walk the array, swapping adjacent pairs that are out of
// order. After pass 1 the largest element has bubbled to the
// end; after pass 2 the two largest are in place, and so on.
//
// Two things make it written well:
//
// 1. The inner bound shrinks — after i passes the last i
//    elements are final, so the walk stops at n - i - 1.
// 2. The early exit — a pass with zero swaps means the array
//    is already sorted. That is what turns the best case into
//    O(n).
//
// TRACE
//
// [5, 3, 8, 4, 2]
//
// pass 0  5>3 swap  [3,5,8,4,2]
//         5<8       [3,5,8,4,2]
//         8>4 swap  [3,5,4,8,2]
//         8>2 swap  [3,5,4,2,8]    8 is final
//
// pass 1  3<5, 5>4 swap, 5>2 swap  [3,4,2,5,8]
// pass 2  3<4, 4>2 swap            [3,2,4,5,8]
// pass 3  3>2 swap                 [2,3,4,5,8]
// pass 4  no swaps → early exit
//
// COMPLEXITY
//
// Worst / average: O(n²) — n passes, up to n comparisons each
// Best:            O(n)  — one clean pass, early exit fires
// Space:           O(1)  — sorts in place
// Stable:          yes   — swaps only on strict >, so equal
//                          elements keep their original order
//
//==============================================================

func bubbleSort(_ nums: inout [Int]) {
    let n = nums.count

    for i in 0..<n {
        var isSwapped = false

        // Last i elements are already in place
        for j in 0..<(n - i - 1) {
            if nums[j] > nums[j + 1] {
                nums.swapAt(j, j + 1)
                isSwapped = true
            }
        }

        // A pass with no swaps means the array is sorted
        if !isSwapped {
            break
        }
    }
}

//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== 01 - Bubble Sort ==========")

var nums1 = [5, 3, 8, 4, 2]
bubbleSort(&nums1)

print(nums1)
// [2, 3, 4, 5, 8]

var nums2 = [1, 2, 3, 4, 5]
bubbleSort(&nums2)

print(nums2)
// [1, 2, 3, 4, 5]   early exit after one pass

var nums3 = [5, 4, 3, 2, 1]
bubbleSort(&nums3)

print(nums3)
// [1, 2, 3, 4, 5]   worst case, every pass swaps

var nums4 = [3, 3, 3]
bubbleSort(&nums4)

print(nums4)
// [3, 3, 3]

var nums5 = [2, 2, 1, 3, 1]
bubbleSort(&nums5)

print(nums5)
// [1, 1, 2, 2, 3]

var nums6 = [1]
bubbleSort(&nums6)

print(nums6)
// [1]

var nums7 = [Int]()
bubbleSort(&nums7)

print(nums7)
// []
