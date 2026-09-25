import Foundation

//==============================================================
// MARK: - 09_Advanced_Patterns_Q75_Q85
//==============================================================

//==============================================================
// MARK: - Phase 09. Advanced Patterns
//==============================================================

// Problems: Q75 - Q85
// Focus: Heap, Graph, Backtracking, Dynamic Programming
//==============================================================



//==============================================================
// MARK: - Helper - Min Heap
//==============================================================

final class MiniHeap {
    
    private var heap = [Int]()
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    var count: Int {
        heap.count
    }
    
    func peek() -> Int? {
        
        if heap.isEmpty {
            return nil
        }
        
        return heap.first
    }
    
    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(heap.count - 1)
    }
    
    func remove() -> Int? {
        
        guard !heap.isEmpty else { return nil }
        guard heap.count > 1 else { return heap.removeLast() }
        
        let mini = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(0)
        return mini
    }
    
    // CoreLogic functions
    
    private func heapifyUp(_ index: Int) {
        var childIndex = index
        
        while childIndex > 0 {
            let parentIndex = getParentIndex(childIndex)
            
            if heap[parentIndex] <= heap[childIndex] {
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
            let leftIndex = getLeftChildIndex(parentIndex)
            let rightIndex = getRightChildIndex(parentIndex)
            
            if leftIndex < heap.count, heap[leftIndex] < heap[smallest] {
                smallest = leftIndex
            }
            
            if rightIndex < heap.count, heap[rightIndex] < heap[smallest] {
                smallest = rightIndex
            }
            
            if parentIndex == smallest {
                break
            }
            
            heap.swapAt(smallest, parentIndex)
            parentIndex = smallest
        }
        
    }
    
    
    // Helper for index
    
    
    private func getParentIndex(_ index: Int) -> Int {
        (index-1)/2
    }
    
    private func getLeftChildIndex(_ index: Int) -> Int {
        2 * index + 1
    }
    
    private func getRightChildIndex(_ index: Int) -> Int {
        2 * index + 2
    }

}


//==============================================================
// MARK: - Helper - Linked List
//==============================================================

final class ListNode {
    var value: Int
    var next: ListNode?
    
