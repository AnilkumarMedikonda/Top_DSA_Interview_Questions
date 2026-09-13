import Foundation

/*
==============================================================
Q70 - LC098 Validate Binary Search Tree
==============================================================

Problem

Given the root of a binary tree, determine whether it is a valid
binary search tree.

A valid BST requires, at EVERY node:
  every value in the ENTIRE left subtree  < node value
  every value in the ENTIRE right subtree > node value

Example

    2
   / \
  1   3

Input  : [2, 1, 3]
Output : true

    5
   / \
  1   4
     / \
    3   6

Input  : [5, 1, 4, nil, nil, 3, 6]
Output : false — 3 is in 5's right subtree but is smaller than 5

Constraints

- Number of nodes in [1, 10^4]
- -2^31 <= Node.val <= 2^31 - 1

Pattern

01 — DFS Preorder + 06 — BST Property Walk

Why preorder: the valid RANGE flows DOWN. Each node checks itself
against the bounds it was handed, then narrows them for its
children. Nothing comes back up except a yes/no.

THE TRAP

The common wrong model is "left child smaller, right child bigger",
which is a LOCAL check:

        5
       / \
      3   8
         / \
        2   9

Every parent/child pair passes. NOT a BST — 2 sits inside 5's
right subtree and must exceed 5. A local check cannot see this;
the constraint lives two levels up. That is why the range has to
be carried down rather than recomputed at each node.

Brute force

Inorder into an array, then check it is strictly ascending.
Named, not implemented — it is also O(n) time, so it loses on
SPACE only: O(n) for the array versus O(h) for the call stack.
Same traversal, worse footprint.

Why optional bounds, not Int.min / Int.max

LC098 allows node values at the integer extremes. A sentinel of
Int.min breaks the moment a node actually holds Int.min. Optionals
say "no bound yet" without borrowing a real value to mean it.

Strict inequality

<= and >= , not < and > . Duplicates are invalid in a BST, so a
node equal to a bound must fail.

Signature note

The bounds are default parameters, so isValidBST(root) matches
LeetCode's one-argument signature while the recursive calls supply
the range. A nested helper would also work; that shape becomes
necessary in Q71 and Q74, where a value must persist across every
call and a default parameter cannot hold one.

Time  : O(n) — every node visited once, short-circuits on the
        first violation
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

    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.val = value
        self.left = left
        self.right = right
    }
}

//==============================================================
// MARK: - Build Binary Tree (Level Order)
//==============================================================

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

//==============================================================
// MARK: - Solution
//==============================================================

func isValidBST(_ node: TreeNode?,
                minValue: Int? = nil,
                maxValue: Int? = nil) -> Bool {

    guard let node = node else { return true }

    if let minValue = minValue, node.val <= minValue {
        return false
    }

    if let maxValue = maxValue, node.val >= maxValue {
        return false
    }

    // left inherits the floor, gets this node as its new ceiling
    // right inherits the ceiling, gets this node as its new floor
    return isValidBST(node.left, minValue: minValue, maxValue: node.val)
        && isValidBST(node.right, minValue: node.val, maxValue: maxValue)
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print("\n========== Q70 - Validate Binary Search Tree ==========")

//   2
//  / \
// 1   3
print(isValidBST(buildTree([2, 1, 3])))
// true

//     5
//    / \
//   1   4
//      / \
//     3   6
print(isValidBST(buildTree([5, 1, 4, nil, nil, 3, 6])))
// false — 3 and 4 are in 5's right subtree but smaller than 5

//      5
//     / \
//    3   8
//       / \
//      2   9
print(isValidBST(buildTree([5, 3, 8, nil, nil, 2, 9])))
// false — THE TRAP. Every parent/child pair is fine; 2 is not.

//       10
//      /  \
//     5    20
//    / \   / \
//   3   7 15  25
print(isValidBST(buildTree([10, 5, 20, 3, 7, 15, 25])))
// true — valid at every level

print(isValidBST(buildTree([1])))
// true — single node

print(isValidBST(buildTree([])))
// true — empty tree is vacuously valid

//   2
//  / \
// 2   2
print(isValidBST(buildTree([2, 2, 2])))
// false — duplicates fail; this is why <= and >= , not < and >

// 1
//  \
//   2
//    \
//     3
print(isValidBST(buildTree([1, nil, 2, nil, 3])))
// true — right-skewed but valid; O(h) becomes O(n) here

//       10
//      /  \
//     5    20
//         /  \
//        9    25
print(isValidBST(buildTree([10, 5, 20, nil, nil, 9, 25])))
// false — 9 clears its parent 20 but not its grandparent 10
