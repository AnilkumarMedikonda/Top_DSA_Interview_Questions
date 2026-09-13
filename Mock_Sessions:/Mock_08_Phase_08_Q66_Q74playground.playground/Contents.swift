import Foundation

/*
==============================================================
TREE & BST — MOCK INTERVIEW SESSION
==============================================================

Goal:
Revise and implement the OPTIMAL solution for every problem.

Rules:
1. Use only the optimal solution.
2. No brute-force solution unless specifically asked.
3. No hints during the problem.
4. Explain approach before coding.
5. Write the complete solution yourself.
6. TreeNode + Build Tree are reusable helpers.
7. Run all test cases.
8. Explain Time & Space Complexity after coding.
9. Follow-up interview questions may be asked.

Problems:
Q66 → Maximum Depth of Binary Tree
Q67 → Same Tree
Q68 → Invert Binary Tree
Q69 → Binary Tree Level Order Traversal
Q70 → Validate Binary Search Tree
Q71 → Diameter of Binary Tree
Q72 → Lowest Common Ancestor of BST
Q73 → Kth Smallest Element in BST
Q74 → Binary Tree Maximum Path Sum


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
// MARK: - Build Tree
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

        // Left
        if let leftValue = values[index] {
            let node = TreeNode(value: leftValue)
            current.left = node
            queue.append(node)
        }

        index += 1

        // Right
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
// MARK: - Q66_LC104_Maximum_Depth_Of_Binary_Tree
//==============================================================

/*
LeetCode : 104

Given the root of a binary tree, return its maximum depth —
the number of NODES along the longest path from the root down
to the farthest leaf.

Counts nodes, not edges: a single node is depth 1.

Pattern : 03 — DFS Postorder
Time    : O(n)
Space   : O(h) — O(log n) balanced, O(n) skewed
*/

func maxDepth(_ root: TreeNode?) -> Int {

    guard let node = root else { return 0 }

    let left = maxDepth(node.left)
    let right = maxDepth(node.right)

    if left > right {
        return left + 1
    } else {
        return right + 1
    }
}

print("\n========== Q66_LC104_Maximum_Depth_Of_Binary_Tree ==========")

print(maxDepth(buildTree([3, 9, 20, nil, nil, 15, 7]))) // Expected: 3
print(maxDepth(buildTree([1, nil, 2]))) // Expected: 2
print(maxDepth(buildTree([1]))) // Expected: 1
print(maxDepth(buildTree([]))) // Expected: 0
print(maxDepth(buildTree([1, 2, 3, 4, 5, 6, 7]))) // Expected: 3
print(maxDepth(buildTree([1, 2, nil, 3, nil, 4]))) // Expected: 4

//==============================================================
// MARK: - Q67_LC100_Same_Tree
//==============================================================

/*
LeetCode : 100

Given the roots of two binary trees p and q, determine if they
are structurally identical with the same node values.

Three-way base case — both nil, exactly one nil, values differ.
The asymmetry is the trap.

Pattern : 01 — DFS Preorder
Time    : O(n)
Space   : O(h) — h is the height of the SHALLOWER tree
*/

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

print("\n========== Q67_LC100_Same_Tree ==========")

print(isSameTree(buildTree([1, 2, 3]), buildTree([1, 2, 3]))) // Expected: true
print(isSameTree(buildTree([1, 2]), buildTree([1, nil, 2]))) // Expected: false
print(isSameTree(buildTree([1, 2, 1]), buildTree([1, 1, 2]))) // Expected: false
print(isSameTree(buildTree([]), buildTree([]))) // Expected: true
print(isSameTree(buildTree([1]), buildTree([1]))) // Expected: true
print(isSameTree(buildTree([1]), buildTree([2]))) // Expected: false
print(isSameTree(buildTree([1, 2, 3]), buildTree([]))) // Expected: false

//==============================================================
// MARK: - Q68_LC226_Invert_Binary_Tree
//==============================================================

/*
LeetCode : 226

Invert the tree — swap the left and right children of every node.

        4                    4
       / \                  / \
      2   7       →        7   2
     / \ / \              / \ / \
    1  3 6  9            9  6 3  1

Pattern : 01 — DFS Preorder
Time    : O(n)
Space   : O(h)
*/

