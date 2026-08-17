import Foundation

/*
 Q08 — LC169 Majority Element                              [Easy]

 Given an array nums of size n, return the majority element — the
 element that appears more than floor(n / 2) times.

 You may assume the majority element ALWAYS EXISTS in the array.

 Example 1:  nums = [3,2,3]          ->  3
 Example 2:  nums = [2,2,1,1,1,2,2]  ->  2

 Constraints:
   n == nums.length
   1 <= n <= 5 * 10^4
   -10^9 <= nums[i] <= 10^9

 Follow-up: linear time and O(1) space.
*/

let nums1 = [3, 2, 3]
let nums2 = [2, 2, 1, 1, 1, 2, 2]
let nums3 = [1]

//============================================================
// MARK: - Approach 1 — Frequency Map
// Time : O(n)
// Space: O(n)
//
// Counts everything, then scans for the largest count. Note this
// answers "MOST FREQUENT", which is a different question from
// "appears more than n/2 times" — they coincide here only because
// the problem guarantees a majority exists.
//
// The scan over the dictionary is safe only because a guaranteed
// majority means there is no tie. With ties, dictionary order is
// unspecified and the winner would vary between runs.
//============================================================

func majorityElementFrequencyMap(_ nums: [Int]) -> Int {

    var counts = [Int: Int]()

    for num in nums {
        if let count = counts[num] {
            counts[num] = count + 1
        } else {
            counts[num] = 1
        }
    }

    var answer = nums[0]
    var maxCount = 0

    for (key, value) in counts {
        if value > maxCount {
            maxCount = value
            answer = key
        }
    }

    return answer
}

//============================================================
// MARK: - Approach 2 — Boyer-Moore Voting (Optimal)
// Time : O(n)
// Space: O(1)  ← this is the follow-up
//
// Unequal elements cancel one-for-one. Anything occupying more
// than half the array survives all possible cancelling.
//
// count == 0  -> field is empty, current element takes it
// num == cand -> reinforcement, count += 1
// otherwise   -> one dies on each side, count -= 1
//
// WHY NO VERIFY PASS:
// This returns a CANDIDATE, not a proven majority. On [1,2,3] it
// returns 3, which is nonsense — no majority exists there. LC169
// guarantees a majority DOES exist, so the candidate is
// necessarily correct and the second O(n) pass can be dropped.
// Without that guarantee (e.g. LC229), you must verify by
// counting the candidate and checking count > n / 2.
//
// `candidate = 0` is never read: count starts at 0, so the first
// element always takes the `count == 0` branch.
//============================================================

func majorityElement(_ nums: [Int]) -> Int {

    var candidate = 0
    var count = 0

    for num in nums {
        if count == 0 {
            candidate = num
            count = 1
        } else if num == candidate {
            count += 1
        } else {
            count -= 1
        }
    }

    return candidate
}

//============================================================
// MARK: - Tests
//============================================================

print("========== Frequency Map ==========")

print(majorityElementFrequencyMap(nums1))

print(majorityElementFrequencyMap(nums2))

print(majorityElementFrequencyMap(nums3))

print("========== Boyer-Moore ==========")

print(majorityElement(nums1))

print(majorityElement(nums2))

print(majorityElement(nums3))
