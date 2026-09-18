import Foundation

//==============================================================
// MARK: - 02. Selection Sort
//==============================================================
//
// IDEA
//
// At each position i, find the smallest element in the unsorted
// region i..<n and swap it into place. After pass i, the first
// i + 1 elements are final.
//
// Track the INDEX of the minimum, not the value — the index is
// what the swap needs.
//
// TRACE — [5, 3, 8, 4, 2]
//
// i=0  min of [5,3,8,4,2] is 2 at index 4 → swap  [2,3,8,4,5]
// i=1  min of   [3,8,4,5] is 3 at index 1 → no swap
// i=2  min of     [8,4,5] is 4 at index 3 → swap  [2,3,4,8,5]
// i=3  min of       [8,5] is 5 at index 4 → swap  [2,3,4,5,8]
//
// The last element needs no pass — it is whatever remains.
//
// COMPLEXITY
//
// Time:   O(n²) always — no early exit. Sorted input still does
//         every comparison, where bubble and insertion both
//         drop to O(n).
// Writes: exactly n - 1 swaps, whatever the input. That is the
//         one real advantage — when writes are expensive
//         (flash memory, say), selection beats bubble and
//         insertion despite identical big-O.
// Space:  O(1) — in place
// Stable: no — moving a distant minimum into place jumps it
//         over equal elements
//
//==============================================================

func selectionSort(_ nums: inout [Int]) {
    let n = nums.count

    if n < 2 {
        return
    }

    // Last element needs no pass — it is whatever remains
    for i in 0..<(n - 1) {
        var minIndex = i

        for j in (i + 1)..<n {
            if nums[j] < nums[minIndex] {
                minIndex = j
            }
        }

        // Skip the pointless self-swap
        if minIndex != i {
            nums.swapAt(i, minIndex)
        }
    }
}

//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== 02 - Selection Sort ==========")

var nums1 = [5, 3, 8, 4, 2]
selectionSort(&nums1)

print(nums1)
// [2, 3, 4, 5, 8]

var nums2 = [1, 2, 3, 4, 5]
selectionSort(&nums2)

print(nums2)
// [1, 2, 3, 4, 5]   still O(n²) — no early exit exists

var nums3 = [5, 4, 3, 2, 1]
selectionSort(&nums3)

print(nums3)
// [1, 2, 3, 4, 5]

var nums4 = [3, 3, 3]
selectionSort(&nums4)

print(nums4)
// [3, 3, 3]   zero swaps — minIndex never moves off i

var nums5 = [2, 2, 1, 3, 1]
selectionSort(&nums5)

print(nums5)
// [1, 1, 2, 2, 3]

var nums6 = [1]
selectionSort(&nums6)

print(nums6)
// [1]

var nums7 = [Int]()
selectionSort(&nums7)

print(nums7)
// []
