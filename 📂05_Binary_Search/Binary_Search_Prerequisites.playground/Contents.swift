import Foundation

//
//  Binary_Search_Prerequisites
//
//  Mechanics only.
//  No LeetCode problems.
//  No Binary Search implementation.
//
//  Rules:
//  • Manual loops only
//  • No built-in helpers
//  • No force unwraps
//  • Always compute mid as:
//      low + (high - low) / 2
//

// MARK: - D1 Mid Index
// T: O(1), S: O(1)

func midIndex(_ low: Int, _ high: Int) -> Int {
    low + (high - low) / 2
}

print(midIndex(0, 9))
print(midIndex(0, 8))
print(midIndex(4, 5))

// MARK: - D2 Check Sorted
// T: O(n), S: O(1)

func isSorted(_ nums: [Int]) -> Bool {

    if nums.count < 2 {
        return true
    }

    for i in 0..<nums.count - 1 {
        if nums[i] > nums[i + 1] {
            return false
        }
    }

    return true
}

print(isSorted([]))
print(isSorted([5]))
print(isSorted([1,2,2,3]))
print(isSorted([1,3,2]))
print(isSorted([3,2,1]))

// MARK: - D3 Linear Search
// T: O(n), S: O(1)

func linearSearch(_ nums: [Int], _ target: Int) -> Int {

    for i in 0..<nums.count {
        if nums[i] == target {
            return i
        }
    }

    return -1
}

print(linearSearch([1,3,5,7],5))
print(linearSearch([1,3,5,7],1))
print(linearSearch([1,3,5,7],9))
print(linearSearch([],5))

// MARK: - D4 Halving Count
// T: O(log n), S: O(1)

func halvingCount(_ n: Int) -> Int {

    var value = n
    var count = 0

    while value > 1 {
        value /= 2
        count += 1
    }

    return count
}

print(halvingCount(1))
print(halvingCount(8))
print(halvingCount(10))
print(halvingCount(1000))
print(halvingCount(1_000_000))

// MARK: - D5 Search Space Shrinking
// T: O(log n), S: O(1)

func shrinkSearchSpace(_ size: Int) {

    var range = size

    while range > 1 {
        print("Remaining:", range)
        range /= 2
    }

    print("Remaining:", range)
}

shrinkSearchSpace(32)
