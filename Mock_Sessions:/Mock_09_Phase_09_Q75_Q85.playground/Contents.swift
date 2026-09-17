import Foundation

//==============================================================
// MARK: - Mock 12 — Phase 09 Advanced Patterns — Q75–Q85
//==============================================================


//==============================================================
// MARK: - HELPERS
//==============================================================


// MARK: Min Heap (Int)

final class MinHeap {

    private var heap = [Int]()

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    func peek() -> Int? {
        if heap.isEmpty {
            return nil
        }

        return heap[0]
    }

    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(heap.count - 1)
    }

    func remove() -> Int? {
        if heap.isEmpty {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let minValue = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(0)

        return minValue
    }

    // MARK: Core Logic

    private func heapifyUp(_ index: Int) {
        var childIndex = index

        while childIndex > 0 {
            let parentIndex = getParentIndex(childIndex)

            if heap[parentIndex] <= heap[childIndex] {
                break
            }

            heap.swapAt(childIndex, parentIndex)
            childIndex = parentIndex
        }
    }

    private func heapifyDown(_ index: Int) {
        var parentIndex = index

        while true {
            var smallest = parentIndex
            let left = getLeftChildIndex(parentIndex)
            let right = getRightChildIndex(parentIndex)

            if left < heap.count, heap[left] < heap[smallest] {
                smallest = left
            }

            if right < heap.count, heap[right] < heap[smallest] {
                smallest = right
            }

            if smallest == parentIndex {
                break
            }

            heap.swapAt(smallest, parentIndex)
            parentIndex = smallest
        }
    }

    // MARK: Index Helpers

    private func getParentIndex(_ childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    private func getLeftChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }

    private func getRightChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
}


// MARK: Linked List Node

final class Node {

    var value: Int
    var next: Node?

    init(value: Int, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}


// MARK: Min Heap (Node)

final class MinHeapList {

    private var heap = [Node]()

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    func peek() -> Node? {
        if heap.isEmpty {
            return nil
        }

        return heap[0]
    }

    func insert(_ node: Node) {
        heap.append(node)
        heapifyUp(heap.count - 1)
    }

    func remove() -> Node? {
        if heap.isEmpty {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let minNode = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(0)

        return minNode
    }

    // MARK: Core Logic

    private func heapifyUp(_ index: Int) {
        var childIndex = index

        while childIndex > 0 {
            let parentIndex = getParentIndex(childIndex)

            if heap[parentIndex].value <= heap[childIndex].value {
                break
            }

            heap.swapAt(parentIndex, childIndex)
            childIndex = parentIndex
        }
    }

    private func heapifyDown(_ index: Int) {
        var parentIndex = index

        while true {
            var smallest = parentIndex
            let left = getLeftChildIndex(parentIndex)
            let right = getRightChildIndex(parentIndex)

            if left < heap.count, heap[left].value < heap[smallest].value {
                smallest = left
            }

            if right < heap.count, heap[right].value < heap[smallest].value {
                smallest = right
            }

            if smallest == parentIndex {
                break
            }

            heap.swapAt(smallest, parentIndex)
            parentIndex = smallest
        }
    }

    // MARK: Index Helpers

    private func getParentIndex(_ childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    private func getLeftChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }

    private func getRightChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
}


// MARK: Linked List Builders

func createLinkList(_ values: [Int]) -> Node? {
    if values.isEmpty {
        return nil
    }

    let head = Node(value: values[0])
    var current = head

    for i in 1..<values.count {
        let node = Node(value: values[i])
        current.next = node
        current = node
    }

    return head
}

func createListNodes(_ values: [[Int]]) -> [Node] {
    var lists = [Node]()

    for value in values {
        if let list = createLinkList(value) {
            lists.append(list)
        }
    }

    return lists
}

func printList(_ head: Node?) {
    var current = head

    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }

