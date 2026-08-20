import Foundation

/*
 Q19 — LC041 First Missing Positive

 Problem:  Return the smallest positive integer not present in an unsorted
           array. Must run in O(n) time with O(1) auxiliary space.
 Example:  [3,4,-1,1] → 2 · [1,2,0] → 3 · [7,8,9,11,12] → 1
 Pattern:  Cyclic Sort (index as hash)
 Traps:    Swap in a WHILE, not an if — the value that arrives may also be
           misplaced, so re-check the same index.
           Guard on VALUES (nums[i] != nums[correctIndex]), not indices —
           [1,1] loops forever otherwise.
           correctIndex is computed before the range check, but && short-
           circuits, so nums[correctIndex] is never read for out-of-range
           values.
 Bound:    With n elements the answer is always in 1...n+1, so negatives,
           zero, and anything above n can be ignored entirely.
*/

var nums = [3, 4, -1, 1]

//============================================================
// MARK: - Brute Force
// Time: O(n²) | Space: O(1) | Edge: empty, all negative, all above n, [1,1]
// Note: the Set version is O(n) time but O(n) space, which the problem forbids
//============================================================

func firstMissingPositiveBruteForce(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else {
        return 1
    }

    var target = 1

    while true {
        var found = false

        for num in nums {
            if num == target {
                found = true

                break
            }
        }

        if !found {
            return target
        }

        target += 1
    }
}

//============================================================
// MARK: - Optimal (Cyclic Sort)
// Time: O(n) | Space: O(1) | Edge: [1,1], [7,8,9,11,12], [1,2,3] → n+1
//============================================================

func firstMissingPositiveOptimal(_ nums: inout [Int]) -> Int {
    guard !nums.isEmpty else {
        return 1
    }

    //--------------------------------------------------------
    // Step 1: place every value in 1...n at index value - 1
    //--------------------------------------------------------

    var index = 0

    while index < nums.count {
        let correctIndex = nums[index] - 1

        // && short-circuits, so nums[correctIndex] is only read once the
        // range checks pass — negatives never index the array
        if nums[index] > 0 &&
            nums[index] <= nums.count &&
            nums[index] != nums[correctIndex] {

            let temp = nums[index]
            nums[index] = nums[correctIndex]
            nums[correctIndex] = temp

        } else {
            index += 1
        }
    }

    //--------------------------------------------------------
    // Step 2: first index whose value is not index + 1
    //--------------------------------------------------------

    index = 0

    while index < nums.count {
        if nums[index] != index + 1 {
            return index + 1
        }

        index += 1
    }

    //--------------------------------------------------------
    // Step 3: everything from 1...n is present
    //--------------------------------------------------------

    return nums.count + 1
}

//============================================================
// MARK: - Interview Notes
//============================================================
//
// THE BOUND THAT UNLOCKS IT
// With n elements, the answer cannot exceed n + 1. If the array holds
// exactly 1...n the answer is n + 1; otherwise something inside 1...n is
// missing. So negatives, zero, and values above n are irrelevant — they
// occupy slots whose rightful owners are absent, which is the signal.
//
// WHY THE ARRAY IS ITS OWN HASH TABLE
// Value v belongs at index v - 1. Once every value is home, index i either
// holds i + 1 or it does not — and the first mismatch IS the answer. No
// extra structure needed, which is how O(1) space is reached.
//
// WHY WHILE, NOT IF
// A swap brings a new, unexamined value to the current index. An if would
// advance past it and lose it. index only moves in the else branch.
//
// WHY IT IS STILL O(n)
// The nested-looking while does not make it quadratic: every swap puts at
// least one value in its permanent home, and a value is never displaced
// once correct. At most n swaps across the whole loop.
//
// WHY COMPARE VALUES, NOT INDICES
// nums[i] != nums[correctIndex] stops duplicates. Comparing i to
// correctIndex would leave [1,1] swapping forever.
//
// WRONG-TOOL TRAP
// This looks like a hashing problem, and a Set does solve it in O(n) time
// — that is exactly the brute force the constraint forbids. The O(1)-space
// requirement IS the question; the answer is that the indices are the hash
// table. Answering with a Set means answering a different question.
//============================================================

//============================================================
// MARK: - Tests
//============================================================

print("Brute Force")

print(firstMissingPositiveBruteForce(nums))

print("Optimal")

nums = [3, 4, -1, 1]
print(firstMissingPositiveOptimal(&nums))

nums = [1, 2, 0]
print(firstMissingPositiveOptimal(&nums))

nums = [7, 8, 9, 11, 12]
print(firstMissingPositiveOptimal(&nums))

nums = [1, 1]
print(firstMissingPositiveOptimal(&nums))

nums = [1, 2, 3]
print(firstMissingPositiveOptimal(&nums))

nums = [1]
print(firstMissingPositiveOptimal(&nums))
