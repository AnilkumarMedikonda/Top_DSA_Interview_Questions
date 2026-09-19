import Foundation

// 01_Arrays_Q01_Q10

//==============================================================
// MARK: - Phase 01. Arrays
//==============================================================


//==============================================================
// MARK: - Q01. Two Sum
// Difficulty: Easy
// LeetCode: LC001
//==============================================================
//
// Problem:
// Given an array of integers nums and an integer target, return
// indices of the two numbers such that they add up to target.
//
// Example:
// Input: nums = [2, 7, 11, 15], target = 9
// Output: [0, 1]
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q01 - Two Sum")
print("==============================================================")

// Solution

func twoSum(_  nums: [Int], _ target: Int) -> [Int] {
    
    guard nums.count > 1 else { return [] }
    
    var hashMap = [Int: Int]()
    
    for i in 0..<nums.count {
        
        let number = nums[i]
        let hashTarget = target - number
        
        if let hashIndex = hashMap[hashTarget] {
            return [hashIndex, i]
        }
        hashMap[number] = i
    }
    
    return []
}


// Test cases
print("Input: [2, 7, 11, 15], target = 9 -> \(twoSum([2, 7, 11, 15], 9))")
print("Input: [3, 2, 4], target = 6 -> \(twoSum([3, 2, 4], 6))")
print("Input: [3, 3], target = 6 -> \(twoSum([3, 3], 6))")
print("Input: [1], target = 2 -> \(twoSum([1], 2))")



//==============================================================
// MARK: - Q02. Best Time To Buy And Sell Stock
// Difficulty: Easy
// LeetCode: LC121
//==============================================================
//
// Problem:
// Given an array prices where prices[i] is the price of a stock
// on day i, maximize your profit by choosing one day to buy and
// one later day to sell.
//
// Example:
// Input: prices = [7, 1, 5, 3, 6, 4]
// Output: 5
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q02 - Best Time To Buy And Sell Stock")
print("==============================================================")

// Solution

func maxProfit(_ prices: [Int]) -> Int {
    
    guard prices.count > 1 else { return 0 }
    var minPrice = Int.max
    var maxProfit = 0
    
    for price in prices {
        
        if price < minPrice {
            minPrice = price
        } else  {
            let currentProfit = price - minPrice
            maxProfit = max(maxProfit, currentProfit)
        }
    }
    return maxProfit
}


// Test cases
print("Input: [7, 1, 5, 3, 6, 4] -> \(maxProfit([7, 1, 5, 3, 6, 4]))")
print("Input: [1, 2, 3, 4, 5] -> \(maxProfit([1, 2, 3, 4, 5]))")
print("Input: [7, 6, 4, 3, 1] -> \(maxProfit([7, 6, 4, 3, 1]))")
print("Input: [5] -> \(maxProfit([5]))")


//==============================================================
// MARK: - Q03. Contains Duplicate
// Difficulty: Easy
// LeetCode: LC217
//==============================================================
//
// Problem:
// Given an integer array nums, return true if any value appears
// at least twice in the array, and return false if every element
// is distinct.
//
// Example:
// Input: nums = [1, 2, 3, 1]
// Output: true
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q03 - Contains Duplicate")
print("==============================================================")

// Solution


func containsDuplicate(_ nums: [Int]) -> Bool {
    
    var hashMap = [Int: Int]()
    
    for i in 0..<nums.count {
        
        let number = nums[i]
        
        if hashMap[number] != nil {
            return true
        }
        hashMap[number] = 1
    }
    
    return false
    
}


// Test cases
print("Input: [1, 2, 3, 1] -> \(containsDuplicate([1, 2, 3, 1]))")
print("Input: [1, 2, 3, 4] -> \(containsDuplicate([1, 2, 3, 4]))")
print("Input: [1, 1] -> \(containsDuplicate([1, 1]))")
print("Input: [1] -> \(containsDuplicate([1]))")


//==============================================================
// MARK: - Q04. Maximum Subarray
// Difficulty: Medium
// LeetCode: LC053
//==============================================================
//
// Problem:
// Given an integer array nums, find the subarray with the largest
// sum and return its sum.
//
// Example:
// Input: nums = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
// Output: 6
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q04 - Maximum Subarray")
print("==============================================================")

// Solution

