import Foundation

//==============================================================
// Queue Using Two Stacks
//==============================================================
//
// Queue  -> FIFO
// Stack  -> LIFO
//
// Idea
// ----
// One stack for arrivals, one for departures. Reversing a stack
// into another stack restores original order, so the output stack
// hands back elements oldest-first.
//
// The transfer happens ONLY when the output stack is empty. That
// guard is what makes the amortised bound true — draining on every
// dequeue would be O(n) per call and would reverse the order twice.
//
// enqueue  -> O(1) time,           O(1) auxiliary
// dequeue  -> O(1) amortised time, O(1) auxiliary
// front    -> O(1) time,           O(1) auxiliary
// isEmpty  -> O(1) time,           O(1) auxiliary
// Storage  -> O(n)
//
//==============================================================


// MARK: - Queue Using Two Stacks

struct MyQueue {

    private var inputStack = [Int]()
    private var outputStack = [Int]()

    var isEmpty: Bool {
        inputStack.isEmpty && outputStack.isEmpty
    }

    var count: Int {
        inputStack.count + outputStack.count
    }

    // input's BOTTOM is the oldest un-transferred element, so this reads
    // index 0 — the one place in this file a stack is touched non-LIFO.
    // It looks like a bug and is not; inputStack.last would be the newest.
    var front: Int? {
        if let value = outputStack.last {
            return value
        }
        if inputStack.isEmpty {
            return nil
        }
        return inputStack[0]
    }

    mutating func enqueue(_ value: Int) {
        inputStack.append(value)
    }

    mutating func dequeue() -> Int? {
        if outputStack.isEmpty {
            while let value = inputStack.popLast() {
                outputStack.append(value)
            }
        }
        return outputStack.popLast()
    }

    func display() {
        print("Input Stack  :", inputStack)

        print("Output Stack :", outputStack)
    }
}


// MARK: - Traces

print("========== QUEUE USING TWO STACKS ==========")

var queue = MyQueue()
queue.enqueue(10)
queue.enqueue(20)
queue.enqueue(30)

print("\nAfter enqueue 10, 20, 30")
queue.display()

if let value = queue.dequeue() {
    print("\nDequeue :", value)
}

queue.display()

// Enqueue while output still holds elements — the two stacks now
// hold live data at the same time. This is the state that breaks
// implementations which transfer on every call.
queue.enqueue(40)

print("\nAfter enqueue 40")
queue.display()

if let value = queue.dequeue() {
    print("\nDequeue :", value)
}

queue.display()

if let value = queue.front {
    print("\nFront :", value)
}

print("isEmpty :", queue.isEmpty)

print("Count :", queue.count)


// MARK: - Front Before Any Transfer

// front must work when everything is still in the input stack
print("\n========== FRONT BEFORE TRANSFER ==========")

var freshQueue = MyQueue()
freshQueue.enqueue(1)
freshQueue.enqueue(2)
freshQueue.enqueue(3)
freshQueue.display()

if let value = freshQueue.front {
    print("Front :", value)
}


// MARK: - Empty Queue Edge Case

print("\n========== EMPTY QUEUE ==========")

var emptyQueue = MyQueue()

print("Dequeue on empty :", emptyQueue.dequeue() as Any)

print("Front on empty :", emptyQueue.front as Any)

print("isEmpty :", emptyQueue.isEmpty)


// MARK: - Drain And Refill

print("\n========== DRAIN AND REFILL ==========")

var cycleQueue = MyQueue()
cycleQueue.enqueue(1)
cycleQueue.enqueue(2)

while let value = cycleQueue.dequeue() {
    print("Draining :", value)
}

print("isEmpty after drain :", cycleQueue.isEmpty)

cycleQueue.enqueue(3)

if let value = cycleQueue.dequeue() {
    print("Dequeue after refill :", value)
}


// MARK: - Dry Run

/*
 enqueue 10, 20, 30
     input  [10, 20, 30]
     output []

 dequeue
     output empty -> transfer
     input  []
     output [30, 20, 10]
     pop -> 10

 dequeue
     output not empty -> NO transfer
     output [30]
     pop -> 20

 enqueue 40
     input  [40]
     output [30]
     both stacks live at once

 dequeue
     output not empty -> NO transfer
     pop -> 30

 dequeue
     output empty -> transfer
     input  []
     output [40]
     pop -> 40
*/


// MARK: - Interview Notes

/*
 Rule
 ----
 enqueue          -> push to input, always
 dequeue / front  -> read from output; transfer first only if output is empty


 Why amortised, and not plain O(1)
 ---------------------------------
 A single dequeue can cost O(n) — the one that triggers the transfer.
 The claim is about the sequence, not the operation.

 Each element is touched exactly three times across its whole life:
     pushed to input       once
     moved to output       once
     popped from output    once

 n enqueues followed by n dequeues = 2n pushes + 2n pops = O(1) per
 operation averaged. But dequeue #1 alone is O(n).

 Saying plain "O(1)" is wrong and it is the follow-up an interviewer
 asks to see whether the argument was understood or memorised. Say
 "amortised O(1), worst case O(n) on the transfer."


 The guard is the whole pattern
 ------------------------------
 Transferring on every dequeue costs O(n) per call AND reverses the
 order twice, so elements come out newest-first. The emptiness check
 is not an optimisation — it is correctness.


 Complexity
 ----------
 enqueue  -> O(1) time,           O(1) auxiliary
 dequeue  -> O(1) amortised time, O(1) auxiliary  (worst case O(n))
 front    -> O(1) time,           O(1) auxiliary
 isEmpty  -> O(1) time,           O(1) auxiliary
 Storage  -> O(n)
*/