    print("nil")
}


// MARK: Graph Builders

func createDirectedGraph(_ edges: [[Int]], _ vertices: Int) -> [[Int]] {
    var graph = Array(repeating: [Int](), count: vertices)

    for edge in edges {
        let u = edge[0]
        let v = edge[1]

        graph[u].append(v)
    }

    return graph
}

func createInDegree(_ graph: [[Int]]) -> [Int] {
    var inDegree = Array(repeating: 0, count: graph.count)

    for node in 0..<graph.count {
        for neighbour in graph[node] {
            inDegree[neighbour] += 1
        }
    }

    return inDegree
}

func topologicalOrder(_ graph: [[Int]], inDegree: [Int]) -> [Int] {
    var result = [Int]()
    var inDegree = inDegree
    var queue = [Int]()
    var head = 0

    for node in 0..<graph.count {
        if inDegree[node] == 0 {
            queue.append(node)
        }
    }

    while head < queue.count {
        let node = queue[head]
        head += 1

        result.append(node)

        for neighbour in graph[node] {
            inDegree[neighbour] -= 1

            if inDegree[neighbour] == 0 {
                queue.append(neighbour)
            }
        }
    }

    return result
}


// MARK: Print Helper

func show(_ value: Int?) {
    if let value = value {
        print(value)
    } else {
        print("nil")
    }
}


//==============================================================
// MARK: - Q75 — LC215 — Kth Largest Element In An Array
//==============================================================
//
// PROBLEM
//
// Given an integer array nums and an integer k, return the
// kth largest element in the array.
//
// Note that it is the kth largest element in SORTED ORDER,
// not the kth distinct element.
//
// EXAMPLE
//
// Input:  nums = [3,2,1,5,6,4], k = 2
// Output: 5
//
// Input:  nums = [3,2,3,1,2,4,5,5,6], k = 4
// Output: 4
//
// CONSTRAINTS
//
// 1 <= k <= nums.count <= 10^5
// -10^4 <= nums[i] <= 10^4
//
// APPROACH — Heap
//
// Min-heap capped at k. Evict whenever the size exceeds k, so
// the root is always the smallest of the k largest seen so
// far — which IS the kth largest once every element has
// passed through.
//
// Time:  O(n log k)
// Space: O(k)
//
//==============================================================

// MARK: Solution

func kthLargest(_ nums: [Int], _ k: Int) -> Int? {
    let heap = MinHeap()

    for num in nums {
        heap.insert(num)

        // Cap at k, not 1
        if heap.count > k {
            heap.remove()
        }
    }

    return heap.peek()
}

// MARK: Tests

print("\n========== Q75 - Kth Largest Element In An Array ==========")

show(kthLargest([3, 2, 1, 5, 6, 4], 2))
// 5

show(kthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))
// 4

show(kthLargest([1], 1))
// 1


//==============================================================
// MARK: - Q76 — LC023 — Merge K Sorted Lists
//==============================================================
//
// PROBLEM
//
// You are given an array of k linked lists, each sorted in
// ascending order. Merge them into one sorted linked list and
// return its head.
//
// EXAMPLE
//
// Input:  [[1,4,5], [1,3,4], [2,6]]
// Output: 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil
//
// CONSTRAINTS
//
// 0 <= k <= 10^4
// 0 <= list length <= 500
// -10^4 <= node value <= 10^4
// total nodes <= 10^4
//
// APPROACH — Heap
//
// Seed the heap with the head of every list, pop the smallest,
// append it, push its successor. The heap never holds more
// than k nodes, so each of the N nodes costs one log k insert
// and one log k removal.
//
// Time:  O(N log k)
// Space: O(k)
//
//==============================================================

// MARK: Solution

func mergeKLists(_ lists: [Node]) -> Node? {
    let heap = MinHeapList()

    for list in lists {
        heap.insert(list)
    }

    let dummy = Node(value: 0)
    var tail = dummy

    while let node = heap.remove() {
        tail.next = node
        tail = node

        if let nextNode = node.next {
            heap.insert(nextNode)
        }
    }

    // The last node still points into its original list
    tail.next = nil

    // dummy.next, not tail.next — tail IS the last node
    return dummy.next
}