func maxSubArray(_ nums: [Int]) -> Int {
    
    
    guard !nums.isEmpty else { return 0 }
    var currentSum = nums[0]
    var maxSum = nums[0]
    
    for i in 1..<nums.count {
        if nums[i] > currentSum + nums[i] {
            currentSum = nums[i]
        } else {
            currentSum += nums[i]
        }
        maxSum = max(currentSum, maxSum)
    }
    
    
    return maxSum
    
}



// Test cases
print("Input: [-2, 1, -3, 4, -1, 2, 1, -5, 4] -> \(maxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4]))")
print("Input: [5, 4, -1, 7, 8] -> \(maxSubArray([5, 4, -1, 7, 8]))")
print("Input: [-1, -2, -3] -> \(maxSubArray([-1, -2, -3]))")
print("Input: [5] -> \(maxSubArray([5]))")
print("Input: [1, 2, 3] -> \(maxSubArray([1, 2, 3]))")  // 6


//==============================================================
// MARK: - Q05. Move Zeroes
// Difficulty: Easy
// LeetCode: LC283
//==============================================================
//
// Problem:
// Given an integer array nums, move all 0's to the end while
// maintaining the relative order of the non-zero elements.
//
// Example:
// Input: nums = [0, 1, 0, 3, 12]
// Output: [1, 3, 12, 0, 0]
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q05 - Move Zeroes")
print("==============================================================")

// Solution


func moveZeroes(_ nums: inout [Int]) {
    
    var write = 0
    
    for i in 0..<nums.count {
        
        if nums[i] != 0 {
            nums.swapAt(i, write)
            write += 1
        }
        
    }
    
}


// Test cases
var zeroes1 = [0, 1, 0, 3, 12]
moveZeroes(&zeroes1)
print("Input: [0, 1, 0, 3, 12] -> \(zeroes1)")

var zeroes2 = [1, 2, 3, 4]
moveZeroes(&zeroes2)
print("Input: [1, 2, 3, 4] -> \(zeroes2)")

var zeroes3 = [0, 0, 1]
moveZeroes(&zeroes3)
print("Input: [0, 0, 1] -> \(zeroes3)")

var zeroes4 = [0, 0, 0]
moveZeroes(&zeroes4)
print("Input: [0, 0, 0] -> \(zeroes4)")


//==============================================================
// MARK: - Q06. Merge Sorted Array
// Difficulty: Easy
// LeetCode: LC088
//==============================================================
//
// Problem:
// Given two sorted integer arrays nums1 and nums2, merge nums2
// into nums1 as one sorted array.
//
// Example:
// Input: nums1 = [1, 2, 3, 0, 0, 0], m = 3
//        nums2 = [2, 5, 6], n = 3
// Output: [1, 2, 2, 3, 5, 6]
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q06 - Merge Sorted Array")
print("==============================================================")

// Solution

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
            
    var i = m - 1
    var j = n - 1
    
    var write = m + n - 1
    
    while i >= 0 && j >= 0 {
        
        if nums1[i] >= nums2[j] {
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
        j -= 1
        write -= 1
    }
    
    
}


// Test cases
var merge1 = [1, 2, 3, 0, 0, 0]
merge(&merge1, 3, [2, 5, 6], 3)
print("Input: [1, 2, 3], [2, 5, 6] -> \(merge1)")

var merge2 = [1]
merge(&merge2, 1, [], 0)
print("Input: [1], [] -> \(merge2)")

var merge3 = [0]
merge(&merge3, 0, [1], 1)
print("Input: [], [1] -> \(merge3)")

var merge4 = [2, 0]
merge(&merge4, 1, [1], 1)
print("Input: [2], [1] -> \(merge4)")


//==============================================================
// MARK: - Q07. Remove Duplicates From Sorted Array
// Difficulty: Easy
// LeetCode: LC026
//==============================================================
//
// Problem:
// Given an integer array nums sorted in non-decreasing order,
// remove the duplicates in-place so each unique element appears
// only once. Return the number of unique elements.
//
// Example:
// Input: nums = [1, 1, 2]
// Output: 2, nums = [1, 2, _]
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q07 - Remove Duplicates From Sorted Array")
print("==============================================================")

// Solution

func removeDuplicates(_ nums: inout [Int]) -> Int {
    
    guard !nums.isEmpty else { return 0 }
    
    var write = 1
    
    for read in 1..<nums.count {
        
        if nums[read] != nums[write-1] {
            nums[write] = nums[read]
            write += 1
        }
    }
    
    
    return write
}


// Test cases
var duplicates1 = [1, 1, 2]
let count1 = removeDuplicates(&duplicates1)
print("Input: [1, 1, 2] -> Count: \(count1), Array: \(duplicates1)")

