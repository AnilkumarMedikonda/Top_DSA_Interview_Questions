import Foundation

//==============================================================
// Pattern 09 — Cyclic Sort
//==============================================================

/*
 Objective
 ---------
 Place every number at its correct index.

 Number  -> Correct Index

 1 -> 0
 2 -> 1
 3 -> 2
 4 -> 3
 5 -> 4
*/

/*
 Example

 Before
 [3,5,2,1,4]

 After
 [1,2,3,4,5]
*/

/*
 When to Use
 -----------
✓ Numbers are in the range 1...n
✓ Need to place numbers at their correct position
✓ Missing Number
✓ Missing Positive
✓ Duplicate Number
✓ Corrupt Pair
*/

/*
 Core Formula
 ------------

correctIndex = nums[i] - 1
Example

nums[i] = 4
correctIndex = 3

↓
4 belongs at index 3
*/

/*
 Algorithm
 ---------
Start

i = 0

↓
Find correct index

↓
Already at correct position?

YES
↓
Move to next index

NO
↓

Swap

↓

Stay on same index

Repeat
*/

/*
 Golden Rule
 -----------
Swap

↓

Do NOT increment i
Reason:
A new number comes to index i.
It may also be in the wrong position.

Only increment i when

nums[i] == nums[correctIndex]
*/

/*
 Template
 --------
var i = 0

while i < nums.count {
    let correctIndex = nums[i] - 1
    if nums[i] != nums[correctIndex] {
        swap
    } else {
        i += 1
    }
}
*/

/*
 Time  : O(n)
 Space : O(1)
*/

//==============================================================
// Cyclic Sort
//==============================================================

func cyclicSort(_ nums: inout [Int]) {

    var i = 0

    while i < nums.count {

        let correctIndex = nums[i] - 1

        print("\n====================================")
        print("Current Index : \(i)")
        print("Current Value : \(nums[i])")
        print("Correct Index : \(correctIndex)")
        print("Array Before  : \(nums)")

        if nums[i] != nums[correctIndex] {

            print("❌ Wrong Position")
            print("Swap \(nums[i]) ↔︎ \(nums[correctIndex])")

            let temp = nums[i]
            nums[i] = nums[correctIndex]
            nums[correctIndex] = temp

            print("Array After Swap")
            print(nums)

        } else {

            print("✅ Already Correct")
            print("Move to Next Index")

            i += 1
        }
    }
}

//==============================================================
// Test
//==============================================================

var nums = [3,5,2,1,4]

print("Before :", nums)

cyclicSort(&nums)

print("\n==============================")
print("After :", nums)
