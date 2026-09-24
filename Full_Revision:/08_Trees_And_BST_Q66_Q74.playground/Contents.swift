import Foundation

//==============================================================
// MARK: - PHASE 08: TREES & BST
//==============================================================
//
// Q66 - Q74
//
// Focus:
//
// - DFS / Recursion
// - BFS / Queue
// - Binary Tree Traversal
// - BST Properties
// - Inorder Traversal
// - Tree Height / Depth
// - Tree Diameter
// - Tree Path Sum
// - Lowest Common Ancestor
//
//==============================================================


//==============================================================
// MARK: - Tree Helpers
//==============================================================

final class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

func buildTree(_ values: [Int?]) -> TreeNode? {
    
    guard !values.isEmpty, let root = values[0] else {
        return nil
    }
    
    let rootNode = TreeNode(value: root)
    var queue: [TreeNode] = [rootNode]
    var index = 1
    var head = 0
    
    while index < values.count, head < queue.count {
        let current = queue[head]
        head += 1
        
        if index < values.count {
            if let left = values[index] {
                let node = TreeNode(value: left)
                current.left = node
                queue.append(node)
            }
            index += 1
        }
        
        if index < values.count {
            if let right = values[index] {
                let node = TreeNode(value: right)
                current.right = node
                queue.append(node)
            }
            index += 1
        }
    }
    
    return rootNode
}

func printLevelOrder(_ tree: TreeNode?) {
    
    guard let rootNode = tree else {
        print("[]")
        return
    }
    
    var queue = [rootNode]
    var head = 0
    var output = [Int]()
    
    while head < queue.count {
        let current = queue[head]
        head += 1
        
        output.append(current.value)
        
        if let left = current.left {
            queue.append(left)
        }
        
        if let right = current.right {
            queue.append(right)
        }
    }
    
    print(output)
}


//==============================================================
// MARK: Helper Check
//==============================================================

print("========== Helper Check ==========")

printLevelOrder(buildTree([4, 2, 7, 1, 3, 6, 9]))
// Expected: [4, 2, 7, 1, 3, 6, 9]

printLevelOrder(buildTree([3, 9, 20, nil, nil, 15, 7]))
// Expected: [3, 9, 20, 15, 7]

printLevelOrder(buildTree([1]))
// Expected: [1]

printLevelOrder(buildTree([]))
// Expected: []


//==============================================================
// MARK: - Q66. Maximum Depth of Binary Tree
//==============================================================
//
// Difficulty: Easy
// LeetCode: 104
//
// Given the root of a binary tree, return its maximum depth.
//
// The maximum depth is the number of nodes along the longest
// path from the root node down to the farthest leaf node.
//
// Example:
// Input:  [3,9,20,nil,nil,15,7]
// Output: 3
//
// Time: O(n)
// Space: O(h)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func maxDepth(_ root: TreeNode?) -> Int {
    
    guard let node = root else { return 0 }
    
    let left = maxDepth(node.left)
    let right = maxDepth(node.right)
    
    return max(left, right) + 1
}


//--------------------------------------------------------------
// MARK: Test Cases - Q66
//--------------------------------------------------------------

print("========== Q66: Maximum Depth of Binary Tree ==========")

print(maxDepth(buildTree([3, 9, 20, nil, nil, 15, 7])))
// Expected: 3

print(maxDepth(buildTree([1, 2])))
// Expected: 2

print(maxDepth(buildTree([1])))
// Expected: 1

print(maxDepth(buildTree([])))
// Expected: 0


//==============================================================
// MARK: - Q67. Same Tree
//==============================================================
//
// Difficulty: Easy
// LeetCode: 100
//
// Given the roots of two binary trees, determine if the two
// trees are structurally identical and have the same node values.
//
// Example:
// Input:
//   p = [1,2,3]
//   q = [1,2,3]
//
// Output: true
//
// Time: O(n)
// Space: O(h)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func isSameTree(_ tree1: TreeNode?, _ tree2: TreeNode?) -> Bool {
    
    if tree1 == nil && tree2 == nil {
        return true
    }
    
    guard let tree1 = tree1, let tree2 = tree2 else {
        return false
    }
    
    if tree1.value != tree2.value {
        return false
    }
    
    return isSameTree(tree1.left, tree2.left) && isSameTree(tree1.right, tree2.right)
}