    init(value: Int, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

func createList(_ values: [Int]) -> ListNode? {
    
    guard !values.isEmpty else { return nil }
    let headNode: ListNode? = ListNode(value: values[0])
    var current: ListNode? = headNode
    
    for i in 1..<values.count {
        let node = ListNode(value: values[i])
        current?.next = node
        current = node
    }
    
    return headNode
    
}

func printListNode(_ headNode: ListNode?) {
    
    var current: ListNode? = headNode
    
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")
}


//==============================================================
// MARK: - Helper - Linked List Min Heap
//==============================================================

final class MiniHeapList {

    private var heap = [ListNode]()
    
    var count: Int {
        heap.count
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    func peek() -> ListNode? {
        if heap.isEmpty {
            return nil
        }
        return heap.first
    }
    
    func insert(_ node: ListNode) {
        heap.append(node)
        heapifyUp(heap.count - 1)
    }
    
    func remove() -> ListNode? {
        
        guard !heap.isEmpty else {
            return nil
        }
        
        guard heap.count > 1 else {
            return heap.removeLast()
        }
        
        let mini = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(0)
        return mini
        
    }
    
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
            
            heap.swapAt(parentIndex, smallest)
            parentIndex = smallest
        }
    }
        
    // helpers
    
    private func getParentIndex(_ index: Int) -> Int {
        (index-1)/2
    }
    
    private func getLeftChildIndex(_ index: Int) -> Int {
        2 * index + 1
    }
    
    private func getRightChildIndex(_ index: Int) -> Int {
        2 * index + 2
    }
}


//==============================================================
// MARK: - Helper - Graph
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


func createInDegree(_ graph: [[Int]]) -> [Int] {
    
    var inDegree = Array(repeating: 0, count: graph.count)
    
    for node in 0..<graph.count {
        
        for neighbour in graph[node] {
            inDegree[neighbour] += 1
        }
    }
    
    return inDegree
}


func topologicalSortOrder(_ graph: [[Int]], inDegree: [Int]) -> [Int] {
    
    var inDegree = inDegree
    var result = [Int]()
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


//==============================================================
// MARK: - Q75. Kth Largest Element in an Array
//==============================================================
//
// Difficulty: Medium
// LeetCode: 215
//
// Given an integer array nums and an integer k, return the kth
// largest element in the array.
//
// Example:
// Input:  nums = [3,2,1,5,6,4], k = 2
// Output: 5
//
// Pattern:
// Min Heap
//
// Time: O(n log k)
// Space: O(k)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func findKthLargestElement(_ nums: [Int], _ k: Int) -> Int {
    
    let heap = MiniHeap()
    
    for num in nums {
        
        heap.insert(num)
        
        if heap.count > k {
            _ = heap.remove()
        }
    }
    
    return heap.peek() ?? -1
}


//--------------------------------------------------------------
// MARK: Test Cases - Q75
//--------------------------------------------------------------

print("========== Q75: Kth Largest Element in an Array ==========")

print(findKthLargestElement([3, 2, 1, 5, 6, 4], 2))
// Expected: 5

print(findKthLargestElement([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))
// Expected: 4

print(findKthLargestElement([7, 6, 5, 4, 3, 2, 1], 5))
// Expected: 3

print(findKthLargestElement([2, 2, 2, 1, 1, 3], 3))
// Expected: 2

print(findKthLargestElement([1], 1))
// Expected: 1


//==============================================================
// MARK: - Q76. Merge K Sorted Lists
//==============================================================
//
// Difficulty: Hard
// LeetCode: 23
//
// You are given an array of k linked lists, where each linked
// list is sorted in ascending order.
//
// Merge all the linked lists into one sorted linked list.
//
// Example:
// Input:
// [1 -> 4 -> 5]
// [1 -> 3 -> 4]
// [2 -> 6]
//
// Output:
// 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6
//
// Pattern:
// Linked List + Min Heap
//
// Time: O(n log k)
// Space: O(k)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    
    let dummy: ListNode? = ListNode(value: 0)
    var tail: ListNode? = dummy
    
    let heap = MiniHeapList()
    
    for list in lists {
        
        if let node = list {
            heap.insert(node)
        }
    }
    
    while let node = heap.remove() {
        
        tail?.next = node
        tail = node
        
        if let nextNode = node.next {
            heap.insert(nextNode)
        }
    }

    tail?.next = nil
    
    return dummy?.next
    
}


//--------------------------------------------------------------
// MARK: Test Cases - Q76
//--------------------------------------------------------------

print("========== Q76: Merge K Sorted Lists ==========")

printListNode(mergeKLists([
    createList([1, 4, 5]),
    createList([1, 3, 4]),
    createList([2, 6])
]))
// Expected: 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil

printListNode(mergeKLists([
    createList([1]),
    createList([2]),
    createList([3])
]))
// Expected: 1 -> 2 -> 3 -> nil

printListNode(mergeKLists([
    createList([1, 1, 1]),
    createList([1, 1])
]))
// Expected: 1 -> 1 -> 1 -> 1 -> 1 -> nil

printListNode(mergeKLists([
    createList([]),
    createList([2, 4]),
    createList([])
]))
// Expected: 2 -> 4 -> nil

printListNode(mergeKLists([createList([])]))
// Expected: nil

printListNode(mergeKLists([]))
// Expected: nil


//==============================================================
// MARK: - Q77. Number of Islands
//==============================================================
//
// Difficulty: Medium
// LeetCode: 200
//
// Given an m x n 2D binary grid which represents a map of
// '1's (land) and '0's (water), return the number of islands.
//
// An island is surrounded by water and is formed by connecting
// adjacent lands horizontally or vertically.
//
// Example:
// Input:
// [
//   ["1","1","1","1","0"],
//   ["1","1","0","1","0"],
//   ["1","1","0","0","0"],
//   ["0","0","0","0","0"]
// ]
//
// Output: 1
//
// Pattern:
// DFS / Graph Traversal
//
// Time: O(rows * columns)
// Space: O(rows * columns)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func numberOfIslands(_ grid: [[String]]) -> Int {
    
    guard !grid.isEmpty, !grid[0].isEmpty else { return 0 }
    
