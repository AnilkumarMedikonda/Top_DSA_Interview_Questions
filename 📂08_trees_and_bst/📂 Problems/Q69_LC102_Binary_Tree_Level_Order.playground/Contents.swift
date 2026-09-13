import Foundation

/*
==============================================================
Q69 - LC102 Binary Tree Level Order Traversal
==============================================================

Problem

Given the root of a binary tree, return the level order traversal
of its nodes' values — left to right, level by level, as an array
of arrays.

Example

      3
     / \
    9  20
       / \
      15  7

Input  : [3, 9, 20, nil, nil, 15, 7]
Output : [[3], [9, 20], [15, 7]]

Constraints

- Number of nodes in [0, 2000]
- -1000 <= Node.val <= 1000

Pattern

04 — BFS Level Order

Brute force : none. Recursion cannot express this — DFS goes down
one branch fully before touching the next, so it never has a whole
level in hand. The queue is not an optimisation, it is the only
way to do it.

Idea

Queue plus a level-size SNAPSHOT taken before draining. Without
the snapshot you drain into the next level and lose the grouping
entirely.

Head index instead of removeFirst() — removeFirst() on a Swift
array is O(n), which would make the whole traversal O(n²).

Time  : O(n) — every node enqueued and dequeued once
Space : O(w) — the widest level; up to n/2 at the bottom of a
        full tree, so O(n) as a bound. A skewed tree holds one
        node per level, so it is cheap there.

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

func levelOrder(_ root: TreeNode?) -> [[Int]] {

    guard let root = root else { return [] }

    var queue = [root]
    var head = 0
    var result = [[Int]]()

    while head < queue.count {

        // snapshot BEFORE draining — this is what separates levels
        let levelSize = queue.count - head
        var levelArray = [Int]()

        for _ in 0..<levelSize {

            let node = queue[head]
            head += 1

            levelArray.append(node.val)

            if let left = node.left {
                queue.append(left)
            }

            if let right = node.right {
                queue.append(right)
            }
        }

        result.append(levelArray)
    }

    return result
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print("\n========== Q69 - Binary Tree Level Order Traversal ==========")

//       3
//      / \
//     9  20
//        / \
//       15  7
print(levelOrder(buildTree([3, 9, 20, nil, nil, 15, 7])))
// [[3], [9, 20], [15, 7]]

//   1
//  / \
// 2   3
print(levelOrder(buildTree([1, 2, 3])))
// [[1], [2, 3]]

print(levelOrder(buildTree([1])))
// [[1]]

print(levelOrder(buildTree([])))
// []

//   1
//  /
// 2
//  \
//   3
//    \
//     4
print(levelOrder(buildTree([1, 2, nil, 3, nil, 4])))
// [[1], [2], [3], [4]] — one node per level, queue never holds more than one

//       1
//      / \
//     2   3
//    / \ / \
//   4  5 6  7
print(levelOrder(buildTree([1, 2, 3, 4, 5, 6, 7])))
// [[1], [2, 3], [4, 5, 6, 7]] — widest level is n/2, the O(w) worst case

//     1
//    / \
//   2   3
//  /     \
// 4       5
print(levelOrder(buildTree([1, 2, 3, 4, nil, nil, 5])))
// [[1], [2, 3], [4, 5]] — gaps in the middle of a level close up
