import Foundation

//==============================================================
// MARK: - 06. Heap Sort
//==============================================================
//
// IDEA
//
// Two phases, both in the same array.
//
// 1. Build a max heap from the bottom up. Start at n / 2 - 1,
//    the last non-leaf node — everything past it is a leaf and
//    already a valid heap of one.
//
// 2. Swap the root (the largest element) to the end, shrink the
//    heap by one, and sift the new root back down. Repeat.
//
// The heapSize parameter is the whole trick. Passing `end`
// rather than `n` on the second call is what keeps the sorted
// tail untouched.
//
// TRACE — [5, 3, 8, 4, 2]
//
// build   start at index 1 (n/2 - 1)
//         heapify(1): 3 vs children 4, 2 → swap  [5,4,8,3,2]
//         heapify(0): 5 vs children 4, 8 → swap  [8,4,5,3,2]
//
// extract swap 8 to end, heapify size 4  [5,4,2,3 | 8]
//         swap 5 to end, heapify size 3  [4,3,2 | 5,8]
//         swap 4 to end, heapify size 2  [3,2 | 4,5,8]
//         swap 3 to end, heapify size 1  [2 | 3,4,5,8]
//
// COMPLEXITY
//
// Time:   O(n log n) always — O(n) to build the heap, then n
//         extractions at O(log n) each. No bad input.
//         The build is O(n), not O(n log n), because most nodes
//         sit near the bottom and sift down only a level or two.
// Space:  O(1) — the heap lives in the array itself. The
//         recursion in heapify costs O(log n) stack; an
//         iterative sift makes it genuinely O(1).
// Stable: no — swapping the root to the end jumps elements over
//         equal values.
//
// The only sort here with BOTH a guaranteed O(n log n) and O(1)
// space. Merge gives up the space, quick gives up the guarantee.
// Quick is still the library default — cache locality and a
// smaller constant beat the better worst case in practice.
//
//==============================================================

func heapSort(_ nums: inout [Int]) {
    let n = nums.count

    if n < 2 {
        return
    }

    // Phase 1 — build the max heap.
    // n / 2 - 1 is the last non-leaf node; leaves need no work.
    var i = n / 2 - 1

    while i >= 0 {
        heapify(&nums, n, i)
        i -= 1
    }

    // Phase 2 — move the largest to the end, shrink, re-heapify
    var end = n - 1

    while end > 0 {
        nums.swapAt(0, end)

        // `end`, not `n` — the sorted tail is now outside the heap
        heapify(&nums, end, 0)
        end -= 1
    }
}

private func heapify(_ nums: inout [Int], _ heapSize: Int, _ root: Int) {
    var largest = root

    let left = 2 * root + 1
    let right = 2 * root + 2

    if left < heapSize && nums[left] > nums[largest] {
        largest = left
    }

    if right < heapSize && nums[right] > nums[largest] {
        largest = right
    }

    if largest != root {
        nums.swapAt(root, largest)
        heapify(&nums, heapSize, largest)
    }
}

//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== 05 - Heap Sort ==========")

var nums1 = [5, 3, 8, 4, 2]
heapSort(&nums1)

print(nums1)
// [2, 3, 4, 5, 8]

var nums2 = [1, 2, 3, 4, 5]
heapSort(&nums2)

print(nums2)
// [1, 2, 3, 4, 5]   no best case — still O(n log n)

var nums3 = [5, 4, 3, 2, 1]
heapSort(&nums3)

print(nums3)
// [1, 2, 3, 4, 5]

var nums4 = [3, 3, 3]
heapSort(&nums4)

print(nums4)
// [3, 3, 3]   all equal — no degradation, unlike Lomuto

var nums5 = [2, 2, 1, 3, 1]
heapSort(&nums5)

print(nums5)
// [1, 1, 2, 2, 3]

var nums6 = [1]
heapSort(&nums6)

print(nums6)
// [1]

var nums7 = [Int]()
heapSort(&nums7)

print(nums7)
// []
