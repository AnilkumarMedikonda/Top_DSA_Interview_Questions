import Foundation

//==============================================================
// Q47 — LC410 Split Array Largest Sum
//==============================================================
/*
 Split nums into m non-empty contiguous subarrays. Minimize the
 LARGEST subarray sum among the m parts. Return that minimized
 largest sum. O(n log(sum)).

 Example:
   [7,2,5,10,8], m = 2   → 18   ([7,2,5] | [10,8])
   [1,2,3,4,5], m = 2    → 9    ([1,2,3] | [4,5])
   [1,4,4], m = 3        → 4

 Constraints:
   1 <= nums.count <= 1000
   0 <= nums[i] <= 10^6
   1 <= m <= nums.count

 Pattern: Search On Answer — binary search the largest-sum value,
          not the array. Predicate: can we split into <= m parts
          where no part exceeds this cap?
 Bounds: floor = max(nums) (a part must hold the biggest element),
         ceiling = sum(nums) (one part holds everything).
 Interval: closed, record-and-narrow, seek first feasible cap.
 Complexity: predicate walks all n → O(n log(sum)).
 Note: identical structure to LC1011 Ship Packages — m splits
       instead of days, maxSum instead of capacity.
 Edge cases: m == 1 (answer = sum), m == count (answer = max).
*/

//==============================================================
// MARK: - Predicate
// Greedy: count parts at this cap. Reset to nums[i] (not 0) —
// the overflowing element starts the new part.
//==============================================================
func canSplit(_ nums: [Int], _ m: Int, _ maxSum: Int) -> Bool {
    var currentSplit = 1
    var currentSum = 0
    for i in 0..<nums.count {
        if currentSum + nums[i] > maxSum {
            currentSum = nums[i]
            currentSplit += 1
        } else {
            currentSum += nums[i]
        }
    }
    return currentSplit <= m
}

//==============================================================
// MARK: - Brute Force
// Try every cap from max(nums) upward; first feasible wins.
// T - O((sum - max) × n), S - O(1)
//==============================================================
func splitArrayBruteForce(_ nums: [Int], _ m: Int) -> Int {
    var maxNumber = nums[0]
    var totalSum = 0
    for num in nums {
        if num > maxNumber {
            maxNumber = num
        }
        totalSum += num
    }
    for cap in maxNumber...totalSum {
        if canSplit(nums, m, cap) {
            return cap
        }
    }
    return totalSum
}

//==============================================================
// MARK: - Optimal
// Binary search the cap range [max(nums), sum(nums)].
// T - O(n log(sum)), S - O(1)
//==============================================================
func splitArray(_ nums: [Int], _ m: Int) -> Int {
    var maxNumber = nums[0]
    var totalSum = 0
    for num in nums {
        if num > maxNumber {
            maxNumber = num
        }
        totalSum += num
    }
    var left = maxNumber
    var right = totalSum
    var answer = totalSum
    while left <= right {
        let mid = left + (right - left) / 2
        if canSplit(nums, m, mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return answer
}

//==============================================================
// MARK: - Tests
//==============================================================
print("Brute Force")

print(splitArrayBruteForce([7,2,5,10,8], 2))   // 18

print(splitArrayBruteForce([1,2,3,4,5], 2))    // 9

print(splitArrayBruteForce([1,4,4], 3))        // 4

print("Optimal")

print(splitArray([7,2,5,10,8], 2))   // 18

print(splitArray([1,2,3,4,5], 2))    // 9

print(splitArray([1,4,4], 3))        // 4

print(splitArray([1,2,3,4,5], 1))    // 15
