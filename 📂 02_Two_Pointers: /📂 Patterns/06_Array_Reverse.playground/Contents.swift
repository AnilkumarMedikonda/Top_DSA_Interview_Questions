import Foundation

//==============================================================
// Pattern 06 — Array Reverse
//==============================================================
//
// IDEA
// Two pointers converge and swap blind — no comparison, no
// decision. Both move every iteration. That is what separates
// it from Opposite Ends.
//
// SUB-RANGE IS THE REAL SKILL
// Reversing the whole array is easy. Reversing nums[i...j] is
// what problems need. Pass i and j in; the loop body is identical.
//
// THE ROTATION TRICK
// Rotate right by k = three reversals:
//   1. reverse the whole array
//   2. reverse [0 ..< k]
//   3. reverse [k ..< count]
// O(n) time, O(1) space, no second array.
//
// k MUST BE REDUCED
// k %= count first. k can exceed count, and k == count means no
// rotation. Guard the empty array BEFORE the modulo — k % 0 traps.
//
// LEFT ROTATION
// Same three reversals with shift = count - (k % count).
//
// TRAPS
// - Raw k out of range: guards fire, no crash, wrong answer.
// - shift - 1 when shift is 0 gives -1 — guard shift > 0 first.
// - Forgetting to shadow let parameters into var copies.
//
// COMPLEXITY
// Time O(n), Space O(1).
//
// USED BY
// Q17 Rotate Array, Q16 Next Permutation (reverse the suffix).
//==============================================================


//==============================================================
// Helper — Reverse a sub-range
//==============================================================

// Time: O(n)  |  Space: O(1)
// Edge cases: left >= right (no-op), out-of-bounds index (no-op), single element

func reverseSubArrayRange(_ nums: inout [Int], _ left: Int, _ right: Int) {
    guard left >= 0, right < nums.count, left < right else {
        return
    }
    var left = left
    var right = right
    while left < right {
        let temp = nums[right]
        nums[right] = nums[left]
        nums[left] = temp
        left += 1
        right -= 1
    }
}

var nums = [10, 20, 30, 40, 50]
reverseSubArrayRange(&nums, 1, 3)
print(nums)


//==============================================================
// Rotate Right by k
//==============================================================

// Time: O(n)  |  Space: O(1)
// Edge cases: empty array, single element, k = 0, k = count (no-op), k > count (reduced with %)

func rotateRight(_ nums: inout [Int], _ k: Int) {
    guard nums.count > 1 else {
        return
    }
    let shift = k % nums.count
    guard shift > 0 else {
        return
    }
    reverseSubArrayRange(&nums, 0, nums.count - 1)
    reverseSubArrayRange(&nums, 0, shift - 1)
    reverseSubArrayRange(&nums, shift, nums.count - 1)
}

nums = [1, 2, 3, 4, 5, 6, 7]
rotateRight(&nums, 3)
print(nums)

nums = [1, 2, 3, 4, 5, 6, 7]
rotateRight(&nums, 10)
print(nums)

nums = [1, 2, 3, 4, 5, 6, 7]
rotateRight(&nums, 7)
print(nums)


//==============================================================
// Rotate Left by k
//==============================================================

// Time: O(n)  |  Space: O(1)
// Edge cases: same as rotateRight; shift maps to count - (k % count)

func rotateLeft(_ nums: inout [Int], _ k: Int) {
    guard nums.count > 1 else {
        return
    }
    let reduced = k % nums.count
    guard reduced > 0 else {
        return
    }
    rotateRight(&nums, nums.count - reduced)
}

nums = [1, 2, 3, 4, 5, 6, 7]
rotateLeft(&nums, 3)
print(nums)
