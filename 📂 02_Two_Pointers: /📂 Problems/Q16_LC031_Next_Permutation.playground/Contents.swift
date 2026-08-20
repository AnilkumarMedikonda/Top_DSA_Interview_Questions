import Foundation

/*
 Q16 — LC031 Next Permutation

 Problem:  Rearrange nums into the next lexicographically greater permutation,
           in place, with O(1) extra memory. If none exists, sort ascending.
 Example:  [1,2,3] → [1,3,2] · [3,2,1] → [1,2,3] · [1,1,5] → [1,5,1]
 Pattern:  Right-to-Left Traversal + Array Reverse
 Traps:    Swap-target scan needs <=, not <. An equal value is NOT greater,
           so the scan must walk past it — [1,5,1] breaks otherwise.
           No brute force here: enumerating permutations is O(n!).
*/

var nums = [1, 2, 3]

//============================================================
// MARK: - Helper
// Time: O(n) | Space: O(1) | Edge: start >= count - 1 is a no-op
//============================================================

func reverse(_ nums: inout [Int], _ start: Int) {
    var left = start
    var right = nums.count - 1

    while left < right {
        let temp = nums[left]
        nums[left] = nums[right]
        nums[right] = temp

        left += 1
        right -= 1
    }
}

//============================================================
// MARK: - Optimal
// Time: O(n) | Space: O(1) | Edge: single element, fully descending, duplicates
//============================================================

func nextPermutation(_ nums: inout [Int]) {

    // Step 1 — find the pivot: first index from the right where nums[i] < nums[i+1]
    var pivot = nums.count - 2

    while pivot >= 0 && nums[pivot] >= nums[pivot + 1] {
        pivot -= 1
    }

    // Step 2 — if a pivot exists, find the rightmost value strictly greater and swap
    if pivot >= 0 {
        var j = nums.count - 1

        while j >= 0 && nums[j] <= nums[pivot] {
            j -= 1
        }

        let temp = nums[pivot]
        nums[pivot] = nums[j]
        nums[j] = temp
    }

    // Step 3 — reverse the suffix. If there was no pivot, this reverses the whole array.
    reverse(&nums, pivot + 1)
}

//============================================================
// MARK: - Interview Notes
//============================================================
//
// WHY THE PIVOT IS FOUND FROM THE RIGHT
// The suffix after the pivot is non-increasing — already the largest
// arrangement of those digits. Nothing inside it can grow, so the change
// has to happen at the first position where an increase is possible.
//
// WHY THE SWAP TARGET IS THE RIGHTMOST GREATER VALUE
// The suffix is non-increasing, so scanning from the right finds the
// SMALLEST value that still exceeds the pivot. Any larger choice would
// overshoot and skip permutations.
//
// WHY THE SUFFIX IS REVERSED, NOT SORTED
// After the swap the suffix is still non-increasing (the swap preserves
// that ordering). Reversing turns it ascending in O(n) — a sort would
// cost O(n log n) for the same result.
//
// WHY NO PIVOT MEANS WRAP
// pivot = -1 means the whole array is descending: the last permutation.
// reverse(&nums, 0) produces the first one.
//
// WRONG-TOOL TRAP
// Looks like a sorting or backtracking problem — "generate permutations"
// suggests recursion. But only ONE permutation is wanted, and it is
// reachable by index arithmetic alone. Generating them all is O(n!) to
// answer a question that costs O(n).
//============================================================

//============================================================
// MARK: - Tests
//============================================================

nextPermutation(&nums)
print(nums)

nums = [3, 2, 1]
nextPermutation(&nums)
print(nums)

nums = [1, 1, 5]
nextPermutation(&nums)
print(nums)

nums = [1, 5, 1]
nextPermutation(&nums)
print(nums)

nums = [1, 3, 5, 4, 2]
nextPermutation(&nums)
print(nums)

nums = [2, 3, 1, 3, 3]
nextPermutation(&nums)
print(nums)

nums = [1]
nextPermutation(&nums)
print(nums)
