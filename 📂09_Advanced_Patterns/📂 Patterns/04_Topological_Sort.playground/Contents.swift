//==============================================================
// MARK: - 04. Topological Sort
//==============================================================
//
// Topological Sort:
// Arrange nodes based on their dependencies.
//
// Pattern:
// 1. Create Directed Graph
// 2. Calculate In-Degree
// 3. Find nodes with In-Degree = 0
// 4. Add them to Queue
// 5. Process Queue
// 6. Reduce neighbours' In-Degree
// 7. Add new In-Degree = 0 nodes
//
// Time:  O(V + E)
// Space: O(V + E)
//
//==============================================================

import Foundation


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

func topLogicalSortOrder(_ graph: [[Int]], inDegree: [Int] ) -> [Int] {

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
// MARK: - Test Case 1
//==============================================================
//
// 0 → 1
// 0 → 2
// 1 → 3
// 2 → 3
//
// Possible Output:
// [0, 1, 2, 3]
//
//==============================================================

let edges1 = [
    [0, 1],
    [0, 2],
    [1, 3],
    [2, 3]
]

let graph1 = createGraph(edges1, 4)
let inDegree1 = createDegree(graph1)
let result1 = topLogicalSortOrder(graph1, inDegree: inDegree1)

print("Graph:", graph1)
print("In-Degree:", inDegree1)
print("Topological Order:", result1)


//==============================================================
// MARK: - Test Case 2 - Cycle
//==============================================================
//
// 0 → 1
// ↑   ↓
// └── 2
//
// No valid Topological Order
//
//==============================================================

let edges2 = [
    [0, 1],
    [1, 2],
    [2, 0]
]

let graph2 = createGraph(edges2, 3)
let inDegree2 = createDegree(graph2)
let result2 = topLogicalSortOrder(graph2, inDegree: inDegree2)

print("Graph:", graph2)
print("In-Degree:", inDegree2)
print("Topological Order:", result2)
