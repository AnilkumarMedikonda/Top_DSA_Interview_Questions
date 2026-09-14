import Foundation

//==============================================================
// MARK: - Dynamic Programming Pattern
//==============================================================
//
// State
// → What does dp[i] represent?
//
// Choice
// → What choices do I have?
//
// Transition
// → How does dp[i] depend on previous states?
//
// Base Case
// → What are the smallest known answers?
//
//==============================================================

func dynamicProgramming(_ nums: [Int]) -> Int {

    let n = nums.count

    if n == 0 {
        return 0
    }

    var dp = Array(repeating: 0, count: n)

    // Base Case
    dp[0] = nums[0]

    // Build the solution
    for i in 1..<n {
        dp[i] = max(dp[i - 1], nums[i])
    }

    return dp[n - 1]
}

//==============================================================
// MARK: - Test Case 1
//==============================================================

let nums1 = [1,2,3,4,5]
let result1 = dynamicProgramming(nums1)

print("Test Case 1: \(result1)")
print("Expected: 5")

//==============================================================
// MARK: - Test Case 2
//==============================================================

let nums2 = [5,1,3,2,4]
let result2 = dynamicProgramming(nums2)

print("Test Case 2: \(result2)")
print("Expected: 5")

//==============================================================
// MARK: - Test Case 3
//==============================================================

let nums3 = [10,2,8,15,4]
let result3 = dynamicProgramming(nums3)

print("Test Case 3: \(result3)")
print("Expected: 15")