func invertTree(_ root: TreeNode?) -> TreeNode? {

    guard let node = root else { return nil }

    let temp = node.left
    node.left = node.right
    node.right = temp

    _ = invertTree(node.left)
    _ = invertTree(node.right)

    return node
}

print("\n========== Q68_LC226_Invert_Binary_Tree ==========")

let invertRoot1 = invertTree(buildTree([4, 2, 7, 1, 3, 6, 9]))

if let node = invertRoot1 {
    print(node.val)              // Expected: 4
}

if let node = invertRoot1?.left {
    print(node.val)              // Expected: 7
}

if let node = invertRoot1?.right {
    print(node.val)              // Expected: 2
}

let invertRoot2 = invertTree(buildTree([2, 1, 3]))

if let node = invertRoot2?.left {
    print(node.val)              // Expected: 3
}

if let node = invertRoot2?.right {
    print(node.val)              // Expected: 1
}

if let node = invertTree(buildTree([1])) {
    print(node.val)              // Expected: 1
}

print(invertTree(buildTree([])) == nil) // Expected: true

//==============================================================
// MARK: - Q69_LC102_Binary_Tree_Level_Order_Traversal
//==============================================================

/*
LeetCode : 102

Return the level order traversal of the nodes' values, level by
level, left to right.

The level-size SNAPSHOT taken before draining is what separates
levels. Read queue[head] INSIDE the loop — head moves every
iteration.

Pattern : 04 — BFS Level Order
Time    : O(n)
Space   : O(w) — widest level, up to n/2, so O(n) as a bound
*/

func levelOrder(_ root: TreeNode?) -> [[Int]] {

    guard let node = root else { return [] }

    var queue = [node]
    var result = [[Int]]()
    var head = 0

    while head < queue.count {

        let levelSize = queue.count - head
        var level = [Int]()

        for _ in 0..<levelSize {

            let current = queue[head]
            head += 1

            level.append(current.val)

            if let left = current.left {
                queue.append(left)
            }

            if let right = current.right {
                queue.append(right)
            }
        }

        result.append(level)
    }

    return result
}

print("\n========== Q69_LC102_Binary_Tree_Level_Order_Traversal ==========")

print(levelOrder(buildTree([3, 9, 20, nil, nil, 15, 7])))
// Expected: [[3], [9, 20], [15, 7]]

print(levelOrder(buildTree([1])))
// Expected: [[1]]

print(levelOrder(buildTree([])))
// Expected: []

print(levelOrder(buildTree([1, 2, 3, 4, 5, 6, 7])))
// Expected: [[1], [2, 3], [4, 5, 6, 7]]

print(levelOrder(buildTree([1, 2, 3, 4, nil, nil, 5])))
// Expected: [[1], [2, 3], [4, 5]]

//==============================================================
// MARK: - Q70_LC098_Validate_Binary_Search_Tree
//==============================================================

/*
LeetCode : 98

Determine if a binary tree is a valid BST. The rule applies to
the ENTIRE subtree, not just the immediate children:

        5
       / \
      3   8
         / \
        2   9

Every parent/child pair passes. Not a BST — 2 is in 5's right
subtree and must exceed 5.

BOUNDARY: write the comparison from the NODE's side —
val <= min, not min > val. The second form drops the equality
and lets duplicates pass.

Pattern : 01 — DFS Preorder + 06 — BST Property Walk
Time    : O(n)
Space   : O(h)
*/

func isValidBST(_ root: TreeNode?, minValue: Int? = nil, maxValue: Int? = nil) -> Bool {

    guard let root = root else { return true }

    if let min = minValue, root.val <= min {
        return false
    }

    if let max = maxValue, root.val >= max {
        return false
    }

    return isValidBST(root.left, minValue: minValue, maxValue: root.val) &&
           isValidBST(root.right, minValue: root.val, maxValue: maxValue)
}

print("\n========== Q70_LC098_Validate_Binary_Search_Tree ==========")

print(isValidBST(buildTree([2, 1, 3])))
// Expected: true

print(isValidBST(buildTree([5, 1, 4, nil, nil, 3, 6])))
// Expected: false

