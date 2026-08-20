import Foundation

/*
 Q17 — LC189 Rotate Array

 Problem:  Rotate nums to the right by k steps, in place.
 Example:  [1,2,3,4,5,6,7], k = 3 → [5,6,7,1,2,3,4]
 Pattern:  Array Reverse (three reversals)
 Traps:    guard shift > 0, NOT > 1 — a shift of 1 is a real rotation.
           Reduce k with k % count first; guard the array before the
           modulo, since k % 0 traps.
           The two blocks are [0, shift-1] and [shift, count-1] —
           adjacent, no gap. Any +1 between them strands an element.
           Test several k values: k = 3 on 7 elements hides off-by-ones.
 Skipped:  rotate-by-one k times, O(n × k) — no stepping stone to either
           solution below, and it times out at n = k = 10^5.
*/

let nums = [1, 2, 3, 4, 5, 6, 7]
let k = 3

//============================================================
// MARK: - Split and Append
// Time: O(n) | Space: O(n) | Edge: single element, k = 0, k = count, k > count
//============================================================

func rotateSplit(_ nums: inout [Int], _ k: Int) {
    guard nums.count > 1 else { return }

    let shift = k % nums.count

    guard shift > 0 else { return }

    var result = [Int]()

    for i in (nums.count - shift)..<nums.count {
        result.append(nums[i])
    }

    for i in 0..<(nums.count - shift) {
        result.append(nums[i])
    }

    nums = result
}

//============================================================
// MARK: - Helper
// Time: O(n) | Space: O(1) | Edge: left >= right is a no-op
//============================================================

func reverseArray(_ nums: inout [Int], _ left: Int, _ right: Int) {
    var left = left
    var right = right

    while left < right {
        let temp = nums[left]
        nums[left] = nums[right]
        nums[right] = temp

        left += 1
        right -= 1
    }
}

//============================================================
// MARK: - Optimal (three reversals)
// Time: O(n) | Space: O(1) | Edge: single element, k = 0, k = 1, k = count, k > count
//============================================================

func rotateOptimal(_ nums: inout [Int], _ k: Int) {
    guard nums.count > 1 else { return }

    let shift = k % nums.count

    guard shift > 0 else { return }

    reverseArray(&nums, 0, nums.count - 1)
    reverseArray(&nums, 0, shift - 1)
    reverseArray(&nums, shift, nums.count - 1)
}

//============================================================
// MARK: - Interview Notes
//============================================================
//
// WHY THREE REVERSALS WORK
// Rotating right by k moves the last k elements to the front with their
// order preserved. Reversing the whole array puts those k at the front —
// but backwards — and the remaining n-k at the back, also backwards.
// Reversing each block separately restores the order inside both.
// Two blocks, one pass each, nothing allocated.
//
// WHY k MUST BE REDUCED
// Rotating by count is the identity. k = 10 on 7 elements is the same as
// k = 3. Without the modulo, shift - 1 and shift go out of range — and if
// the helper guards silently, that becomes a wrong answer instead of a
// crash, which is worse.
//
// WHY SPLIT AND APPEND IS STILL WORTH KEEPING
// It states the answer plainly: last k first, the rest after. That is the
// sentence to say out loud before showing the trick. The reversal version
// only exists to answer the follow-up — "now do it in O(1) space."
//
// WRONG-TOOL TRAP
// Moving elements around suggests a queue or a temp buffer, which is where
// the O(n) space comes from. Reversal is what makes it O(1). There is also
// a cyclic-replacement solution walking gcd(n, k) cycles — same complexity,
// much harder to verify under pressure. Name it if asked; do not reach for it.
//
// LEFT ROTATION
// Same three reversals with shift = count - (k % count).
//============================================================

//============================================================
// MARK: - Tests
//============================================================

var split = nums
rotateSplit(&split, k)
print(split)

var optimal = nums
rotateOptimal(&optimal, k)
print(optimal)

optimal = nums
rotateOptimal(&optimal, 1)
print(optimal)

optimal = nums
rotateOptimal(&optimal, 2)
print(optimal)

optimal = nums
rotateOptimal(&optimal, 8)
print(optimal)

optimal = nums
rotateOptimal(&optimal, 10)
print(optimal)

optimal = nums
rotateOptimal(&optimal, 7)
print(optimal)

optimal = nums
rotateOptimal(&optimal, 0)
print(optimal)

optimal = [1]
rotateOptimal(&optimal, 3)
print(optimal)
