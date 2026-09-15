import Foundation


//==============================================================

// MARK: - Q79. Course Schedule
// LeetCode 207

//==============================================================

// Problem:
//
// There are numCourses courses labeled from 0 to numCourses - 1.
//
// prerequisites[i] = [course, prerequisite]
//
// It means:
// To take "course", you must first complete "prerequisite".
//
// Return true if all courses can be completed.
// Return false if there is a circular dependency.
//
// Example:
//
// numCourses = 2
// prerequisites = [[1, 0]]
//
// 0 → 1
//
// Result: true
//
// Circular Example:
//
// numCourses = 2
// prerequisites = [[1, 0], [0, 1]]
//
// 0 → 1
// ↑   ↓
// └───┘
//
// Result: false
//
// Pattern:
// Graph + Topological Sort
//
// Key Idea:
//
// Course dependency = Directed Graph
// In-Degree = Number of prerequisites
//
// Steps:
//
// 1. Create Directed Graph
// 2. Calculate In-Degree
// 3. Find nodes with In-Degree = 0
// 4. Add them to Queue
// 5. Process Queue
// 6. Reduce neighbours' In-Degree
// 7. Add new In-Degree = 0 nodes
// 8. Count completed courses
// 9. Compare completed courses with numCourses
//
// If:
// completedCourses == numCourses → true
// completedCourses < numCourses → cycle exists → false
//
// Time: O(V + E)
// Space: O(V + E)

//==============================================================


//==============================================================

// MARK: - Create Directed Graph

//==============================================================

func createGraph(_ edges: [[Int]], _ vertices: Int) -> [[Int]] {
    var graph = Array(repeating: [Int](), count: vertices)

    for edge in edges {
        let u = edge[0]
        let v = edge[1]

        graph[u].append(v)
    }

    return graph
}

//==============================================================

// MARK: - Create In-Degree

//==============================================================

func createDegree(_ graph: [[Int]]) -> [Int] {
    var inDegree = Array(repeating: 0, count: graph.count)

    for node in 0..<graph.count {
        for neighbour in graph[node] {
            inDegree[neighbour] += 1
        }
    }

    return inDegree
}

//==============================================================

// MARK: - Topological Sort

//==============================================================

func topLogicalSortOrder(_ graph: [[Int]], inDegree: [Int]) -> [Int] {
    var result = [Int]()
    var inDegree = inDegree
    var queue = [Int]()
    var index = 0

    // Add nodes with no pending dependencies
    for node in 0..<graph.count {
        if inDegree[node] == 0 {
            queue.append(node)
        }
    }

    // Process queue
    while index < queue.count {
        let node = queue[index]
        index += 1

        result.append(node)

        // Remove completed dependency
        for neighbour in graph[node] {
            inDegree[neighbour] -= 1

            if inDegree[neighbour] == 0 {
                queue.append(neighbour)
            }
        }
    }

    return result
}

//==============================================================

// MARK: - Course Schedule

//==============================================================

func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {

    var edges = [[Int]]()

    for prerequisite in prerequisites {
        let course = prerequisite[0]
        let requiredCourse = prerequisite[1]

        edges.append([requiredCourse, course])
    }

    let graph = createGraph(edges, numCourses)
    let inDegree = createDegree(graph)

    let result = topLogicalSortOrder(
        graph,
        inDegree: inDegree
    )

    return result.count == numCourses
}


print("\n========== Q79 - Course Schedule ==========")

print(canFinish(2, [[1, 0]]))
// true

//==============================================================

// MARK: - Test Case 1

//==============================================================

// 0 → 1
//
// Expected: true

let result1 = canFinish(2, [[1, 0]])

print("Test 1:", result1)

//==============================================================

// MARK: - Test Case 2

//==============================================================

// 0 → 1
// ↑   ↓
// └───┘
//
// Expected: false

let result2 = canFinish(2, [[1, 0], [0, 1]])

print("Test 2:", result2)

//==============================================================

// MARK: - Test Case 3

//==============================================================

// 0 → 1 → 2 → 3
//
// Expected: true

let result3 = canFinish(
    4,
    [[1, 0], [2, 1], [3, 2]]
)

print("Test 3:", result3)

//==============================================================

// MARK: - Test Case 4

//==============================================================

// 0 → 1
// 0 → 2
//
// Expected: true

let result4 = canFinish(
    3,
    [[1, 0], [2, 0]]
)

print("Test 4:", result4)

//==============================================================

// MARK: - Test Case 5

//==============================================================

// 0 → 1 → 2 → 0
//
// Cycle exists.
//
// Expected: false

let result5 = canFinish(
    3,
    [[1, 0], [2, 1], [0, 2]]
)

print("Test 5:", result5)

//==============================================================

// MARK: - Test Case 6

//==============================================================

// No prerequisites.
//
// Expected: true

let result6 = canFinish(5, [])

print("Test 6:", result6)