print(isValidBST(buildTree([5, 4, 6, nil, nil, 3, 7])))
// Expected: false

print(isValidBST(buildTree([5, 3, 8, nil, nil, 2, 9])))
// Expected: false — the trap, every parent/child pair passes

print(isValidBST(buildTree([2, 2, 2])))
// Expected: false — duplicates are invalid; this is the regression test

print(isValidBST(buildTree([1])))
// Expected: true

print(isValidBST(buildTree([])))
// Expected: true

print(isValidBST(buildTree([5, 3, 8, 2, 4, 6, 9])))
// Expected: true

print(isValidBST(buildTree([5, 3, 8, nil, nil, 4, 9])))
// Expected: false

//==============================================================
// MARK: - Q71_LC543_Diameter_Of_Binary_Tree
//==============================================================

/*
LeetCode : 543

Return the length of the diameter — the longest path between any
two nodes, measured in EDGES. Need not pass through the root.

RECORD → left + right       (both branches, path ends here)
RETURN → max(left, right)+1 (one branch, parent extends through)

Pattern : 07 — Tree DP
Time    : O(n)
Space   : O(h)
*/

func diameterOfBinaryTree(_ root: TreeNode?) -> Int {

    var diameter = 0

    func dfs(_ node: TreeNode?) -> Int {

        guard let node = node else { return 0 }

        let left = dfs(node.left)
        let right = dfs(node.right)

        let through = left + right

        if through > diameter {
            diameter = through
        }

        if left > right {
            return left + 1
        } else {
            return right + 1
        }
    }

    _ = dfs(root)

    return diameter
}

print("\n========== Q71_LC543_Diameter_Of_Binary_Tree ==========")

print(diameterOfBinaryTree(buildTree([1, 2, 3, 4, 5])))
// Expected: 3

print(diameterOfBinaryTree(buildTree([1, 2])))
// Expected: 1

print(diameterOfBinaryTree(buildTree([1])))
// Expected: 0

print(diameterOfBinaryTree(buildTree([])))
// Expected: 0

print(diameterOfBinaryTree(buildTree([10, 5, 20, 3, 7, 15, 25])))
// Expected: 4

print(diameterOfBinaryTree(buildTree([1, 2, nil, 3, nil, 4])))
// Expected: 3

print(diameterOfBinaryTree(buildTree([1, 2, 3, 4, 5, nil, nil, 6])))
// Expected: 4 — widest path never touches the root

//==============================================================
// MARK: - Q72_LC235_Lowest_Common_Ancestor_of_a_BST
//==============================================================

/*
LeetCode : 235

Find the lowest node that has both p and q as descendants.

Both smaller → go left. Both greater → go right. Otherwise this
node IS the answer — that branch covers both "they split here"
and "one of them is this node".

Iterative: every call would be a tail call, so the loop carries
no state. O(1) space is what separates this from the general LCA.

Pattern : 06 — BST Property Walk
Time    : O(h) — O(log n) balanced, O(n) on a degenerate stick
Space   : O(1)
*/

