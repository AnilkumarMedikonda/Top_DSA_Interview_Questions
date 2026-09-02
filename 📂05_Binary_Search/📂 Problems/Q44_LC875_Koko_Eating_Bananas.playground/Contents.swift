import Foundation

//==============================================================
// Q44 — LC875 Koko Eating Bananas
//==============================================================
/*
 Koko has n piles of bananas and h hours. Each hour she picks one
 pile and eats up to k bananas from it; if the pile has fewer than
 k, she eats it all and the rest of the hour is wasted (she can't
 start another pile that hour). Find the minimum integer speed k
 that lets her finish all piles within h hours.

 Example:
   [3,6,7,11], h = 8        → 4
   [30,11,23,4,20], h = 5   → 30
   [30,11,23,4,20], h = 6   → 23

 Constraints:
   1 <= piles.count <= 10^4
   piles.count <= h <= 10^9
   1 <= piles[i] <= 10^9

 Pattern: Search On Answer — binary search the speed, not the
          piles. Predicate: can she finish within h at speed k?
 Bounds: floor = 1, ceiling = max pile (faster than the biggest
         pile changes nothing — one pile per hour).
 Interval: closed, record-and-narrow, seek first feasible speed.
 Trap: hours per pile is ceilDivide(pile, k), not pile / k.
 Complexity: predicate walks all n piles → O(n log(maxPile)).
 Edge cases: single pile, h == n (answer = max pile).
*/

//==============================================================
// MARK: - Predicate
// Total hours = sum of ceil(pile / k). Feasible if <= h.
//==============================================================
func canFinish(_ piles: [Int], _ k: Int, _ h: Int) -> Bool {
    var totalHours = 0
    for i in 0..<piles.count {
        var hours = piles[i] / k
        if piles[i] % k != 0 {
            hours += 1
        }
        totalHours += hours
    }
    return totalHours <= h
}

//==============================================================
// MARK: - Brute Force
// Try every speed from 1 upward; first feasible wins.
// T - O(maxPile × n), S - O(1)
//==============================================================
func minEatingSpeedBrute(_ piles: [Int], _ h: Int) -> Int {
    var maxPile = piles[0]
    for pile in piles {
        if pile > maxPile {
            maxPile = pile
        }
    }
    for k in 1...maxPile {
        if canFinish(piles, k, h) {
            return k
        }
    }
    return maxPile
}

//==============================================================
// MARK: - Optimal
// Binary search speed in [1, maxPile], seek first feasible.
// T - O(n log(maxPile)), S - O(1)
//==============================================================
func minEatingSpeed(_ piles: [Int], _ h: Int) -> Int {
    var maxPile = piles[0]
    for pile in piles {
        if pile > maxPile {
            maxPile = pile
        }
    }
    var left = 1
    var right = maxPile
    var answer = maxPile
    while left <= right {
        let mid = left + (right - left) / 2
        if canFinish(piles, mid, h) {
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

print(minEatingSpeedBrute([3,6,7,11], 8))          // 4

print(minEatingSpeedBrute([30,11,23,4,20], 5))     // 30

print(minEatingSpeedBrute([30,11,23,4,20], 6))     // 23

print("Optimal")

print(minEatingSpeed([3,6,7,11], 8))          // 4

print(minEatingSpeed([30,11,23,4,20], 5))     // 30

print(minEatingSpeed([30,11,23,4,20], 6))     // 23

print(minEatingSpeed([312884470], 968709470))  // 1
