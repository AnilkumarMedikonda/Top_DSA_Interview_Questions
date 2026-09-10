import Foundation

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
        if index < values.count,
           let leftValue = values[index] {

            let leftNode = TreeNode(value: leftValue)
            current.left = leftNode
            queue.append(leftNode)
        }

        index += 1

        // Right Child
        if index < values.count,
           let rightValue = values[index] {

            let rightNode = TreeNode(value: rightValue)
            current.right = rightNode
            queue.append(rightNode)
        }

        index += 1
    }

    return root
}

//==============================================================
// MARK: - Print Tree
//==============================================================

func printTree(_ node: TreeNode?, _ prefix: String = "", _ isLeft: Bool = true) {

    guard let node = node else {
        print(prefix + (isLeft ? "├── " : "└── ") + ".")
        return
    }

    if prefix.isEmpty {
        print(node.val)
    } else {
        print(prefix + (isLeft ? "├── " : "└── ") + "\(node.val)")
    }

    if node.left == nil && node.right == nil {
        return
    }

    let childPrefix = prefix + (prefix.isEmpty ? "" : (isLeft ? "│   " : "    "))

    printTree(node.left, childPrefix, true)
    printTree(node.right, childPrefix, false)
}

//==============================================================
// MARK: - Example Tree
//==============================================================

/*
                10
              /    \
             5      20
            / \    /  \
           3   7  15  25
*/

let root = buildTree([10, 5, 20, 3, 7, 15, 25])

//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== D1 - TreeNode and buildTree ==========")

if let root = root {

    print("Root:", root.val)                       // 10

    if let left = root.left {
        print("Left Child:", left.val)             // 5

        if let leftLeft = left.left {
            print("Left Left:", leftLeft.val)      // 3
        }

        if let leftRight = left.right {
            print("Left Right:", leftRight.val)    // 7
        }
    }

    if let right = root.right {
        print("Right Child:", right.val)           // 20

        if let rightLeft = right.left {
            print("Right Left:", rightLeft.val)    // 15
        }

        if let rightRight = right.right {
            print("Right Right:", rightRight.val)  // 25
        }
    }
} else {
    print("Root: (empty)")
}

print("\nTree Structure")
print("----------------")

printTree(root)
