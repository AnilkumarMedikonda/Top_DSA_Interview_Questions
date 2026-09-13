import Foundation

/*
==============================================================

Pattern : DFS Postorder

==============================================================

Work happens AFTER both recursive calls.

Left → Right → Node

Information flows UP.

The node cannot calculate its answer until it knows what
its children returned.

This is the mirror of Preorder:

Preorder  → pushes information DOWN
Postorder → pulls information UP

Typical examples:
- Height
- Diameter
- Maximum Path Sum
- Subtree calculations

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
//
// Left -> Right -> Node
//==============================================================

func dfsPostorder(_ node: TreeNode?) {

    guard let node = node else {
        return
    }

    dfsPostorder(node.left)
    dfsPostorder(node.right)

    // Process Node LAST
    print(node.val, terminator: " ")
}

//==============================================================
// MARK: - Template 2 : Postorder With Return Value
//
// Children return information.
// Parent uses that information.
//==============================================================

func treeHeight(_ node: TreeNode?) -> Int {

    guard let node = node else {
        return 0
    }

    let leftHeight = treeHeight(node.left)
    let rightHeight = treeHeight(node.right)

    return max(leftHeight, rightHeight) + 1
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
// Postorder:
// Left → Right → Node
//
// Output:
// 3 7 5 15 25 20 10
//
// 10 → go left
//   5 → go left
//     3 → print 3
//     7 → print 7
//   5 → print 5
//
// 10 → go right
//   20 → go left
//     15 → print 15
//     25 → print 25
//   20 → print 20
//
// 10 → both subtrees done
// 10 → print 10
//
// Root prints LAST.
//
//==============================================================

//==============================================================
// MARK: - Test
//==============================================================

print("\n========== Pattern 03 - DFS Postorder ==========")

let postorderRoot = buildTree([10, 5, 20, 3, 7, 15, 25])

dfsPostorder(postorderRoot)
print()
// Output: 3 7 5 15 25 20 10

print(treeHeight(postorderRoot))
// 3

print(treeHeight(buildTree([1])))
// 1

print(treeHeight(buildTree([])))
// 0

print(treeHeight(buildTree([1, 2, nil, 3, nil, 4])))
// 4
