import Foundation

/*
==============================================================
Pattern : DFS Preorder
==============================================================

Root → Left → Right

Work happens BEFORE the two recursive calls.

Process the current node first, then:
1. Traverse Left
2. Traverse Right

Useful when the parent/current node must be processed
before visiting its children.

Problems:
Q67 - Same Tree
Q68 - Invert Binary Tree

Time  : O(n)
Space : O(h)

==============================================================
*/

// MARK: - TreeNode

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

// MARK: - Build Binary Tree

func buildTree(_ values: [Int?]) -> TreeNode? {
    guard !values.isEmpty, let rootValue = values[0] else {
        return nil
    }

    let root = TreeNode(value: rootValue)
    var queue: [TreeNode] = [root]
    var head = 0
    var index = 1

    while head < queue.count && index < values.count {
        let current = queue[head]
        head += 1

        if let leftValue = values[index] {
            let leftNode = TreeNode(value: leftValue)
            current.left = leftNode
            queue.append(leftNode)
        }

        index += 1

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

// MARK: - Template: DFS Preorder
// Root → Left → Right

func dfsPreorder(_ node: TreeNode?) {
    guard let node = node else {
        return
    }

    // Process Node first
    print(node.val, terminator: " ")

    dfsPreorder(node.left)
    dfsPreorder(node.right)
}

// MARK: - Test

print("\n========== Pattern 01 - DFS Preorder ==========")
dfsPreorder(buildTree([10, 5, 20, 3, 7, 15, 25]))
print()
// Output: 10 5 3 7 20 15 25
