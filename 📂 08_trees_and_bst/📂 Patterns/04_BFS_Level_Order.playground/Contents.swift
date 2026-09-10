import Foundation

/*
==============================================================
Pattern : BFS Level Order
==============================================================

Traversal

Level by Level

Top → Bottom

Left → Right

Uses

Queue (FIFO)

Best Used For

• Binary Tree Level Order Traversal
• Right Side View
• Zigzag Level Order
• Average of Levels
• Minimum Depth

Problems

✅ Q69 - Binary Tree Level Order Traversal

Same BFS Skeleton Used In

✅ LC102 - Binary Tree Level Order Traversal
✅ LC103 - Zigzag Level Order
✅ LC107 - Level Order Bottom
✅ LC199 - Binary Tree Right Side View
✅ LC637 - Average of Levels

Time  : O(n)
Space : O(n)

Interview Tip

If the question mentions

• Level
• Layer
• Distance

Think

BFS + Queue

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
// MARK: - Template : BFS Level Order
// Head-index queue. Level size snapshotted before draining.
//==============================================================

func levelOrder(_ root: TreeNode?) {

    guard let root = root else {
        return
    }

    var queue = [root]
    var head = 0

    while head < queue.count {

        let levelSize = queue.count - head
        var drained = 0

        print("Level:", terminator: " ")

        while drained < levelSize {

            let current = queue[head]
            head += 1

            // process node here
            print(current.val, terminator: " ")

            if let left = current.left {
                queue.append(left)
            }

            if let right = current.right {
                queue.append(right)
            }

            drained += 1
        }

        print()
    }
}

//==============================================================
// MARK: - Trace
//
//          10
//        /    \
//       5      20
//      / \    /  \
//     3   7  15  25
//
// head=0  queue=[10]                 levelSize=1  → print 10
// head=1  queue=[10,5,20]            levelSize=2  → print 5 20
// head=3  queue=[10,5,20,3,7,15,25]  levelSize=4  → print 3 7 15 25
// head=7  queue.count=7              loop ends
//
// The queue never shrinks — head walks forward through it.
// levelSize is always count-minus-head, which is exactly the
// nodes enqueued by the previous level and not yet drained.
//
// Output
//
// Level: 10
// Level: 5 20
// Level: 3 7 15 25
//
//==============================================================

//==============================================================
// MARK: - Test
//==============================================================

print("\n========== Pattern 04 - BFS Level Order ==========")

let levelOrderRoot = buildTree([10, 5, 20, 3, 7, 15, 25])

levelOrder(levelOrderRoot)
// Level: 10
// Level: 5 20
// Level: 3 7 15 25

levelOrder(buildTree([1, 2, nil, 3, nil, 4]))
// Level: 1
// Level: 2
// Level: 3
// Level: 4

levelOrder(buildTree([1]))
// Level: 1

levelOrder(buildTree([]))
// nothing printed