//--------------------------------------------------------------
// MARK: Test Cases - Q67
//--------------------------------------------------------------

print("========== Q67: Same Tree ==========")

print(isSameTree(buildTree([1, 2, 3]), buildTree([1, 2, 3])))
// Expected: true

print(isSameTree(buildTree([1, 2]), buildTree([1, nil, 2])))
// Expected: false

print(isSameTree(buildTree([1, 2, 3]), buildTree([1, 3, 2])))
// Expected: false

print(isSameTree(buildTree([]), buildTree([])))
// Expected: true


//==============================================================
// MARK: - Q68. Invert Binary Tree
//==============================================================
//
// Difficulty: Easy
// LeetCode: 226
//
// Given the root of a binary tree, invert the tree and return
// its root.
//
// Example:
// Input:  [4,2,7,1,3,6,9]
// Output: [4,7,2,9,6,3,1]
//
// Time: O(n)
// Space: O(h)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func invertTree(_ tree: TreeNode?) -> TreeNode? {
    
    guard let root = tree else { return nil }
    
    let temp = root.left
    root.left = root.right
    root.right = temp
    
    invertTree(root.left)
    invertTree(root.right)
    
    return root
}


//--------------------------------------------------------------
// MARK: Test Cases - Q68
//--------------------------------------------------------------

print("========== Q68: Invert Binary Tree ==========")

printLevelOrder(invertTree(buildTree([4, 2, 7, 1, 3, 6, 9])))
// Expected: [4, 7, 2, 9, 6, 3, 1]

printLevelOrder(invertTree(buildTree([2, 1, 3])))
// Expected: [2, 3, 1]

printLevelOrder(invertTree(buildTree([1])))
// Expected: [1]

printLevelOrder(invertTree(buildTree([])))
// Expected: []


//==============================================================
// MARK: - Q69. Binary Tree Level Order Traversal
//==============================================================
//
// Difficulty: Medium
// LeetCode: 102
//
// Given the root of a binary tree, return the level order
// traversal of its nodes' values.
//
// Traverse the tree level by level from left to right.
//
// Example:
// Input:  [3,9,20,nil,nil,15,7]
// Output: [[3],[9,20],[15,7]]
//
// Time: O(n)
// Space: O(n)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func levelOrder(_ treeNode: TreeNode?) -> [[Int]] {
    
    guard let rootNode = treeNode else { return [] }
    
    var result = [[Int]]()
    var queue = [rootNode]
    var head = 0
    
    while head < queue.count {
        
        let levelSize = queue.count - head
        var levelArray = [Int]()
        
        for _ in 0..<levelSize {
            let current = queue[head]
            head += 1
            
            levelArray.append(current.value)
            
            if let left = current.left {
                queue.append(left)
            }
            
            if let right = current.right {
                queue.append(right)
            }
        }
        
        result.append(levelArray)
    }
    
    return result
}


//--------------------------------------------------------------
// MARK: Test Cases - Q69
//--------------------------------------------------------------

print("========== Q69: Binary Tree Level Order Traversal ==========")

print(levelOrder(buildTree([3, 9, 20, nil, nil, 15, 7])))
// Expected: [[3], [9, 20], [15, 7]]

print(levelOrder(buildTree([1, 2, 3, 4, 5])))
// Expected: [[1], [2, 3], [4, 5]]

print(levelOrder(buildTree([1])))
// Expected: [[1]]

print(levelOrder(buildTree([])))
// Expected: []


