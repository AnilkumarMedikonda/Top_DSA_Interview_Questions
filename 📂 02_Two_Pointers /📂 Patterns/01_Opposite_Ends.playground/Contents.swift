import Foundation

//==============================================================
// Pattern 01 — Opposite Ends
// Two Pointers
//==============================================================

var nums = [1,2,3,4,5]

func reverseArray(_ nums: inout [Int]) {
    
    var left = 0
    var right = nums.count - 1

    while left < right {
        let temp = nums[left]
        nums[left] = nums[right]
        nums[right] = temp
        left += 1
        right -= 1
    }
}
reverseArray(&nums)
print(nums)
