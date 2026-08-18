import Foundation

//==============================================================
// Phase 02 — Two Pointers
// Prerequisites
// Fundamental Two Pointer Concepts & Operations
// Required before solving Q11–Q19
//==============================================================

// MARK: - What is Two Pointers?

/*
 Two Pointers is a technique that uses two indices
 to traverse one or more arrays efficiently.

 Goal:
 • Reduce Time Complexity
 • Solve problems in O(n)
 • Perform in-place operations
 */

// MARK: - When to Use?

/*
 ✅ Sorted Arrays
 ✅ Compare elements from both ends
 ✅ Find pairs or triplets
 ✅ In-place array modification
 ✅ Merge two sorted arrays
 */

// MARK: - Pointer Types

/*
 1. Opposite Ends
    L -----------> <----------- R

 2. Same Direction
    Read -------->
    Write ------->

 3. Two Arrays
    nums1 ------->
    nums2 ------->
 */

// MARK: - Pointer Initialization

var left = 0
var right = 0

var read = 0
var write = 0

var i = 0
var j = 0

// MARK: - Common Loop Conditions

/*
 Opposite Ends

 while left < right

 --------------------------

 Same Direction

 for read in 0..<nums.count

 --------------------------

 Two Arrays

 while i >= 0 && j >= 0
 */

// MARK: - Common Operations

/*
 • Compare
 • Move Left Pointer
 • Move Right Pointer
 • Move Both Pointers
 • Swap Elements
 • Overwrite Elements
 */

// MARK: - Time & Space Complexity

/*
 Most Two Pointer algorithms

 Time  : O(n)
 Space : O(1)
 */

// MARK: - Common Mistakes
/*
 ❌ Infinite loop
 ❌ Forgetting to move pointers
 ❌ Wrong loop condition
 ❌ Off-by-one errors
 ❌ Moving the wrong pointer
 ❌ Forgetting duplicate skipping (3Sum)
 ❌ Merging from the front instead of the end
 */
