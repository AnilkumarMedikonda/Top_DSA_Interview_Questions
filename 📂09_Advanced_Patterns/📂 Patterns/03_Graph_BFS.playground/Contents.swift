//==============================================================
// MARK: - 03. Graph BFS
//==============================================================
//
// Pattern:
// Visited Set → Queue → snapshot level size → drain
//
// Mark visited at ENQUEUE, not at dequeue.
// Head index, not removeFirst — removeFirst is O(n).
//
// The snapshot is the whole pattern. Everything in the queue
// now is one step from the start; anything appended during
// the drain is one step further.
//
// Fires on shortest path, minimum steps, level order.
//
// Time:  O(V + E)
// Space: O(V)
//
//==============================================================


//==============================================================
// MARK: - Create Graph
//==============================================================
//
// Edge list → adjacency list.
//
// Undirected adds both directions, directed adds one.
// Allocates V buckets, then reads E edges.
//
// Time:  O(V + E)
// Space: O(V + E)
//
//==============================================================

public func createGraph(_ edges: [[Int]], _ vertices: Int) -> [[Int]] {
    var graph = Array(repeating: [Int](), count: vertices)

    for edge in edges {
        let u = edge[0]
        let v = edge[1]

        graph[u].append(v)
        graph[v].append(u)
    }

    return graph
}


public func createDirectedGraph(_ edges: [[Int]], _ vertices: Int) -> [[Int]] {
    var graph = Array(repeating: [Int](), count: vertices)

    for edge in edges {
        let u = edge[0]
        let v = edge[1]

        graph[u].append(v)
    }

    return graph
}


// MARK: - BFS Level

func bfsLevels(_ graph: [[Int]], _ start: Int) -> Int {
    var visited = Set<Int>()
    var queue = [Int]()
    var head = 0
    var level = 0

    visited.insert(start)
    queue.append(start)

    while head < queue.count {
        let levelSize = queue.count - head

        for _ in 0..<levelSize {
            let node = queue[head]
            head += 1

            for neighbour in graph[node] {
                if !visited.contains(neighbour) {
                    visited.insert(neighbour)
                    queue.append(neighbour)
                }
            }
        }

        if head < queue.count {
            level += 1
        }
    }

    return level
}

//==============================================================
// MARK: - Trace
//==============================================================
//
//      0 —— 1 —— 3
//      |
//      2
//
// head 0  levelSize 1  →  drain 0, enqueue 1, 2   level 1
// head 1  levelSize 2  →  drain 1, enqueue 3
//                         drain 2, nothing        level 2
// head 3  levelSize 1  →  drain 3, nothing        stop
//
// Read queue.count inside the drain instead of snapshotting
// and every level collapses into one.
//
//==============================================================

print("\n========== 03 - Graph BFS ==========")

let bfsGraph1 = createGraph([[0, 1], [0, 2], [1, 3]], 4)

print(bfsLevels(bfsGraph1, 0))
// 2

let bfsGraph2 = createGraph([[0, 1], [1, 2], [2, 3]], 4)

print(bfsLevels(bfsGraph2, 0))
// 3

let cycleGraph = createGraph([[0, 1], [0, 2], [1, 3], [2, 3]], 4)

print(bfsLevels(cycleGraph, 0))
// 2

let splitGraph = createGraph([[0, 1]], 4)

print(bfsLevels(splitGraph, 2))
// 0
