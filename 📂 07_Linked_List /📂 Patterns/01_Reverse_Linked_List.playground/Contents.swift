import Foundation

//==========================================================
// PATTERN 01 — REVERSE LINKED LIST
//==========================================================
//
// WHAT
// Reverse every next pointer.
//
// PATTERN
//
// Save Next
//      ↓
// Reverse Link
//      ↓
// Move Prev
//      ↓
// Move Current
//
// USED IN
//
// ✓ LC206 Reverse Linked List
// ✓ LC234 Palindrome Linked List
// ✓ LC143 Reorder List
// ✓ LC025 Reverse Nodes In K Group
//
//==========================================================

final class ListNode {

    var val: Int

    var next: ListNode?

    init(_ val: Int, _ next: ListNode? = nil) {

        self.val = val

        self.next = next
    }
}

//==========================================================
// Create Linked List
//==========================================================

func createListNode(_ values: [Int]) -> ListNode? {

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
//==========================================================

func traverseNode(_ head: ListNode?) {

    var current = head

    while let node = current {

        print(node.val, terminator: " -> ")

        current = node.next
    }

    print("nil")
}

//==========================================================
// Reverse Linked List
//==========================================================

func reverseList(_ head: ListNode?) -> ListNode? {

    //------------------------------------------------------
    // Step 1
    // Create Previous Pointer
    //------------------------------------------------------

    var prev: ListNode? = nil

    // nil

    //------------------------------------------------------
    // Step 2
    // Create Current Pointer
    //------------------------------------------------------

    var current = head

    // prev            current
    //  ↓                 ↓
    // nil      1 -> 2 -> 3 -> 4 -> 5

    //------------------------------------------------------
    // Step 3
    // Start Traversing
    //------------------------------------------------------

    while let node = current {

        //--------------------------------------------------
        // Step 4
        // Save Next Node
        //--------------------------------------------------

        let nextNode = node.next

        // prev      current      nextNode
        //  ↓           ↓            ↓
        // nil         1            2

        //--------------------------------------------------
        // Step 5
        // Reverse Pointer
        //--------------------------------------------------

        node.next = prev

        // 1 -> nil
        //
        // 2 -> 3 -> 4 -> 5

        //--------------------------------------------------
        // Step 6
        // Move Previous
        //--------------------------------------------------

        prev = node

        // prev
        //  ↓
        // 1 -> nil

        //--------------------------------------------------
        // Step 7
        // Move Current
        //--------------------------------------------------

        current = nextNode

        // prev              current
        //  ↓                   ↓
        // 1 -> nil      2 -> 3 -> 4 -> 5
    }

    //------------------------------------------------------
    // Step 8
    // Return New Head
    //------------------------------------------------------

    return prev
}

//==========================================================
// Test
//==========================================================

let head = createListNode([1,2,3,4,5])

print("Original")

traverseNode(head)

print()

print("Reverse")

let reverse = reverseList(head)

traverseNode(reverse)
