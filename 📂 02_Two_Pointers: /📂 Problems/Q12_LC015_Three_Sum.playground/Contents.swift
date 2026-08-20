import Foundation

/*
 Q12 — LC015 Three Sum

 Problem:  Return all unique triplets summing to zero, no duplicate triplets.
 Example:  [-1,0,1,2,-1,-4] → [[-1,-1,2],[-1,0,1]]
 Pattern:  Sort + Opposite Ends with duplicate skipping
 Traps:    Index the sorted copy, not nums. Skip duplicates at i, left AND right.
 
 //============================================================
 // High-Level Logic
 //============================================================

 /*
 1. Sort the array.

 2. Fix one element.

 3. Use Two Pointers for the remaining elements.

 4. Compare the sum with the target.
    - Equal   → Save triplet
    - Smaller → Move left
    - Greater → Move right

 5. Skip duplicate values.

 6. Continue until all elements are processed.
 */

 // Pattern:
 // Sort → Fix One Element → Two Pointers → Skip Duplicates

 // Time: O(n²)
 // Space: O(1) (excluding output)
 
 
*/

let nums = [-1, 0, 1, 2, -1, -4]
let target = 0

//============================================================
// MARK: - Helper
// Time: O(k) | Space: O(1) | Edge: empty result returns false
//============================================================

func isDuplicate(_ result: [[Int]], current: [Int]) -> Bool {
    var i = 0

    while i < result.count {
        let triplet = result[i]

        if triplet[0] == current[0] && triplet[1] == current[1] && triplet[2] == current[2] {
            return true
        }

        i += 1
    }

    return false
}

//============================================================
// MARK: - Brute Force
// Time: O(n³ × k) | Space: O(1) aux | Edge: n < 3, all zeros | TLE at n = 3000
//============================================================

func threeSumBruteForce(_ nums: [Int], _ target: Int) -> [[Int]] {
    guard nums.count > 2 else { return [] }

    let sorted = nums.sorted()
    var result = [[Int]]()

    for i in 0..<sorted.count {
        for j in i + 1..<sorted.count {
            for k in j + 1..<sorted.count {
                let sum = sorted[i] + sorted[j] + sorted[k]

                if sum == target {
                    let triplet = [sorted[i], sorted[j], sorted[k]]

                    if !isDuplicate(result, current: triplet) {
                        result.append(triplet)
                    }
                }
            }
        }
    }

    return result
}

//============================================================
// MARK: - Optimal (Sorting + Two Pointers)
// Time: O(n²) | Space: O(1) aux | Edge: n < 3, [0,0,0,0] → one triplet
//============================================================

func threeSumOptimal(_ nums: [Int], _ target: Int) -> [[Int]] {
    guard nums.count > 2 else { return [] }

    let sorted = nums.sorted()
    var result = [[Int]]()

    for i in 0..<sorted.count - 2 {
        if i > 0 && sorted[i] == sorted[i - 1] {
            continue
        }

        var left = i + 1
        var right = sorted.count - 1

        while left < right {
            let sum = sorted[i] + sorted[left] + sorted[right]

            if sum == target {
                result.append([sorted[i], sorted[left], sorted[right]])

                while left < right && sorted[left] == sorted[left + 1] {
                    left += 1
                }

                while left < right && sorted[right] == sorted[right - 1] {
                    right -= 1
                }

                left += 1
                right -= 1

            } else if sum < target {
                left += 1
            } else {
                right -= 1
            }
        }
    }

    return result
}

//============================================================
// MARK: - Tests
//============================================================

print("Brute Force")

print(threeSumBruteForce(nums, target))

print("Optimal")

print(threeSumOptimal(nums, target))

print(threeSumOptimal([0, 0, 0, 0], target))

print(threeSumOptimal([-2, 0, 1, 1, 2], target))
