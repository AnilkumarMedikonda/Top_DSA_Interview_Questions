import Foundation

//==============================================================
// MARK: - 04. Merge Sort
//==============================================================
//
// IDEA
//
// Divide and conquer. Split in half, sort each half
// recursively, then merge two sorted arrays into one.
//
// The merge is the whole algorithm: walk both sides with two
// indices, always taking the smaller head. Once one side runs
// out, the rest of the other is already sorted and is appended
// as is.
//
// TRACE
//
// [5, 3, 8, 4, 2]
//
// split  [5,3]        [8,4,2]
// split  [5] [3]      [8]  [4,2] → [4] [2]
// merge  [3,5]        [8]  [2,4]
// merge  [3,5]        [2,4,8]
// merge  [2,3,4,5,8]
//
// COMPLEXITY
//
// Time:   O(n log n) always — log n levels of splitting, O(n)
//         merging per level. No input makes it worse, which is
//         what quick sort cannot claim.
// Space:  O(n) — the merged arrays. This is the price, and the
//         reason quick sort exists.
// Stable: yes, provided merge takes from the LEFT on ties.
//
// On a LINKED LIST this is the sort to use: no random access
// needed, and the merge relinks nodes instead of allocating,
// which drops the O(n) space. That merge is Q58 and Q76.
//
// Array slicing is used deliberately for the split.
//
//==============================================================

func mergeSort(_ nums: inout [Int]) {
    if nums.count < 2 {
        return
    }

    let mid = nums.count / 2

    var left = Array(nums[..<mid])
    var right = Array(nums[mid...])

    mergeSort(&left)
    mergeSort(&right)

    nums = merge(left, right)
}

private func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var result = [Int]()
    var i = 0
    var j = 0

    while i < left.count && j < right.count {
        // <= not < : the left side came first, so it wins ties.
        // This one character is the difference between stable
        // and unstable.
        if left[i] <= right[j] {
            result.append(left[i])
            i += 1
        } else {
            result.append(right[j])
            j += 1
        }
    }

    // Whichever side is left over is already sorted
    while i < left.count {
        result.append(left[i])
        i += 1
    }

    while j < right.count {
        result.append(right[j])
        j += 1
    }

    return result
}

//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== 03 - Merge Sort ==========")

var nums1 = [5, 3, 8, 4, 2]
mergeSort(&nums1)

print(nums1)
// [2, 3, 4, 5, 8]

var nums2 = [1, 2, 3, 4, 5]
mergeSort(&nums2)

print(nums2)
// [1, 2, 3, 4, 5]   no best case — still O(n log n)

var nums3 = [5, 4, 3, 2, 1]
mergeSort(&nums3)

print(nums3)
// [1, 2, 3, 4, 5]

var nums4 = [3, 3, 3]
mergeSort(&nums4)

print(nums4)
// [3, 3, 3]

var nums5 = [2, 2, 1, 3, 1]
mergeSort(&nums5)

print(nums5)
// [1, 1, 2, 2, 3]

var nums6 = [1]
mergeSort(&nums6)

print(nums6)
// [1]

var nums7 = [Int]()
mergeSort(&nums7)

print(nums7)
// []