    var grid = grid
    let rows = grid.count
    let columns = grid[0].count
    var islands = 0
    
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
        dfs(row, column - 1)
        dfs(row, column + 1)
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


//--------------------------------------------------------------
// MARK: Test Cases - Q77
//--------------------------------------------------------------

print("========== Q77: Number of Islands ==========")

print(numberOfIslands([
    ["1","1","1","1","0"],
    ["1","1","0","1","0"],
    ["1","1","0","0","0"],
    ["0","0","0","0","0"]
]))
// Expected: 1

print(numberOfIslands([
    ["1","1","0","0","0"],
    ["1","1","0","0","0"],
    ["0","0","1","0","0"],
    ["0","0","0","1","1"]
]))
// Expected: 3

print(numberOfIslands([
    ["0","0","0"],
    ["0","0","0"],
    ["0","0","0"]
]))
// Expected: 0

print(numberOfIslands([["1"]]))
// Expected: 1

print(numberOfIslands([["1","0","1","0","1"]]))
// Expected: 3


//==============================================================
// MARK: - Q78. Rotting Oranges
//==============================================================
//
// Difficulty: Medium
// LeetCode: 994
//
// You are given an m x n grid where:
//
// 0 = empty cell
// 1 = fresh orange
// 2 = rotten orange
//
// Every minute, a rotten orange makes adjacent fresh oranges
// rotten.
//
// Return the minimum number of minutes until no fresh oranges
// remain. Return -1 if impossible.
//
// Example:
// Input:
// [
//   [2,1,1],
//   [1,1,0],
//   [0,1,1]
// ]
//
// Output: 4
//
// Pattern:
// Multi-Source BFS
//
// Time: O(rows * columns)
// Space: O(rows * columns)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func rottingOranges(_ grid: [[Int]]) -> Int {
    
    guard !grid.isEmpty, !grid[0].isEmpty else { return -1 }
    
    var grid = grid
    let rows = grid.count
    let columns = grid[0].count
    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    var freshOranges = 0
    var minutes = 0
    var queue = [(row: Int, column: Int)]()
    var head = 0
    
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
                
                let newRow = current.row + direction.0
                let newColumn = current.column + direction.1
                
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
    
    return freshOranges == 0 ? minutes : -1
}


//--------------------------------------------------------------
// MARK: Test Cases - Q78
//--------------------------------------------------------------

print("========== Q78: Rotting Oranges ==========")

print(rottingOranges([
    [2, 1, 1],
    [1, 1, 0],
    [0, 1, 1]
]))
// Expected: 4

print(rottingOranges([
    [2, 1, 1],
    [0, 1, 1],
    [1, 0, 1]
]))
// Expected: -1

print(rottingOranges([[0, 2]]))
// Expected: 0

print(rottingOranges([[1]]))
// Expected: -1

print(rottingOranges([[0]]))
// Expected: 0


//==============================================================
// MARK: - Q79. Course Schedule
//==============================================================
//
// Difficulty: Medium
// LeetCode: 207
//
// There are numCourses courses labeled from 0 to numCourses - 1.
//
// You are given an array prerequisites where
// prerequisites[i] = [course, prerequisite].
//
// Return true if you can finish all courses.
//
// Example:
// Input:
// prerequisites = [[1,0]], numCourses = 2
//
// Output: true
//
// Pattern:
// Topological Sort / BFS / Kahn's Algorithm
//
// Time: O(V + E)
// Space: O(V + E)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func canFinish(_ courses: [[Int]], _ numCourses: Int) -> Bool {
    
    var edges = [[Int]]()
    
    for course in courses {
        
        let pre = course[0]
        let req = course[1]
        
        edges.append([req, pre])
    }
    
    let graph = createGraph(edges, numCourses)
    let inDegree = createInDegree(graph)
    let result = topologicalSortOrder(graph, inDegree: inDegree)
    
    return result.count == numCourses
}


//--------------------------------------------------------------
// MARK: Test Cases - Q79
//--------------------------------------------------------------

print("========== Q79: Course Schedule ==========")

print(canFinish([[1, 0]], 2))
// Expected: true

print(canFinish([[1, 0], [0, 1]], 2))
// Expected: false

print(canFinish([[1, 0], [2, 1]], 3))
// Expected: true

print(canFinish([[1, 0], [2, 0], [3, 1], [3, 2]], 4))
// Expected: true

print(canFinish([], 3))
// Expected: true


//==============================================================
// MARK: - Q80. Word Ladder
//==============================================================
//
// Difficulty: Hard
// LeetCode: 127
//
// A transformation sequence from beginWord to endWord is a
// sequence of words where:
//
// - Only one letter changes at a time.
// - Every transformed word must exist in wordList.
//
// Return the number of words in the shortest transformation
// sequence. Return 0 if no such sequence exists.
//
// Example:
// Input:
// beginWord = "hit"
// endWord = "cog"
// wordList = ["hot","dot","dog","lot","log","cog"]
//
// Output: 5
//
// Pattern:
// BFS + Set
//
// Time: O(n * m^2 * 26), n = words, m = word length
// Space: O(n * m)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func ladderLength(_ beginWord: String, _ endWord: String, _ wordsList: [String]) -> Int {
    
    guard wordsList.contains(endWord) else { return 0 }
    guard beginWord != endWord else { return 1 }
    
    var wordList = Set(wordsList)
    wordList.remove(beginWord)
    
    let letters = Array("abcdefghijklmnopqrstuvwxyz")
    var queue = [String]()
    var head = 0
    var steps = 1
    
    queue.append(beginWord)

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
                    
                    if wordList.contains(newWord) {
                        wordList.remove(newWord)
                        queue.append(newWord)
                    }
                }
                
                chars[i] = original
            }
        }
        
        steps += 1
    }
    
    return 0
}


