import Foundation

/*
==============================================================
Pattern : DFS Postorder
==============================================================

Work happens AFTER both recursive calls.

Left → Right → Node

Fires when information flows UP — the node cannot answer until
it knows what its children returned. A height, a subtree sum,
a "does this subtree qualify" flag.

This is the mirror of preorder:
  preorder  pushes constraints DOWN
  postorder pulls results UP
Choosing between the two is the main skill in this phase.

The base case returns the IDENTITY — the value that leaves the
answer unchanged for an empty subtree. 0 for heights and counts,
Int.min for a maximum. Getting this wrong is the most common way
the template breaks.

Problems : Q66, Q71, Q74

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

    init(value: Int,
         left: TreeNode? = nil,
         right: TreeNode? = nil) {

        self.val = value
        self.left = left
        self.right = right
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

    let rootNode = TreeNode(value: rootValue)

    var queue = [rootNode]
    var head = 0
    var index = 1

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        // Left Child
        if let leftValue = values[index] {
            let node = TreeNode(value: leftValue)
            current.left = node
            queue.append(node)
        }

        index += 1

        // Right Child
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
// MARK: - Template 1 : Plain Postorder
// Left -> Right -> Node. Nothing comes back.
//==============================================================

func dfsPostorder(_ node: TreeNode?) {

    guard let node = node else {
        return
    }

    dfsPostorder(node.left)
    dfsPostorder(node.right)

    // process node here — both children are already done
    print(node.val, terminator: " ")
}

//==============================================================
// MARK: - Template 2 : Postorder With Return Value
// The parent waits for both children, then computes its answer.
// This is the form that earns postorder its place.
//==============================================================

func treeHeight(_ node: TreeNode?) -> Int {

    guard let node = node else {
        return 0
    }

    let leftHeight = treeHeight(node.left)
    let rightHeight = treeHeight(node.right)

    if leftHeight > rightHeight {
        return leftHeight + 1
    } else {
        return rightHeight + 1
    }
}

//==============================================================
// MARK: - Trace
//
//         10
//        /  \
//       5    20
//      / \   / \
//     3   7 15  25
//
// Template 1 output : 3 7 5 15 25 20 10
//
//   10  → go left, print nothing yet
//     5  → go left, print nothing yet
//       3  → both children nil, print 3, return
//       7  → both children nil, print 7, return
//     5  → both children done, print 5, return
//    20  → go left
//      15  → print 15, return
//      25  → print 25, return
//    20  → both children done, print 20, return
//   10  → both subtrees done, print 10
//
// The root prints LAST. Every child finishes before its parent
// is touched — which is exactly why the parent can use what
// they returned.
//
// treeHeight on the same tree returns 3:
//
//   3 and 7 and 15 and 25 → return 1 (leaves)
//   5 and 20              → return 1 + 1 = 2
//   10                    → return 2 + 1 = 3
//
//==============================================================

//==============================================================
// MARK: - Test
//==============================================================

print("\n========== Pattern 03 - DFS Postorder ==========")

let postorderRoot = buildTree([10, 5, 20, 3, 7, 15, 25])

dfsPostorder(postorderRoot)
print()
// 3 7 5 15 25 20 10

print(treeHeight(postorderRoot))
// 3

print(treeHeight(buildTree([1])))
// 1 — single node counts as height 1, not 0

print(treeHeight(buildTree([])))
// 0 — empty tree

print(treeHeight(buildTree([1, 2, nil, 3, nil, 4])))
// 4 — left-skewed stick, every level adds one
