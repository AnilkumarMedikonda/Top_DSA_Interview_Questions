

import Foundation

//==============================================================
// Pattern 05 — Dutch National Flag
//==============================================================

// Time: O(n)  |  Space: O(1)
// Edge cases: empty array (high = -1, loop skipped), single element, all same value


func swapElements(_ nums: inout [Int], _ i: Int, _ j: Int) {
    guard i >= 0, j >= 0, i < nums.count, j < nums.count, i != j else {
        return
    }
    let temp = nums[i]
    nums[i] = nums[j]
    nums[j] = temp
}

func sortColors(_ nums: inout [Int]) {
    var low = 0
    var mid = 0
    var high = nums.count - 1
    while mid <= high {
        if nums[mid] == 0 {
            swapElements(&nums, low, mid)
            low += 1
            mid += 1
        } else if nums[mid] == 1 {
            mid += 1
        } else {
            swapElements(&nums, high, mid)
            high -= 1
        }
    }
}

var colors = [2, 0, 2, 1, 1, 0]
sortColors(&colors)
print(colors)

var tricky = [2, 0, 1]
sortColors(&tricky)
print(tricky)


