import UIKit

// ============================================================
// 01_Arrays — Prerequisites
// Basic Swift Array Operations
// Required before solving Q01–Q10
// ============================================================

/*
 Topics Covered
 01. Print Elements
 02. Count Elements
 03. Maximum Element
 04. Minimum Element
 05. Maximum Element Index
 06. Minimum Element Index
 */

var numbers = [10, 45, 22, 99, 13, 78]

// MARK: - 01 Print Elements
// Time : O(n)
// Space: O(1)

func printElements(_ nums: [Int]) {

    guard !nums.isEmpty else { return }

    for num in nums {
        print(num)
    }
}

print("========== Print Elements ==========")
printElements(numbers)


// MARK: - 02 Count Elements
// Time : O(n)
// Space: O(1)

func countElements(_ nums: [Int]) -> Int {

    var count = 0

    for _ in nums {
        count += 1
    }

    return count
}

print()
print("========== Count Elements ==========")
print(countElements(numbers))


// ============================================================
// MARK: - 03 Maximum Element
// Time : O(n)
// Space: O(1)
// ============================================================

func maximumElement(_ nums: [Int]) -> Int {

    var maximum = Int.min

    guard !nums.isEmpty else { return maximum }

    for num in nums {
        if num > maximum {
            maximum = num
        }
    }

    return maximum
}

print()
print("========== Maximum Element ==========")
print(maximumElement(numbers))


// MARK: - 04 Minimum Element
// Time : O(n)
// Space: O(1)

func minimumElement(_ nums: [Int]) -> Int {

    var minimum = Int.max

    guard !nums.isEmpty else { return minimum }

    for num in nums {

        if num < minimum {
            minimum = num
        }
    }

    return minimum
}

print()
print("========== Minimum Element ==========")
print(minimumElement(numbers))


// MARK: - 05 Maximum Element Index
// Time : O(n)
// Space: O(1)

func maximumElementIndex(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return -1 }

    var maximum = Int.min
    var index = -1

    for i in 0..<nums.count {

        if nums[i] > maximum {

            maximum = nums[i]
            index = i
        }
    }

    return index
}

print()
print("========== Maximum Element Index ==========")
print(maximumElementIndex(numbers))


// MARK: - 06 Minimum Element Index
// Time : O(n)
// Space: O(1)

func minimumElementIndex(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return -1 }

    var minimum = Int.max
    var index = -1

    for i in 0..<nums.count {

        if nums[i] < minimum {

            minimum = nums[i]
            index = i
        }
    }

    return index
}

print()
print("========== Minimum Element Index ==========")
print(minimumElementIndex(numbers))


// MARK: - 07 Sum of Array
// Time : O(n)
// Space: O(1)

func sumOfElements(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var sum = 0

    for num in nums {
        sum += num
    }

    return sum
}

print()
print("========== Sum of Elements ==========")
print(sumOfElements(numbers))


// MARK: - 08 Average of Array
// Time : O(n)
// Space: O(1)

func averageOfArray(_ nums: [Int]) -> Double {

    guard !nums.isEmpty else { return 0 }

    let sum = sumOfElements(nums)
    return Double(sum) / Double(nums.count)
}

print()
print("========== Average of Array ==========")
print(averageOfArray(numbers))


// MARK: - 09 Linear Search
// Time : O(n)
// Space: O(1)

func linearSearch(_ nums: [Int], _ target: Int) -> Int {

    guard !nums.isEmpty else { return -1 }

    for i in 0..<nums.count {

        if nums[i] == target {
            return i
        }
    }

    return -1
}

print()
print("========== Linear Search ==========")
print(linearSearch(numbers, 22))
print(linearSearch(numbers, 100))


// MARK: - 10 Reverse Array (In-place)
// Time : O(n)
// Space: O(1)

var reverseNumbers = [10, 20, 30, 40, 50]

func reverseArray(_ nums: inout [Int]) {

    guard !nums.isEmpty else { return }
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

print()
print("========== Reverse Array ==========")
reverseArray(&reverseNumbers)
print(reverseNumbers)


// MARK: - 11 Swap Elements
// Time : O(1)
// Space: O(1)

var swapNumbers = [10, 20, 30, 40, 50]

func swapElements(_ nums: inout [Int], _ first: Int, _ second: Int) {

    guard first >= 0, second >= 0, first < nums.count,second < nums.count else {
        return
    }
    let temp = nums[first]
    nums[first] = nums[second]
    nums[second] = temp
}

print()
print("========== Swap Elements ==========")
swapElements(&swapNumbers, 1, 3)
print(swapNumbers)
