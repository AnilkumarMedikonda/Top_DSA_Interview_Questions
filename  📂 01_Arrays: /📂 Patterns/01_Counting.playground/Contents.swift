import UIKit

//============================================================
// 01_Counting Pattern
// Pattern: Counting / Frequency Counting
//============================================================

let numbers = [10, 20, 30, 20, 40, 20, 50]

//============================================================
// MARK: - 01 Count Total Elements
// Time : O(n)
// Space: O(1)
//============================================================

func countElements(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var count = 0

    for _ in nums {
        count += 1
    }

    return count
}

print("========== 01 Count Total Elements ==========")
print(countElements(numbers))


//============================================================
// MARK: - 02 Count Occurrence of Target
// Time : O(n)
// Space: O(1)
//============================================================

func countOccurrences(_ nums: [Int], _ target: Int) -> Int {

    guard !nums.isEmpty else { return 0 }

    var count = 0

    for num in nums {

        if num == target {
            count += 1
        }
    }

    return count
}

print()
print("========== 02 Count Occurrence of Target ==========")
print(countOccurrences(numbers, 20))


//============================================================
// MARK: - 03 Count Even Numbers
// Time : O(n)
// Space: O(1)
//============================================================

func countEvenNumbers(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var count = 0

    for num in nums {

        if num % 2 == 0 {
            count += 1
        }
    }

    return count
}

print()
print("========== 03 Count Even Numbers ==========")
print(countEvenNumbers(numbers))


//============================================================
// MARK: - 04 Count Odd Numbers
// Time : O(n)
// Space: O(1)
//============================================================

func countOddNumbers(_ nums: [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var count = 0

    for num in nums {

        if num % 2 != 0 {
            count += 1
        }
    }

    return count
}

print()
print("========== 04 Count Odd Numbers ==========")
print(countOddNumbers(numbers))


//============================================================
// MARK: - 05 Frequency Map
// Time : O(n)
// Space: O(n)
//============================================================

func frequencyMap(_ nums: [Int]) -> [Int : Int] {

    guard !nums.isEmpty else { return [:] }

    var map = [Int : Int]()

    for num in nums {

        if let count = map[num] {
            map[num] = count + 1
        } else {
            map[num] = 1
        }
    }

    return map
}

print()
print("========== 05 Frequency Map ==========")
let frequency = frequencyMap(numbers)
print(frequency)


//============================================================
// MARK: - 06 Find Duplicate Elements
// Time : O(n)
// Space: O(n)
//============================================================

func findDuplicateElements(_ nums: [Int]) -> [Int] {

    guard !nums.isEmpty else { return [] }

    var map = [Int : Int]()
    var result = [Int]()

    for num in nums {

        if let count = map[num] {
            map[num] = count + 1
        } else {
            map[num] = 1
        }
    }

    for (key, value) in map {

        if value > 1 {
            result.append(key)
        }
    }

    return result
}

print()
print("========== 06 Find Duplicate Elements ==========")
print(findDuplicateElements(numbers))


//============================================================
// MARK: - 07 Find Unique Elements
// Time : O(n)
// Space: O(n)
//============================================================

func findUniqueElements(_ nums: [Int]) -> [Int] {

    guard !nums.isEmpty else { return [] }

    var map = [Int : Int]()
    var result = [Int]()

    for num in nums {

        if let count = map[num] {
            map[num] = count + 1
        } else {
            map[num] = 1
        }
    }

    for (key, value) in map {

        if value == 1 {
            result.append(key)
        }
    }

    return result
}

print()
print("========== 07 Find Unique Elements ==========")
print(findUniqueElements(numbers))
