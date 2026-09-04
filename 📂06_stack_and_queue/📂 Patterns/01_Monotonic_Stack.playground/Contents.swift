import Foundation

//==============================================================
// Monotonic Stack
//==============================================================
//
// A Monotonic Stack maintains its elements in sorted order.
//
// Types
// 1. Increasing Stack
// 2. Decreasing Stack
//
// Time  : O(n)
// Space : O(n)
//
//==============================================================


// MARK: - 1. Monotonic Increasing Stack (Store Values)

print("========== Increasing Stack ==========")

var increasingStack = [Int]()

let nums1 = [5, 2, 8, 3, 6, 1, 7]

for value in nums1 {

    while let top = increasingStack.last,
          top > value {

        print("Pop :", top)
        increasingStack.removeLast()
    }

    increasingStack.append(value)

    print("Push :", value)
    print("Stack:", increasingStack)
}

print()


// MARK: - 2. Monotonic Decreasing Stack (Store Values)

print("========== Decreasing Stack ==========")

var decreasingStack = [Int]()

let nums2 = [5, 2, 8, 3, 6, 1, 7]

for value in nums2 {

    while let top = decreasingStack.last,
          top < value {

        print("Pop :", top)
        decreasingStack.removeLast()
    }

    decreasingStack.append(value)

    print("Push :", value)
    print("Stack:", decreasingStack)
}

print()


// MARK: - 3. Monotonic Increasing Stack (Store Indices)

print("========== Increasing Stack (Indices) ==========")

let nums3 = [4, 2, 6, 3, 7]

var increasingIndexStack = [Int]()

for index in nums3.indices {

    while let lastIndex = increasingIndexStack.last,
          nums3[lastIndex] > nums3[index] {

        increasingIndexStack.removeLast()
    }

    increasingIndexStack.append(index)

    print("Indices :", increasingIndexStack)
    print("Values  :", increasingIndexStack.map { nums3[$0] })
}

print()


// MARK: - 4. Monotonic Decreasing Stack (Store Indices)

print("========== Decreasing Stack (Indices) ==========")

let nums4 = [73, 74, 75, 71, 69, 72, 76, 73]

var decreasingIndexStack = [Int]()

for index in nums4.indices {

    while let lastIndex = decreasingIndexStack.last,
          nums4[lastIndex] < nums4[index] {

        decreasingIndexStack.removeLast()
    }

    decreasingIndexStack.append(index)

    print("Indices :", decreasingIndexStack)
    print("Values  :", decreasingIndexStack.map { nums4[$0] })
}

print()


// MARK: - 5. Generic Templates

// Increasing Stack
var stack1 = [Int]()

for value in nums1 {

    while let top = stack1.last,
          top > value {

        stack1.removeLast()
    }

    stack1.append(value)
}


// Decreasing Stack
var stack2 = [Int]()

for value in nums1 {

    while let top = stack2.last,
          top < value {

        stack2.removeLast()
    }

    stack2.append(value)
}


// Increasing Stack (Indices)
var stack3 = [Int]()

for index in nums3.indices {

    while let lastIndex = stack3.last,
          nums3[lastIndex] > nums3[index] {

        stack3.removeLast()
    }

    stack3.append(index)
}


// Decreasing Stack (Indices)
var stack4 = [Int]()

for index in nums4.indices {

    while let lastIndex = stack4.last,
          nums4[lastIndex] < nums4[index] {

        stack4.removeLast()
    }

    stack4.append(index)
}


// MARK: - 6. Interview Notes

/*
 ------------------------------------------------
 Increasing Stack
 ------------------------------------------------
 Remove Greater Elements

 while top > current
     pop

 push(current)


 ------------------------------------------------
 Decreasing Stack
 ------------------------------------------------
 Remove Smaller Elements

 while top < current
     pop

 push(current)


 ------------------------------------------------
 Store Values
 ------------------------------------------------
 • Next Greater Value
 • Previous Smaller Value


 ------------------------------------------------
 Store Indices
 ------------------------------------------------
 • Next Greater Element
 • Daily Temperatures
 • Previous / Next Index
 • Distance Problems


 ------------------------------------------------
 Recognition
 ------------------------------------------------
 • Next Greater Element
 • Next Smaller Element
 • Daily Temperatures
 • Stock Span
 • Largest Rectangle Histogram
 • Trapping Rain Water


 ------------------------------------------------
 Complexity
 ------------------------------------------------
 Time  : O(n)
 Space : O(n)

 Each element is pushed once and popped at most once.
 */
