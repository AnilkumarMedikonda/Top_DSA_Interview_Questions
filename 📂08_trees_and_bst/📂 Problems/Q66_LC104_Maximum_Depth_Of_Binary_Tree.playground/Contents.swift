import Foundation

/*
==============================================================
Q66 - LC104 Maximum Depth of Binary Tree
==============================================================

Pattern
✅ Tree DP (Postorder DFS)

Idea

Return the height of each subtree.

Current Node

depth = max(left, right) + 1

Base Case

nil → 0

Traversal

Left → Right → Node

Time  : O(n)
Space : O(h)

Interview Tip

Leaves return 1.
The answer is built from the bottom up.

==============================================================
*/


class TreeNode {
    
    var root: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(root: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.root = root
        self.left = left
        self.right = right
    }
}

func buildTree(_ values: [Int?]) -> TreeNode? {
    
    guard !values.isEmpty, let root = values[0] else { return nil }
    var rootNode = TreeNode(root: root)
    var queue = [rootNode]
    var head = 0
    var index = 1
    
    while head < queue.count, index < values.count {
        var current = queue[head]
        head += 1
        
        if index < values.count {
            
            if let left = values[index] {
                let node = TreeNode(root: left)
                current.left = node
                queue.append(node)
            }
            
            index += 1
        }
        
        if index < values.count {
            
            if let right = values[index] {
                let node = TreeNode(root: right)
                current.right = node
                queue.append(node)
            }
            
            index += 1
        }
        
    }
    
    return rootNode
}


func maxDepth(_ node: TreeNode?) -> Int {

    guard let node = node else { return 0 }

    let left = maxDepth(node.left)
    let right = maxDepth(node.right)

    if left > right {
        return left + 1
    } else {
        return right + 1
    }
}
print("\n========== Q66 - Maximum Depth Of Binary Tree ==========")


//==============================================================
// MARK: - Test Cases
//==============================================================

print("\n========== Q66 - Maximum Depth Of Binary Tree ==========")

//       3
//      / \
//     9  20
//        / \
//       15  7
print(maxDepth(buildTree([3, 9, 20, nil, nil, 15, 7])))
// 3 — the LC104 example

//       1
print(maxDepth(buildTree([1])))
// 1 — single node counts as depth 1, not 0

// (empty)
print(maxDepth(buildTree([])))
// 0

//   1
//  /
// 2
//  \
//   3
//    \
//     4
print(maxDepth(buildTree([1, 2, nil, 3, nil, 4])))
// 4 — skewed, call stack reaches full depth O(n)

//   1
//  / \
// 2   3
print(maxDepth(buildTree([1, 2, 3])))
// 2

// 1
//  \
//   2
//    \
//     3
print(maxDepth(buildTree([1, nil, 2, nil, 3])))
// 3 — right-skewed

//   1
//  /
// 2
print(maxDepth(buildTree([1, 2, nil])))
// 2 — left child only

//       1
//      / \
//     2   3
//    / \ / \
//   4  5 6  7
print(maxDepth(buildTree([1, 2, 3, 4, 5, 6, 7])))
// 3 — full tree

//       1
//      / \
//     2   3
//    / \
//   4   5
//  /
// 6
print(maxDepth(buildTree([1, 2, 3, 4, 5, nil, nil, 6])))
// 4 — deepest path is 1→2→4→6, not down the balanced side
