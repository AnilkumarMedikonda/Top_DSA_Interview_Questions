//
//  Q25_LC347_Top_K_Frequent_Elements
//  Phase 03 — Strings and Hashing
//
//  Return the k most frequent elements of nums, in any order.
//
//  Example:
//  ([1,1,1,2,2,3], 2) → [1,2]
//  ([1], 1)           → [1]
//
//  Constraints:
//  1 <= nums.length <= 10^5
//  k is in [1, number of distinct elements]
//  The answer is guaranteed unique.
//
//  Pattern: 08_Bucket_By_Frequency + 01_HashMap
//
//  Counts are bounded by n, so index BY the count instead of comparing counts.
//  That's what replaces a sort (O(n log n)) or a heap (O(n log k)) with O(n).
//  Bucket size is n + 1: the highest possible frequency is n, so index n must
//  exist. Slot 0 is never filled — nothing appears zero times.
//

import Foundation

// MARK: - Helper

func buildFrequencyMap(_ nums: [Int]) -> [Int: Int] {
    var hashMap = [Int: Int]()

    for num in nums {
        if let count = hashMap[num] {
            hashMap[num] = count + 1
        } else {
            hashMap[num] = 1
        }
    }

    return hashMap
}

// MARK: - Brute force
// Count, then scan the whole map k times, taking the max each round.
// `taken` stops a winner being picked twice.
// T - O(n + d·k) where d = distinct values  S - O(d)

func topKFrequentBrute(_ nums: [Int], _ k: Int) -> [Int] {
    let hashMap = buildFrequencyMap(nums)
    var result = [Int]()
    var taken = Set<Int>()

    while result.count < k {
        var bestValue = 0
        var bestCount = 0

        for (value, count) in hashMap {
            if taken.contains(value) {
                continue
            }

            if count > bestCount {
                bestCount = count
                bestValue = value
            }
        }

        if bestCount == 0 {
            break
        }

        result.append(bestValue)
        taken.insert(bestValue)
    }

    return result
}

// MARK: - Better
// Sort the distinct values by count, take the first k.
// Honest about the cost — sorting is what buckets exist to avoid.
// T - O(n + d log d)  S - O(d)

func topKFrequentSorted(_ nums: [Int], _ k: Int) -> [Int] {
    let hashMap = buildFrequencyMap(nums)
    var pairs = [(value: Int, count: Int)]()

    for (value, count) in hashMap {
        pairs.append((value, count))
    }

    pairs.sort(by: { $0.count > $1.count })

    var result = [Int]()
    var i = 0

    while i < k && i < pairs.count {
        result.append(pairs[i].value)
        i += 1
    }

    return result
}

// MARK: - Optimal
// Frequency map → buckets indexed by count → walk BACKWARDS.
// Forward returns the least frequent.
// The result.count < k check sits inside the inner loop too: one bucket can
// hold several values, so dumping a whole bucket can overshoot k.
// T - O(n)  S - O(n)

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    let hashMap = buildFrequencyMap(nums)
    var buckets = Array(repeating: [Int](), count: nums.count + 1)

    for (value, count) in hashMap {
        buckets[count].append(value)
    }

    var result = [Int]()
    var current = nums.count

    while current > 0 && result.count < k {
        for value in buckets[current] {
            if result.count < k {
                result.append(value)
            }
        }

        current -= 1
    }

    return result
}

// MARK: - Tests

print(topKFrequentBrute([1, 1, 1, 2, 2, 3], 2))

print(topKFrequentSorted([1, 1, 1, 2, 2, 3], 2))

print(topKFrequent([1, 1, 1, 2, 2, 3], 2))

print(topKFrequent([1], 1))

print(topKFrequent([1, 2], 2))

print(topKFrequent([4, 4, 4, 5, 5, 6], 1))

print(topKFrequent([5, 5, 5], 1))

// MARK: - Notes
//
// Approaches:
//   Brute    repeated max over the map    T O(n + d·k)      S O(d)
//   Better   sort the frequency map       T O(n + d log d)  S O(d)
//   Optimal  bucket by count              T O(n)            S O(n)
//
// A min-heap of size k is O(n log k) — better than sorting, still worse than
// buckets. Buckets win because counts are bounded by n and can be used as
// array indices; comparison-based methods don't know that.
//
// Walk from nums.count down to 1. Using index < nums.count instead misses the
// top bucket: [5,5,5] puts its answer at index 3.
//
// Output order is unspecified. Within a bucket the order comes from dictionary
// iteration, which has none.
//
// Edge cases: single element · all elements identical (frequency n) ·
// k equals the distinct count · value 0 is ordinary, unrelated to index 0.
