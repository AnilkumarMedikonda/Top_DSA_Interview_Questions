import Foundation

/*
 Q07 — LC026 Remove Duplicates from Sorted Array           [Easy]

 nums is sorted in non-decreasing order. Remove duplicates IN-PLACE
 so each unique element appears once, keeping relative order.
 Return k, the number of unique elements. The first k slots must
 hold those uniques; anything past k does not matter.

 Example 1:  nums = [1,1,2]
             -> 2, nums = [1,2,_]

 Example 2:  nums = [0,0,1,1,1,2,2,3,3,4]
             -> 5, nums = [0,1,2,3,4,_,_,_,_,_]

 Constraints:
   1 <= nums.length <= 3 * 10^4
   -100 <= nums[i] <= 100
   nums is sorted in non-decreasing order
*/

//============================================================
// MARK: - Approach 1 — Set
// Time : O(n)
// Space: O(n)
//
// Works, but throws away the problem's key fact: the array is
// SORTED, so duplicates are always adjacent. A Set is what you
// would need if it were unsorted. Kept for contrast.
//
// Note the order: write, THEN increment. Incrementing first
// shifts every element by one AND runs off the end when every
// element is unique.
//============================================================

func removeDuplicatesUsingSet(_ nums: inout [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var seen = Set<Int>()
    var write = 0

    for num in nums {
        if !seen.contains(num) {
            nums[write] = num
            write += 1
            seen.insert(num)
        }
    }

    return write
}

//============================================================
// MARK: - Approach 2 — Write Pointer (Optimal)
// Time : O(n)
// Space: O(1)
//
// Because the array is sorted, an element is new exactly when it
// differs from the LAST KEPT element — nums[write - 1].
//
// That is the difference from Move Zeroes: there the keep-test
// was against a fixed value (0), here it is against a target
// that moves as we keep things.
//
// write starts at 1: nums[0] is always unique by definition, so
// it is already in place.
//
// read starts at 1 too — comparing nums[0] to itself is wasted
// work.
//============================================================

func removeDuplicates(_ nums: inout [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var write = 1

    for read in 1..<nums.count {
        if nums[read] != nums[write - 1] {
            nums[write] = nums[read]
            write += 1
        }
    }

    return write
}

//============================================================
// MARK: - Tests
//============================================================

print("========== Set ==========")

var s1 = [1, 1, 2]
print(removeDuplicatesUsingSet(&s1), s1)

var s2 = [1, 2, 3]
print(removeDuplicatesUsingSet(&s2), s2)

print("========== Optimal ==========")

var a = [1, 1, 2]
print(removeDuplicates(&a), a)

var b = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
print(removeDuplicates(&b), b)

var c = [1]
print(removeDuplicates(&c), c)

var d = [2, 2, 2, 2]
print(removeDuplicates(&d), d)

var e = [1, 2, 3, 4]
print(removeDuplicates(&e), e)