func lowestCommonAncestor(_ root: TreeNode?, _ p: Int, _ q: Int) -> TreeNode? {

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

print("\n========== Q72_LC235_Lowest_Common_Ancestor_of_a_BST ==========")

func showNode(_ node: TreeNode?) {
    if let node = node {
        print(node.val)
    } else {
        print("nil")
    }
}

let lcaRoot1 = buildTree([6, 2, 8, 0, 4, 7, 9, nil, nil, 3, 5])

showNode(lowestCommonAncestor(lcaRoot1, 2, 8)) // Expected: 6
showNode(lowestCommonAncestor(lcaRoot1, 2, 4)) // Expected: 2
showNode(lowestCommonAncestor(lcaRoot1, 3, 5)) // Expected: 4
showNode(lowestCommonAncestor(lcaRoot1, 0, 5)) // Expected: 2
showNode(lowestCommonAncestor(lcaRoot1, 7, 9)) // Expected: 8
showNode(lowestCommonAncestor(lcaRoot1, 2, 2)) // Expected: 2

showNode(lowestCommonAncestor(buildTree([5, 3, 8, 1, 4]), 1, 4)) // Expected: 3
showNode(lowestCommonAncestor(buildTree([10]), 10, 10)) // Expected: 10
showNode(lowestCommonAncestor(buildTree([]), 1, 2)) // Expected: nil

//==============================================================
// MARK: - Q73_LC230_Kth_Smallest_Element_in_a_BST
//==============================================================

/*
LeetCode : 230

Return the kth smallest value in a BST. Inorder traversal of a
BST produces values in ascending order.

BOUNDARY: `return` after finding the answer exits ONE FRAME, not
the traversal — every ancestor still descends right. The `k > 0`
in the guard is what actually stops the walk and delivers the
O(h + k). Without it the answers are still correct and the
complexity is O(n), which no test will catch.

Pattern : 02 — DFS Inorder
Time    : O(h + k)
Space   : O(h)
*/

func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {

    var answer = 0
    var k = k

    func dfs(_ treeNode: TreeNode?) {

        guard let node = treeNode, k > 0 else { return }

        dfs(node.left)

        k -= 1

        if k == 0 {
            answer = node.val
            return
        }

        dfs(node.right)
    }

    dfs(root)

    return answer
}

print("\n========== Q73_LC230_Kth_Smallest_Element_in_a_BST ==========")

let kthRoot1 = buildTree([3, 1, 4, nil, 2])

print(kthSmallest(kthRoot1, 1)) // Expected: 1
print(kthSmallest(kthRoot1, 2)) // Expected: 2
print(kthSmallest(kthRoot1, 3)) // Expected: 3
print(kthSmallest(kthRoot1, 4)) // Expected: 4

let kthRoot2 = buildTree([5, 3, 7, 2, 4, 6, 8])

print(kthSmallest(kthRoot2, 1)) // Expected: 2
print(kthSmallest(kthRoot2, 4)) // Expected: 5
print(kthSmallest(kthRoot2, 7)) // Expected: 8

print(kthSmallest(buildTree([1]), 1)) // Expected: 1

//==============================================================
// MARK: - Q74_LC124_Binary_Tree_Maximum_Path_Sum
//==============================================================

/*
LeetCode : 124

Return the maximum path sum of any non-empty path. The path need
not pass through the root.

RECORD → leftGain + val + rightGain  (both branches)
RETURN → max(leftGain, rightGain)+val (one branch)

Negative subtrees clamp to 0 — discarding them beats including them.

BOUNDARY: seed at Int.min, NOT 0. With 0, an all-negative tree
returns 0, which is not a path at all. [-3] and [-3,-2,-1] are
the regression tests.

Pattern : 07 — Tree DP
Time    : O(n)
Space   : O(h)
*/

func maxPathSum(_ root: TreeNode?) -> Int {

    var best = Int.min

    func dfs(_ node: TreeNode?) -> Int {

        guard let node = node else { return 0 }

        let left = dfs(node.left)
        let right = dfs(node.right)

        var leftGain = 0
        var rightGain = 0

        if left > 0 {
            leftGain = left
        }

        if right > 0 {
            rightGain = right
        }

        let currentSum = leftGain + rightGain + node.val

        if currentSum > best {
            best = currentSum
        }

        if leftGain > rightGain {
            return leftGain + node.val
        } else {
            return rightGain + node.val
        }
    }

    _ = dfs(root)

    return best
}

print("\n========== Q74_LC124_Binary_Tree_Maximum_Path_Sum ==========")

print(maxPathSum(buildTree([1, 2, 3])))
// Expected: 6

print(maxPathSum(buildTree([-10, 9, 20, nil, nil, 15, 7])))
// Expected: 42

print(maxPathSum(buildTree([5])))
// Expected: 5

print(maxPathSum(buildTree([-3])))
// Expected: -3 — fails if seeded at 0

print(maxPathSum(buildTree([2, -1, 3])))
// Expected: 5

print(maxPathSum(buildTree([-3, -2, -1])))
// Expected: -1 — fails if seeded at 0

print(maxPathSum(buildTree([10, 2, 10, nil, nil, 20, 1])))
// Expected: 42

print(maxPathSum(buildTree([-10, 5, 20, nil, nil, 15, 7])))
// Expected: 42

print(maxPathSum(buildTree([2, -100, -200, 4, 5])))
// Expected: 2 — both children clamp to 0
