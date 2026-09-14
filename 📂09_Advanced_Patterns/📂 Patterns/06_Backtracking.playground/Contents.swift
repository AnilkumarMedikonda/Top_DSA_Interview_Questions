import Foundation

//==============================================================
// MARK: - Backtracking Pattern
//==============================================================
//
// Pattern:
// Choose → Explore → Undo → Try Next Choice
//
// Backtracking = Recursion + Choice + Undo
//
// path → Stores the current choice/state
//
// Base Case → Stop when all choices are processed
//
//==============================================================

func backtrack(_ nums: [Int]) {

    var path = [Int]()

    func explore(_ index: Int) {

        // Base Case
        // All elements have been processed
        if index == nums.count {
            print(path)
            return
        }

        //==========================================================
        // Choose
        //==========================================================

        path.append(nums[index])

        // Explore
        explore(index + 1)

        //==========================================================
        // Undo
        //==========================================================
        // Remove the current choice before trying another choice

        path.removeLast()

        //==========================================================
        // Skip / Next Choice
        //==========================================================

        explore(index + 1)
    }

    explore(0)
}

//==============================================================
// MARK: - Test Case
//==============================================================

let nums = [1,2,3]

backtrack(nums)

// Output:
// [1,2,3]
// [1,2]
// [1,3]
// [1]
// [2,3]
// [2]
// [3]
// []
