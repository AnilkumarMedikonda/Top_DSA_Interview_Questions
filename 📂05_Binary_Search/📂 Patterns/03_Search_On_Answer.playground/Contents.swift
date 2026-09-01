import Foundation

// MARK: - Search On Answer
// T - O(log(range) * predicate), S - O(1)
// Toy predicates here are O(1) → reads as O(log n).
// Real ones (Koko, Ship) walk the array → O(n log(range)).


//==============================================================
// MARK: - Minimum Valid Answer
//
// Pattern:
// ❌ ❌ ❌ ✅ ✅ ✅
//
// Find the FIRST valid answer.
//
// Used In:
// • LC875 - Koko Eating Bananas
// • LC1011 - Capacity To Ship Packages Within D Days
// • LC410 - Split Array Largest Sum
// • LC1482 - Minimum Number of Days to Make m Bouquets
// • LC1283 - Find the Smallest Divisor Given a Threshold
//
// T - O(log n), S - O(1)
//==============================================================

func isPossible(_ value: Int) -> Bool {

    return value >= 35
}

func minimumValidAnswer() -> Int {

    var low = 1
    var high = 100
    var answer = high

    while low <= high {

        let mid = low + (high - low) / 2

        if isPossible(mid) {

            answer = mid
            high = mid - 1

        } else {

            low = mid + 1
        }
    }

    return answer
}

print(minimumValidAnswer())      // 35


//==============================================================
// MARK: - Maximum Valid Answer
//
// Pattern:
// ✅ ✅ ✅ ❌ ❌ ❌
//
// Find the LAST valid answer.
//
// Used In:
// • LC1552 - Magnetic Force Between Two Balls
// • Aggressive Cows (Classic Interview Problem)
// • Allocate Maximum Minimum Distance Problems
//
// T - O(log n), S - O(1)
//==============================================================


func isValid(_ value: Int) -> Bool {

    return value <= 65
}

func maximumValidAnswer() -> Int {

    var low = 1
    var high = 100
    var answer = low

    while low <= high {

        let mid = low + (high - low) / 2

        if isValid(mid) {

            answer = mid
            low = mid + 1

        } else {

            high = mid - 1
        }
    }

    return answer
}

print(maximumValidAnswer())      // 65
