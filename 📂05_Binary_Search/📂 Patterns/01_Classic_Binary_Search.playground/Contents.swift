// MARK: - Classic Binary Search
//
// Searches for an exact target in a sorted array.
//
// Preconditions:
// • Array must be sorted in non-decreasing order.
// • Returns any matching index if duplicates exist.
//
// Fires when:
// • Input is sorted.
// • Need the index of an exact value.
//
// T: O(log n)
// S: O(1)

func binarySearch(_ nums: [Int], _ target: Int) -> Int {

    var low = 0
    var high = nums.count - 1

    while low <= high {

        let mid = low + (high - low) / 2

        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }

    return -1
}

// MARK: - Tests

print(binarySearch([1, 3, 5, 7, 9, 11], 7))   // 3
print(binarySearch([1, 3, 5, 7, 9, 11], 4))   // -1
print(binarySearch([], 1))                    // -1
print(binarySearch([5], 5))                   // 0
print(binarySearch([5], 3))                   // -1
print(binarySearch([1, 2], 2))                // 1
