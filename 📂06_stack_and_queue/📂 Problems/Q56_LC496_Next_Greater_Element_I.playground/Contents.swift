import Foundation

//==============================================================
// Q56 - LC496 - Next Greater Element I
//==============================================================
//
// Problem
// -------
// nums1 is a subset of nums2 and all values are unique. For each
// element of nums1, find its next greater element in nums2 — the
// first value to its right that is larger. Return -1 when there is
// none. The result has the same length as nums1.
//
// Example
// -------
// nums1 = [4, 1, 2], nums2 = [1, 3, 4, 2]  -> [-1, 3, -1]
// nums1 = [2, 4],    nums2 = [1, 2, 3, 4]  -> [3, -1]
//
// Constraints
// -----------
// 1 <= nums1.count <= nums2.count <= 1000
// 0 <= nums1[i], nums2[i] <= 10^4
// all values are unique, and every nums1 element appears in nums2
//
// Pattern : Monotonic Stack (01_Monotonic_Stack)
//
// Brute Force : O(n · m) time, O(1) auxiliary
// Optimal     : O(n + m) time, O(m) space
//
//==============================================================


// MARK: - Brute Force

// Time  : O(m)
// Space : O(1)
func indexOfElement(_ nums: [Int], _ target: Int) -> Int {
    for i in 0..<nums.count {
        if nums[i] == target {
            return i
        }
    }
    return -1
}

// Find each element in nums2, then scan right from there.
//
// Time  : O(n · m)
// Space : O(1) auxiliary
func nextGreaterElementBruteForce(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var result = [Int]()

    for num in nums1 {
        var nextGreater = -1
        let index = indexOfElement(nums2, num)

        if index != -1 {
            for i in (index + 1)..<nums2.count {
                if nums2[i] > num {
                    nextGreater = nums2[i]
                    break
                }
            }
        }
        // outside the if — a missing element still contributes -1,
        // or the result comes out shorter than nums1
        result.append(nextGreater)
    }

    return result
}


// MARK: - Optimal (Monotonic Stack)

// Don't iterate nums1. Run the monotonic stack over nums2 once to
// build value -> nextGreater, then look each nums1 element up.
//
// Values on the stack, not indices: the answer is a value and no
// distance is involved. Q50 stores indices because its answer is a
// gap — same template, opposite choice, driven by what gets recorded.
//
// Uniqueness is what makes a value-keyed dictionary safe here.
//
// Time  : O(n + m)
// Space : O(m)
func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    var answers = [Int: Int]()
    var stack = [Int]()

    for num in nums2 {
        while let last = stack.last, last < num {
            let waiter = stack.removeLast()
            answers[waiter] = num
        }
        stack.append(num)
    }

    var result = [Int]()

    for num in nums1 {
        if let found = answers[num] {
            result.append(found)
        } else {
            result.append(-1)
        }
    }

    return result
}


// MARK: - Test Cases

print("========== BRUTE FORCE ==========")

print("[4,1,2] in [1,3,4,2] :", nextGreaterElementBruteForce([4, 1, 2], [1, 3, 4, 2]))
// [-1, 3, -1]

print("[2,4] in [1,2,3,4] :", nextGreaterElementBruteForce([2, 4], [1, 2, 3, 4]))
// [3, -1]

print("[3,2,1] in [3,2,1] :", nextGreaterElementBruteForce([3, 2, 1], [3, 2, 1]))
// [-1, -1, -1]

print("[1] in [1] :", nextGreaterElementBruteForce([1], [1]))
// [-1]

print()

print("========== OPTIMAL ==========")

print("[4,1,2] in [1,3,4,2] :", nextGreaterElement([4, 1, 2], [1, 3, 4, 2]))
// [-1, 3, -1]

print("[2,4] in [1,2,3,4] :", nextGreaterElement([2, 4], [1, 2, 3, 4]))
// [3, -1]

print("[3,2,1] in [3,2,1] :", nextGreaterElement([3, 2, 1], [3, 2, 1]))
// [-1, -1, -1]

print("[1] in [1] :", nextGreaterElement([1], [1]))
// [-1]


// MARK: - Notes

/*
 Build the map over nums2, then look up — iterating nums1 forces the
 O(n · m) search back in.

 Values here, indices in Q50. The record line decides: a value answer
 needs values, a distance answer needs positions.

 Anything left on the stack never resolved. The if let / else -1 in
 the lookup covers it with no cleanup pass.
*/
