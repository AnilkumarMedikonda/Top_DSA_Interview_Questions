import Foundation

//==============================================================
// MARK: - First Occurrence
// Fires when: Find the first index of a target in a sorted array.
// T - O(log n), S - O(1)
//==============================================================

func firstOccurrence(_ nums: [Int], _ target: Int) -> Int {

    guard !nums.isEmpty else { return -1 }

    var low = 0
    var high = nums.count - 1
    var answer = -1

    while low <= high {

        let mid = low + (high - low) / 2

        if nums[mid] == target {

            answer = mid
            high = mid - 1

        } else if nums[mid] < target {

            low = mid + 1

        } else {

            high = mid - 1
        }
    }

    return answer
}

// MARK: - Tests

print(firstOccurrence([1, 2, 4, 4, 4, 6, 8], 4))   // 2
print(firstOccurrence([1, 2, 4, 4, 4, 6, 8], 6))   // 5
print(firstOccurrence([1, 2, 4, 4, 4, 6, 8], 3))   // -1
print(firstOccurrence([], 5))                      // -1



//==============================================================
// MARK: - Last Occurrence
// Fires when: Find the last index of a target in a sorted array.
// T - O(log n), S - O(1)
//==============================================================

func lastOccurrence(_ nums: [Int], _ target: Int) -> Int {

    guard !nums.isEmpty else { return -1 }

    var low = 0
    var high = nums.count - 1
    var answer = -1

    while low <= high {

        let mid = low + (high - low) / 2

        if nums[mid] == target {

            answer = mid
            low = mid + 1

        } else if nums[mid] < target {

            low = mid + 1

        } else {

            high = mid - 1
        }
    }

    return answer
}

// MARK: - Tests

print(lastOccurrence([1, 2, 4, 4, 4, 6, 8], 4))    // 4
print(lastOccurrence([1, 2, 4, 4, 4, 6, 8], 6))    // 5
print(lastOccurrence([1, 2, 4, 4, 4, 6, 8], 3))    // -1
print(lastOccurrence([], 5))                       // -1



//==============================================================
// MARK: - Lower Bound
// Fires when: Find the first element >= target.
// Returns insertion position if target is not found.
// T - O(log n), S - O(1)
//==============================================================

func lowerBound(_ nums: [Int], _ target: Int) -> Int {

    guard !nums.isEmpty else { return 0 }

    var low = 0
    var high = nums.count - 1
    var answer = nums.count

    while low <= high {

        let mid = low + (high - low) / 2

        if nums[mid] >= target {

            answer = mid
            high = mid - 1

        } else {

            low = mid + 1
        }
    }

    return answer
}

// MARK: - Tests

print(lowerBound([1, 3, 5, 7, 9], 5))      // 2
print(lowerBound([1, 3, 5, 7, 9], 6))      // 3
print(lowerBound([1, 3, 5, 7, 9], 0))      // 0
print(lowerBound([1, 3, 5, 7, 9], 10))     // 5
print(lowerBound([], 5))                   // 0



//==============================================================
// MARK: - Upper Bound
// Fires when: Find the first element > target.
// Returns insertion position if no greater element exists.
// T - O(log n), S - O(1)
//==============================================================

func upperBound(_ nums: [Int], _ target: Int) -> Int {

    guard !nums.isEmpty else { return 0 }

    var low = 0
    var high = nums.count - 1
    var answer = nums.count

    while low <= high {

        let mid = low + (high - low) / 2

        if nums[mid] > target {

            answer = mid
            high = mid - 1

        } else {

            low = mid + 1
        }
    }

    return answer
}

// MARK: - Tests

print(upperBound([1, 3, 5, 7, 9], 5))      // 3
print(upperBound([1, 3, 5, 7, 9], 6))      // 3
print(upperBound([1, 3, 5, 5, 5, 7], 5))   // 5
print(upperBound([1, 3, 5, 7, 9], 10))     // 5
print(upperBound([], 5))                   // 0
