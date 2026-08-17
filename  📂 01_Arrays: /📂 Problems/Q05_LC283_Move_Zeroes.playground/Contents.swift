import Foundation

/*
 Q05 — LC283 Move Zeroes                                   [Easy]

 Given an integer array nums, move all 0's to the end of it while
 maintaining the relative order of the non-zero elements.

 You must do this IN-PLACE without making a copy of the array.

 Example 1:  nums = [0,1,0,3,12]  ->  [1,3,12,0,0]
 Example 2:  nums = [0]           ->  [0]

 Constraints:
   1 <= nums.length <= 10^4
   -2^31 <= nums[i] <= 2^31 - 1

 Follow-up: Could you minimize the total number of operations?
*/

//============================================================
// MARK: - Extra Array
// Time : O(n)
// Space: O(n)
//
// NOT a brute force — the time is the same. The cost is the
// extra array, which the problem explicitly forbids ("in-place,
// without making a copy"). Kept for contrast only.
//============================================================

func moveZeroesExtraArray(_ nums: inout [Int]) {
    var result = [Int]()
    for i in 0..<nums.count {
        if nums[i] != 0 {
            result.append(nums[i])
        }
    }
    for i in 0..<nums.count {
        if nums[i] == 0 {
            result.append(nums[i])
        }
    }
    for i in 0..<result.count {
        nums[i] = result[i]
    }
}

print("========== Extra Array ==========")

var a1 = [0, 1, 0, 3, 12]
moveZeroesExtraArray(&a1)
print(a1)

var a2 = [0]
moveZeroesExtraArray(&a2)
print(a2)

//============================================================
// MARK: - Optimal (Write Pointer + Swap)
// Time : O(n)
// Space: O(1)
//
// read visits every element; write only advances on a non-zero.
// Swapping (rather than copying) pushes each zero into the slot
// the non-zero vacated, so the tail is already correct — no
// second pass needed.
//
// write never overtakes read, so nothing unexamined is clobbered.
//
// The `write != read` guard is the follow-up: with no zeros in
// the array, every swap would be an element with itself.
//============================================================

func moveZeroes(_ nums: inout [Int]) {
    var write = 0
    for read in 0..<nums.count {
        if nums[read] != 0 {
            if write != read {
                let temp = nums[read]
                nums[read] = nums[write]
                nums[write] = temp
            }
            write += 1
        }
    }
}

print("========== Optimal ==========")

var b1 = [0, 1, 0, 3, 12]
moveZeroes(&b1)
print(b1)

var b2 = [0]
moveZeroes(&b2)
print(b2)

var b3 = [1, 2, 3, 4, 5]
moveZeroes(&b3)
print(b3)

var b4 = [0, 0, 0]
moveZeroes(&b4)
print(b4)
