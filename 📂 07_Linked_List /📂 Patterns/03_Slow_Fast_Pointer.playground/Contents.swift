import Foundation

//==========================================================
// PATTERN 03 — SLOW & FAST POINTER
//==========================================================
//
// WHAT
// Use two pointers moving at different speeds.
//
// Slow  -> Moves 1 Step
// Fast  -> Moves 2 Steps
//
// WHY
// Find the middle without counting nodes.
//
// WHEN IT FIRES
//
// ✓ Find Middle Node
// ✓ Detect Cycle
// ✓ Find Cycle Start
// ✓ Split Linked List
// ✓ Palindrome Linked List
// ✓ Reorder List
//
// PATTERN
//
// slow = head
// fast = head
//
// while fast != nil && fast.next != nil
//
//      slow = slow.next
//
//      fast = fast.next.next
//
// return slow
//
// COMPLEXITY
//
// Time  : O(n)
// Space : O(1)
//
// USED IN
//
// ✓ LC141 Linked List Cycle
// ✓ LC876 Middle Of Linked List
// ✓ LC143 Reorder List
// ✓ LC234 Palindrome Linked List
//
//==========================================================

final class ListNode {

    var value: Int

    var next: ListNode?

    init(_ value: Int, _ next: ListNode? = nil) {

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

    let head = ListNode(values[0])

    var current = head

    for i in 1..<values.count {

        let node = ListNode(values[i])

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
// Algorithm
// Find Middle Node
//
// Time  O(n)
// Space O(1)
//==========================================================

func middleNode(_ head: ListNode?) -> ListNode? {

    //------------------------------------------------------
    // Step 1
    // Create Slow Pointer
    //------------------------------------------------------

    var slow = head

    // slow
    //  ↓
    // 1 -> 2 -> 3 -> 4 -> 5

    //------------------------------------------------------
    // Step 2
    // Create Fast Pointer
    //------------------------------------------------------

    var fast = head

    // slow
    //  ↓
    // 1 -> 2 -> 3 -> 4 -> 5
    //  ↑
    // fast

    //------------------------------------------------------
    // Step 3
    // Traverse Until Fast Reaches End
    //------------------------------------------------------

    while let fastNode = fast, let fastNext = fastNode.next {

        //--------------------------------------------------
        // Step 4
        // Move Slow One Step
        //--------------------------------------------------

        slow = slow?.next

        // 1 -> 2 -> 3 -> 4 -> 5
        //      ↑
        //    slow

        //--------------------------------------------------
        // Step 5
        // Move Fast Two Steps
        //--------------------------------------------------

        fast = fast?.next?.next

        // 1 -> 2 -> 3 -> 4 -> 5
        //          ↑
        //         fast

        //--------------------------------------------------
        // After First Iteration
        //
        // slow = 2
        // fast = 3
        //
        // After Second Iteration
        //
        // slow = 3
        // fast = 5
        //--------------------------------------------------
    }

    //------------------------------------------------------
    // Step 6
    // Slow Points To Middle
    //------------------------------------------------------

    return slow
}

//==========================================================
// Tests
//==========================================================

print("========== Original List ==========")

let head = createList([1,2,3,4,5])

traverseList(head)

print()

print("========== Middle Node ==========")

if let middle = middleNode(head) {

    print("Middle :", middle.value)
}
