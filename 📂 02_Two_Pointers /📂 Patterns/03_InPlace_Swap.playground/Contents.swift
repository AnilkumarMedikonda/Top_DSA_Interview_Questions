import Foundation

//==============================================================
// Pattern 04 — In-Place Swap
//==============================================================
//
// IDEA
// Exchange two elements using a temp variable, no extra array.
// The primitive every other pattern in this phase calls.
//
// WHY MANUAL
// swapAt is a built-in. Write the three lines yourself —
// interviewers ask you to, and it makes the read/write order
// explicit.
//
// ORDER MATTERS
// temp = a, a = b, b = temp. Skip the temp and you lose one value.
//
// SELF-SWAP
// i == j swaps an element with itself. Harmless, but wasted work
// in a hot loop — guard it when swaps are the bottleneck.
//
// COMPLEXITY
// Time O(1), Space O(1).
//
// USED BY
// Q15 Sort Colors, Q16 Next Permutation, Q17 Rotate Array,
// Q19 First Missing Positive.
//==============================================================

// Time: O(1)  |  Space: O(1)
// Edge cases: negative index, index >= count, i == j (self-swap, no-op)

func swapElements(_ nums: inout [Int], _ i: Int, _ j: Int) {
    guard i >= 0, j >= 0, i < nums.count, j < nums.count, i != j else {
        return
    }
    let temp = nums[i]
    nums[i] = nums[j]
    nums[j] = temp
}

var nums = [10, 20, 30, 40, 50]
swapElements(&nums, 0, 3)
print(nums)

swapElements(&nums, 3, 0)
print(nums)
