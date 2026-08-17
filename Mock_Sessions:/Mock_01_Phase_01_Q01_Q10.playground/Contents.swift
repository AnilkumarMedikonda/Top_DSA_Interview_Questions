import Foundation

// =====================================================================
// PHASE 01 — ARRAYS (Q01–Q10)  ·  FINAL
//
// Date attempted: 2026-08-17
// Result: 10 / 10 correct
// =====================================================================


// ---------------------------------------------------------------------
// Q01 — LC 001. Two Sum
//
// Return the indices of the two numbers that add up to target. Exactly
// one solution exists. Cannot use the same element twice.
//
// nums = [2,7,11,15], target = 9  ->  [0,1]
//
// Constraints:
//   2 <= nums.length <= 10^4
//   -10^9 <= nums[i], target <= 10^9
//   Only one valid answer exists.
//
// Edge cases: duplicate values [3,3]; answer not at the start [3,2,4]
// Pattern: HashMap — check for the complement BEFORE inserting
// T - O(n)  S - O(n)
// Result: [x] clean
// ---------------------------------------------------------------------

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var hashMap = [Int: Int]()

    for i in 0..<nums.count {
        let number = nums[i]
        let hasTarget = target - number

        if let index = hashMap[hasTarget] {
            return [index, i]
        }
        hashMap[number] = i
    }

    return []
}

print("Q01 Two Sum")

print(twoSum([2, 7, 11, 15], 9))        // expect [0,1]

print(twoSum([3, 3], 6))                // expect [0,1]

print(twoSum([3, 2, 4], 6))             // expect [1,2]


// ---------------------------------------------------------------------
// Q02 — LC 121. Best Time to Buy and Sell Stock
//
// Buy on one day, sell on a later day. Return the max profit, or 0 if
// no profit is possible.
//
// prices = [7,1,5,3,6,4]  ->  5
//
// Constraints:
//   1 <= prices.length <= 10^5
//   0 <= prices[i] <= 10^4
//
// Edge cases: descending prices -> 0; single day -> 0
// Pattern: one-pass running state — track the min price seen so far
// T - O(n)  S - O(1)
// Result: [x] clean
// ---------------------------------------------------------------------

func maxProfit(_ prices: [Int]) -> Int {
    var bestProfit = 0
    var minPrice = Int.max

    for price in prices {
        if price < minPrice {
            minPrice = price
        } else {
            let profit = price - minPrice
            if profit > bestProfit {
                bestProfit = profit
            }
        }
    }

    return bestProfit
}

print("Q02 Best Time to Buy and Sell Stock")

print(maxProfit([7, 1, 5, 3, 6, 4]))    // expect 5

print(maxProfit([7, 6, 4, 3, 1]))       // expect 0

print(maxProfit([1]))                   // expect 0


// ---------------------------------------------------------------------
// Q03 — LC 217. Contains Duplicate
//
// Return true if any value appears at least twice.
//
// nums = [1,2,3,1]  ->  true
//
// Constraints:
//   1 <= nums.length <= 10^5
//   -10^9 <= nums[i] <= 10^9
//
// Edge cases: all unique -> false; single element -> false
// Pattern: Set — counts are never read, so a Set beats a dictionary
// T - O(n)  S - O(n)
// Result: [x] clean
// ---------------------------------------------------------------------

func containsDuplicate(_ nums: [Int]) -> Bool {
    var seen = Set<Int>()

    for num in nums {
        if seen.contains(num) {
            return true
        }
        seen.insert(num)
    }

    return false
}

print("Q03 Contains Duplicate")

print(containsDuplicate([1, 2, 3, 1]))      // expect true

print(containsDuplicate([1, 2, 3, 4]))      // expect false

print(containsDuplicate([1]))               // expect false


// ---------------------------------------------------------------------
// Q04 — LC 053. Maximum Subarray
//
// Return the largest sum of any contiguous non-empty subarray.
//
// nums = [-2,1,-3,4,-1,2,1,-5,4]  ->  6
//
// Constraints:
//   1 <= nums.length <= 10^5
//   -10^4 <= nums[i] <= 10^4
//
// Edge cases: ALL NEGATIVE [-3,-1,-2] -> -1; single element
// Pattern: Kadane. `currentSum > 0` is exactly when extending the run
// beats restarting it — no built-in max needed. Testing the new total
// instead (`sum > 0`) is the trap: it throws away a good run on one
// large negative.
// T - O(n)  S - O(1)
// Result: [x] clean
// ---------------------------------------------------------------------

func maxSubArray(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    var maxSum = nums[0]
    var currentSum = nums[0]

    for i in 1..<nums.count {
        if currentSum > 0 {
            currentSum += nums[i]
        } else {
            currentSum = nums[i]
        }
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return maxSum
}

print("Q04 Maximum Subarray")

print(maxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4]))     // expect 6

print(maxSubArray([-3, -1, -2]))                        // expect -1

print(maxSubArray([5]))                                 // expect 5


