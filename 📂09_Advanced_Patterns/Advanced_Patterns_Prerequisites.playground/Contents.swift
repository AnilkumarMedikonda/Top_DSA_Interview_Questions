import Foundation

//==============================================================
// MARK: - 01. Big-O & Complexity
//==============================================================
//
// Time  → How operations grow with input size
// Space → How extra memory grows with input size
//
// O(1)       → Constant
// O(log n)   → Binary Search
// O(n)       → Single Loop
// O(n log n) → Efficient Sorting
// O(n²)      → Nested Loops
//
//==============================================================

// O(1)
// Time:  O(1)
// Space: O(1)

func getFirst(_ nums: [Int]) -> Int? {
    if nums.isEmpty {
        return nil
    }

    return nums[0]
}


// O(n)
// Time:  O(n)
// Space: O(1)

func getSum(_ nums: [Int]) -> Int {
    var sum = 0

    for num in nums {
        sum += num
    }

    return sum
}


// O(n²)
// Time:  O(n²)
// Space: O(1)

func printPairs(_ nums: [Int]) {
    for i in 0..<nums.count {
        for j in (i + 1)..<nums.count {
            print("Pair --- (\(nums[i]), \(nums[j]))")
        }
    }
}


//==============================================================
// MARK: - 02. Recursion
//==============================================================
//
// Every recursion needs:
// 1. Base Case
// 2. Recursive Case
// 3. Progress toward Base Case
//
// Uses → Trees, Graph DFS, Backtracking, Divide & Conquer
//
//==============================================================

// factorial(5) → 5 × 4 × 3 × 2 × 1 → 120
//
// Time:  O(n)
// Space: O(n)

func factorial(_ n: Int) -> Int {
    if n <= 1 {
        return 1
    }

    return n * factorial(n - 1)
}


// Time:  O(n)
// Space: O(n)

func countdown(_ n: Int) {
    if n == 0 {
        return
    }

    print(n)

    countdown(n - 1)
}


//==============================================================
// MARK: - 03. Graph Fundamentals
//==============================================================
//
// Directed   → one-way,  u → v
// Undirected → two-way,  u ↔ v
//
// Vertices → Nodes
// Edges    → Connections
//
//==============================================================

// MARK: - D4. Adjacency List From Edge Pairs
//
// Allocates V buckets, then reads E edges.
//
// Time:  O(V + E)
// Space: O(V + E)

func buildDirectedGraph(_ vertices: Int, _ edges: [[Int]]) -> [[Int]] {
    var graph = Array(repeating: [Int](), count: vertices)

    for edge in edges {
        let u = edge[0]
        let v = edge[1]

        graph[u].append(v)
    }

    return graph
}


// Time:  O(V + E)
// Space: O(V + E)

func buildUndirectedGraph(_ vertices: Int, _ edges: [[Int]]) -> [[Int]] {
    var graph = Array(repeating: [Int](), count: vertices)

    for edge in edges {
        let u = edge[0]
        let v = edge[1]

        graph[u].append(v)
        graph[v].append(u)
    }

    return graph
}


// Test

let sampleVertices = 4

let sampleEdges = [
    [0, 1],
    [0, 2],
    [1, 2],
    [2, 3]
]

print("\n========== D4 - Adjacency List ==========")

print(buildDirectedGraph(sampleVertices, sampleEdges))
// [[1, 2], [2], [3], []]

print(buildUndirectedGraph(sampleVertices, sampleEdges))
// [[1, 2], [0, 2], [0, 1, 3], [2]]


//==============================================================
// MARK: - D5. Indegree Array
//==============================================================
//
// Indegree → how many edges point INTO a node.
// Directed graphs only. Seed of Kahn's algorithm.
//
// Time:  O(V + E)
// Space: O(V)
//
//==============================================================

func buildIndegree(_ vertices: Int, _ edges: [[Int]]) -> [Int] {
    var indegree = Array(repeating: 0, count: vertices)

    for edge in edges {
        let v = edge[1]

        indegree[v] += 1
    }

    return indegree
}


// Test

print("\n========== D5 - Indegree Array ==========")

print(buildIndegree(sampleVertices, sampleEdges))
// [0, 1, 2, 1]


//==============================================================
// MARK: - D3. Visited Tracking
//==============================================================
//
// Graph → Set<Int> or [Bool] of size V
// Grid  → 2D [[Bool]], one flag per cell
//
// Time:  O(1) per check
// Space: O(V) / O(m·n)
//
//==============================================================

func makeVisitedGrid(_ rows: Int, _ columns: Int) -> [[Bool]] {
    return Array(repeating: Array(repeating: false, count: columns), count: rows)
}


