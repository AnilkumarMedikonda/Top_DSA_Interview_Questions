import Foundation

/*
==============================================================
Pattern : DFS Inorder
==============================================================

Work happens BETWEEN the two recursive calls.

Left → Node → Right

On a BST, inorder emits values in SORTED ASCENDING ORDER.
That single fact is the whole reason this pattern exists —
it is the solution to Q70 and Q73.

On a non-BST, inorder is just an arbitrary visit order with no
special meaning. Reach for it only when the tree is a BST and
the answer depends on sorted order.

Limitation : recursive inorder always walks the entire tree.
When you need to STOP partway — the kth value, the first match —
the recursion cannot be interrupted. See Pattern 05, Iterative DFS.

Problems : Q70, Q73

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
// MARK: - Template : DFS Inorder
// Left -> Node -> Right
//==============================================================

func dfsInorder(_ node: TreeNode?) {

    guard let node = node else {
        return
    }

    dfsInorder(node.left)

    // process node here — on a BST, values arrive sorted
    print(node.val, terminator: " ")

    dfsInorder(node.right)
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
// Output : 3 5 7 10 15 20 25
//
// Sorted. That is not a coincidence — it is the BST invariant
// read out loud. Everything left of a node is smaller, so it
// all gets printed first; everything right is larger, so it
// all comes after.
//
// Descent order — the node is printed on the way BACK UP from
// its left subtree, not on the way in:
//
//   10  → go left first, print nothing yet
//     5  → go left first, print nothing yet
//       3  → left is nil, print 3, right is nil, return
//     5  → print 5, go right
//       7  → print 7, return
//   10  → left subtree done, print 10, go right
//    20  → go left first
//      15  → print 15, return
//    20  → print 20, go right
//      25  → print 25, return
//
// The whole left subtree finishes before the node is touched.
// That is what "between the calls" means in practice.
//==============================================================

//==============================================================
// MARK: - Test
//==============================================================

print("\n========== Pattern 02 - DFS Inorder ==========")

let inorderRoot = buildTree([10, 5, 20, 3, 7, 15, 25])

dfsInorder(inorderRoot)
print()
// 3 5 7 10 15 20 25 — sorted, because this tree is a BST

let notABST = buildTree([5, 3, 8, nil, nil, 2, 9])

dfsInorder(notABST)
print()
// 3 5 2 8 9 — NOT sorted, and that is exactly how Q70 detects it
