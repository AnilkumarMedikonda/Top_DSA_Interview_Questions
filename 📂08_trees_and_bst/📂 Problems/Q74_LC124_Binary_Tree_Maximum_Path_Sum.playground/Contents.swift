import Foundation

// Q74_LC124_Binary_Tree_Maximum_Path_Sum

/*
 Pattern: Tree DP — Postorder DFS

 Idea:
 Find the best path sum through every node.

 Left → Right → Node

 At each node:

 1. Get leftGain
 2. Get rightGain
 3. Record:
    leftGain + node.value + rightGain
 4. Return:
    max(leftGain, rightGain) + node.value

 Negative gain:
 Ignore it using max(0, gain).

 Key:
 RECORD → both branches
 RETURN → one branch

 Path can start/end at ANY node.
 It does not need to pass through root.

 Time: O(n)
 Space: O(h)
 */

final class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(value: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
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

func maxPathSum(_ root: TreeNode?) -> Int {

    var maximumPathSum = Int.min

    func dfs(_ node: TreeNode?) -> Int {

        guard let node = node else { return 0 }

        // a negative subtree is worth discarding — clamp it to 0
        let leftRaw = dfs(node.left)
        var leftGain = 0

        if leftRaw > 0 {
            leftGain = leftRaw
        }

        let rightRaw = dfs(node.right)
        var rightGain = 0

        if rightRaw > 0 {
            rightGain = rightRaw
        }

        // RECORD — both branches, the path ends here
        let currentPathSum = leftGain + node.value + rightGain

        if currentPathSum > maximumPathSum {
            maximumPathSum = currentPathSum
        }

        // RETURN — one branch only, the parent extends through us
        if leftGain > rightGain {
            return leftGain + node.value
        } else {
            return rightGain + node.value
        }
    }

    _ = dfs(root)

    return maximumPathSum
}

// MARK: - Test Cases

print("\n========== Q74 - Maximum Path Sum ==========")

print(maxPathSum(buildTree([1, 2, 3]))) // 6
print(maxPathSum(buildTree([-10, 9, 20, nil, nil, 15, 7]))) // 42
print(maxPathSum(buildTree([5]))) // 5
print(maxPathSum(buildTree([-3]))) // -3
print(maxPathSum(buildTree([2, -1, 3]))) // 5
print(maxPathSum(buildTree([-3, -2, -1]))) // -1
print(maxPathSum(buildTree([10, 2, 10, nil, nil, 20, 1]))) // 42
print(maxPathSum(buildTree([-10, 5, 20, nil, nil, 15, 7]))) // 42