// MARK: Tests

print("\n========== Q76 - Merge K Sorted Lists ==========")

printList(mergeKLists(createListNodes([[1, 4, 5], [1, 3, 4], [2, 6]])))
// 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil

printList(mergeKLists(createListNodes([])))
// nil

printList(mergeKLists(createListNodes([[1, 2, 3]])))
// 1 -> 2 -> 3 -> nil


//==============================================================
// MARK: - Q77 — LC200 — Number Of Islands
//==============================================================
//
// PROBLEM
//
// Given an m x n 2D binary grid of "1"s (land) and "0"s
// (water), return the number of islands.
//
// An island is surrounded by water and is formed by connecting
// adjacent lands HORIZONTALLY or VERTICALLY. Diagonals do not
// connect. All four edges of the grid are surrounded by water.
//
// EXAMPLE
//
// Input:
// [["1","1","0","0","0"],
//  ["1","1","0","0","0"],
//  ["0","0","1","0","0"],
//  ["0","0","0","1","1"]]
// Output: 3
//
// CONSTRAINTS
//
// 1 <= m, n <= 300
// grid[i][j] is "0" or "1"
//
// APPROACH — Graph DFS
//
// Scan every cell. On land, count one island and DFS out from
// it, sinking each visited cell to "0" — so the grid itself
// is the visited set and no extra array is needed.
//
// Time:  O(m × n)
// Space: O(m × n) — recursion depth is the largest island
//
//==============================================================

// MARK: Solution

func numberOfIslands(_ grid: [[String]]) -> Int {
    if grid.isEmpty || grid[0].isEmpty {
        return 0
    }

    var grid = grid
    let rows = grid.count
    let columns = grid[0].count
    var islands = 0

    // Declared BEFORE the loop that calls it — a nested func
    // capturing mutable locals cannot be used above its
    // own declaration
    func dfs(_ row: Int, _ column: Int) {
        if row < 0 || row >= rows || column < 0 || column >= columns {
            return
        }

        if grid[row][column] == "0" {
            return
        }

        grid[row][column] = "0"

        dfs(row - 1, column)
        dfs(row + 1, column)
        dfs(row, column + 1)
        dfs(row, column - 1)
    }

    for row in 0..<rows {
        for column in 0..<columns {
            if grid[row][column] == "1" {
                islands += 1
                dfs(row, column)
            }
        }
    }

    return islands
}

// MARK: Tests

print("\n========== Q77 - Number Of Islands ==========")

print(numberOfIslands([
    ["1", "1", "0", "0", "0"],
    ["1", "1", "0", "0", "0"],
    ["0", "0", "1", "0", "0"],
    ["0", "0", "0", "1", "1"]
]))
// 3

print(numberOfIslands([
    ["1", "1", "1"],
    ["0", "1", "0"],
    ["1", "1", "1"]
]))
// 1


//==============================================================
// MARK: - Q78 — LC994 — Rotting Oranges
//==============================================================
//
// PROBLEM
//
// Given an m x n grid where each cell is:
//   0 — empty
//   1 — fresh orange
//   2 — rotten orange
//
// Every minute, any fresh orange 4-directionally adjacent to a
// rotten orange becomes rotten.
//
// Return the minimum number of minutes until no fresh orange
// remains, or -1 if that is impossible.
//
// EXAMPLE
//
// Input:  [[2,1,1],[1,1,0],[0,1,1]]   Output: 4
// Input:  [[2,1,1],[0,1,1],[1,0,1]]   Output: -1
// Input:  [[0,2]]                     Output: 0
//
// CONSTRAINTS
//
// 1 <= m, n <= 10
// grid[i][j] is 0, 1 or 2
//
// APPROACH — Multi-source BFS
//
// Seed the queue with EVERY rotten orange before the loop
// starts, then drain one level per minute. The level-size
// snapshot is taken before the drain, so oranges rotted this
// minute land in the next level.
//
// freshOranges > 0 in the while condition is what stops the
// extra minute after the last rot.
//
// Time:  O(m × n)
// Space: O(m × n)
//
//==============================================================

