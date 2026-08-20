import Foundation

//────────────────────────────────────────────
// Q13 — LC042 Trapping Rain Water
// Difficulty: Hard
// Pattern: Two Pointers
//───────────────────────────────────────────

// MARK: - Problem

/*
 Given an array of heights, return total water trapped after rain.

 Input:  [0,1,0,2,1,0,1,3,2,1,2,1]
 Output: 6

         |
     |   | | |
   | | | | | | |
   ─────────────────

 Key insight:
 water at i = min(maxLeft, maxRight) - height[i]
*/

// MARK: - Interview Q&A

/*
 Q: What determines water level at index i?
 A: min(maxLeft, maxRight) - height[i]

 Q: Why min of both sides?
 A: Water spills over the shorter wall

 Q: Why O(n) not O(n²)?
 A: Two pointers move inward — each element visited exactly once

 Q: Why process the smaller side first?
 A: Smaller side is the bottleneck — it determines the water level
*/

// MARK: - Brute Force  O(n²) time  O(1) space

/*
 Strategy:
 - max from left
 - max from right
 - water = min(leftMax, rightMax) - height[i]
 - add to total

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ heights: [Int]) -> Int {

    var totalWater = 0

    for i in 0..<heights.count {

        var leftMax = 0
        var rightMax = 0

        for left in 0...i {
            leftMax = max(leftMax, heights[left])
        }

        for right in i..<heights.count {
            rightMax = max(rightMax, heights[right])
        }

        let water = min(leftMax, rightMax) - heights[i]
        totalWater += water
    }

    return totalWater
}

// MARK: - Optimal ⭐️  O(n) time  O(1) space

/*
 Strategy:
 - Two pointers from both ends moving inward
 - Smaller side is always the bottleneck
 - if heights[left] < heights[right] → process left,  left++
 - else                               → process right, right--

 INTERVIEW: Each element visited once → O(n)
 INTERVIEW: >= safer than > for max update — equal height adds 0 water anyway
*/

func optimised(_ heights: [Int]) -> Int {

    var left     = 0
    var right    = heights.count - 1
    var leftMax  = 0
    var rightMax = 0
    var totalWater = 0

    while left < right {

        if heights[left] < heights[right] {

            if heights[left] >= leftMax {
                leftMax = heights[left]
            } else {
                totalWater += leftMax - heights[left]
            }
            left += 1

        } else {

            if heights[right] >= rightMax {
                rightMax = heights[right]
            } else {
                totalWater += rightMax - heights[right]
            }
            right -= 1
        }
    }

    return totalWater
}

// MARK: - Tests

let tests: [([Int], Int)] = [
    ([0,1,0,2,1,0,1,3,2,1,2,1], 6),
    ([4,2,0,3,2,5],              9),
    ([1,0,1],                    1),
    ([3,0,0,2,0,4],              10),
    ([1,1],                      0)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r) | Expected: \(t.1)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r) | Expected: \(t.1)")
}