// ---------------------------------------------------------------------
// Q05 — LC 283. Move Zeroes
//
// Move all zeroes to the end in-place, keeping the relative order of the
// non-zero elements. No copy of the array.
//
// nums = [0,1,0,3,12]  ->  [1,3,12,0,0]
//
// Constraints:
//   1 <= nums.length <= 10^4
//   -2^31 <= nums[i] <= 2^31 - 1
//
// Edge cases: [0] single zero; [1,2,3] no zeroes at all
// Pattern: write pointer + swap. The swap answers the follow-up — no
// second pass is needed to zero-fill the tail.
// T - O(n)  S - O(1)
// Result: [x] clean
// ---------------------------------------------------------------------

func moveZeroes(_ nums: inout [Int]) {
    var write = 0

    for i in 0..<nums.count {
        if nums[i] != 0 {
            let temp = nums[write]
            nums[write] = nums[i]
            nums[i] = temp
            write += 1
        }
    }
}

print("Q05 Move Zeroes")

var q05a = [0, 1, 0, 3, 12]
moveZeroes(&q05a)
print(q05a)                 // expect [1,3,12,0,0]

var q05b = [0]
moveZeroes(&q05b)
print(q05b)                 // expect [0]

var q05c = [1, 2, 3]
moveZeroes(&q05c)
print(q05c)                 // expect [1,2,3]


// ---------------------------------------------------------------------
// Q06 — LC 088. Merge Sorted Array
//
// nums1 has length m + n: the first m slots hold its elements, the last
// n are placeholders. Merge nums2 into nums1 in-place, sorted. Nothing
// is returned.
//
// nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3  ->  [1,2,2,3,5,6]
//
// Constraints:
//   nums1.length == m + n, nums2.length == n
//   0 <= m, n <= 200 and 1 <= m + n <= 200
//   -10^9 <= nums1[i], nums2[j] <= 10^9
//
// Edge cases: m = 0; n = 0 — both handled by the loop conditions, no
// guard required
// Pattern: backward fill from m + n - 1, so nothing is overwritten
// before it is read. Only nums2 needs a drain loop — leftover nums1
// elements already sit in their final slots.
// T - O(m + n)  S - O(1)
// Result: [x] clean
// ---------------------------------------------------------------------

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var i = m - 1
    var j = n - 1
    var write = m + n - 1

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
        write -= 1
        j -= 1
    }
}

print("Q06 Merge Sorted Array")

var q06a = [1, 2, 3, 0, 0, 0]
merge(&q06a, 3, [2, 5, 6], 3)
print(q06a)                     // expect [1,2,2,3,5,6]

var q06b = [1]
merge(&q06b, 1, [], 0)
print(q06b)                     // expect [1]

var q06c = [0]
merge(&q06c, 0, [1], 1)
print(q06c)                     // expect [1]


// ---------------------------------------------------------------------
// Q07 — LC 026. Remove Duplicates from Sorted Array
//
// Remove duplicates in-place from a sorted array. Return k, the count of
// unique elements; the first k slots must hold them in order.
//
// nums = [0,0,1,1,1,2,2,3,3,4]  ->  5, nums = [0,1,2,3,4,...]
//
// Constraints:
//   1 <= nums.length <= 3 * 10^4
//   -100 <= nums[i] <= 100
//   nums is sorted in non-decreasing order.
//
// Edge cases: SINGLE ELEMENT [5] -> 1 (this was the repeated miss); all
// duplicates [1,1] -> 1; all unique [1,2,3] -> 3
// Pattern: write pointer from index 1 (index 0 is always unique).
// Compare against nums[write - 1] — the last element KEPT, not the last
// element read. With write seeded at 1, `1..<nums.count` is an empty
// range for a single element, so the answer falls out correctly.
// T - O(n)  S - O(1)
// Result: [x] clean
// ---------------------------------------------------------------------

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

print("Q07 Remove Duplicates from Sorted Array")

var q07a = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
print(removeDuplicates(&q07a))      // expect 5

var q07b = [5]
print(removeDuplicates(&q07b))      // expect 1

var q07c = [1, 1]
print(removeDuplicates(&q07c))      // expect 1

var q07d = [1, 2, 3]
print(removeDuplicates(&q07d))      // expect 3


// ---------------------------------------------------------------------
// Q08 — LC 169. Majority Element
//
// Return the element appearing more than n/2 times. It always exists.
//
// nums = [2,2,1,1,1,2,2]  ->  2
//
// Constraints:
//   1 <= nums.length <= 5 * 10^4
//   -10^9 <= nums[i] <= 10^9
//   Follow-up: O(n) time, O(1) space.
//
// Edge cases: single element; candidate switching mid-array [3,2,3]
// Pattern: Boyer-Moore voting. Because the majority element occupies
// more than half the array, its votes cannot all be cancelled out.
// T - O(n)  S - O(1)
// Result: [x] clean
// ---------------------------------------------------------------------

func majorityElement(_ nums: [Int]) -> Int {
    var candidate = 0
    var count = 0

    for num in nums {
        if count == 0 {
            candidate = num
            count = 1
        } else if candidate == num {
            count += 1
        } else {
            count -= 1
        }
    }

    return candidate
}