//--------------------------------------------------------------
// MARK: Test Cases - Q80
//--------------------------------------------------------------

print("========== Q80: Word Ladder ==========")

print(ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]))
// Expected: 5

print(ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log"]))
// Expected: 0

print(ladderLength("a", "c", ["a", "b", "c"]))
// Expected: 2

print(ladderLength("hit", "hot", ["hot"]))
// Expected: 2

print(ladderLength("hot", "hot", ["hot"]))
// Expected: 1


//==============================================================
// MARK: - Q81. Redundant Connection
//==============================================================
//
// Difficulty: Medium
// LeetCode: 684
//
// You are given a graph that started as a tree with n nodes
// labeled from 1 to n, with one additional edge added.
//
// Return the edge that can be removed so that the resulting
// graph is a tree.
//
// If there are multiple answers, return the edge that occurs
// last in the input.
//
// Example:
// Input:
// [[1,2], [1,3], [2,3]]
//
// Output:
// [2,3]
//
// Pattern:
// Union-Find / Disjoint Set
//
// Time: O(n) with path compression
// Space: O(n)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func redundantConnection(_ edges: [[Int]]) -> [Int] {
    
    // n edges with exactly one cycle means exactly n nodes, labelled 1...n
    let nodeCount = edges.count
    var parent = Array(0...nodeCount)
    
    func findParent(_ node: Int) -> Int {
        
        if parent[node] != node {
            parent[node] = findParent(parent[node])
        }
        
        return parent[node]
    }
    
    for edge in edges {
        
        let nodeX = edge[0]
        let nodeY = edge[1]
        
        let parentX = findParent(nodeX)
        let parentY = findParent(nodeY)
        
        if parentX == parentY {
            return [nodeX, nodeY]
        }
        
        parent[parentY] = parentX
    }
    
    return []
}


//--------------------------------------------------------------
// MARK: Test Cases - Q81
//--------------------------------------------------------------

print("========== Q81: Redundant Connection ==========")

print(redundantConnection([[1, 2], [1, 3], [2, 3]]))
// Expected: [2, 3]

print(redundantConnection([[1, 2], [2, 3], [3, 4], [1, 4], [1, 5]]))
// Expected: [1, 4]

print(redundantConnection([[1, 2], [2, 3], [3, 1]]))
// Expected: [3, 1]

print(redundantConnection([[1, 2], [2, 3], [3, 4], [4, 5], [1, 5]]))
// Expected: [1, 5]


//==============================================================
// MARK: - Q82. Subsets
//==============================================================
//
// Difficulty: Medium
// LeetCode: 78
//
// Given an integer array nums of unique elements, return all
// possible subsets.
//
// The solution set must not contain duplicate subsets.
//
// Example:
// Input:  nums = [1,2,3]
// Output:
// [[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]]
//
// Pattern:
// Backtracking
//
// Time: O(n * 2^n)
// Space: O(n * 2^n)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func subSets(_ nums: [Int]) -> [[Int]] {
    
    var result = [[Int]]()
    var path = [Int]()
    
    func dfs(_ index: Int) {
        
        result.append(path)
        
        for i in index..<nums.count {
            
            path.append(nums[i])
            
            dfs(i + 1)
            
            path.removeLast()
        }
    }
    
    dfs(0)
    
    return result
}


//--------------------------------------------------------------
// MARK: Test Cases - Q82
//--------------------------------------------------------------

print("========== Q82: Subsets ==========")

print(subSets([1, 2, 3]))
// Expected: [[], [1], [1,2], [1,2,3], [1,3], [2], [2,3], [3]]

print(subSets([1, 2]))
// Expected: [[], [1], [1,2], [2]]

print(subSets([0]))
// Expected: [[], [0]]

print(subSets([]))
// Expected: [[]]


