import Foundation

//==============================================================
// Q53 - LC232 - Implement Queue Using Stacks
//==============================================================
//
// Problem
// -------
// Implement a FIFO queue using only two stacks. Support push, pop,
// peek and empty, using only standard stack operations — push to top,
// pop from top, peek at top, size, is-empty.
//
// Example
// -------
// push(1)
// push(2)
// peek()  -> 1
// pop()   -> 1
// empty() -> false
//
// Constraints
// -----------
// 1 <= x <= 9
// at most 100 calls to push, pop, peek and empty
// all calls to pop and peek are valid — never on an empty queue
//
// Follow-up: make each operation amortised O(1).
//
// Pattern : Two Stack Queue (05_Two_Stack_Queue)
//
// Brute Force : push O(1), pop O(n) with removeFirst()
// Optimal     : all four amortised O(1), storage O(n)
//
// Amortised, not plain O(1): a single pop can cost O(n) when it
// triggers the transfer. Each element is touched exactly three times
// over its life — pushed to input, moved to output, popped from
// output — so the average across a sequence is constant.
//
// LC232 names the methods push / pop / peek / empty. This file uses
// enqueue / dequeue / front / isEmpty; rename before submitting.
//
//==============================================================


struct MyQueue {

    private var inputStack = [Int]()
    private var outputStack = [Int]()

    // MARK: - Enqueue

    mutating func enqueue(_ value: Int) {
        inputStack.append(value)

    }

    // MARK: - Dequeue

    mutating func dequeue() -> Int? {
        
        if outputStack.isEmpty {
            
            while let last = inputStack.popLast() {
                outputStack.append(last)
            }
        }

        return outputStack.popLast()
    }

    // MARK: - Front

    mutating func front() -> Int? {

        if outputStack.isEmpty {
            
            while let last = inputStack.popLast() {
                outputStack.append(last)
            }
        }

        return outputStack.last
    }

    // MARK: - isEmpty

    func isEmpty() -> Bool {

        return inputStack.isEmpty && outputStack.isEmpty
    }

    // MARK: - Count

    func count() -> Int {

        inputStack.count + outputStack.count
    }

    // MARK: - Display

    func display() {

        print("Input Stack: ", inputStack)
        print("Output Stack: ", outputStack)
    }
}

//==============================================================
// MARK: - Test Cases
//==============================================================

var queue = MyQueue()

print("========== Enqueue ==========")

queue.enqueue(10)
queue.enqueue(20)
queue.enqueue(30)
queue.enqueue(40)

queue.display()

print()

print("========== Front ==========")

print(queue.front() as Any)

queue.display()

print()

print("========== Dequeue ==========")

print(queue.dequeue() as Any)

queue.display()

print()

print(queue.dequeue() as Any)

queue.display()

print()

print("========== Queue Info ==========")

print("Front :", queue.front() as Any)
print("Count :", queue.count())
print("isEmpty :", queue.isEmpty())

print()

print("========== Empty Queue ==========")

var emptyQueue = MyQueue()

print(emptyQueue.dequeue() as Any)
print(emptyQueue.front() as Any)
print(emptyQueue.isEmpty())
