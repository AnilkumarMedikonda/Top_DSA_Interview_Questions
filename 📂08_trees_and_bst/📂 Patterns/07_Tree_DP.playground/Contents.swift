import Foundation

/*
==============================================================
Pattern : Tree DP
==============================================================

Traversal

Left → Right → Node

(Postorder)

Children compute first.

Parent combines the children's answers.

--------------------------------------------------------------
Two Outputs

1. Return
   • Value sent to the parent.
   • Parent can continue ONLY ONE branch.

2. Update
   • Final answer for the current node.
   • Current node can use BOTH branches.

Return → Parent continues

Update → Final Answer

--------------------------------------------------------------
Used For

• Maximum Depth
• Diameter of Binary Tree
• Balanced Binary Tree
• Maximum Path Sum

Problems

✅ Q66 - Maximum Depth
✅ Q71 - Diameter of Binary Tree
✅ Q74 - Maximum Path Sum

Time  : O(n)
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

    init(value: Int,
         left: TreeNode? = nil,
         right: TreeNode? = nil) {

        self.value = value
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

    let rootNode = TreeNode(value: root)

    var queue = [rootNode]
    var head = 0
    var index = 1

    while head < queue.count && index < values.count {

        let current = queue[head]
        head += 1

        if index < values.count {

            if let value = values[index] {

                let node = TreeNode(value: value)

                current.left = node
                queue.append(node)
            }

            index += 1
        }

        if index < values.count {

            if let value = values[index] {

                let node = TreeNode(value: value)

                current.right = node
                queue.append(node)
            }

            index += 1
        }
    }

    return rootNode
}

//==============================================================
// MARK: - Generic Tree DP Template
//==============================================================

var answer = 0

func dfs(_ node: TreeNode?) -> Int {

    guard let node = node else {
        return 0
    }

    let left = dfs(node.left)

    let right = dfs(node.right)

    // Update final answer
    // answer = ...

    // Return value to parent
    return max(left, right) + 1
}

//==============================================================
// MARK: - Test
//==============================================================

print("========== Pattern 07 - Tree DP ==========")

let root = buildTree([10, 5, 20, 3, 7, 15, 25])

print(dfs(root))
