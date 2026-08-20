import Foundation

//============================================================
// Cyclic Sort - Notes
//============================================================

/*
 Purpose
 -------
 • Place every number at its correct index.
 • Works when numbers are in the range 0...n or 1...n.

 Idea
 ----
 • If a number is not in its correct position,
   swap it with the element at its correct index.
 • Repeat until every possible number is placed correctly.

 Time  : O(n)
 Space : O(1)

 Used In
 -------
 • LC268 - Missing Number
 • LC41 - First Missing Positive
 • Find Missing Numbers
 • Find Duplicate Numbers
*/


//------------------------------------------------------------
// 01 Cyclic Sort
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

var numbers = [3, 1, 5, 4, 2]

func cyclicSort(_ nums: inout [Int]) {

    var index = 0

    while index < nums.count {

        let correctIndex = nums[index] - 1

        if nums[index] != nums[correctIndex] {

            let temp = nums[index]
            nums[index] = nums[correctIndex]
            nums[correctIndex] = temp

        } else {
            index += 1
        }
    }
}

print("========== Cyclic Sort ==========")
print("Before :", numbers)

cyclicSort(&numbers)

print("After  :", numbers)