//==============================================================
// MARK: - Q70. Validate Binary Search Tree
//==============================================================
//
// Difficulty: Medium
// LeetCode: 98
//
// Given the root of a binary tree, determine if it is a valid
// binary search tree.
//
// A valid BST follows:
// - Left subtree values are smaller.
// - Right subtree values are greater.
// - Every subtree must also satisfy the BST property.
//
// Example:
// Input:  [2,1,3]
// Output: true
//
// Time: O(n)
// Space: O(h)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func isValidBST(_ treeNode: TreeNode?) -> Bool {
    
    func isValidDFS(_ treeNode: TreeNode?, minValue: Int? = nil, maxValue: Int? = nil) -> Bool {
        
        guard let node = treeNode else { return true }
        
        if let minValue = minValue, minValue >= node.value {
            return false
        }
        
        if let maxValue = maxValue, maxValue <= node.value {
            return false
        }
        
        return isValidDFS(node.left, minValue: minValue, maxValue: node.value) &&
               isValidDFS(node.right, minValue: node.value, maxValue: maxValue)
    }
    
    return isValidDFS(treeNode)
}


//--------------------------------------------------------------
// MARK: Test Cases - Q70
//--------------------------------------------------------------

print("========== Q70: Validate Binary Search Tree ==========")

print(isValidBST(buildTree([2, 1, 3])))
// Expected: true

print(isValidBST(buildTree([5, 1, 4, nil, nil, 3, 6])))
// Expected: false

print(isValidBST(buildTree([2, 2, 2])))
// Expected: false

print(isValidBST(buildTree([1])))
// Expected: true


//==============================================================
// MARK: - Q71. Diameter of Binary Tree
//==============================================================
//
// Difficulty: Easy
// LeetCode: 543
//
// Given the root of a binary tree, return the length of the
// diameter of the tree.
//
// The diameter is the longest path between any two nodes.
// The length is measured by the number of edges.
//
// Example:
// Input:  [1,2,3,4,5]
// Output: 3
//
// Time: O(n)
// Space: O(h)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func diameterOfBinaryTree(_ treeNode: TreeNode?) -> Int {
    
    var diameter = 0
    
    func dfs(_ treeNode: TreeNode?) -> Int {
        
        guard let node = treeNode else { return 0 }
        
        let left = dfs(node.left)
        let right = dfs(node.right)
        let currentPath = left + right
        
        diameter = max(currentPath, diameter)
        
        return max(left, right) + 1
    }
    
    _ = dfs(treeNode)
    
    return diameter
}


//--------------------------------------------------------------
// MARK: Test Cases - Q71
//--------------------------------------------------------------

print("========== Q71: Diameter of Binary Tree ==========")

print(diameterOfBinaryTree(buildTree([1, 2, 3, 4, 5])))
// Expected: 3

print(diameterOfBinaryTree(buildTree([1, 2])))
// Expected: 1

print(diameterOfBinaryTree(buildTree([1])))
// Expected: 0

print(diameterOfBinaryTree(buildTree([1, 2, 3, 4, 5, 6, 7])))
// Expected: 4


//==============================================================
// MARK: - Q72. Lowest Common Ancestor of a BST
//==============================================================
//
// Difficulty: Medium
// LeetCode: 235
//
// Given a binary search tree and two nodes p and q, find their
// lowest common ancestor.
//
// The BST property can be used to decide whether to move left,
// move right, or return the current node.
//
// Example:
// Input:  [6,2,8,0,4,7,9,nil,nil,3,5]
// p = 2, q = 8
// Output: 6
//
// Time: O(h)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func lowestCommonAncestor(_ treeNode: TreeNode?, _ p: Int, _ q: Int) -> TreeNode? {
    
    var current: TreeNode? = treeNode
    
    while let node = current {
        
        if node.value < p && node.value < q {
            current = node.right
        } else if node.value > p && node.value > q {
            current = node.left
        } else {
            return current
        }
    }
    
    return current
}


//--------------------------------------------------------------
// MARK: Test Cases - Q72
//--------------------------------------------------------------

print("========== Q72: Lowest Common Ancestor of a BST ==========")

let bst72 = buildTree([6, 2, 8, 0, 4, 7, 9, nil, nil, 3, 5])

print(lowestCommonAncestor(bst72, 2, 8)?.value ?? -1)
// Expected: 6

print(lowestCommonAncestor(bst72, 2, 4)?.value ?? -1)
// Expected: 2

