import Foundation

/*
==============================================================
Q68 - LC226 Invert Binary Tree
==============================================================

Pattern

✅ DFS Preorder (Recursion)

Idea

Swap the left and right child
at every node.

Base Case

nil → return nil

Traversal

Node → Left → Right

Time  : O(n)

Space : O(h)

==============================================================
*/

//==============================================================
// MARK: - TreeNode
//==============================================================

final class TreeNode {

    let root: Int
    var left: TreeNode?
    var right: TreeNode?

    init(root: Int,
         left: TreeNode? = nil,
         right: TreeNode? = nil) {

        self.root = root
        self.left = left
        self.right = right
    }
}

//==============================================================
// MARK: - Build Tree
//==============================================================

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty,
          let root = values[0] else {
        return nil
    }

    let rootNode = TreeNode(root: root)

    var queue = [rootNode]
    var head = 0
    var index = 1

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        // Left Child
        if index < values.count {

            if let left = values[index] {

                let node = TreeNode(root: left)
                current.left = node
                queue.append(node)
            }

            index += 1
        }

        // Right Child
        if index < values.count {

            if let right = values[index] {

                let node = TreeNode(root: right)
                current.right = node
                queue.append(node)
            }

            index += 1
        }
    }

    return rootNode
}

//==============================================================
// MARK: - Invert Binary Tree
//==============================================================

func invertBinaryTree(_ treeNode: TreeNode?) -> TreeNode? {

    guard let node = treeNode else {
        return nil
    }

    // Swap Left & Right
    let temp = node.left
    node.left = node.right
    node.right = temp

    invertBinaryTree(node.left)
    invertBinaryTree(node.right)

    return node
}

//==============================================================
// MARK: - Preorder (Verify Output)
//==============================================================

func preorder(_ node: TreeNode?) {

    guard let node = node else {
        return
    }

    print(node.root, terminator: " ")

    preorder(node.left)
    preorder(node.right)
}

//==============================================================
// MARK: - Test Cases
//==============================================================

// Test Case 1
let tree1 = buildTree([4, 2, 7, 1, 3, 6, 9])

print("Before:")
preorder(tree1)
print()

invertBinaryTree(tree1)

print("After:")
preorder(tree1)
print()

// Expected:
// Before : 4 2 1 3 7 6 9
// After  : 4 7 9 6 2 3 1

//--------------------------------------------------------------

// Test Case 2
let tree2 = buildTree([2, 1, 3])

print("\nBefore:")
preorder(tree2)
print()

invertBinaryTree(tree2)

print("After:")
preorder(tree2)
print()

// Expected:
// Before : 2 1 3
// After  : 2 3 1

//--------------------------------------------------------------

// Test Case 3
let tree3 = buildTree([1])

print("\nBefore:")
preorder(tree3)
print()

invertBinaryTree(tree3)

print("After:")
preorder(tree3)
print()

// Expected:
// Before : 1
// After  : 1

//--------------------------------------------------------------

// Test Case 4
let tree4 = buildTree([])

print("\nEmpty Tree:")
print(preorder(tree4))

// Expected:
// Empty Tree

//--------------------------------------------------------------

// Test Case 5
let tree5 = buildTree([1, 2, nil, 3])

print("\nBefore:")
preorder(tree5)
print()

invertBinaryTree(tree5)

print("After:")
preorder(tree5)
print()

// Expected:
// Before : 1 2 3
// After  : 1 2 3
// (Tree structure is mirrored even though preorder values appear the same.)
