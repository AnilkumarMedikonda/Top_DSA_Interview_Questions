import Foundation

/*
 Q14 — LC977 Squares of a Sorted Array

 Problem:  Given a sorted array, return the squares of each number, also sorted.
 Example:  [-4,-1,0,3,10] → [0,1,9,16,100]
 Pattern:  Opposite Ends with backward fill
 Traps:    Fill the result BACKWARDS — the largest square is always at one of
           the two ends, never the middle. No guard for count == 1; the loop
           handles it.
*/

let nums = [-4, -1, 0, 3, 10]

//============================================================
// MARK: - Helper
// Time: O(n²) | Space: O(1) | Edge: empty, single element, already sorted
//============================================================

func insertionSort(_ nums: inout [Int]) {
    for i in 1..<nums.count {
        let current = nums[i]
        var j = i - 1

        while j >= 0 && nums[j] > current {
            nums[j + 1] = nums[j]
            j -= 1
        }

        nums[j + 1] = current
    }
}

//============================================================
// MARK: - Brute Force
// Time: O(n log n) | Space: O(n) | Edge: empty, single element
//============================================================

func sortedSquaresBruteForce(_ nums: [Int]) -> [Int] {
    var squares = [Int]()

    for i in 0..<nums.count {
        squares.append(nums[i] * nums[i])
    }

    return squares.sorted()
}

//============================================================
// MARK: - Optimal
// Time: O(n) | Space: O(n) | Edge: single element, all negative, all positive
//============================================================

func sortedSquaresOptimal(_ nums: [Int]) -> [Int] {
    var left = 0
    var right = nums.count - 1
    var index = nums.count - 1

    var result = Array(repeating: 0, count: nums.count)

    while left <= right {
        let leftValue = nums[left] * nums[left]
        let rightValue = nums[right] * nums[right]

        if leftValue > rightValue {
            result[index] = leftValue
            left += 1
        } else {
            result[index] = rightValue
            right -= 1
        }

        index -= 1
    }

    return result
}

//============================================================
// MARK: - Interview Notes
//============================================================
//
// WHY BACKWARD FILL
// The input is sorted but the squares are not — negatives flip, so the
// sequence dips in the middle. The SMALLEST square sits somewhere in that
// middle and cannot be found in O(1). The LARGEST is always at one end or
// the other, so that is the value you can name with certainty each step —
// and it belongs at the back of the result.
//
// WRONG-TOOL TRAP
// Looks like Merge Two Arrays — and it is, conceptually: the negatives
// reversed and the non-negatives are two sorted sequences being merged.
// But there is no second array to walk, so the merge runs inward from
// both ends of one array instead of forward through two.
//
// COMPLEXITY
// Brute force squares in O(n) then sorts — the sort dominates.
// Optimal skips the sort entirely by exploiting the existing order.
//============================================================

//============================================================
// MARK: - Tests
//============================================================

print("Brute Force")

print(sortedSquaresBruteForce(nums))

print("Optimal")

print(sortedSquaresOptimal(nums))

print(sortedSquaresOptimal([-3]))

print(sortedSquaresOptimal([-5, -3, -1]))

print(sortedSquaresOptimal([1, 2, 3]))

print(sortedSquaresOptimal([-7, -3, 2, 3, 11]))
