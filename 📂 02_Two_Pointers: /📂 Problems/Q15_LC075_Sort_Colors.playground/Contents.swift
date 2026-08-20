import Foundation

/*
 Q15 — LC075 Sort Colors

 Problem:  Sort an array containing only 0, 1, 2 in place, in one pass,
           without using a library sort.
 Example:  [2,0,2,1,1,0] → [0,0,1,1,2,2]
 Pattern:  Dutch National Flag (three-region partition)
 Traps:    while mid <= high, NOT <. The value at high is unexamined.
           After swapping with high, mid does NOT advance — the incoming
           value still has to be looked at.
*/

var nums = [2, 0, 2, 1, 1, 0]

//============================================================
// MARK: - Brute Force (Counting Passes)
// Time: O(n) — three passes | Space: O(n) | Edge: empty, single element, all same value
//============================================================

func sortColorsBruteForce(_ nums: inout [Int]) {
    var result = [Int]()

    for num in nums {
        if num == 0 {
            result.append(num)
        }
    }

    for num in nums {
        if num == 1 {
            result.append(num)
        }
    }

    for num in nums {
        if num == 2 {
            result.append(num)
        }
    }

    nums = result
}

//============================================================
// MARK: - Optimal (Dutch National Flag)
// Time: O(n) — one pass | Space: O(1) | Edge: [1,2,0], [2,0,1], all same value
//============================================================

func sortColorsOptimal(_ nums: inout [Int]) {
    var low = 0
    var mid = 0
    var high = nums.count - 1

    while mid <= high {
        if nums[mid] == 0 {
            let temp = nums[mid]
            nums[mid] = nums[low]
            nums[low] = temp

            low += 1
            mid += 1

        } else if nums[mid] == 1 {
            mid += 1

        } else {
            let temp = nums[high]
            nums[high] = nums[mid]
            nums[mid] = temp

            high -= 1
        }
    }
}

//============================================================
// MARK: - Interview Notes
//============================================================
//
// THE REGIONS
// nums[0..<low]     = 0s, final
// nums[low..<mid]   = 1s, final
// nums[mid...high]  = unknown, still being scanned
// nums[high+1...]   = 2s, final
//
// THE ASYMMETRY
// Swap with low  -> mid advances. The value coming back is a 1, already
//                   examined, already in the right region.
// Swap with high -> mid stays. The value coming back is from the unknown
//                   region and has never been looked at.
// That asymmetry IS the pattern. Advancing mid after a high swap skips
// an element and is the bug everyone writes first.
//
// WRONG-TOOL TRAP
// The brute force is a counting sort in disguise — three passes, extra
// array. It is O(n) too, so the improvement is NOT complexity, it is the
// one-pass, O(1)-space constraint the interviewer actually asked for.
// Answering "both are O(n)" misses the point of the question.
//
// FOLLOW-UP
// Generalises to any k buckets, but only k = 3 works in one pass with
// O(1) space. For larger k it becomes counting sort.
//============================================================

//============================================================
// MARK: - Tests
//============================================================

print("Brute Force")

sortColorsBruteForce(&nums)
print(nums)

print("Optimal")

nums = [2, 0, 2, 1, 1, 0]
sortColorsOptimal(&nums)
print(nums)

nums = [1, 2, 0]
sortColorsOptimal(&nums)
print(nums)

nums = [2, 0, 1]
sortColorsOptimal(&nums)
print(nums)

nums = [0]
sortColorsOptimal(&nums)
print(nums)

nums = [2, 2, 2]
sortColorsOptimal(&nums)
print(nums)
