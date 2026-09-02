import Foundation

//==============================================================
// Q46 — LC1011 Capacity To Ship Packages Within D Days
//==============================================================
/*
 A conveyor belt has packages with given weights, in order. Within
 `days` days, ship every package in that order without reordering.
 Each day loads packages onto the ship up to its weight capacity.
 Find the LEAST capacity that ships everything within `days` days.

 Example:
   [1,2,3,4,5,6,7,8,9,10], days = 5   → 15
   [3,2,2,4,1,4], days = 3            → 6
   [1,2,3,1,1], days = 4             → 3

 Constraints:
   1 <= days <= weights.count <= 5*10^4
   1 <= weights[i] <= 500

 Pattern: Search On Answer — binary search the capacity, not the
          array. Predicate: can we ship within `days` at this cap?
 Bounds: floor = max weight (must hold the heaviest package),
         ceiling = sum (one day holds everything).
 Interval: closed, record-and-narrow, seek the first feasible cap.
 Complexity: predicate walks all n weights → O(n log(sum)).
 Edge cases: days == 1 (answer = sum), days == count (answer = max).
*/

//==============================================================
// MARK: - Predicate
// Greedy day count at a given capacity. Reset to `weight` (not 0)
// because the overflowing package starts the new day.
//==============================================================
func canShip(_ weights: [Int], _ days: Int, _ capacity: Int) -> Bool {
    var currentDays = 1
    var currentWeight = 0
    for weight in weights {
        if currentWeight + weight > capacity {
            currentDays += 1
            currentWeight = weight
        } else {
            currentWeight += weight
        }
    }
    return currentDays <= days
}

//==============================================================
// MARK: - Brute Force
// Try every capacity from maxWeight upward; first feasible wins.
// T - O((sum - max) × n), S - O(1)
//==============================================================
func shipWithinDaysBruteForce(_ weights: [Int], _ days: Int) -> Int {
    var maxWeight = weights[0]
    var totalWeight = 0
    for weight in weights {
        if weight > maxWeight {
            maxWeight = weight
        }
        totalWeight += weight
    }
    for capacity in maxWeight...totalWeight {
        if canShip(weights, days, capacity) {
            return capacity
        }
    }
    return totalWeight
}

//==============================================================
// MARK: - Optimal
// Binary search the capacity range [maxWeight, sum].
// T - O(n log(sum)), S - O(1)
//==============================================================
func shipWithinDays(_ weights: [Int], _ days: Int) -> Int {
    var maxWeight = weights[0]
    var totalWeight = 0
    for weight in weights {
        if weight > maxWeight {
            maxWeight = weight
        }
        totalWeight += weight
    }
    var left = maxWeight
    var right = totalWeight
    var answer = totalWeight
    while left <= right {
        let mid = left + (right - left) / 2
        if canShip(weights, days, mid) {
            answer = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    return answer
}

//==============================================================
// MARK: - Tests
//==============================================================
print("Brute Force")

print(shipWithinDaysBruteForce([1,2,3,4,5,6,7,8,9,10], 5))   // 15

print(shipWithinDaysBruteForce([3,2,2,4,1,4], 3))            // 6

print(shipWithinDaysBruteForce([1,2,3,1,1], 4))              // 3

print("Optimal")

print(shipWithinDays([1,2,3,4,5,6,7,8,9,10], 5))   // 15

print(shipWithinDays([3,2,2,4,1,4], 3))            // 6

print(shipWithinDays([1,2,3,1,1], 4))              // 3

print(shipWithinDays([10], 1))                     // 10
