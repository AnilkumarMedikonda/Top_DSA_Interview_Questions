import Foundation

// Q83 - LeetCode 39: Combination Sum
//
// Problem:
// Given an array of distinct positive integers candidates
// and a target integer, return all unique combinations
// where the chosen numbers add up to target.
//
// Important:
// The same number can be used unlimited times.
//
// Example:
// candidates = [2,3,6,7]
// target = 7
//
// Output:
// [[2,2,3], [7]]
//
// Constraints:
// 1 <= candidates.count <= 30
// 2 <= candidates[i] <= 40
// All candidates are distinct
// 1 <= target <= 40
//
// Brute force:
// Not useful here. Every valid combination must be produced,
// so the output itself can be large.
//
// Pattern:
// Backtracking
//
// Key Idea:
// Choose → Explore → Undo
//
// Important Difference from Subsets:
//
// Subsets:
// dfs(i + 1) → cannot reuse current element
//
// Combination Sum:
// dfs(i) → can reuse current element
//
// Important:
// The loop starts from index instead of 0.
// This prevents duplicate orderings like [2,3] and [3,2].
//
// Base Cases:
// remainingTarget == 0 → valid combination
// remainingTarget < 0  → invalid combination
//
// Steps:
// 1. Create result
// 2. Create path
// 3. Start DFS
// 4. If remainingTarget == 0, save path
// 5. If remainingTarget < 0, stop
// 6. Choose candidate
// 7. Explore recursively
// 8. Undo candidate
//
// Time: O(n^(target / minCandidate)) approximately
// Space: O(target / minCandidate) excluding output

func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {

    var result = [[Int]]()
    var path = [Int]()

    func dfs(index: Int, remainingTarget: Int) {

        if remainingTarget == 0 {
            result.append(path)
            return
        }

        if remainingTarget < 0 {
            return
        }

        for i in index..<candidates.count {

            // Choose
            path.append(candidates[i])

            // Explore
            // Use i again because the same number can be reused
            dfs(index: i, remainingTarget: remainingTarget - candidates[i])

            // Undo
            path.removeLast()
        }
    }

    dfs(index: 0, remainingTarget: target)

    return result
}

// MARK: - Test Cases

print("\n========== Q83 - Combination Sum ==========")

print(combinationSum([2, 3, 6, 7], 7))
// [[2, 2, 3], [7]]

print(combinationSum([2, 3, 5], 8))
// [[2, 2, 2, 2], [2, 3, 3], [3, 5]]

print(combinationSum([2], 1))
// []

print(combinationSum([2, 4], 8))
// [[2, 2, 2, 2], [2, 2, 4], [4, 4]]

print(combinationSum([3, 5, 7], 10))
// [[3, 7], [5, 5]]

print(combinationSum([7], 7))
// [[7]]

print(combinationSum([2, 3], 1))
// []