//==============================================================
// MARK: - Q83. Combination Sum
//==============================================================
//
// Difficulty: Medium
// LeetCode: 39
//
// Given an array of distinct integers candidates and a target
// integer target, return all unique combinations where the
// chosen numbers sum to target.
//
// The same number may be chosen an unlimited number of times.
//
// Example:
// Input:
// candidates = [2,3,6,7]
// target = 7
//
// Output:
// [[2,2,3],[7]]
//
// Pattern:
// Backtracking
//
// Time: O(n^(target/min))
// Space: O(target/min)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

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
            
            path.append(candidates[i])
            
            dfs(i, remainingTarget - candidates[i])
            
            path.removeLast()
        }
    }
    
    dfs(0, target)
    
    return result
}


//--------------------------------------------------------------
// MARK: Test Cases - Q83
//--------------------------------------------------------------

print("========== Q83: Combination Sum ==========")

print(combinationSum([2, 3, 6, 7], 7))
// Expected: [[2,2,3], [7]]

print(combinationSum([2, 3, 5], 8))
// Expected: [[2,2,2,2], [2,3,3], [3,5]]

print(combinationSum([2, 3], 6))
// Expected: [[2,2,2], [3,3]]

print(combinationSum([2], 1))
// Expected: []

print(combinationSum([7], 7))
// Expected: [[7]]


//==============================================================
// MARK: - Q84. House Robber
//==============================================================
//
// Difficulty: Medium
// LeetCode: 198
//
// You are a professional robber planning to rob houses along
// a street.
//
// Each house has a certain amount of money. Adjacent houses
// cannot both be robbed.
//
// Return the maximum amount of money you can rob.
//
// Example:
// Input:  nums = [2,7,9,3,1]
// Output: 12
//
// Pattern:
// Dynamic Programming
//
// Time: O(n)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func rob(_ nums: [Int]) -> Int {
    
    guard !nums.isEmpty else { return 0 }
    
    var prev1 = 0
    var prev2 = 0
    
    for num in nums {
        
        let current = max(prev2 + num, prev1)
        prev2 = prev1
        prev1 = current
    }
    
    return prev1
}


//--------------------------------------------------------------
// MARK: Test Cases - Q84
//--------------------------------------------------------------

print("========== Q84: House Robber ==========")

print(rob([2, 7, 9, 3, 1]))
// Expected: 12

print(rob([1, 2, 3, 1]))
// Expected: 4

print(rob([2, 1, 1, 2]))
// Expected: 4

print(rob([5]))
// Expected: 5

print(rob([]))
// Expected: 0


//==============================================================
// MARK: - Q85. Longest Increasing Subsequence
//==============================================================
//
// Difficulty: Medium
// LeetCode: 300
//
// Given an integer array nums, return the length of the longest
// strictly increasing subsequence.
//
// A subsequence does not have to be contiguous.
//
// Example:
// Input:  nums = [10,9,2,5,3,7,101,18]
// Output: 4
//
// Pattern:
// Dynamic Programming
//
// Time: O(n^2)
// Space: O(n)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func lengthOfLIS(_ nums: [Int]) -> Int {
    
    guard !nums.isEmpty else { return 0 }
    
    var dp = Array(repeating: 1, count: nums.count)
    var longest = 1
    
    for i in 0..<nums.count {
        
        for j in 0..<i {
            
            if nums[j] < nums[i] {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
        
        longest = max(longest, dp[i])
    }
    
    return longest
}


//--------------------------------------------------------------
// MARK: Test Cases - Q85
//--------------------------------------------------------------

print("========== Q85: Longest Increasing Subsequence ==========")

print(lengthOfLIS([10, 9, 2, 5, 3, 7, 101, 18]))
// Expected: 4

print(lengthOfLIS([0, 1, 0, 3, 2, 3]))
// Expected: 4

print(lengthOfLIS([7, 7, 7, 7, 7]))
// Expected: 1

print(lengthOfLIS([5, 4, 3, 2, 1]))
// Expected: 1

print(lengthOfLIS([1]))
// Expected: 1


//==============================================================
// MARK: - PHASE 09 COMPLETE
//==============================================================
//
// Q75 - Kth Largest Element in an Array
// Q76 - Merge K Sorted Lists
// Q77 - Number of Islands
// Q78 - Rotting Oranges
// Q79 - Course Schedule
// Q80 - Word Ladder
// Q81 - Redundant Connection
// Q82 - Subsets
// Q83 - Combination Sum
// Q84 - House Robber
// Q85 - Longest Increasing Subsequence
//
//==============================================================
