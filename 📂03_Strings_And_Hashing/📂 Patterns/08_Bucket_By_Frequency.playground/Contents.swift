//
//  08_Bucket_By_Frequency
//  Phase 03 — Strings and Hashing
//
//  Index an array by COUNT instead of by value. Same move as the 26-slot
//  character array, different axis.
//  Size is n + 1: the highest possible frequency is n, so index n must exist.
//  Slot 0 is never filled — nothing appears zero times and still shows up.
//  Replaces a sort (O(n log n)) or a heap (O(n log k)) with O(n).
//
//  Feeds: Q25 Top K Frequent Elements
//

import Foundation

// 1 — bucket values by how often they appear.
// Time O(n), Space O(n)
func bucketByCount(_ nums: [Int]) -> [[Int]] {
    var hashMap = [Int: Int]()

    for num in nums {
        if let count = hashMap[num] {
            hashMap[num] = count + 1
        } else {
            hashMap[num] = 1
        }
    }

    var buckets = Array(repeating: [Int](), count: nums.count + 1)

    for (value, count) in hashMap {
        buckets[count].append(value)
    }

    return buckets
}

print(bucketByCount([1, 1, 1, 2, 2, 3]))

print(bucketByCount([5, 5, 5]))

print(bucketByCount([]))
