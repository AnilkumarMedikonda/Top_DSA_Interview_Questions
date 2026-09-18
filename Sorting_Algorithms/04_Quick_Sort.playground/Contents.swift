import Foundation

//==============================================================
// MARK: - 05. Quick Sort
//==============================================================
//
// IDEA
//
// Pick a pivot, partition so everything smaller sits left and
// everything larger sits right, then recurse on both sides.
// The pivot is final after one partition — it never moves again.
//
// LOMUTO PARTITION
//
// Pivot is the last element. Walk j from low to high - 1 and
// keep a boundary index i marking the end of the "smaller than
// pivot" region. Anything smaller swaps across the boundary.
// At the end, swap the pivot into i + 1.
//
// TRACE — partition of [5, 3, 8, 4, 2], pivot 2
//
// i = -1
// j=0  5<2? no
// j=1  3<2? no
// j=2  8<2? no
// j=3  4<2? no
// swap(i+1=0, high=4) → [2, 3, 8, 4, 5], pivot lands at 0
//
// That is the worst-case shape: one side empty, the other n-1.
//
// COMPLEXITY
//
// Time:   O(n log n) average — each partition splits roughly in
//         half, log n levels deep
//         O(n²) worst — SORTED input with nums[high] as pivot
//         gives partitions of n-1 and 0 every time
// Space:  O(log n) average for the recursion stack, O(n) worst
// Stable: no — the final swap jumps the pivot over equal elements
//
// Despite the worse worst case it is the library default over
// heap sort: in place, small constant factor, good cache
// locality. A random or median-of-three pivot makes the worst
// case vanishingly unlikely.
//
//==============================================================

// MARK: - In-Place (the real one)

func quickSort(_ nums: inout [Int]) {
    quickSort(&nums, 0, nums.count - 1)
}

private func quickSort(_ nums: inout [Int], _ low: Int, _ high: Int) {
    if low >= high {
        return
    }

    let partitionIndex = partition(&nums, low, high)

    quickSort(&nums, low, partitionIndex - 1)
    quickSort(&nums, partitionIndex + 1, high)
}

private func partition(_ nums: inout [Int], _ low: Int, _ high: Int) -> Int {
    let pivot = nums[high]

    // i marks the end of the "smaller than pivot" region
    var i = low - 1

    for j in low..<high {
        if nums[j] < pivot {
            i += 1
            nums.swapAt(i, j)
        }
    }

    // The pivot belongs just past the boundary
    nums.swapAt(i + 1, high)

    return i + 1
}

//==============================================================
// MARK: - Concept Version
//==============================================================
//
// Three buckets instead of an in-place partition. Not what you
// would write in an interview — it allocates O(n) per level, so
// O(n log n) space against the real version's O(log n) — but it
// makes the partition idea obvious in six lines.
//
// The equal bucket is why this handles all-duplicate input in
// O(n) while Lomuto degrades to O(n²) on it.
//
//==============================================================

func quickSortConcept(_ numbers: [Int]) -> [Int] {
    // Base case — without this, the empty `less` array from the
    // first recursion traps on numbers[0]
    if numbers.count < 2 {
        return numbers
    }

    let pivot = numbers[0]
    var less = [Int]()
    var equal = [Int]()
    var greater = [Int]()

    for number in numbers {
        if number < pivot {
            less.append(number)
        } else if number > pivot {
            greater.append(number)
        } else {
            equal.append(number)
        }
    }

    return quickSortConcept(less) + equal + quickSortConcept(greater)
}

//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== 04 - Quick Sort ==========")

var nums1 = [5, 3, 8, 4, 2]
quickSort(&nums1)

print(nums1)
// [2, 3, 4, 5, 8]

var nums2 = [1, 2, 3, 4, 5]
quickSort(&nums2)

print(nums2)
// [1, 2, 3, 4, 5]   worst case — sorted input, pivot always largest

var nums3 = [5, 4, 3, 2, 1]
quickSort(&nums3)

print(nums3)
// [1, 2, 3, 4, 5]

var nums4 = [3, 3, 3]
quickSort(&nums4)

print(nums4)
// [3, 3, 3]   all equal — Lomuto degrades to O(n²) here too

var nums5 = [2, 2, 1, 3, 1]
quickSort(&nums5)

print(nums5)
// [1, 1, 2, 2, 3]

var nums6 = [1]
quickSort(&nums6)

print(nums6)
// [1]

var nums7 = [Int]()
quickSort(&nums7)

print(nums7)
// []

print("\n========== 04 - Quick Sort - Concept ==========")

print(quickSortConcept([5, 3, 8, 4, 2]))
// [2, 3, 4, 5, 8]

print(quickSortConcept([3, 3, 3]))
// [3, 3, 3]   one pass, everything lands in `equal`

print(quickSortConcept([2, 2, 1, 3, 1]))
// [1, 1, 2, 2, 3]

print(quickSortConcept([Int]()))
// []