var duplicates2 = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
let count2 = removeDuplicates(&duplicates2)
print("Input: [0, 0, 1, 1, 1, 2, 2, 3, 3, 4] -> Count: \(count2), Array: \(duplicates2)")

var duplicates3 = [1, 1, 1, 1]
let count3 = removeDuplicates(&duplicates3)
print("Input: [1, 1, 1, 1] -> Count: \(count3), Array: \(duplicates3)")

var duplicates4: [Int] = []
let count4 = removeDuplicates(&duplicates4)
print("Input: [] -> Count: \(count4), Array: \(duplicates4)")


//==============================================================
// MARK: - Q08. Majority Element
// Difficulty: Easy
// LeetCode: LC169
//==============================================================
//
// Problem:
// Given an array nums of size n, return the majority element.
// The majority element appears more than floor(n / 2) times.
//
// Example:
// Input: nums = [2, 2, 1, 1, 1, 2, 2]
// Output: 2
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q08 - Majority Element")
print("==============================================================")

// Solution

func majorityElement(_ nums: [Int]) -> Int {
    
    var candidate = 0
    var count = 0
    
    for num in nums {
        
        if count == 0 {
            candidate = num
            count += 1
        } else if candidate == num {
            count += 1
        } else {
            count -= 1
        }
    }
    
    return candidate
}



// Test cases
print("Input: [2, 2, 1, 1, 1, 2, 2] -> \(majorityElement([2, 2, 1, 1, 1, 2, 2]))")
print("Input: [3, 3, 4] -> \(majorityElement([3, 3, 4]))")
print("Input: [1] -> \(majorityElement([1]))")
print("Input: [5, 5, 5, 2, 2] -> \(majorityElement([5, 5, 5, 2, 2]))")


//==============================================================
// MARK: - Q09. Missing Number
// Difficulty: Easy
// LeetCode: LC268
//==============================================================
//
// Problem:
// Given an array nums containing n distinct numbers in the range
// [0, n], return the only number in the range that is missing.
//
// Example:
// Input: nums = [3, 0, 1]
// Output: 2
//
// Time: O(n)
// Space: O(1)
//
//==============================================================

print("\n==============================================================")
print("Q09 - Missing Number")
print("==============================================================")

// Solution

func missingNumber(_ nums: [Int]) -> Int {
    
    var totalSum = 0
    var expectedSum = 0
    
    
    for i in 0...nums.count {
        expectedSum += i
    }
    
    for num in nums {
        totalSum += num
    }
    
    return expectedSum - totalSum
}


// Test cases
print("Input: [3, 0, 1] -> \(missingNumber([3, 0, 1]))")
print("Input: [9, 6, 4, 2, 3, 5, 7, 0, 1] -> \(missingNumber([9, 6, 4, 2, 3, 5, 7, 0, 1]))")
print("Input: [0] -> \(missingNumber([0]))")
print("Input: [1] -> \(missingNumber([1]))")


//==============================================================
// MARK: - Q10. Product Of Array Except Self
// Difficulty: Medium
// LeetCode: LC238
//==============================================================
//
// Problem:
// Given an integer array nums, return an array answer such that
// answer[i] is equal to the product of all elements except nums[i].
//
// Example:
// Input: nums = [1, 2, 3, 4]
// Output: [24, 12, 8, 6]
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q10 - Product Of Array Except Self")
print("==============================================================")

// Solution


func productExceptSelf(_ nums: [Int]) -> [Int] {
    
    var result = Array(repeating: 1, count: nums.count)
    
    for i in 1..<result.count {
        result[i] = result[i-1] * nums[i-1]
    }
    
    var right = 1
    var j = nums.count - 1
    
    
    while j >= 0 {
        
        result[j] *= right
        right *= nums[j]
        j -= 1
    }
    
    return result
}



// Test cases
print("Input: [1, 2, 3, 4] -> \(productExceptSelf([1, 2, 3, 4]))")
print("Input: [-1, 1, 0, -3, 3] -> \(productExceptSelf([-1, 1, 0, -3, 3]))")
print("Input: [2, 3] -> \(productExceptSelf([2, 3]))")
print("Input: [5] -> \(productExceptSelf([5]))")
print("Input: [1, 2, 3, 4] -> \(productExceptSelf([1, 2, 3, 4]))")  // [24, 12, 8, 6]


//==============================================================
// MARK: - Phase 01. Arrays Revision Complete
//==============================================================
