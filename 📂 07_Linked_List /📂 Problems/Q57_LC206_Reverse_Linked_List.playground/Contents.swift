import Foundation

//==========================================================
// Q57 - LC206 Reverse Linked List
//==========================================================
//
// Pattern : 01 Reverse Linked List
//
// Problem
// Given the head of a singly linked list, reverse the list and
// return the head of the reversed list.
//
// Example 1
// Input   1 -> 2 -> 3 -> 4 -> 5 -> nil
// Output  5 -> 4 -> 3 -> 2 -> 1 -> nil
//
// Example 2
// Input   1 -> 2 -> nil
// Output  2 -> 1 -> nil
//
// Example 3
// Input   nil
// Output  nil
//
// Constraints
// 0 <= number of nodes <= 5000
// -5000 <= Node.val <= 5000
//
// Follow-up: solve it both iteratively and recursively.
//
// Time  : O(n)
// Space : O(1) iterative, O(n) recursive
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

func createList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    let head = ListNode(value: values[0])
    var current = head

    for i in 1..<values.count {
        let node = ListNode(value: values[i])
        current.next = node
        current = node
    }

    return head
}

//==========================================================
// Traverse Linked List
//
// Time  O(n)
// Space O(1)
//==========================================================

func traverseList(_ head: ListNode?) {
    var current = head

    while let node = current {
        print(node.value, terminator: " -> ")

        current = node.next
    }

    print("nil")
}


//==========================================================
// Brute Force
// Collect every value, then rebuild a new list backwards.
// Manual loop — no reversed().
//
// Time  O(n) - one pass to collect, one to rebuild
// Space O(n) - the values array plus a whole new list
//
// The original list is left untouched, which the optimal does
// not do. That is the only thing this version buys.
//==========================================================

func reverseListBruteForce(_ head: ListNode?) -> ListNode? {
    var values: [Int] = []
    var current = head

    while let node = current {
        values.append(node.value)
        current = node.next
    }

    guard !values.isEmpty else { return nil }

    let newHead = ListNode(value: values[values.count - 1])
    var tail = newHead
    var i = values.count - 2

    while i >= 0 {
        let node = ListNode(value: values[i])
        tail.next = node
        tail = node
        i -= 1
    }

    return newHead
}


//==========================================================
// Optimal — Iterative
//
// Three pointers, and the order is fixed:
// save next, flip the link, advance prev, advance current.
// Swap any two and you either drop the tail or spin forever.
//
// Step 1  prev starts nil — the reversed list ends there
// Step 2  current starts at head
// Step 3  save nextNode BEFORE the flip destroys node.next
// Step 4  flip:  node.next = prev
// Step 5  advance prev to node
// Step 6  advance current to nextNode
// Step 7  return prev, NOT current
//
// current is nil when the loop exits. prev is standing on the
// old tail, which is the new head.
//
// Time  O(n) - each node visited once
// Space O(1) - three pointers
//==========================================================

func reverseList(_ head: ListNode?) -> ListNode? {

    //------------------------------------------------------
    // Step 1 and 2
    // prev holds the reversed part, current holds the rest
    //------------------------------------------------------

    var prev: ListNode? = nil
    var current = head

    while let node = current {

        //--------------------------------------------------
        // Step 3
        // Save the rest of the list before severing it
        //--------------------------------------------------

        let nextNode = node.next

        //--------------------------------------------------
        // Step 4
        // Flip this link backwards — the EDIT
        //--------------------------------------------------

        node.next = prev

        //--------------------------------------------------
        // Step 5 and 6
        // Advance both pointers — the MOVE
        //--------------------------------------------------

        prev = node
        current = nextNode
    }

    //------------------------------------------------------
    // Step 7
    // prev is the old tail = the new head
    //------------------------------------------------------

    return prev
}


//==========================================================
// Optimal — Recursive
//
// Recurse to the tail, then flip each link on the way back up.
//
// next.next = node   the node ahead now points back
// node.next = nil    without this the old tail keeps its forward
//                    pointer and the last two nodes form a cycle
//
// newHead is set once at the deepest call and passes through
// every frame untouched.
//
// Time  O(n) - one call per node
// Space O(n) - call stack, n frames deep. This is why the
//              iterative version ships: 5000 nodes is 5000 frames.
//              Say this out loud; the follow-up exists to ask it.
//==========================================================

func reverseListRecursive(_ head: ListNode?) -> ListNode? {
    guard let node = head, let next = node.next else {
        return head
    }

    let newHead = reverseListRecursive(next)
    next.next = node
    node.next = nil

    return newHead
}


//==========================================================
// Tests
//==========================================================

print("\n========== Q57 - Reverse Linked List ==========")

traverseList(reverseList(createList([1, 2, 3, 4, 5])))              // 5 -> 4 -> 3 -> 2 -> 1 -> nil

traverseList(reverseList(createList([1, 2])))                       // 2 -> 1 -> nil

traverseList(reverseList(createList([10])))                         // 10 -> nil

traverseList(reverseList(createList([])))                           // nil

traverseList(reverseList(createList([-1, -2, -3, -4])))             // -4 -> -3 -> -2 -> -1 -> nil

traverseList(reverseList(createList([1, 2, 2, 3, 3])))              // 3 -> 3 -> 2 -> 2 -> 1 -> nil

traverseList(reverseListBruteForce(createList([1, 2, 3, 4, 5])))    // 5 -> 4 -> 3 -> 2 -> 1 -> nil

traverseList(reverseListBruteForce(createList([])))                 // nil

traverseList(reverseListRecursive(createList([1, 2, 3, 4, 5])))     // 5 -> 4 -> 3 -> 2 -> 1 -> nil

traverseList(reverseListRecursive(createList([1])))                 // 1 -> nil

traverseList(reverseListRecursive(createList([])))                  // nil
