import Foundation

//==========================================================
// PATTERN 04 — FIXED GAP POINTER
//==========================================================
//
// WHAT
// Keep a fixed gap between Slow and Fast.
//
// WHY
// Find the Nth Node From End
// without counting the list length.
//
// WHEN IT FIRES
//
// ✓ LC019 Remove Nth Node From End
// ✓ Find Kth Node From End
//
// PATTERN
//
// Dummy
//    ↓
// slow = dummy
// fast = dummy
//
// Move Fast (n + 1)
//
// Move Slow & Fast Together
//
// Fast == nil
//
// Slow Before Target
//
// Delete Target
//
// Return dummy.next
//
// COMPLEXITY
//
// Time  : O(n)
//
// Space : O(1)
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
// Remove Nth Node From End
//==========================================================

func removeNthNode(_ head: ListNode?, _ n: Int) -> ListNode? {

    //------------------------------------------------------
    // Step 1
    // Create Dummy Node
    //------------------------------------------------------

    let dummy = ListNode(0)

    // 0

    //------------------------------------------------------
    // Step 2
    // Connect Dummy To Head
    //------------------------------------------------------

    dummy.next = head

    // 0 -> 1 -> 2 -> 3 -> 4 -> 5

    //------------------------------------------------------
    // Step 3
    // Create Slow Pointer
    //------------------------------------------------------

    var slow: ListNode? = dummy

    // slow
    //  ↓
    // 0 -> 1 -> 2 -> 3 -> 4 -> 5

    //------------------------------------------------------
    // Step 4
    // Create Fast Pointer
    //------------------------------------------------------

    var fast: ListNode? = dummy

    // slow
    //  ↓
    // 0 -> 1 -> 2 -> 3 -> 4 -> 5
    //  ↑
    // fast

    //------------------------------------------------------
    // Step 5
    // Move Fast (n + 1) Steps
    //------------------------------------------------------

    for _ in 0...n {
        
        if fast == nil {
            return head
        }

        fast = fast?.next
    }

    // Example (n = 2)
    //
    // slow -> 0
    // fast -> 3

    //------------------------------------------------------
    // Step 6
    // Move Slow & Fast Together
    //------------------------------------------------------

    while let fastNode = fast {

        slow = slow?.next

        fast = fast?.next
    }

    // Example
    //
    // slow -> 3
    // fast -> nil

    //------------------------------------------------------
    // Step 7
    // Delete Target Node
    //------------------------------------------------------

    if let slowNode = slow, let victim = slowNode.next {
        slowNode.next = victim.next
    }

    // Before
    //
    // 3 -> 4 -> 5
    //
    // After
    //
    // 3 -----> 5

    //------------------------------------------------------
    // Step 8
    // Return New Head
    //------------------------------------------------------

    return dummy.next
}

//==========================================================
// Tests
//==========================================================

print("========== Original ==========")

let head = createList([1,2,3,4,5])

traverseList(head)

print()

print("========== Remove 2nd Node From End ==========")

let result = removeNthNode(head, 2)

traverseList(result)

traverseList(removeNthNode(createList([1, 2, 3, 4, 5]), 5))   // 2 -> 3 -> 4 -> 5 -> nil, head removed
traverseList(removeNthNode(createList([1]), 1))               // nil
traverseList(removeNthNode(createList([1, 2, 3]), 99))        // 1 -> 2 -> 3 -> nil, unchanged
