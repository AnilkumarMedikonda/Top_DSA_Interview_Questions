import Foundation

/*
==============================================================
Q73 - LC230 Kth Smallest Element in a BST
==============================================================

Problem

Given the root of a BST and an integer k, return the
k-th smallest value in the BST.

Example

          3
         / \
        1   4
         \
          2

Inorder:
1 → 2 → 3 → 4

If k = 2

Output:
2

Pattern

02 — DFS Inorder
06 — BST Property

Key Idea

Inorder traversal of a BST gives values in sorted
ascending order.

Inorder:
Left → Node → Right

Therefore:

1st visited node → 1st smallest
2nd visited node → 2nd smallest
3rd visited node → 3rd smallest
...

We decrease k whenever we visit a node.

When k == 0:
Current node is the answer.

Time  : O(h + k)
Space : O(h)

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

func kthSmallestElement( _ treeNode: TreeNode?, k: Int) -> Int {

    var k = k
    var answer = 0

    func dfsInorder(_ treeNode: TreeNode?) {

        guard let node = treeNode else {
            return
        }

        // Left
        dfsInorder(node.left)

        // Node
        k -= 1

        if k == 0 {
            answer = node.value
            return
        }

        // Right
        dfsInorder(node.right)
    }

    dfsInorder(treeNode)

    return answer
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print("\n========== Q73 - Kth Smallest Element BST ==========")

//==============================================================
// Test 1
//==============================================================

//        3
//       / \
//      1   4
//       \
//        2
//
// Inorder:
// 1 → 2 → 3 → 4

let root1 = buildTree([
    3, 1, 4,
    nil, 2
])

print(kthSmallestElement(root1, k: 1))
// Expected: 1

print(kthSmallestElement(root1, k: 2))
// Expected: 2

print(kthSmallestElement(root1, k: 3))
// Expected: 3

print(kthSmallestElement(root1, k: 4))
// Expected: 4


//==============================================================
// Test 2
//==============================================================

//          5
//         / \
//        3   6
//       / \
//      2   4
//     /
//    1
//
// Inorder:
// 1 → 2 → 3 → 4 → 5 → 6

let root2 = buildTree([
    5, 3, 6,
    2, 4,
    1
])

print(kthSmallestElement(root2, k: 1))
// Expected: 1

print(kthSmallestElement(root2, k: 3))
// Expected: 3

print(kthSmallestElement(root2, k: 5))
// Expected: 5

print(kthSmallestElement(root2, k: 6))
// Expected: 6


//==============================================================
// Test 3 - Single Node
//==============================================================

let root3 = buildTree([10])

print(kthSmallestElement(root3, k: 1))
// Expected: 10


//==============================================================
// Test 4 - Right Skewed BST
//==============================================================

// 1
//  \
//   2
//    \
//     3
//      \
//       4

let root4 = buildTree([
    1,
    nil, 2,
    nil, 3,
    nil, 4
])

print(kthSmallestElement(root4, k: 3))
// Expected: 3


//==============================================================
// Test 5 - Left Skewed BST
//==============================================================

//       4
//      /
//     3
//    /
//   2
//  /
// 1

let root5 = buildTree([
    4, 3,
    2, nil,
    1
])

print(kthSmallestElement(root5, k: 2))
// Expected: 2


//==============================================================
// Test 6 - Balanced BST
//==============================================================

//          8
//        /   \
//       4     12
//      / \   /  \
//     2   6 10  14
//
// Inorder:
// 2 → 4 → 6 → 8 → 10 → 12 → 14

let root6 = buildTree([
    8, 4, 12,
    2, 6, 10, 14
])

print(kthSmallestElement(root6, k: 4))
// Expected: 8

print(kthSmallestElement(root6, k: 7))
// Expected: 14
