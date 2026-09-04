import Foundation

//==============================================================
// Q49 - LC155 - Min Stack
//==============================================================
//
// Problem
// -------
// Design a stack that supports push, pop, top, and retrieving the
// minimum element — all in constant time.
//
// Example
// -------
// push(-2), push(0), push(-3)
// getMin() -> -3
// pop()
// top()    -> 0
// getMin() -> -2
//
// Constraints
// -----------
// -2^31 <= val <= 2^31 - 1
// pop, top and getMin are only called on a non-empty stack
// at most 3 * 10^4 calls total
//
// Pattern : Min Stack (03_Min_Stack)
//
// Brute Force : push O(1), pop O(1), top O(1), getMin O(n)
// Optimal     : all four O(1), storage O(n)
//
//==============================================================


// MARK: - Brute Force (single stack, scan for the minimum)

// Storing values alone means the minimum has to be recomputed by
// walking the whole stack. Correct, but getMin is O(n) and the
// problem explicitly asks for constant time.
struct MinStackBruteForce {

    private var stack = [Int]()

    var isEmpty: Bool {
        stack.isEmpty
    }

    var top: Int? {
        stack.last
    }

    // Time  : O(n)   <- this is what the optimal version removes
    // Space : O(1)
    var minimum: Int? {
        if stack.isEmpty {
            return nil
        }
        var smallest = stack[0]
        var index = 1
        while index < stack.count {
            if stack[index] < smallest {
                smallest = stack[index]
            }
            index += 1
        }
        return smallest
    }

    // Time : O(1)
    mutating func push(_ value: Int) {
        stack.append(value)
    }

    // Time : O(1)
    mutating func pop() -> Int? {
        if stack.isEmpty {
            return nil
        }
        return stack.removeLast()
    }
}


// MARK: - Optimal (paired min stack)

// A single running minimum tracks correctly on the way up and loses
// history on the way down — once it is popped off, the previous
// minimum is unrecoverable without a scan.
//
// So store the minimum AS OF EACH DEPTH alongside the value. The two
// stacks move in lockstep: every push pushes both, every pop pops both.
//
// push    : O(1) time, O(1) auxiliary
// pop     : O(1) time, O(1) auxiliary
// top     : O(1) time, O(1) auxiliary
// minimum : O(1) time, O(1) auxiliary
// Storage : O(n)
struct MinStack {

    private var stack = [Int]()
    private var minStack = [Int]()

    var isEmpty: Bool {
        stack.isEmpty
    }

    var count: Int {
        stack.count
    }

    var top: Int? {
        stack.last
    }

    var minimum: Int? {
        minStack.last
    }

    mutating func push(_ value: Int) {
        stack.append(value)

        if let currentMin = minStack.last {
            if value < currentMin {
                minStack.append(value)
            } else {
                minStack.append(currentMin)
            }
        } else {
            minStack.append(value)
        }
    }

    mutating func pop() -> Int? {
        if stack.isEmpty {
            return nil
        }
        minStack.removeLast()
        return stack.removeLast()
    }

    func display() {
        print("Stack    :", stack)

        print("MinStack :", minStack)
    }
}


// MARK: - Test Cases (LeetCode example)

print("========== LC155 EXAMPLE ==========")

var example = MinStack()
example.push(-2)
example.push(0)
example.push(-3)
example.display()

print("getMin :", example.minimum as Any)   // -3

if let removed = example.pop() {
    print("pop :", removed)                 // -3
}

print("top :", example.top as Any)          // 0

print("getMin :", example.minimum as Any)   // -2


// MARK: - Test Cases (walkthrough)

print("\n========== WALKTHROUGH ==========")

var stack = MinStack()

stack.push(10)
stack.display()

print()

stack.push(5)
stack.display()

print()

stack.push(8)
stack.display()

print()

stack.push(2)
stack.display()

print()

stack.push(6)
stack.display()

print()

print("Top :", stack.top as Any)

print("Min :", stack.minimum as Any)

print()

if let removed = stack.pop() {
    print("Pop :", removed)
}

stack.display()

print()

if let removed = stack.pop() {
    print("Pop :", removed)
}

stack.display()

// popping 2 restores the minimum to 5 with no scan
print("Min :", stack.minimum as Any)


// MARK: - Duplicate Minimum Edge Case

print("\n========== DUPLICATE MINIMUM ==========")

var duplicates = MinStack()
duplicates.push(5)
duplicates.push(5)
duplicates.display()

if let removed = duplicates.pop() {
    print("Pop :", removed)
}

print("Min after popping one 5 :", duplicates.minimum as Any)   // 5


// MARK: - Empty Stack Edge Case

print("\n========== EMPTY STACK ==========")

var emptyStack = MinStack()

print("Pop :", emptyStack.pop() as Any)

print("Top :", emptyStack.top as Any)

print("Min :", emptyStack.minimum as Any)


// MARK: - Brute Force Comparison

print("\n========== BRUTE FORCE ==========")

var slow = MinStackBruteForce()
slow.push(10)
slow.push(5)
slow.push(8)
slow.push(2)
slow.push(6)

print("Top :", slow.top as Any)

print("Min :", slow.minimum as Any)         // 2, found by scanning

if let removed = slow.pop() {
    print("Pop :", removed)
}

if let removed = slow.pop() {
    print("Pop :", removed)
}

print("Min :", slow.minimum as Any)         // 5, found by scanning again


// MARK: - Notes

/*
 The two approaches
 ------------------
 Brute force  one stack, getMin scans        O(n) per getMin
 Optimal      two stacks in lockstep         O(1) per getMin

 The trade is O(n) extra space for O(1) time, and the problem
 statement demands the O(1), so the space is not optional here.

 Why not one running minimum
 ---------------------------
 It survives pushes and breaks on pops. Once the current minimum is
 popped off the stack, the previous one cannot be recovered without
 walking the whole structure — which is the brute force again.

 LeetCode signature
 ------------------
 LC155 declares pop() as Void and top()/getMin() as Int, with the
 guarantee that they are never called on an empty stack. This file
 returns Int? throughout, which is safer in a playground but differs
 from what gets submitted. Write the Void version in the mock.

 Space optimisation (named, not implemented)
 -------------------------------------------
 Push to minStack only when value <= currentMin, and pop from it only
 when the popped value equals minStack.last. Still O(1) per operation,
 but O(k) space where k is the number of distinct minima.

 The trap is the <= rather than <:

   push 5, push 5, pop
   with <     minStack [5]     pop removes it   -> min nil    WRONG
   with <=    minStack [5, 5]  pop removes one  -> min 5      RIGHT

 Duplicated minima are exactly what a strict < loses, which is why
 the duplicate test above exists.

 Complexity
 ----------
 push     O(1) time, O(1) auxiliary
 pop      O(1) time, O(1) auxiliary
 top      O(1) time, O(1) auxiliary
 minimum  O(1) time, O(1) auxiliary
 Storage  O(n)
*/
