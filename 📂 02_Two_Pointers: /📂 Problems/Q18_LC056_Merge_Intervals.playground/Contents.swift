import Foundation

/*
 Q18 — LC056 Merge Intervals
*/

//============================================================
// MARK: - Brute Force
// Time : O(n²)
// Space: O(n)
//============================================================

func mergeIntervalsBruteForce(_ intervals: [[Int]]) -> [[Int]] {

    guard intervals.count > 1 else {
        return intervals
    }

    var intervals = intervals

    // Sort first (for learning, using insertion sort)
    sortByStartIntervals(&intervals)

    var visited = Array(repeating: false, count: intervals.count)
    var result = [[Int]]()

    var i = 0

    while i < intervals.count {

        if visited[i] {
            i += 1
            continue
        }

        var start = intervals[i][0]
        var end = intervals[i][1]

        var j = i + 1

        while j < intervals.count {

            if visited[j] {
                j += 1
                continue
            }

            if intervals[j][0] <= end {

                start = min(start, intervals[j][0])
                end = max(end, intervals[j][1])

                visited[j] = true
            }

            j += 1
        }

        result.append([start, end])

        i += 1
    }

    return result
}

//============================================================
// MARK: - Sort (Insertion Sort)
// Time : O(n²)
// Space: O(1)
//============================================================

func sortByStartIntervals(_ intervals: inout [[Int]]) {

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

//============================================================
// MARK: - Helpers
//============================================================

func isOverLap(_ first: [Int], second: [Int]) -> Bool {
    return first[1] >= second[0]
}

func getMax(_ first: Int, _ second: Int) -> Int {
    return first > second ? first : second
}

//============================================================
// MARK: - Optimal
// Time : O(n²) using Insertion Sort
//        O(n log n) using built-in sort()
// Space: O(n)
//============================================================

func mergeIntervalsOptimal(_ intervals: [[Int]]) -> [[Int]] {

    guard intervals.count > 1 else {
        return intervals
    }

    var intervals = intervals

    sortByStartIntervals(&intervals)

    var result = [[Int]]()

    result.append(intervals[0])

    var i = 1

    while i < intervals.count {

        let lastIndex = result.count - 1
        let lastMerged = result[lastIndex]

        if isOverLap(lastMerged, second: intervals[i]) {

            result[lastIndex][1] =
                getMax(lastMerged[1], intervals[i][1])

        } else {

            result.append(intervals[i])
        }

        i += 1
    }

    return result
}

//============================================================
// MARK: - Tests
//============================================================

let intervals = [
    [8,10],
    [1,3],
    [15,18],
    [2,6]
]

print("Brute Force")
print(mergeIntervalsBruteForce(intervals))

print()

print("Optimal")
print(mergeIntervalsOptimal(intervals))