print(lowestCommonAncestor(bst72, 7, 9)?.value ?? -1)
// Expected: 8

print(lowestCommonAncestor(bst72, 3, 5)?.value ?? -1)
// Expected: 4

print(lowestCommonAncestor(buildTree([2, 1, 3]), 1, 3)?.value ?? -1)
// Expected: 2


//==============================================================
// MARK: - Q73. Kth Smallest Element in a BST
//==============================================================
//
// Difficulty: Medium
// LeetCode: 230
//
// Given the root of a binary search tree and an integer k,
// return the kth smallest value in the tree.
//
// Inorder traversal of a BST visits nodes in ascending order.
//
// Example:
// Input:  [3,1,4,nil,2], k = 1
// Output: 1
//
// Time: O(h + k)
// Space: O(h)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func kthSmallest(_ treeNode: TreeNode?, k: Int) -> Int {
    
    var answer = 0
    var k = k
    
    func dfsInOrder(_ treeNode: TreeNode?) {
        
        guard let node = treeNode, k > 0 else { return }
        
        dfsInOrder(node.left)
        
        k -= 1
        
        if k == 0 {
            answer = node.value
            return
        }
        
        dfsInOrder(node.right)
    }
    
    dfsInOrder(treeNode)
    
    return answer
}


//--------------------------------------------------------------
// MARK: Test Cases - Q73
//--------------------------------------------------------------

print("========== Q73: Kth Smallest Element in a BST ==========")

let bst73 = buildTree([3, 1, 4, nil, 2])

print(kthSmallest(bst73, k: 1))
// Expected: 1

print(kthSmallest(bst73, k: 2))
// Expected: 2

print(kthSmallest(bst73, k: 4))
// Expected: 4

print(kthSmallest(buildTree([5, 3, 6, 2, 4, nil, nil, 1]), k: 4))
// Expected: 4

print(kthSmallest(buildTree([1]), k: 1))
// Expected: 1


//==============================================================
// MARK: - Q74. Binary Tree Maximum Path Sum
//==============================================================
//
// Difficulty: Hard
// LeetCode: 124
//
// Given the root of a binary tree, return the maximum path sum.
//
// A path may start and end at any node, but it must follow
// connected parent-child relationships.
//
// Example:
// Input:  [-10,9,20,nil,nil,15,7]
// Output: 42
//
// Time: O(n)
// Space: O(h)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func maxPathSum(_ treeNode: TreeNode?) -> Int {
    
    var bestSum = Int.min
    
    func dfs(_ treeNode: TreeNode?) -> Int {
        
        guard let node = treeNode else { return 0 }
        
        let leftPath = max(0, dfs(node.left))
        let rightPath = max(0, dfs(node.right))
        let currentSum = leftPath + rightPath + node.value
        
        bestSum = max(bestSum, currentSum)
        
        return max(leftPath, rightPath) + node.value
    }
    
    _ = dfs(treeNode)
    
    return bestSum
}


//--------------------------------------------------------------
// MARK: Test Cases - Q74
//--------------------------------------------------------------

print("========== Q74: Binary Tree Maximum Path Sum ==========")

print(maxPathSum(buildTree([1, 2, 3])))
// Expected: 6

print(maxPathSum(buildTree([-10, 9, 20, nil, nil, 15, 7])))
// Expected: 42

print(maxPathSum(buildTree([-3])))
// Expected: -3

print(maxPathSum(buildTree([2, -1])))
// Expected: 2

print(maxPathSum(buildTree([-2, -1, -3])))
// Expected: -1


//==============================================================
// MARK: - PHASE 08 COMPLETE
//==============================================================
//
// Q66 - Maximum Depth of Binary Tree
// Q67 - Same Tree
// Q68 - Invert Binary Tree
// Q69 - Binary Tree Level Order Traversal
// Q70 - Validate Binary Search Tree
// Q71 - Diameter of Binary Tree
// Q72 - Lowest Common Ancestor of a BST
// Q73 - Kth Smallest Element in a BST
// Q74 - Binary Tree Maximum Path Sum
//
//==============================================================
