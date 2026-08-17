import Foundation

/*
 Q06 — LC088 Merge Sorted Array                            [Easy]

 nums1 and nums2 are sorted in non-decreasing order. m = number of
 real elements in nums1, n = number of elements in nums2. nums1 has
 length m + n; its last n slots are 0 and should be ignored.

 Merge them into nums1, sorted. Nothing is returned.

 Example 1:  nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
             -> [1,2,2,3,5,6]
 Example 2:  nums1 = [1], m = 1, nums2 = [], n = 0   -> [1]
 Example 3:  nums1 = [0], m = 0, nums2 = [1], n = 1  -> [1]

 Constraints:
   nums1.length == m + n
   nums2.length == n
   0 <= m, n <= 200
   1 <= m + n <= 200
   -10^9 <= nums1[i], nums2[j] <= 10^9

 Follow-up: O(m + n) time.
*/

//============================================================
// MARK: - Approach 1 — Extra Array
// Time : O(m + n)
// Space: O(m + n)
//
// Classic forward merge into a new array, then copy back.
// Correct, but the extra array is what the optimal removes.
//
// No guard: if m or n is 0 the matching while loop simply does
// not run, and the drain loops handle the rest.
//============================================================

func mergeExtraArray(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {

    var result = [Int]()
    var i = 0
    var j = 0

    while i < m && j < n {
        if nums1[i] < nums2[j] {
            result.append(nums1[i])
            i += 1
        } else {
            result.append(nums2[j])
            j += 1
        }
    }

    while i < m {
        result.append(nums1[i])
        i += 1
    }

    while j < n {
        result.append(nums2[j])
        j += 1
    }

    for k in 0..<result.count {
        nums1[k] = result[k]
    }
}

//============================================================
// MARK: - Approach 2 — Backward Two Pointers (Optimal)
// Time : O(m + n)
// Space: O(1)
//
// Filling FORWARD would overwrite nums1 elements that have not
// been merged yet — slot 0 holds a live value. But the last n
// slots are throwaway zeros, so writing backward destroys nothing.
//
// Take the LARGER of the two tails each step and place it at the
// far right, walking all three pointers left.
//
// Only ONE drain loop is needed: `while j >= 0`. If nums1 still
// has elements left, they are already sitting in their correct
// positions — nothing to move. Leftovers in nums2 are not.
// That is also why Example 3 (m = 0) works.
//============================================================

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {

    var i = m - 1              // last real element of nums1
    var j = n - 1              // last element of nums2
    var write = m + n - 1      // last slot in nums1

    while i >= 0 && j >= 0 {
        if nums1[i] > nums2[j] {
            nums1[write] = nums1[i]
            i -= 1
        } else {
            nums1[write] = nums2[j]
            j -= 1
        }
        write -= 1
    }

    while j >= 0 {
        nums1[write] = nums2[j]
        j -= 1
        write -= 1
    }
}

//============================================================
// MARK: - Tests
//============================================================

print("========== Extra Array ==========")

var x1 = [1, 2, 3, 0, 0, 0]
mergeExtraArray(&x1, 3, [2, 5, 6], 3)
print(x1)

var x2 = [4, 5, 6, 0, 0]
mergeExtraArray(&x2, 3, [1, 2], 2)
print(x2)

print("========== Optimal ==========")

var a = [1, 2, 3, 0, 0, 0]
merge(&a, 3, [2, 5, 6], 3)
print(a)

var b = [1]
merge(&b, 1, [], 0)
print(b)

var c = [0]
merge(&c, 0, [1], 1)
print(c)

var d = [4, 5, 6, 0, 0]
merge(&d, 3, [1, 2], 2)
print(d)