print("Q08 Majority Element")

print(majorityElement([3, 2, 3]))                   // expect 3

print(majorityElement([2, 2, 1, 1, 1, 2, 2]))       // expect 2

print(majorityElement([1]))                         // expect 1


// ---------------------------------------------------------------------
// Q09 — LC 268. Missing Number
//
// nums holds n distinct numbers from the range [0, n]. Return the one
// number in that range which is missing.
//
// nums = [3,0,1]  ->  2
//
// Constraints:
//   n == nums.length and 1 <= n <= 10^4
//   0 <= nums[i] <= n, all values unique
//   Follow-up: O(1) extra space, O(n) time.
//
// Edge cases: [0] -> 1 (missing at the end); [1] -> 0 (missing at 0)
// Pattern: (a) sum — expected total for 0...n minus the actual total.
// (b) XOR — every index and value cancels in pairs, leaving only the
// missing number. XOR cannot overflow by construction, which is the
// answer to give if an interviewer raises the constraint on n.
// T - O(n)  S - O(1)  (both versions)
// Result: [x] clean
// ---------------------------------------------------------------------

func missingNumber(_ nums: [Int]) -> Int {
    var expectedSum = 0

    for num in 0...nums.count {
        expectedSum += num
    }
    var actualSum = 0

    for num in nums {
        actualSum += num
    }

    return expectedSum - actualSum
}

func missingNumberXOR(_ nums: [Int]) -> Int {
    var result = nums.count

    for i in 0..<nums.count {
        result ^= i
        result ^= nums[i]
    }

    return result
}

print("Q09 Missing Number — sum")

print(missingNumber([9, 6, 4, 2, 3, 5, 7, 0, 1]))       // expect 8

print(missingNumber([0]))                               // expect 1

print(missingNumber([1]))                               // expect 0

print("Q09 Missing Number — XOR")

print(missingNumberXOR([9, 6, 4, 2, 3, 5, 7, 0, 1]))    // expect 8

print(missingNumberXOR([0]))                            // expect 1

print(missingNumberXOR([1]))                            // expect 0


// ---------------------------------------------------------------------
// Q10 — LC 238. Product of Array Except Self
//
// answer[i] = product of every element except nums[i]. O(n) time, no
// division.
//
// nums = [1,2,3,4]  ->  [24,12,8,6]
//
// Constraints:
//   2 <= nums.length <= 10^5
//   -30 <= nums[i] <= 30
//   Every prefix and suffix product fits in a 32-bit integer.
//   Follow-up: O(1) extra space (the output array does not count).
//
// Edge cases: a ZERO in the array [-1,1,0,-3,3] -> [0,0,9,0,0] (this is
// what a division-based approach cannot handle); minimum length [2,3]
// Pattern: prefix then suffix. Left-to-right fills answer with the
// running prefix product; right-to-left multiplies each slot by a
// running suffix. Order matters — multiply into answer[j] FIRST, then
// update right, or nums[j] ends up inside its own product.
// T - O(n)  S - O(1) extra, excluding the output array
// Result: [x] clean
// ---------------------------------------------------------------------

func productExceptSelf(_ nums: [Int]) -> [Int] {
    var answer = Array(repeating: 1, count: nums.count)

    for i in 1..<answer.count {
        answer[i] = answer[i - 1] * nums[i - 1]
    }
    var right = 1
    var j = nums.count - 1

    while j >= 0 {
        answer[j] *= right
        right *= nums[j]
        j -= 1
    }

    return answer
}

print("Q10 Product of Array Except Self")

print(productExceptSelf([1, 2, 3, 4]))              // expect [24,12,8,6]

print(productExceptSelf([-1, 1, 0, -3, 3]))         // expect [0,0,9,0,0]

print(productExceptSelf([2, 3]))                    // expect [3,2]


// =====================================================================
// SESSION SUMMARY — 2026-08-17
//
//   Clean first try:   10 / 10 (fifth pass; earlier passes 8/10 and 9/10)
//
//   Bugs by category across the day:
//     sentinel / init   Int.min for a min-tracker (Q02); maxSum seeded
//                       at 0 on a problem whose answer can be negative
//     guard / edge      Q07 single element, introduced three separate
//                       times; dead guards added on problems whose
//                       constraints rule out an empty array
//     condition         Q04 tested `sum > 0` instead of `currentSum > 0`
//     signature         Q06 parameter order not LeetCode's
//
//   Carry forward to Mock 01:
//     - Name the edge cases BEFORE coding, then RUN them. Every failure
//       today was a test whose expected value was already written down.
//     - Do not add a guard unless it can change the result. A guard that
//       returns a plausible wrong value is worse than no guard.
//
//   PATTERN SUMMARY — four patterns cover all ten problems
//     Hashing / Set           Q01, Q03
//     Write pointer           Q05, Q07
//     One-pass running state  Q02, Q04, Q08
//     Prefix / backward fill  Q06, Q09, Q10
// =====================================================================