// MARK: Solution

func rottingOranges(_ grid: [[Int]]) -> Int {
    if grid.isEmpty || grid[0].isEmpty {
        return 0
    }

    var grid = grid
    let rows = grid.count
    let columns = grid[0].count
    let directions = [(-1, 0), (1, 0), (0, 1), (0, -1)]

    var queue = [(Int, Int)]()
    var head = 0
    var minutes = 0
    var freshOranges = 0

    for row in 0..<rows {
        for column in 0..<columns {
            if grid[row][column] == 1 {
                freshOranges += 1
            } else if grid[row][column] == 2 {
                queue.append((row, column))
            }
        }
    }

    while head < queue.count, freshOranges > 0 {
        let levelSize = queue.count - head

        for _ in 0..<levelSize {
            let current = queue[head]
            head += 1

            for direction in directions {
                let newRow = current.0 + direction.0
                let newColumn = current.1 + direction.1

                if newRow < 0 || newRow >= rows || newColumn < 0 || newColumn >= columns {
                    continue
                }

                if grid[newRow][newColumn] != 1 {
                    continue
                }

                grid[newRow][newColumn] = 2
                freshOranges -= 1
                queue.append((newRow, newColumn))
            }
        }

        minutes += 1
    }

    if freshOranges == 0 {
        return minutes
    }

    return -1
}

// MARK: Tests

print("\n========== Q78 - Rotting Oranges ==========")

print(rottingOranges([[2, 1, 1], [1, 1, 0], [0, 1, 1]]))
// 4

print(rottingOranges([[2, 1, 1], [0, 1, 1], [1, 0, 1]]))
// -1

print(rottingOranges([[0, 2]]))
// 0


//==============================================================
// MARK: - Q79 — LC207 — Course Schedule
//==============================================================
//
// PROBLEM
//
// There are numCourses courses labelled 0 to numCourses - 1.
// prerequisites[i] = [a, b] means you must take course b
// BEFORE course a.
//
// Return true if you can finish all courses.
//
// EXAMPLE
//
// Input:  numCourses = 2, prerequisites = [[1,0]]
// Output: true
//
// Input:  numCourses = 2, prerequisites = [[1,0],[0,1]]
// Output: false
//
// CONSTRAINTS
//
// 1 <= numCourses <= 2000
// 0 <= prerequisites.count <= 5000
// All pairs are distinct
//
// APPROACH — Topological Sort (Kahn's)
//
// THE TRAP: [a, b] means b comes FIRST, so the edge runs
// b → a. Build it backwards and every in-degree is wrong
// while the code still returns plausible answers.
//
// Seed the queue with in-degree 0 nodes, drain, decrement
// neighbours. A short result means a cycle.
//
// Time:  O(V + E)
// Space: O(V + E)
//
//==============================================================

// MARK: Solution

func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var edges = [[Int]]()

    // Flip: [course, prerequisite] → prerequisite → course
    for prerequisite in prerequisites {
        let course = prerequisite[0]
        let requiredCourse = prerequisite[1]

        edges.append([requiredCourse, course])
    }

    let graph = createDirectedGraph(edges, numCourses)
    let inDegree = createInDegree(graph)
    let result = topologicalOrder(graph, inDegree: inDegree)

    return result.count == numCourses
}

// MARK: Tests

print("\n========== Q79 - Course Schedule ==========")

print(canFinish(2, [[1, 0]]))
// true

print(canFinish(2, [[1, 0], [0, 1]]))
// false

print(canFinish(3, [[1, 0], [2, 1]]))
// true


