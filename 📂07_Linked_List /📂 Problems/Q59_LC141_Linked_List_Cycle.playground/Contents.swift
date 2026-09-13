import Foundation

//==========================================================
// Q59 - LC141 Linked List Cycle
//==========================================================
//
// Pattern : 03 Slow Fast Pointer
//
// Problem
// Given the head of a linked list, determine whether the list
// has a cycle in it. A cycle exists if some node can be reached
// again by continuously following the next pointer.
//
// Example 1
// Input   3 -> 2 -> 0 -> -4, tail connects to index 1
// Output  true
//
// Example 2
// Input   1 -> 2, tail connects to index 0
// Output  true
//
// Example 3
// Input   1 -> nil
// Output  false
//
// Constraints
// 0 <= number of nodes <= 10^4
// -10^5 <= Node.val <= 10^5
// position is -1 for no cycle, otherwise a valid index
//
// Follow-up: solve it with O(1) memory.
//
// Time  : O(n)
// Space : O(n) brute force, O(1) optimal
//
//==========================================================


final class ListNode {
    var value: Int
    var next: ListNode?

    init(value: Int, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

//==========================================================
// Create Linked List
//
// Time  O(n)
// Space O(n)
//==========================================================

func createListNode(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    let headNode = ListNode(value: values[0])
    var current = headNode

    for i in 1..<values.count {
        let node = ListNode(value: values[i])
        current.next = node
        current = node
    }

    return headNode
}

//==========================================================
// Create Cyclic List — test helper only
// Points the tail back at the node at the given position.
// Pass -1 for no cycle. NEVER traverse the result.
//
// Time  O(n)
// Space O(n)
//==========================================================

func createCycle(_ values: [Int], position: Int) -> ListNode? {
    guard !values.isEmpty else { return nil }
    let headNode = ListNode(value: values[0])
    var current = headNode
    var cycleNode: ListNode? = nil

    if position == 0 {
        cycleNode = headNode
    }

    for i in 1..<values.count {
        let node = ListNode(value: values[i])
        current.next = node
        current = node

        if position == i {
            cycleNode = node
        }
    }

    current.next = cycleNode

    return headNode
}


//==========================================================
// Brute Force
// Remember every node seen. A node seen twice is a cycle.
//
// The set is keyed by ObjectIdentifier, not value — two nodes
// holding the same number are different nodes, and only the
// reference proves you have been here before.
//
// Time  O(n) - each node visited at most once
// Space O(n) - the set holds every node
//==========================================================

func hasCycleBruteForce(_ headNode: ListNode?) -> Bool {
    var visited = Set<ObjectIdentifier>()
    var current = headNode

    while let node = current {
        if visited.contains(ObjectIdentifier(node)) {
            return true
        }

        visited.insert(ObjectIdentifier(node))
        current = node.next
    }

    return false
}


//==========================================================
// Optimal — Floyd's cycle detection
//
// Slow moves 1, fast moves 2. On a cycle the gap between them
// closes by exactly 1 each pass, so fast always catches slow —
// it can never step over it. On a straight list fast runs out
// of nodes first.
//
// Step 1  both start at the head
// Step 2  guard BOTH hops: fastNode for the first, fastNext
//         for the second
// Step 3  move first, compare second — they start equal, so
//         comparing before moving returns true on every list
// Step 4  === not ==. Values repeat; references do not.
//
// Time  O(n) - fast covers the list, slow covers half
// Space O(1) - two pointers
//==========================================================

func hasCycleOptimal(_ headNode: ListNode?) -> Bool {

    //------------------------------------------------------
    // Step 1
    // Both pointers start at the head
    //------------------------------------------------------

    var slow = headNode
    var fast = headNode

    //------------------------------------------------------
    // Step 2
    // Room for a two-step hop, or the list ends
    //------------------------------------------------------

    while let fastNode = fast, let fastNext = fastNode.next {

        //--------------------------------------------------
        // Step 3
        // Move both, then compare
        //--------------------------------------------------

        slow = slow?.next
        fast = fastNext.next

        //--------------------------------------------------
        // Step 4
        // Identity, not value
        //--------------------------------------------------

        if slow === fast {
            return true
        }
    }

    //------------------------------------------------------
    // Step 5
    // Fast reached nil, so the list terminates
    //------------------------------------------------------

    return false
}


//==========================================================
// Tests
//==========================================================

print("\n========== Q59 - Linked List Cycle ==========")

print(hasCycleOptimal(createListNode([1, 2, 3, 4, 5])))            // false

print(hasCycleOptimal(createCycle([1, 2, 3, 4, 5], position: 3)))  // true

print(hasCycleOptimal(createCycle([1, 2, 3, 4, 5], position: 0)))  // true

print(hasCycleOptimal(createListNode([1])))                        // false

print(hasCycleOptimal(createCycle([1], position: 0)))              // true

print(hasCycleOptimal(nil))                                        // false

print(hasCycleOptimal(createListNode([1, 1, 1, 1])))               // false

print(hasCycleBruteForce(createListNode([1, 2, 3])))               // false

print(hasCycleBruteForce(createCycle([1, 2, 3], position: 1)))     // true

print(hasCycleBruteForce(createListNode([1, 1, 1])))               // false
