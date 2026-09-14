//==============================================================
// MARK: - 02. Graph DFS
//==============================================================
//
// Pattern:
// Edge List → Create Graph → Visited Set → DFS
//
// Go deep down one branch, then back out and take the next.
// Mark visited on ENTRY, before recursing — otherwise a cycle
// re-enters the same node forever.
//
// Fires on connectivity, components, flood fill, "how many
// groups" — reachability matters, distance does not.
//
//==============================================================


//==============================================================
// MARK: - Create Graph
//==============================================================
//
// Time:  O(V + E)
// Space: O(V + E)
//
//==============================================================

func createGraph(_ edges: [[Int]], _ vertices: Int) -> [[Int]] {
    var graph = Array(repeating: [Int](), count: vertices)

    for edge in edges {
        let u = edge[0]
        let v = edge[1]

        graph[u].append(v)
        graph[v].append(u)
    }

    return graph
}


//==============================================================
// MARK: - DFS
//==============================================================
//
// Time:  O(V + E)
// Space: O(V) — visited set plus recursion stack
//
//==============================================================

func dfs(_ graph: [[Int]], _ start: Int) {
    var visited = Set<Int>()

    func explore(_ node: Int) {
        if visited.contains(node) {
            return
        }

        visited.insert(node)

        print(node)

        for neighbour in graph[node] {
            explore(neighbour)
        }
    }

    explore(start)
}


//==============================================================
// MARK: - Test Case 1 - Tree
//==============================================================

//        0
//       / \
//      1   2
//      |
//      3

print("\n========== 02 - Graph DFS - Tree ==========")

let edges1 = [
    [0, 1],
    [0, 2],
    [1, 3]
]

let graph1 = createGraph(edges1, 4)

dfs(graph1, 0)
// 0, 1, 3, 2


//==============================================================
// MARK: - Test Case 2 - Chain
//==============================================================

//        0
//        |
//        1
//        |
//        2
//        |
//        3

print("\n========== 02 - Graph DFS - Chain ==========")

let edges2 = [
    [0, 1],
    [1, 2],
    [2, 3]
]

let graph2 = createGraph(edges2, 4)

dfs(graph2, 0)
// 0, 1, 2, 3


//==============================================================
// MARK: - Test Case 3 - Cycle
//==============================================================

//      0 —— 1
//      |    |
//      2 —— 3

print("\n========== 02 - Graph DFS - Cycle ==========")

let edges3 = [
    [0, 1],
    [0, 2],
    [1, 3],
    [2, 3]
]

let graph3 = createGraph(edges3, 4)

dfs(graph3, 0)
// 0, 1, 3, 2


//==============================================================
// MARK: - Test Case 4 - Disconnected
//==============================================================

//      0 —— 1        2        3

print("\n========== 02 - Graph DFS - Disconnected ==========")

let edges4 = [
    [0, 1]
]

let graph4 = createGraph(edges4, 4)

dfs(graph4, 0)
// 0, 1

dfs(graph4, 2)
// 2
