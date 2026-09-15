
import Foundation

// Q77_LC200_Number_Of_Islands

//==============================================================
// MARK: - Problem
//==============================================================
//
// Given an m x n 2D grid of '1's (land) and '0's (water),
// return the number of islands.
//
// An island is surrounded by water and is formed by connecting
// adjacent lands horizontally or vertically.
//
// Example:
//
// Input:
// [
//   ["1","1","1","1","0"],
//   ["1","1","0","1","0"],
//   ["1","1","0","0","0"],
//   ["0","0","0","0","0"]
// ]
//
// Constraints:
// 1 <= m, n <= 300
// grid[i][j] is '0' or '1'
//
// Brute force: none. Every cell must be examined, so O(m × n)
// is the floor. The only alternative is DFS with a separate
// visited array instead of sinking — same complexity, more
// space.


// Output: 1
//
//==============================================================
// MARK: - Notes
//==============================================================
//
// Pattern: Graph DFS
//
// High-Level Steps:
// 1. Traverse every cell.
// 2. If cell == "1", found a new island.
// 3. Increment result.
// 4. DFS through connected land.
// 5. Mark visited land as "0".
// 6. Continue scanning.
//
// Directions:
// Up, Down, Left, Right
//
// Time  : O(m × n) — every cell visited once
// Space : O(m × n) — recursion depth equals the size of the
//         largest island, which can be the whole grid; plus
//         the local grid copy

//==============================================================

func numberOfIslands(_ grid: [[Character]]) -> Int {
    if grid.isEmpty || grid[0].isEmpty {
        return 0
    }

    let rows = grid.count
    let columns = grid[0].count
    var grid = grid
    var result = 0

    func dfs(_ row: Int, _ col: Int) {
        if row < 0 || row >= rows || col < 0 || col >= columns {
            return
        }

        if grid[row][col] == "0" {
            return
        }

        grid[row][col] = "0"

        dfs(row - 1, col)
        dfs(row + 1, col)
        dfs(row, col - 1)
        dfs(row, col + 1)
    }

    for row in 0..<rows {
        for col in 0..<columns {
            if grid[row][col] == "1" {
                result += 1
                dfs(row, col)
            }
        }
    }

    return result
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print("\n========== Q77 - Number Of Islands ==========")

print(numberOfIslands([
    ["1","1","1","1","0"],
    ["1","1","0","1","0"],
    ["1","1","0","0","0"],
    ["0","0","0","0","0"]
])) // 1

print(numberOfIslands([
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
])) // 3

print(numberOfIslands([
    ["1","0","1"],
    ["0","1","0"],
    ["1","0","1"]
])) // 5

print(numberOfIslands([])) // 0