//==============================================================
// MARK: - Q80 — LC127 — Word Ladder
//==============================================================
//
// PROBLEM
//
// Given beginWord, endWord and a dictionary wordList, return
// the number of words in the SHORTEST transformation sequence
// from beginWord to endWord, or 0 if none exists.
//
// Adjacent words differ by exactly one letter, and every
// intermediate word must be in wordList. beginWord need not be.
// The count includes both ends.
//
// EXAMPLE
//
// beginWord = "hit", endWord = "cog"
// wordList  = ["hot","dot","dog","lot","log","cog"]
// Output: 5   (hit → hot → dot → dog → cog)
//
// CONSTRAINTS
//
// 1 <= word length <= 10
// 1 <= wordList.count <= 5000
// All lowercase, all words the same length, all unique
//
// APPROACH — BFS on an implicit graph
//
// The graph is never built. Neighbours are GENERATED by
// substituting each position with each of 26 letters and
// keeping whatever lands in the word set.
//
// THE TRAP: restore chars[i] after varying position i. Leave
// it mutated and position i+1 is varied against a corrupted
// word — and the bad candidates just miss the set, so the
// tests still pass.
//
// Time:  O(N · L²)
// Space: O(N · L)
//
//==============================================================

// MARK: Solution

func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    var wordSet = Set(wordList)

    if !wordSet.contains(endWord) {
        return 0
    }

    wordSet.remove(beginWord)

    var queue = [String]()
    var head = 0
    var steps = 1

    queue.append(beginWord)

    let letters = Array("abcdefghijklmnopqrstuvwxyz")

    while head < queue.count {
        let levelSize = queue.count - head

        for _ in 0..<levelSize {
            let currentWord = queue[head]
            head += 1

            var chars = Array(currentWord)

            for i in 0..<chars.count {
                let original = chars[i]

                for letter in letters {
                    if letter == original {
                        continue
                    }

                    chars[i] = letter

                    let newWord = String(chars)

                    if newWord == endWord {
                        return steps + 1
                    }

                    if wordSet.contains(newWord) {
                        wordSet.remove(newWord)
                        queue.append(newWord)
                    }
                }

                // Restore before moving to the next position
                chars[i] = original
            }
        }

        steps += 1
    }

    return 0
}

// MARK: Tests

print("\n========== Q80 - Word Ladder ==========")

print(ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]))
// 5

