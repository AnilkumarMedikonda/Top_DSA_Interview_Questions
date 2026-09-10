import Foundation

/*
==============================================================
Q67 - LC100 Same Tree
==============================================================

Problem

Given the roots of two binary trees p and q, return true if they
are the same tree — identical in structure AND in node values.

Example

    1         1
   / \       / \
  2   3     2   3

Input  : p = [1, 2, 3], q = [1, 2, 3]
Output : true

    1         1
   /           \
  2             2

Input  : p = [1, 2], q = [1, nil, 2]
Output : false — same values, different structure

Constraints

- Number of nodes in each tree in [0, 100]
- -10^4 <= Node.val <= 10^4

Pattern

01 — DFS Preorder

Why preorder: the node is compared BEFORE descending, and each
recursive call is handed a PAIR of nodes. The second tree is the
state flowing down — same Pattern 01 shape, with a TreeNode? as
the state instead of an Int.

Brute force : none. Both trees must be walked in the worst case.
The && short-circuits, so a mismatch high up exits early without
touching the rest — that is a real property of the solution, not
a separate algorithm.

Idea

Three-way base case, and the asymmetry is the trap:

  both nil      → true   (two empty subtrees match)
  exactly one nil → false (structure differs)
  values differ → false

Otherwise recurse into left pair AND right pair.

Time  : O(n) — n is the smaller tree; the walk stops as soon as
        one side runs out
Space : O(h) — call stack, h being the height of the SHALLOWER
        tree; O(log n) balanced, O(n) skewed

==============================================================
*/


final class TreeNode {

    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = value
        self.left = left
        self.right = right
    }
}


func buildTree(_ values: [Int?]) -> TreeNode? {

    guard !values.isEmpty, let rootValue = values[0] else { return nil }

    let rootNode = TreeNode(value: rootValue)
    var queue = [rootNode]
    var head = 0
    var index = 1

    while head < queue.count, index < values.count {

        let current = queue[head]
        head += 1

        if let leftValue = values[index] {
            let node = TreeNode(value: leftValue)
            current.left = node
            queue.append(node)
        }

        index += 1

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

func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {

    if p == nil && q == nil {
        return true
    }

    guard let p = p, let q = q else {
        return false
    }

    if p.val != q.val {
        return false
    }

    return isSameTree(p.left, q.left) && isSameTree(p.right, q.right)
}


print("\n========== Q67 - Same Tree ==========")

//   1       1
//  / \     / \
// 2   3   2   3
print(isSameTree(buildTree([1, 2, 3]), buildTree([1, 2, 3])))
// true

//   1       1
//  /         \
// 2           2
print(isSameTree(buildTree([1, 2]), buildTree([1, nil, 2])))
// false — same values, mirrored structure

//   1       1
//  / \     / \
// 2   1   1   2
print(isSameTree(buildTree([1, 2, 1]), buildTree([1, 1, 2])))
// false — same multiset of values, different arrangement

// (empty) vs (empty)
print(isSameTree(buildTree([]), buildTree([])))
// true

print(isSameTree(buildTree([1]), buildTree([1])))
// true

print(isSameTree(buildTree([1]), buildTree([2])))
// false — single node, values differ

print(isSameTree(buildTree([1, 2, 3, 4, 5]), buildTree([1, 2, 3, 4, 5])))
// true

//     1         1
//    / \       / \
//   2   3     2   3
//  /            \
// 4              4
print(isSameTree(buildTree([1, 2, 3, 4]), buildTree([1, 2, 3, nil, 4])))
// false — 4 is a left child in one, a right child in the other

print(isSameTree(buildTree([1, 2, 3]), buildTree([])))
// false — one empty, one not
