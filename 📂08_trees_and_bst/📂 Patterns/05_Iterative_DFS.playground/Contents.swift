import Foundation

/*
==============================================================
Pattern : Iterative DFS
==============================================================

Traversal

Node → Left → Right

Uses

Stack (LIFO)

Push Right First
Push Left Second

Reason

Stack is Last In First Out.

Right is pushed first,
so Left is processed first.

Problems

✅ LC144 - Binary Tree Preorder Traversal

Time  : O(n)
Space : O(h)

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

//==============================================================
// MARK: - Template : Iterative Preorder
// Simpler, but recursion does the same job. Included for contrast.
//==============================================================

func iterativePreorder(_ root: TreeNode?) {

    guard let root = root else {
        return
    }

    var stack = [root]

    while !stack.isEmpty {

        let current = stack.removeLast()

        // process node here
        print(current.val, terminator: " ")

        // right pushed FIRST so left pops first
        if let right = current.right {
            stack.append(right)
        }

        if let left = current.left {
            stack.append(left)
        }
    }

    print()
}

// MARK: - Template : Iterative Inorder
// Walk left while pushing, pop, then step right once.
// This is the one that can stop early.
//==============================================================

func iterativeInorder(_ root: TreeNode?) {

    var stack: [TreeNode] = []
    var current = root

    while current != nil || !stack.isEmpty {

        // dive as far left as possible, remembering the path
        while let node = current {
            stack.append(node)
            current = node.left
        }

        let node = stack.removeLast()

        // process node here — on a BST, values arrive sorted
        // a `break` placed here is what makes early exit possible
        print(node.val, terminator: " ")

        // the left subtree is finished, so step right exactly once
        current = node.right
    }

    print()
}



//==============================================================
// MARK: - Trace : Iterative Inorder
//
//         10
//        /  \
//       5    20
//      / \   / \
//     3   7 15  25
//
// stack []          current=10  → dive left
// stack [10,5,3]    current=nil → pop 3,  print 3,  current=nil
// stack [10,5]                  → pop 5,  print 5,  current=7
// stack [10,7]      current=nil → pop 7,  print 7,  current=nil
// stack [10]                    → pop 10, print 10, current=20
// stack [20,15]     current=nil → pop 15, print 15, current=nil
// stack [20]                    → pop 20, print 20, current=25
// stack [25]        current=nil → pop 25, print 25, current=nil
// stack []          current=nil → loop ends
//
// Output : 3 5 7 10 15 20 25 — sorted
//
// The outer condition needs BOTH parts. At the start the stack
// is empty but current is not. After every leaf, current is nil
// but the stack still holds ancestors waiting to be processed.
//
// No `guard let root` is needed — a nil root fails both
// conditions and the loop never runs.
//==============================================================

//==============================================================
// MARK: - Test
//==============================================================

print("\n========== Pattern 05 - Iterative DFS ==========")

let iterativeRoot = buildTree([10, 5, 20, 3, 7, 15, 25])

iterativeInorder(iterativeRoot)
// 3 5 7 10 15 20 25

iterativePreorder(iterativeRoot)
// 10 5 3 7 20 15 25

iterativeInorder(buildTree([1, 2, nil, 3, nil, 4]))
// 4 3 2 1 — left-skewed stick, stack reaches full depth

iterativeInorder(buildTree([]))
// prints an empty line, no crash