print(ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log"]))
// 0

print(ladderLength("hit", "hot", ["hot"]))
// 2


//==============================================================
// MARK: - Q81 — LC684 — Redundant Connection
//==============================================================
//
// PROBLEM
//
// A tree is an undirected, connected graph with no cycles.
// You are given a graph that started as a tree with n nodes
// labelled 1 to n, with ONE extra edge added.
//
// Return the edge that can be removed so the result is a tree
// again. If several qualify, return the one that occurs LAST
// in the input.
//
// EXAMPLE
//
// Input:  [[1,2],[1,3],[2,3]]                  Output: [2,3]
// Input:  [[1,2],[2,3],[3,4],[1,4],[1,5]]      Output: [1,4]
//
// CONSTRAINTS
//
// n == edges.count, 3 <= n <= 1000
// 1 <= a < b <= n, no repeated edges, graph is connected
//
// APPROACH — Union-Find
//
// Walk the edges in order. If both endpoints already share a
// root they are already connected, so THIS edge closes a
// cycle and is the answer. Otherwise union the two roots.
//
// Path compression and union by rank left out deliberately —
// n <= 1000 makes the plain version fast enough.
//
// Time:  O(E × H), degrading to O(E × V) without rank
// Space: O(V)
//
//==============================================================

// MARK: Solution

func redundantConnection(_ edges: [[Int]]) -> [Int] {
    // Nodes are 1...n and a tree of n nodes plus one extra
    // edge has exactly n edges, so edges.count == n.
    // Index 0 is allocated but unused.
    let n = edges.count
    var parent = Array(0...n)

    func findParentNode(_ node: Int) -> Int {
        if parent[node] == node {
            return node
        }

        return findParentNode(parent[node])
    }

    for edge in edges {
        let node1 = edge[0]
        let node2 = edge[1]

        let root1 = findParentNode(node1)
        let root2 = findParentNode(node2)

        if root1 == root2 {
            return [node1, node2]
        }

        // Union the ROOTS, not the raw endpoints
        parent[root2] = root1
    }

    return []
}

// MARK: Tests

print("\n========== Q81 - Redundant Connection ==========")

print(redundantConnection([[1, 2], [1, 3], [2, 3]]))
// [2, 3]

print(redundantConnection([[1, 2], [2, 3], [3, 4], [1, 4], [1, 5]]))
// [1, 4]


//==============================================================
// MARK: - Q82 — LC078 — Subsets
//==============================================================
//
// PROBLEM
//
// Given an integer array nums of UNIQUE elements, return all
// possible subsets (the power set).
//
// The solution set must not contain duplicate subsets.
// Order does not matter.
//
// EXAMPLE
//
// Input:  [1,2,3]
// Output: [[],[1],[1,2],[1,2,3],[1,3],[2],[2,3],[3]]
//
// CONSTRAINTS
//
// 1 <= nums.count <= 10
// -10 <= nums[i] <= 10
// All elements unique
//
// APPROACH — Backtracking
//
// Choose → Explore → Undo.
//
// Record at EVERY node, not just the leaf — [1] and [1,2] are
// both subsets and neither is a leaf.
//
// The loop starts at start and recurses on i + 1, which is
// what prevents reuse. Q83 recurses on i instead.
//
// Time:  O(n · 2ⁿ)
// Space: O(n) excluding output
//
//==============================================================

// MARK: Solution

func subsets(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    var path = [Int]()

    func dfs(_ start: Int) {
        // Every current path is a valid subset
        result.append(path)

        for i in start..<nums.count {
            // Choose
            path.append(nums[i])

            // Explore
            dfs(i + 1)

            // Undo
            path.removeLast()
        }
    }

    dfs(0)

    return result
}

// MARK: Tests

print("\n========== Q82 - Subsets ==========")

print(subsets([1, 2, 3]))
// [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]

print(subsets([0]))
// [[], [0]]


//==============================================================
// MARK: - Q83 — LC039 — Combination Sum
//==============================================================
//
// PROBLEM
//
// Given an array of DISTINCT integers candidates and a target,
// return all unique combinations of candidates that sum to
// target.
//
// The same number may be chosen an UNLIMITED number of times.
// Two combinations are unique if the frequency of at least one
// chosen number differs.
//
// EXAMPLE
//
// Input:  candidates = [2,3,6,7], target = 7
// Output: [[2,2,3],[7]]
//
// Input:  candidates = [2], target = 1
// Output: []
//
// CONSTRAINTS
//
// 1 <= candidates.count <= 30
// 2 <= candidates[i] <= 40
// All distinct, 1 <= target <= 40
//
// APPROACH — Backtracking with reuse
//
// dfs(i), not dfs(i + 1) — the same number can be picked again.
// But NOT dfs(index) either: passing index restarts every
// level from the same place and produces duplicate orderings.
//
// The loop starting at index rather than 0 is the other half:
// it is what stops [3,2] and [2,3] both appearing.
//
// Time:  O(n^(target / minCandidate))
// Space: O(target / minCandidate) excluding output
//
//==============================================================

// MARK: Solution

func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
    var result = [[Int]]()
    var path = [Int]()

    func dfs(_ index: Int, _ remainingTarget: Int) {
        if remainingTarget == 0 {
            result.append(path)
            return
        }

        if remainingTarget < 0 {
            return
        }

        for i in index..<candidates.count {
            // Choose
            path.append(candidates[i])

            // Explore — i, so the same number can be reused
            dfs(i, remainingTarget - candidates[i])

            // Undo
            path.removeLast()
        }
    }

    dfs(0, target)

    return result
}

// MARK: Tests

print("\n========== Q83 - Combination Sum ==========")

print(combinationSum([2, 3, 6, 7], 7))
// [[2, 2, 3], [7]]

print(combinationSum([2, 3, 5], 8))
// [[2, 2, 2, 2], [2, 3, 3], [3, 5]]

