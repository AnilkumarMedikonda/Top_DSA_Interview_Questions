import Foundation

// Q81 - LeetCode 684: Redundant Connection
//
// Problem:
//
// Given a graph that started as a tree with n nodes,
// one additional edge was added.
//
// Return the edge that creates a cycle.
//
// Example:
//
// edges = [[1,2], [1,3], [2,3]]
//
// Graph:
//
//     1
//    / \
//   2---3
//
// Result:
// [2,3]
//
// Pattern:
// Union-Find / Disjoint Set
//
// Key Idea:
//
// For every edge:
// 1. Find root of both nodes
// 2. If roots are same → cycle exists
// 3. If roots are different → union them
//
// Steps:
//
// 1. Create Parent Array
// 2. Initially every node is its own parent
// 3. Find root of first node
// 4. Find root of second node
// 5. If both roots are same → redundant edge
// 6. Otherwise connect the two components
//
// Time: O(E × H)
// Space: O(V)
//
// E = Number of edges
// V = Number of vertices
// H = Height of Union-Find tree

// Step 1: Find Redundant Connection

func findRedundantConnection(_ edges: [[Int]]) -> [Int] {

    // Step 2: Create Parent Array

    let n = edges.count
    var parent = Array(0...n)

    // Step 3: Find Root

    func find(_ node: Int) -> Int {
        if parent[node] == node {
            return node
        }

        return find(parent[node])
    }

    // Step 4: Process Each Edge

    for edge in edges {

        let node1 = edge[0]
        let node2 = edge[1]

        // Step 5: Find Roots

        let root1 = find(node1)
        let root2 = find(node2)

        // Step 6: Same Root = Cycle

        if root1 == root2 {
            return [node1, node2]
        }

        // Step 7: Union Two Components

        parent[root2] = root1
    }

    return []
}

// Test Case 1

let result1 = findRedundantConnection(
    [[1, 2], [1, 3], [2, 3]]
)

print("Test 1:", result1)
// [2, 3]


// Test Case 2

let result2 = findRedundantConnection(
    [[1, 2], [2, 3], [3, 4], [1, 4], [1, 5]]
)

print("Test 2:", result2)
// [1, 4]


// Test Case 3

let result3 = findRedundantConnection(
    [[1, 2], [2, 3], [3, 1]]
)

print("Test 3:", result3)
// [3, 1]
