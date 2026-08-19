import Foundation

/*
 Q11 — LC011 Container With Most Water

 Problem:
 Given an array where each element represents the height of a vertical line,
 find two lines that together with the x-axis form a container that holds
 the maximum amount of water.

 Example:
 Input:  [1,8,6,2,5,4,8,3,7]
 Output: 49

 Constraints:
 2 <= height.count <= 10^5
 0 <= height[i] <= 10^4
 */

var heights = [1,8,6,2,5,4,8,3,7]

//============================================================
// MARK: - Brute Force
// Time: O(n²)
// Space: O(1)
//============================================================

func maxAreaBruteForce(_ heights: [Int]) -> Int {

    guard heights.count > 1 else { return 0 }

    var maxWater = 0

    for i in 0..<heights.count {

        for j in (i + 1)..<heights.count {

            let height = min(heights[i], heights[j])
            let width = j - i
            let currentWater = height * width

            maxWater = max(maxWater, currentWater)
        }
    }

    return maxWater
}

print("Brute Force")
print(maxAreaBruteForce(heights))

//============================================================
// MARK: - Optimal (Two Pointers)
// Time: O(n)
// Space: O(1)
//============================================================

func maxAreaOptimal(_ heights: [Int]) -> Int {

    guard heights.count > 1 else { return 0 }

    var maxWater = 0
    var left = 0
    var right = heights.count - 1

    while left < right {

        let height = min(heights[left], heights[right])
        let width = right - left
        let currentWater = height * width

        maxWater = max(maxWater, currentWater)

        if heights[left] < heights[right] {
            left += 1
        } else {
            right -= 1
        }
    }

    return maxWater
}

print()
print("Optimal")
print(maxAreaOptimal(heights))
