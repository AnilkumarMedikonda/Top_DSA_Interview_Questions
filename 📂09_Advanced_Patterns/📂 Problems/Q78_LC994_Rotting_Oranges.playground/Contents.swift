import Foundation

// Q78_LC994_Rotting_Oranges

//==============================================================
// MARK: - Problem
//==============================================================
//
// Given a grid:
//
// 0 → Empty cell
// 1 → Fresh orange
// 2 → Rotten orange
//
// Every minute, a rotten orange makes adjacent fresh oranges
// rotten in the four directions.
//
// Return the minimum number of minutes required to rot
// all fresh oranges.
//
// Return -1 if some fresh oranges can never become rotten.
//
//==============================================================
// MARK: - Notes
//==============================================================
//
// Pattern: Multi-Source BFS
//
// High-Level Steps:
//
// 1. Find all rotten oranges and add them to the Queue.
// 2. Count the total fresh oranges.
// 3. Process the Queue level by level.
// 4. One BFS level = one minute.
// 5. Check Up, Down, Left and Right.
// 6. Convert fresh orange (1) → rotten (2).
// 7. Add the newly rotten orange to the Queue.
// 8. Decrease fresh count.
// 9. If fresh becomes 0 → return minutes.
// 10. If fresh remains → return -1.
//
// Time  : O(rows × columns)
// Space : O(rows × columns)
//
//==============================================================

func orangeRotates(_ grid: [[Int]]) -> Int {
    guard !grid.isEmpty, !grid[0].isEmpty else {
        return 0
    }

    var grid = grid
    let rows = grid.count
    let columns = grid[0].count

    var queue = [(Int, Int)]()
    var head = 0
    var minutes = 0
    var freshOrange = 0

    let directions = [
        (-1, 0),
        (1, 0),
        (0, -1),
        (0, 1)
    ]

    for row in 0..<rows {
        for column in 0..<columns {
            if grid[row][column] == 2 {
                queue.append((row, column))
            } else if grid[row][column] == 1 {
                freshOrange += 1
            }
        }
    }

    while head < queue.count && freshOrange > 0 {
        let levelSize = queue.count - head

        for _ in 0..<levelSize {
            let (currentRow, currentColumn) = queue[head]
            head += 1

            for direction in directions {
                let newRow = currentRow + direction.0
                let newColumn = currentColumn + direction.1

                if newRow < 0 || newRow >= rows ||
                   newColumn < 0 || newColumn >= columns {
                    continue
                }

                if grid[newRow][newColumn] != 1 {
                    continue
                }

                grid[newRow][newColumn] = 2
                freshOrange -= 1
                queue.append((newRow, newColumn))
            }
        }

        minutes += 1
    }

    return freshOrange == 0 ? minutes : -1
}

print("\n========== Q78 - Rotting Oranges ==========")

//==============================================================
// MARK: - Test Cases
//==============================================================

print(orangeRotates([
    [2,1,1],
    [1,1,0],
    [0,1,1]
])) // 4

print(orangeRotates([
    [2,1,1],
    [0,1,1],
    [1,0,1]
])) // -1

print(orangeRotates([
    [0,2]
])) // 0

print(orangeRotates([
    [1]
])) // -1

print(orangeRotates([
    [0]
])) // 0

