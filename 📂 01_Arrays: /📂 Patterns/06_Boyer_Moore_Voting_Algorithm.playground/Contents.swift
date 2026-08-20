import Foundation


//============================================================
// Boyer-Moore Voting Algorithm - Notes
//============================================================

/*
 Purpose
 -------
 • Find the Majority Element.

 Condition
 ---------
 • Majority Element appears more than n/2 times.

 Why n/2?
 --------
 • The majority element appears more times than all other
   elements combined.
 • Pair cancellation can never eliminate it completely.

 Idea
 ----
 • Keep one candidate and one count.
 • Same element      -> count += 1
 • Different element -> count -= 1
 • If count becomes 0, choose a new candidate.
 • Verify the candidate if the problem doesn't guarantee a
   majority element.

 Time  : O(n)
 Space : O(1)

 Used In
 -------
 • LC169 - Majority Element
*/

//============================================================
// 01 Majority Element (Boyer-Moore Voting)
//============================================================

var numbers = [2, 2, 1, 1, 1, 2, 2]

//------------------------------------------------------------
// Step 1: Find Candidate
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

func majorityCandidate(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return -1 }

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

print("========== Majority Candidate ==========")

let candidate = majorityCandidate(numbers)

print("Candidate :", candidate)


//------------------------------------------------------------
// Step 2: Verify Candidate
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

func occursMoreThanHalf(_ nums: [Int], _ candidate: Int) -> Bool {

    var count = 0

    for num in nums {

        if num == candidate {
            count += 1
        }
    }

    return count > nums.count / 2
}

print()
print("========== Verify Candidate ==========")
print("Is Majority :", occursMoreThanHalf(numbers, candidate))
