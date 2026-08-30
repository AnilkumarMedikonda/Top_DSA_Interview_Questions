//
//  06_Monotonic_Deque.swift
//  Phase 04 — Sliding Window
//
//  Pattern: Monotonic Deque
//
//  When to Use
//  ------------
//  ✓ Maximum in every window
//  ✓ Minimum in every window
//  ✓ Largest / Smallest element in a sliding window
//
//  Core Idea
//  ---------
//  Maintain a deque in monotonic (decreasing) order.
//
//  Larger
//     ↓
//  Smaller
//     ↓
//  Smaller
//
//  Any smaller element behind a larger element can never become the
//  maximum, so remove it.
//
//  Learning Steps
//  --------------
//  Step 1 → Learn Deque Operations
//  Step 2 → Maintain Monotonic (Decreasing) Order
//  Step 3 → Store Indices Instead of Values
//  Step 4 → Remove Expired Indices (LC239)
//  Step 5 → Front of Deque is the Answer (LC239)
//
//  Why Store Indices?
//  ------------------
//  ✓ Know whether an element is outside the window.
//  ✓ Remove expired elements efficiently.
//  ✓ Access values using nums[index].
//
//  Complexity
//  ----------
//  Time  : O(n)
//  Space : O(k)
//
//  Related Problems
//  ----------------
//  ✓ LC239 - Sliding Window Maximum
//  ✓ Sliding Window Minimum
//

import Foundation

// MARK: - Step 1: Basic Deque Operations

var deque = [Int]()

// Insert at Back
deque.append(10)
deque.append(20)
deque.append(30)

print("After append:", deque)

// Remove from Back
if !deque.isEmpty {
    deque.removeLast()
}

print("After removeLast:", deque)

// Insert at Front
deque.insert(5, at: 0)

print("After insert at front:", deque)

// Remove from Front
if !deque.isEmpty {
    deque.removeFirst()
}

print("After removeFirst:", deque)

// Peek Front
if let front = deque.first {
    print("Front:", front)
}

// Peek Back
if let back = deque.last {
    print("Back :", back)
}

print("----------------------------------")

// MARK: - Step 2: Maintain Monotonic (Decreasing) Deque

let nums = [1, 3, 2, 5, 4]

deque.removeAll()

for num in nums {

    // Remove all smaller elements
    while let last = deque.last,
          last < num {

        deque.removeLast()
    }

    // Insert current element
    deque.append(num)

    print(deque)
}

print("----------------------------------")

// MARK: - Step 3: Store Indices Instead of Values

deque.removeAll()

for index in 0..<nums.count {

    // Remove smaller elements
    while let lastIndex = deque.last,
          nums[lastIndex] < nums[index] {

        deque.removeLast()
    }

    // Store current index
    deque.append(index)

    print("Indices:", deque)
    var values = [Int]()
    for i in deque {
        values.append(nums[i])
    }
    print("Values : \(values)")
    print("----------------------------------")
}