// Test

print("\n========== D3 - 2D Visited Array ==========")

var visitedGrid = makeVisitedGrid(3, 4)

visitedGrid[1][2] = true

print(visitedGrid[1][2])
// true

print(visitedGrid[0][0])
// false


//==============================================================
// MARK: - D2. Grid Bounds & Four Directions
//==============================================================
//
// Always check bounds BEFORE reading the cell.
//
// Directions → up, down, left, right
//
// Time:  O(1)
// Space: O(1)
//
//==============================================================

let directions = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1]
]

func isInsideGrid(_ row: Int, _ column: Int, _ rows: Int, _ columns: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
}


// Returns the valid neighbours of a cell.
//
// Time:  O(1)
// Space: O(1)

func neighborsOf(_ row: Int, _ column: Int, _ grid: [[Character]]) -> [[Int]] {
    let rows = grid.count

    if rows == 0 {
        return []
    }

    let columns = grid[0].count
    var result = [[Int]]()

    for direction in directions {
        let nextRow = row + direction[0]
        let nextColumn = column + direction[1]

        if isInsideGrid(nextRow, nextColumn, rows, columns) {
            result.append([nextRow, nextColumn])
        }
    }

    return result
}


// Test

let sampleGrid: [[Character]] = [
    ["1", "1", "0"],
    ["0", "1", "0"],
    ["0", "0", "1"]
]

print("\n========== D2 - Grid Bounds & Neighbours ==========")

print(neighborsOf(1, 1, sampleGrid))
// [[0, 1], [2, 1], [1, 0], [1, 2]]

print(neighborsOf(0, 0, sampleGrid))
// [[1, 0], [0, 1]]

print(neighborsOf(2, 2, sampleGrid))
// [[1, 2], [2, 1]]


//==============================================================
// MARK: - 04. DFS
//==============================================================
//
// Explore as deep as possible, then backtrack.
//
// Uses → Recursion / Stack + Visited
//
// Mark visited BEFORE recursing, not after.
//
// Time:  O(V + E)
// Space: O(V)
//
//==============================================================

func dfs(_ graph: [[Int]], _ start: Int) {
    var visited = Set<Int>()

    func explore(_ node: Int) {
        if visited.contains(node) {
            return
        }

        visited.insert(node)

        print("Visited:", node)

        for neighbor in graph[node] {
            explore(neighbor)
        }
    }

    explore(start)
}


// Test

let sampleGraph = [
    [1, 2],
    [0, 3],
    [0, 3],
    [1, 2]
]

print("\n========== 04 - DFS ==========")

dfs(sampleGraph, 0)
// 0, 1, 3, 2


//==============================================================
// MARK: - D1. BFS With Head Index
//==============================================================
//
// Explore level by level.
//
// Head index instead of removeFirst — removeFirst is O(n),
// which makes the whole traversal O(V²).
//
// Uses → shortest path in unweighted graph, minimum steps
//
// Time:  O(V + E)
// Space: O(V)
//
//==============================================================

func bfs(_ graph: [[Int]], _ start: Int) {
    var visited = Set<Int>()
    var queue = [Int]()
    var head = 0

    queue.append(start)
    visited.insert(start)

    while head < queue.count {
        let node = queue[head]
        head += 1

        print("Visited:", node)

        for neighbor in graph[node] {
            if !visited.contains(neighbor) {
                visited.insert(neighbor)
                queue.append(neighbor)
            }
        }
    }
}


// Test

print("\n========== D1 - BFS ==========")

bfs(sampleGraph, 0)
// 0, 1, 2, 3


//==============================================================
// MARK: - 05. Multi-Source BFS
//==============================================================
//
// Seed ALL sources into the queue and mark them visited
// BEFORE the loop starts. Then it is plain BFS.
//
// Time:  O(V + E)
// Space: O(V)
//
//==============================================================

func multiSourceBFS(_ graph: [[Int]], _ sources: [Int]) {
    var visited = Set<Int>()
    var queue = [Int]()
    var head = 0

    for source in sources {
        if !visited.contains(source) {
            visited.insert(source)
            queue.append(source)
        }
    }

    while head < queue.count {
        let node = queue[head]
        head += 1

        print("Visited:", node)

        for neighbor in graph[node] {
            if !visited.contains(neighbor) {
                visited.insert(neighbor)
                queue.append(neighbor)
            }
        }
    }
}


// Test

print("\n========== 05 - Multi-Source BFS ==========")

multiSourceBFS(sampleGraph, [0, 3])
// 0, 3, 1, 2
