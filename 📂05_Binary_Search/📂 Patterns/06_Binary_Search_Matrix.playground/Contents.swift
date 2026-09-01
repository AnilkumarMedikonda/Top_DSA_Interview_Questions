import Foundation

//==============================================================
// MARK: - 06_Binary_Search_Matrix
//==============================================================

/*
 Search a 2D Matrix

 Each row is sorted, and the first value of every row is greater
 than the last value of the row above it — so the whole grid is
 one long sorted sequence wrapped into rows.

 --------------------------------------------------------------
 Key Idea

 Treat the matrix as a virtual 1D sorted array of length rows*cols.
 Binary search that, and map each flat index back to 2D:

   row = mid / columns
   col = mid % columns

 --------------------------------------------------------------
 Used In
 - LC74 - Search a 2D Matrix
*/

//==============================================================
// MARK: - Template
// Exact match → closed interval, low <= high, move by mid ± 1.
// T - O(log(m * n)), S - O(1)
//==============================================================

func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard !matrix.isEmpty && !matrix[0].isEmpty else { return false }
    let rows = matrix.count
    let columns = matrix[0].count
    var low = 0
    var high = rows * columns - 1
    while low <= high {
        let mid = low + (high - low) / 2
        let row = mid / columns
        let col = mid % columns
        if matrix[row][col] == target {
            return true
        } else if matrix[row][col] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return false
}

//==============================================================
// MARK: - Test
//==============================================================

print(searchMatrix([[1,3,5,7],
                    [10,11,16,20],
                    [23,30,34,60]], 3))    // true

print(searchMatrix([[1,3,5,7],
                    [10,11,16,20],
                    [23,30,34,60]], 13))   // false