print(combinationSum([2], 1))
// []


//==============================================================
// MARK: - Q84 — LC198 — House Robber
//==============================================================
//
// PROBLEM
//
// Each house holds some money. Adjacent houses share a
// security system, so robbing two adjacent houses on the same
// night triggers the police.
//
// Return the maximum you can rob without alerting them.
//
// EXAMPLE
//
// Input:  [1,2,3,1]      Output: 4   (rob house 1 and 3)
// Input:  [2,7,9,3,1]    Output: 12  (rob 2 + 9 + 1)
//
// CONSTRAINTS
//
// 1 <= nums.count <= 100
// 0 <= nums[i] <= 400
//
// APPROACH — Dynamic Programming, cumulative
//
// Rob this house  → prev2 + num  (prev is adjacent)
// Skip this house → prev
//
// The i - 2 is what encodes "cannot rob adjacent houses".
//
// State is "best UP TO i" — cumulative — so the answer is the
// LAST value. Q85's state is "ending at i" and its answer is
// the max of the whole array. That difference is the trap.
//
// Only two cells are ever read, so the dp array collapses
// into two variables.
//
// Time:  O(n)
// Space: O(1)
//
//==============================================================

// MARK: Solution

func houseRobber(_ nums: [Int]) -> Int {
    var prev2 = 0
    var prev = 0

    for num in nums {
        let current = max(prev2 + num, prev)
        prev2 = prev
        prev = current
    }

    return prev
}

// MARK: Tests

print("\n========== Q84 - House Robber ==========")

print(houseRobber([2, 7, 9, 3, 1]))
// 12

print(houseRobber([1, 2, 3, 1]))
// 4

print(houseRobber([2, 1, 1, 2]))
// 4


//==============================================================
// MARK: - Q85 — LC300 — Longest Increasing Subsequence
//==============================================================
//
// PROBLEM
//
// Given an integer array nums, return the length of the
// longest STRICTLY increasing subsequence.
//
// A subsequence need not be contiguous — elements may be
// skipped, but the order must be preserved.
//
// EXAMPLE
//
// Input:  [10,9,2,5,3,7,101,18]   Output: 4   ([2,3,7,101])
// Input:  [0,1,0,3,2,3]           Output: 4
// Input:  [7,7,7,7,7]             Output: 1
//
// CONSTRAINTS
//
// 1 <= nums.count <= 2500
// -10^4 <= nums[i] <= 10^4
//
// APPROACH — Dynamic Programming, ending-at
//
// dp[i] = length of the LIS ENDING at index i.
// Every element alone is a sequence, so dp starts at 1.
//
// For each i, check every j < i. If nums[j] < nums[i], the
// sequence ending at j can be extended.
//
// nums → actual values.  dp → sequence lengths.
//
// The answer is the MAX of dp, not dp[n - 1] — the best
// sequence can end anywhere. That is the difference from Q84.
//
// An O(n log n) patience-sorting version exists; this O(n²)
// form is the one to explain in an interview.
//
// Time:  O(n²)
// Space: O(n)
//
//==============================================================

// MARK: Solution

func longestIncreasingSubsequence(_ nums: [Int]) -> Int {
    if nums.isEmpty {
        return 0
    }

    var dp = Array(repeating: 1, count: nums.count)

    for i in 0..<nums.count {
        for j in 0..<i {
            if nums[j] < nums[i] {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
    }

    // Named maximum, not max — a local named max would shadow
    // the max() used above and break that call
    var maximum = 0

    for length in dp {
        if length > maximum {
            maximum = length
        }
    }

    return maximum
}

// MARK: Tests

print("\n========== Q85 - Longest Increasing Subsequence ==========")

print(longestIncreasingSubsequence([10, 9, 2, 5, 3, 7, 101, 18]))
// 4

print(longestIncreasingSubsequence([0, 1, 0, 3, 2, 3]))
// 4

print(longestIncreasingSubsequence([7, 7, 7, 7, 7]))
// 1
