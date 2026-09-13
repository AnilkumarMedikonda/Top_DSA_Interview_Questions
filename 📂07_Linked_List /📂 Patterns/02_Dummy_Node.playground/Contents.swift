import Foundation

//==========================================================
// PATTERN 02 — DUMMY NODE
//==========================================================
//
// WHAT
// A Dummy Node is a fake node placed before the real head.
//
// WHY
// Eliminates special handling when the head changes.
//
// PATTERN
//
// Dummy
//   ↓
// dummy.next = head
//   ↓
// current = dummy
//   ↓
// Modify Links
//   ↓
// return dummy.next
//
// USED IN
//
// ✓ LC021 Merge Two Sorted Lists
// ✓ LC019 Remove Nth Node From End
// ✓ LC024 Swap Nodes In Pairs
// ✓ LC092 Reverse Linked List II
// ✓ LC203 Remove Linked List Elements
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
//
// Time  O(n)
// Space O(n)
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
//
// Time  O(n)
// Space O(1)
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
// Insert At Head Using Dummy Node
//
// Time  O(1)
// Space O(1)
//==========================================================

func insertAtHead(_ head: ListNode?, _ value: Int) -> ListNode? {

    // Step 1
    let dummy = ListNode(0)

    // 0

    // Step 2
    dummy.next = head

    // 0 → 1 → 2 → 3 → 4

    // Step 3
    let newNode = ListNode(value)

    // 100

    // Step 4
    newNode.next = dummy.next

    // 100 → 1 → 2 → 3 → 4

    // Step 5
    dummy.next = newNode

    // 0 → 100 → 1 → 2 → 3 → 4

    // Step 6
    return dummy.next

    // 100 → 1 → 2 → 3 → 4
}

//==========================================================
// Delete Head Using Dummy Node
//
// Time  O(1)
// Space O(1)
//==========================================================

func deleteHead(_ head: ListNode?) -> ListNode? {

    // Step 1
    let dummy = ListNode(0)

    // Step 2
    dummy.next = head

    // 0 → 1 → 2 → 3 → 4

    // Step 3
    dummy.next = dummy.next?.next

    // 0 → 2 → 3 → 4

    // Step 4
    return dummy.next

    // 2 → 3 → 4
}

//==========================================================
// Tests
//==========================================================

print("========== Original ==========")

let head = createListNode([1, 2, 3, 4, 5])

traverseNode(head)

print("\n========== Insert At Head ==========")

let inserted = insertAtHead(head, 100)

traverseNode(inserted)

print("\n========== Delete Head ==========")

let deleted = deleteHead(head)

traverseNode(deleted)
