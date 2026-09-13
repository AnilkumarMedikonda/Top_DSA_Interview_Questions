import Foundation

//==========================================================
// PATTERN 05 — MERGE TWO SORTED LISTS
//==========================================================
//
// WHAT
// Merge two sorted linked lists into one sorted list.
//
// WHY
// Always attach the smaller node.
//
// WHEN IT FIRES
//
// ✓ LC021 Merge Two Sorted Lists
// ✓ Merge Sort (Linked List)
//
// PATTERN
//
// Create Dummy
//      ↓
// Create Tail
//      ↓
// Compare First & Second
//      ↓
// Attach Smaller Node
//      ↓
// Move Tail
//      ↓
// Move Selected List
//      ↓
// Attach Remaining List
//      ↓
// Return dummy.next
//
// Time  : O(n + m)
// Space : O(1)
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
//==========================================================

func createListNode(_ values: [Int]) -> ListNode? {

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
//==========================================================

func traverseListNode(_ head: ListNode?) {

    var current = head

    while let node = current {

        print(node.value, terminator: " -> ")

        current = node.next
    }

    print("nil")
}

//==========================================================
// Merge Two Sorted Lists
//
// Time  : O(n + m)
// Space : O(1)
//==========================================================

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

    //------------------------------------------------------
    // Step 1
    // Create Dummy Node
    //------------------------------------------------------

    let dummy = ListNode(value: 0)

    //------------------------------------------------------
    // Step 2
    // Tail Starts At Dummy
    //------------------------------------------------------

    var tail: ListNode? = dummy

    //------------------------------------------------------
    // Step 3
    // Create Traversal Pointers
    //------------------------------------------------------

    var first = l1

    var second = l2

    //------------------------------------------------------
    // Step 4
    // Compare Both Lists
    //------------------------------------------------------

    while let firstNode = first,
          let secondNode = second {

        //--------------------------------------------------
        // Step 5
        // Attach Smaller Node
        //--------------------------------------------------

        if firstNode.value <= secondNode.value {

            tail?.next = firstNode

            first = firstNode.next

        } else {

            tail?.next = secondNode

            second = secondNode.next
        }

        //--------------------------------------------------
        // Step 6
        // Move Tail
        //--------------------------------------------------

        tail = tail?.next
    }

    //------------------------------------------------------
    // Step 7
    // Attach Remaining Nodes
    //------------------------------------------------------

    if let first {

        tail?.next = first

    } else {

        tail?.next = second
    }

    //------------------------------------------------------
    // Step 8
    // Return Merged List
    //------------------------------------------------------

    return dummy.next
}

//==========================================================
// Tests
//==========================================================

let list1 = createListNode([1, 3, 5, 7])

let list2 = createListNode([2, 4, 6, 8])

print("========== List 1 ==========")

traverseListNode(list1)

print()

print("========== List 2 ==========")

traverseListNode(list2)

print()

print("========== Merged List ==========")

let mergedList = mergeTwoLists(list1, list2)

traverseListNode(mergedList)

traverseListNode(mergeTwoLists(createListNode([1, 2, 3]), nil))        // 1 -> 2 -> 3 -> nil

traverseListNode(mergeTwoLists(nil, nil))                             // nil

traverseListNode(mergeTwoLists(createListNode([1, 1]), createListNode([1, 1])))   // 1 -> 1 -> 1 -> 1 -> nil

traverseListNode(mergeTwoLists(createListNode([1, 2]), createListNode([9, 10])))  // 1 -> 2 -> 9 -> 10 -> nil
