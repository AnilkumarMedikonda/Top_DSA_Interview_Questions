import Foundation

/*
==============================================================

Pattern : DFS Preorder

==============================================================

Work happens BEFORE the two recursive calls.

Root → Left → Right

The current node is processed FIRST.

That is the whole idea of Preorder —

1. Process Node
2. Traverse Left
3. Traverse Right

Use this pattern when the current node needs to be handled
before visiting its children.

Problems : Q67, Q68

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

    init(value: Int) {
        self.val = value
        self.left = nil
        self.right = nil
    }
}

//==============================================================
// MARK: - Build Binary Tree (Level Order)
//==============================================================

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty,
          let rootValue = values[0] else {
        return nil
    }

    let root = TreeNode(value: rootValue)

    var queue: [TreeNode] = [root]
    var head = 0
    var index = 1

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        // Left Child
        if let leftValue = values[index] {
            let leftNode = TreeNode(value: leftValue)
            current.left = leftNode
            queue.append(leftNode)
        }

        index += 1

        // Right Child
        if index < values.count {
            if let rightValue = values[index] {
                let rightNode = TreeNode(value: rightValue)
                current.right = rightNode
                queue.append(rightNode)
            }

            index += 1
        }
    }

    return root
}

//==============================================================
// MARK: - Template : DFS Preorder
//
// Root -> Left -> Right
//==============================================================

func dfsPreorder(_ node: TreeNode?) {

    guard let node = node else {
        return
    }

    // Process node FIRST
    print(node.val, terminator: " ")

    dfsPreorder(node.left)
    dfsPreorder(node.right)
}

//==============================================================
// MARK: - Trace
//
//             10
//            /  \
//           5    20
//          / \   / \
//         3   7 15  25
//
// Output : 10 5 3 7 20 15 25
//
// Preorder starts at the current node.
//
// 10 → print 10
//    5 → print 5
//      3 → print 3
//      7 → print 7
//    20 → print 20
//      15 → print 15
//      25 → print 25
//
// The node is processed BEFORE going to its children.
//
// That is what "before the recursive calls" means in practice.
//
//==============================================================

//==============================================================
// MARK: - Test
//==============================================================

print("\n========== Pattern 01 - DFS Preorder ==========")

let preorderRoot = buildTree([10, 5, 20, 3, 7, 15, 25])

dfsPreorder(preorderRoot)

print()

// 10 5 3 7 20 15 25
