import Foundation

//==============================================================
// Pattern 08 — Interval Merge
// Sorting + Greedy
//==============================================================

/*
 Pattern
 -------
1. Sort intervals by start value.
2. Add first interval to result.
3. Compare current interval with last merged interval.
4. If overlap -> merge.
5. Else -> append.

Overlap Condition

current.start <= last.end
*/

//==============================================================
// Compare two intervals
//==============================================================

func overlaps(_ first: [Int], _ second: [Int]) -> Bool {

    return second[0] <= first[1]
}

//==============================================================
// Find Maximum (Without max())
//==============================================================

func maximum(_ a: Int, _ b: Int) -> Int {

    if a > b {
        return a
    }

    return b
}

//==============================================================
// Insertion Sort
//==============================================================

func sortByStart(_ intervals: inout [[Int]]) {

    var i = 1

    while i < intervals.count {

        let current = intervals[i]
        var j = i - 1

        while j >= 0 && intervals[j][0] > current[0] {
            intervals[j + 1] = intervals[j]
            j -= 1
        }

        intervals[j + 1] = current
        i += 1
    }
}

//==============================================================
// Merge Intervals
//==============================================================

func merge(_ intervals: [[Int]]) -> [[Int]] {

    guard intervals.count > 1 else {
        return intervals
    }

    //----------------------------------------------------------
    // Copy Input
    //----------------------------------------------------------

    var sorted = intervals

    //----------------------------------------------------------
    // Sort
    //----------------------------------------------------------

    sortByStart(&sorted)

    //----------------------------------------------------------
    // Result
    //----------------------------------------------------------

    var result: [[Int]] = []

    result.append(sorted[0])

    //----------------------------------------------------------
    // Merge
    //----------------------------------------------------------

    var i = 1

    while i < sorted.count {

        let current = sorted[i]

        let lastIndex = result.count - 1

        print("\n====================================")
        print("Iteration : \(i)")
        print("Current    : \(current)")
        print("Last Merge : \(result[lastIndex])")

        if overlaps(result[lastIndex], current) {

            print("✅ Overlap")

            let newEnd = maximum(result[lastIndex][1], current[1])

            print("Old End : \(result[lastIndex][1])")
            print("New End : \(current[1])")
            print("Maximum : \(newEnd)")

            result[lastIndex][1] = newEnd

            print("Merged Result")
            print(result)

        } else {

            print("❌ No Overlap")

            result.append(current)

            print("Append Current")

            print(result)
        }

        i += 1
    }

    return result
}

//==============================================================
// Test
//==============================================================

let intervals = [
    [8,10],
    [1,3],
    [15,18],
    [2,6]
]

let answer = merge(intervals)

print("\n==============================")
print("Final Answer")
print(answer)
