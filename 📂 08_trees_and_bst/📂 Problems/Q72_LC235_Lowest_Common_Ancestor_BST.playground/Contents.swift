import Foundation

/*
==============================================================
Q72 - LC235 Lowest Common Ancestor of a BST
==============================================================

Problem

Given a Binary Search Tree (BST) and two nodes p and q,
find their Lowest Common Ancestor (LCA).

LCA = The lowest node that has both p and q in its subtree.

Example

          6
        /   \
       2     8
      / \   / \
     0   4 7   9
        / \
       3   5

LCA of 2 and 8 = 6
LCA of 3 and 5 = 4

BST Property

Left < Node < Right

Pattern

06 — BST Property Walk

Idea

Start from the root.

1. If p and q are both smaller than current:
      Go LEFT

2. If p and q are both greater than current:
      Go RIGHT

3. Otherwise:
      Current node is the LCA.

Why?

The first node where p and q split into different
directions is their Lowest Common Ancestor.

Time  : O(h)
Space : O(1)

==============================================================
*/

//==============================================================
// MARK: - TreeNode
//==============================================================

final class TreeNode {

    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(
        value: Int,
        left: TreeNode? = nil,
        right: TreeNode? = nil
    ) {
        self.value = value
        self.left = left
        self.right = right
    }
}

//==============================================================
// MARK: - Build Binary Tree
//==============================================================

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty,
          let rootValue = values[0] else {
        return nil
    }

    let rootNode = TreeNode(value: rootValue)

    var queue = [rootNode]
    var head = 0
    var index = 1

    while head < queue.count,
          index < values.count {

        let current = queue[head]
        head += 1

        // Left child
        if let leftValue = values[index] {

            let node = TreeNode(value: leftValue)

            current.left = node
            queue.append(node)
        }

        index += 1

        // Right child
        if index < values.count {

            if let rightValue = values[index] {

                let node = TreeNode(value: rightValue)

                current.right = node
                queue.append(node)
            }

            index += 1
        }
    }

    return rootNode
}

//==============================================================
// MARK: - Solution
//==============================================================

func lowestCommonAncestor(
    _ treeNode: TreeNode?,
    _ p: Int,
    _ q: Int
) -> TreeNode? {

    var current: TreeNode? = treeNode

    while let node = current {

        // Both p and q are smaller
        if p < node.value && q < node.value {

            current = node.left

        // Both p and q are greater
        } else if p > node.value && q > node.value {

            current = node.right

        // They split here
        // OR current node is p/q
        } else {

            return node
        }
    }

    return nil
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print("\n========== Q72 - Lowest Common Ancestor BST ==========")

//             6
//           /   \
//          2     8
//         / \   / \
//        0   4 7   9
//           / \
//          3   5

let root = buildTree([
    6, 2, 8,
    0, 4, 7, 9,
    nil, nil, 3, 5
])

//==============================================================
// Test 1
//==============================================================

print(
    lowestCommonAncestor(root, 2, 8)?.value ?? -1
)

// Expected: 6


//==============================================================
// Test 2
//==============================================================

print(
    lowestCommonAncestor(root, 2, 4)?.value ?? -1
)

// Expected: 2


//==============================================================
// Test 3
//==============================================================

print(
    lowestCommonAncestor(root, 3, 5)?.value ?? -1
)

// Expected: 4


//==============================================================
// Test 4
//==============================================================

print(
    lowestCommonAncestor(root, 0, 5)?.value ?? -1
)

// Expected: 2


//==============================================================
// Test 5
//==============================================================

print(
    lowestCommonAncestor(root, 7, 9)?.value ?? -1
)

// Expected: 8


//==============================================================
// Test 6
//==============================================================

print(
    lowestCommonAncestor(root, 2, 2)?.value ?? -1
)

// Expected: 2


//==============================================================
// Test 7 - Single Node
//==============================================================

let singleNode = buildTree([10])

print(
    lowestCommonAncestor(singleNode, 10, 10)?.value ?? -1
)

// Expected: 10


//==============================================================
// Test 8 - Smaller values
//==============================================================

//        5
//       / \
//      3   8
//     / \
//    1   4

let root2 = buildTree([
    5, 3, 8,
    1, 4
])

print(
    lowestCommonAncestor(root2, 1, 4)?.value ?? -1
)

// Expected: 3
