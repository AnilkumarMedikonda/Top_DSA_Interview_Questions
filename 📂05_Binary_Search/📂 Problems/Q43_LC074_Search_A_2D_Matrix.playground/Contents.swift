import Foundation

//==============================================================
// Q43 — LC074 Search a 2D Matrix
//==============================================================
/*
 An m × n matrix where each row is sorted ascending and the first
 value of every row is greater than the last of the previous row —
 the whole grid is one sorted sequence wrapped into rows. Given
 target, return true if present, else false. O(log(m·n)).

 Example:
   [[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3   → true
   [[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13  → false
   [[1]], 1   → true
   [[1]], 2   → false

 Constraints:
   1 <= m, n <= 100
   -10^4 <= matrix[i][j], target <= 10^4

 Pattern: Binary Search Matrix — treat as a virtual 1D sorted
          array of length rows*columns; map index back with
          row = mid / columns, col = mid % columns.
 Interval: closed — low <= high, exact match, mid ± 1.
 Note: the empty guard is REAL here — matrix[0] crashes on an
       empty outer array, so it must come before matrix[0].count.
 Edge cases: single-cell matrix present / absent.
*/

//==============================================================
// MARK: - Brute Force
// Scan every cell.
// T - O(m × n), S - O(1)
//==============================================================
func searchMatrixBruteForce(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard !matrix.isEmpty && !matrix[0].isEmpty else { return false }
    for i in 0..<matrix.count {
        let nums = matrix[i]
        for j in 0..<nums.count {
            if nums[j] == target {
                return true
            }
        }
    }
    return false
}

//==============================================================
// MARK: - Optimal
// Virtual 1D binary search. Divide AND mod by columns, both.
// T - O(log(m × n)), S - O(1)
//==============================================================
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard !matrix.isEmpty, !matrix[0].isEmpty else { return false }
    let rows = matrix.count
    let columns = matrix[0].count
    var low = 0
    var high = rows * columns - 1
    while low <= high {
        let mid = low + (high - low) / 2
        let r = mid / columns
        let c = mid % columns
        if matrix[r][c] == target {
            return true
        } else if matrix[r][c] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return false
}

//==============================================================
// MARK: - Tests
//==============================================================
print("Brute Force")

print(searchMatrixBruteForce([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3))    // true

print(searchMatrixBruteForce([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13))   // false

print("Optimal")

print(searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3))    // true

print(searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13))   // false

print(searchMatrix([[1]], 1))   // true

print(searchMatrix([[1]], 2))   // false
