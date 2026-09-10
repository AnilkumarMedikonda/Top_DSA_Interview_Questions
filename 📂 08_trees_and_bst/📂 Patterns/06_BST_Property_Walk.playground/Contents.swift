import Foundation

/*
==============================================================
Pattern : BST Property Walk
==============================================================

BST Property

Left < Node < Right

Compare once.

↓

Go Left

OR

Go Right

Never search both subtrees.

--------------------------------------------------------------
Templates

1. Search BST
2. Lowest Common Ancestor (BST)

--------------------------------------------------------------
Used For

• Search in BST
• Lowest Common Ancestor
• Validate BST
• Insert into BST
• Delete Node in BST

--------------------------------------------------------------
Problems

✅ Q70 - Validate BST
✅ Q72 - Lowest Common Ancestor BST
✅ Q73 - Kth Smallest Element BST

--------------------------------------------------------------
Same Pattern

LC700 - Search BST
LC701 - Insert BST
LC450 - Delete Node
LC235 - Lowest Common Ancestor BST
LC98  - Validate BST

Time

Balanced BST : O(log n)

Worst Case   : O(n)

Space

Recursive : O(h)

Interview Tip

BST

↓

Compare

↓

Go Left OR Go Right

Never search both sides.

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
// MARK: - Build Tree
//==============================================================

func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty,
          let rootValue = values[0] else {
        return nil
    }

    let root = TreeNode(value: rootValue)

    var queue = [root]
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

    return root
}

//==============================================================
// MARK: - Template 1 : Search BST
//==============================================================

func searchBST(_ node: TreeNode?, _ target: Int) -> Bool {

    guard let node = node else {
        return false
    }

    if node.val == target {
        return true
    }

    if target < node.val {
        return searchBST(node.left, target)
    }

    return searchBST(node.right, target)
}

//==============================================================
// MARK: - Template 2 : Lowest Common Ancestor (BST)
//==============================================================

func lowestCommonAncestor(_ root: TreeNode?,
                          _ p: Int,
                          _ q: Int) -> TreeNode? {

    var current = root

    while let node = current {

        if p < node.val && q < node.val {

            current = node.left

        } else if p > node.val && q > node.val {

            current = node.right

        } else {

            return node
        }
    }

    return nil
}

//==============================================================
// MARK: - Dry Run
//
//            10
//          /    \
//         5      20
//        / \    /  \
//       3   7  15  25
//
// Search 7
//
// 10 -> Left
// 5  -> Right
// 7  -> Found
//
// LCA(3,7)
//
// 10 -> Left
// 5  -> Split
//
// Answer = 5
//
// LCA(3,25)
//
// 10 -> Split
//
// Answer = 10
//
//==============================================================

//==============================================================
// MARK: - Test
//==============================================================

print("========== Pattern 06 - BST Property Walk ==========")

let root = buildTree([10, 5, 20, 3, 7, 15, 25])

print(searchBST(root, 7))
print(searchBST(root, 15))
print(searchBST(root, 100))

print("-----")

if let node = lowestCommonAncestor(root, 3, 7) {
    print(node.val)
}

if let node = lowestCommonAncestor(root, 3, 25) {
    print(node.val)
}

if let node = lowestCommonAncestor(root, 15, 25) {
    print(node.val)
}
