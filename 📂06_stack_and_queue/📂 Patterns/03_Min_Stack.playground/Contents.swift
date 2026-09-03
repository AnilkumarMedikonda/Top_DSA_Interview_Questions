import Foundation

//==============================================================
// Min Stack
//==============================================================
//
// A stack that also answers "what is the smallest value currently
// held?" in O(1).
//
// The idea: a single running minimum survives pushes but cannot be
// restored on pop. So store the minimum *as of each depth* alongside
// the value — the two stacks move in lockstep, and popping one always
// pops the other.
//
// push()   -> O(1) time, O(1) auxiliary
// pop()    -> O(1) time, O(1) auxiliary
// top      -> O(1) time, O(1) auxiliary
// minimum  -> O(1) time, O(1) auxiliary
// Storage  -> O(n)
//
//==============================================================


// MARK: - Min Stack

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


// MARK: - Traces

print("========== MIN STACK ==========")

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

if let peeked = stack.top {
    print("Top :", peeked)
}

if let smallest = stack.minimum {
    print("Min :", smallest)
}

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

if let smallest = stack.minimum {
    print("Min :", smallest)
}


// MARK: - Empty Stack Edge Case

print()

var emptyStack = MinStack()

print("Pop on empty :", emptyStack.pop() as Any)

print("Top on empty :", emptyStack.top as Any)

print("Min on empty :", emptyStack.minimum as Any)


// MARK: - Duplicate Minimum Edge Case

print()

var duplicateStack = MinStack()
duplicateStack.push(5)
duplicateStack.push(5)
duplicateStack.display()

print()

if let removed = duplicateStack.pop() {
    print("Pop :", removed)
}

if let smallest = duplicateStack.minimum {
    print("Min after popping one 5 :", smallest)
}


// MARK: - Trace Table

/*
 push 10    Stack [10]              MinStack [10]
 push 5     Stack [10, 5]           MinStack [10, 5]
 push 8     Stack [10, 5, 8]        MinStack [10, 5, 5]
 push 2     Stack [10, 5, 8, 2]     MinStack [10, 5, 5, 2]
 push 6     Stack [10, 5, 8, 2, 6]  MinStack [10, 5, 5, 2, 2]

 pop -> 6   Stack [10, 5, 8, 2]     MinStack [10, 5, 5, 2]   min 2
 pop -> 2   Stack [10, 5, 8]        MinStack [10, 5, 5]      min 5

 Popping 2 restores the minimum to 5 with no scan. That restoration
 is the whole point — a single running min variable cannot do it.
*/


// MARK: - Interview Notes

/*
 Rule
 -----
 Every push to the main stack pushes the current minimum to the min stack.
 Every pop from the main stack pops the min stack too. Lockstep, always.

 Why not one running min?
 ------------------------
 It tracks correctly on the way up and loses history on the way down.
 Once the minimum is popped off, the previous minimum is unrecoverable
 without an O(n) scan, which breaks the O(1) contract.

 Space optimisation (name it, don't implement it)
 ------------------------------------------------
 Push to minStack only when value <= currentMin, and pop from it only
 when the popped value equals minStack.last. Still O(1) per operation,
 but O(k) space where k is the number of distinct minima rather than O(n).

 The trap is the <= rather than <:

   push 5, push 5, pop
   with <     minStack [5]     pop removes it   -> min returns nil   WRONG
   with <=    minStack [5, 5]  pop removes one  -> min returns 5     RIGHT

 Duplicated minima are exactly what a strict < loses.
*/
