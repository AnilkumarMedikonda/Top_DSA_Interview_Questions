import Foundation

// Q82 - LeetCode 78: Subsets
//
// Problem:
// Given an integer array nums containing unique elements,
// return all possible subsets.
//
// Example:
// Input:
// [1, 2, 3]
//
// Output:
// [[], [1], [1,2], [1,2,3], [1,3], [2], [2,3], [3]]
//
// Pattern:
// Backtracking
//
// Key Idea:
// For every element, we have two choices:
// 1. Take the element
// 2. Skip the element
//
// Backtracking Pattern:
// Choose → Explore → Undo
//
// Important:
// Every "path" is a valid subset,
// so we add path to result at every DFS call.
//
// Steps:
// 1. Create result to store all subsets
// 2. Create path to store the current subset
// 3. Add current path to result
// 4. Loop from the current index
// 5. Choose the current number
// 6. Explore using DFS
// 7. Undo the choice
//
// Example:
// nums = [1,2]
//
// []
// ├── [1]
// │   └── [1,2]
// └── [2]
//
// Time: O(n * 2^n)
// Space: O(n) excluding output
//
// n = number of elements
// Total subsets = 2^n

func subSets(_ nums: [Int]) -> [[Int]] {

    var result = [[Int]]()
    var path = [Int]()

    func dfs(_ index: Int) {

        // Every current path is a valid subset
        result.append(path)

        // Try each available element
        for i in index..<nums.count {

            // Choose
            path.append(nums[i])

            // Explore
            dfs(i + 1)

            // Undo
            path.removeLast()
        }
    }

    dfs(0)

    return result
}

print("\n========== Q82 - Subsets ==========")

print(subSets([1, 2, 3]))
// [[], [1], [1, 2], [1, 2, 3], [1, 3], [2], [2, 3], [3]]

print(subSets([1, 2]))
// [[], [1], [1, 2], [2]]

print(subSets([0]))
// [[], [0]]

print(subSets([Int]()))
// [[]]
