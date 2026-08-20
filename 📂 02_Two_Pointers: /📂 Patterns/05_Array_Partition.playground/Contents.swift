import Foundation

import Foundation

//==============================================================
// Pattern 05 — Array Partition
// Read & Swap Pattern
//==============================================================

/*
 Definition
 ----------
 Partition divides an array into two groups
 based on a condition.

 Examples
 --------
 • Negative | Positive
 • Even | Odd
 • Zero | Non-Zero

 Pattern
 -------
 Read  -> Scans every element.
 Write -> Next position for matching element.
*/

/*
 Template

 var write = 0
 var read = 0

 while read < nums.count {

     if condition {

         nums.swapAt(read, write)
         write += 1
     }

     read += 1
 }
*/

/*
 Complexity
 ----------
 Time  : O(n)
 Space : O(1)
*/

/*
 Edge Cases
 ----------
 • Empty array
 • All elements match
 • No elements match
 • Single element
 • Zero is neither positive nor negative
*/



func moveNegativesToLeft(_ nums: inout [Int]) -> Int {
    var write = 0
    var read = 0
    while read < nums.count {
        if nums[read] < 0 {
            let temp = nums[read]
            nums[read] = nums[write]
            nums[write] = temp
            write += 1
        }
        read += 1
    }
    return write
}

var nums = [3, -2, 5, -1, 7, -6]
let negativeCount = moveNegativesToLeft(&nums)
print(nums, negativeCount)

nums = [3, 8, 1, 6, 2, 7]

// Time: O(n)  |  Space: O(1)
// Edge cases: empty array (returns 0), all even (returns count), no evens (returns 0), negatives (-4 % 2 == 0, handled)

func moveEvensToLeft(_ nums: inout [Int]) -> Int {
    var write = 0
    var read = 0
    while read < nums.count {
        if nums[read] % 2 == 0 {
            let temp = nums[read]
            nums[read] = nums[write]
            nums[write] = temp
            write += 1
        }
        read += 1
    }
    return write
}

nums = [3, 8, 1, 6, 2, 7]
let evenCount = moveEvensToLeft(&nums)
print(nums)

print("evens end at index \(evenCount)")
