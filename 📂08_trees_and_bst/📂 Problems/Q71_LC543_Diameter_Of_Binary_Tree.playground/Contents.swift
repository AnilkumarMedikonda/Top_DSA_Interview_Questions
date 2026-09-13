import Foundation

/*
==============================================================
Q71 - LC543 Diameter of Binary Tree
==============================================================

Problem

Given the root of a binary tree, return the length of its
diameter — the longest path between ANY two nodes, measured in
EDGES. The path need not pass through the root.

Example

      1
     / \
    2   3
   / \
  4   5

Input  : [1, 2, 3, 4, 5]
Output : 3 — the path 4 → 2 → 5 → 1 → 3 has three edges

Constraints

- Number of nodes in [1, 10^4]
- -100 <= Node.val <= 100

Pattern

07 — Tree DP

Brute force : none. Every node has to be visited to know which
subtree holds the longest path, so O(n) is the floor.

THE SPLIT

At every node, two DIFFERENT values:

  RETURN  max(left, right) + 1
          Your parent extends a path THROUGH you, and a path
          cannot fork. Only one branch can continue upward.

  RECORD  left + right
          That path ends at you and goes no further, so it is
          free to use both sides.

Returning left + right instead would let a parent build a path
that forks at you — not a path. This is the mistake Q74 punishes
harder, which is why Q71 comes first.

EDGES, NOT NODES

LC543 counts edges, so left + right needs no + 1 and a single
node has diameter 0. Q66 counts NODES, where a single node is
depth 1. Same tree, opposite conventions — do not carry one
into the other.

The answer is NOT necessarily through the root. See the last
test case.

Time  : O(n) — every node visited once
Space : O(h) — call stack; O(log n) balanced, O(n) skewed

==============================================================
*/

//==============================================================
// MARK: - TreeNode
//==============================================================

final class TreeNode {

    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = value
        self.left = left
        self.right = right
    }
}

//==============================================================
// MARK: - Build Binary Tree (Level Order)
//==============================================================

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let rootValue = values[0] else { return nil }

    let rootNode = TreeNode(value: rootValue)
    var queue = [rootNode]
    var head = 0
    var index = 1

    while head < queue.count, index < values.count {

        let current = queue[head]
        head += 1

        if let leftValue = values[index] {
            let node = TreeNode(value: leftValue)
            current.left = node
            queue.append(node)
        }

        index += 1

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

func diameterOfBinaryTree(_ root: TreeNode?) -> Int {

    var diameter = 0

    func dfs(_ node: TreeNode?) -> Int {

        guard let node = node else { return 0 }

        let leftHeight = dfs(node.left)
        let rightHeight = dfs(node.right)

        // RECORD — both branches, the path ends here
        let currentPath = leftHeight + rightHeight

        if currentPath > diameter {
            diameter = currentPath
        }

        // RETURN — one branch only, the parent extends through us
        if leftHeight > rightHeight {
            return leftHeight + 1
        } else {
            return rightHeight + 1
        }
    }

    _ = dfs(root)

    return diameter
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print("\n========== Q71 - Diameter Of Binary Tree ==========")

//      1
//     / \
//    2   3
//   / \
//  4   5
print(diameterOfBinaryTree(buildTree([1, 2, 3, 4, 5])))
// 3 — path 4 → 2 → 5 → 1 → 3

//   1
//  /
// 2
print(diameterOfBinaryTree(buildTree([1, 2])))
// 1 — one edge

print(diameterOfBinaryTree(buildTree([1])))
// 0 — single node has no edges

print(diameterOfBinaryTree(buildTree([])))
// 0 — empty tree

//       1
//      / \
//     2   3
//    / \
//   4   5
//  /
// 6
print(diameterOfBinaryTree(buildTree([1, 2, 3, 4, 5, nil, nil, 6])))
// 4 — path 6 → 4 → 2 → 5, never touches the root

//   1
//  /
// 2
//  \
//   3
//    \
//     4
print(diameterOfBinaryTree(buildTree([1, 2, nil, 3, nil, 4])))
// 3 — a stick, so the diameter is the stick itself

//       10
//      /  \
//     5    20
//    / \   / \
//   3   7 15  25
print(diameterOfBinaryTree(buildTree([10, 5, 20, 3, 7, 15, 25])))
// 4 — 3 → 5 → 10 → 20 → 15
