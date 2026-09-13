import Foundation

//==========================================================
// PATTERN 06 — K GROUP REVERSE
//==========================================================
//
// WHAT
// Reverse only the first K nodes.
//
// WHY
// Used as the building block for
// Reverse Nodes In K Group (LC25).
//
// WHEN IT FIRES
//
// ✓ Reverse First K Nodes
// ✓ Reverse K Group
//
// PATTERN
//
// Find Kth Node
//      ↓
// Reverse First K Nodes
//      ↓
// Reconnect Groups
//
// Time  : O(k)
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
//
// Time  O(n)
// Space O(n)
//==========================================================

func createList(_ values: [Int]) -> ListNode? {

    guard !values.isEmpty else {

        return nil
    }

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
// Reverse First K Nodes
//
// Time  O(k)
// Space O(1)
//==========================================================

func reverseFirstK(_ head: ListNode?, _ k: Int) -> ListNode? {

    //------------------------------------------------------
    // Step 1
    // Previous Pointer
    //------------------------------------------------------

    var prev: ListNode? = nil

    //------------------------------------------------------
    // Step 2
    // Current Pointer
    //------------------------------------------------------

    var current = head

    //------------------------------------------------------
    // Step 3
    // Count Reversed Nodes
    //------------------------------------------------------

    var count = 0

    //------------------------------------------------------
    // Step 4
    // Reverse K Nodes
    //------------------------------------------------------

    while count < k,
          let node = current {

        //--------------------------------------------------
        // Step 5
        // Save Next Node
        //--------------------------------------------------

        let nextNode = node.next

        //--------------------------------------------------
        // Step 6
        // Reverse Link
        //--------------------------------------------------

        node.next = prev

        //--------------------------------------------------
        // Step 7
        // Move Previous
        //--------------------------------------------------

        prev = node

        //--------------------------------------------------
        // Step 8
        // Move Current
        //--------------------------------------------------

        current = nextNode

        //--------------------------------------------------
        // Step 9
        // Increase Count
        //--------------------------------------------------

        count += 1
    }

    //------------------------------------------------------
    // Step 10
    // Return New Head
    //------------------------------------------------------

    return prev
}

//==========================================================
// Algorithm
// Find Kth Node
//
// Time  O(k)
// Space O(1)
//==========================================================

func findKthNode(_ head: ListNode?, _ k: Int) -> ListNode? {

    //------------------------------------------------------
    // Step 1
    // Current Pointer
    //------------------------------------------------------

    var current = head

    //------------------------------------------------------
    // Step 2
    // Move K-1 Steps
    //------------------------------------------------------

    for _ in 1..<k {

        current = current?.next

        if current == nil {

            return nil
        }
    }

    //------------------------------------------------------
    // Step 3
    // Return Kth Node
    //------------------------------------------------------

    return current
}

//==========================================================
// Tests
//==========================================================

let head = createList([1,2,3,4,5,6])

print("========== Original List ==========")

traverseList(head)

print()

print("========== Kth Node (k = 3) ==========")

if let kth = findKthNode(head, 3) {

    print(kth.value)
}

print()

print("========== Reverse First 3 Nodes ==========")

let reversed = reverseFirstK(head, 3)

traverseList(reversed)

//==========================================================
// Tests
//==========================================================

//----------------------------------------------------------
// Test 1
// Find 3rd Node
//----------------------------------------------------------

print("========== Test 1 : Find 3rd Node ==========")

let head1 = createList([1,2,3,4,5,6])

traverseList(head1)

if let kth = findKthNode(head1, 3) {

    print("Kth Node :", kth.value)
}

print()


//----------------------------------------------------------
// Test 2
// Reverse First 3 Nodes
//----------------------------------------------------------

print("========== Test 2 : Reverse First 3 Nodes ==========")

let head2 = createList([1,2,3,4,5,6])

traverseList(head2)

let reverseThree = reverseFirstK(head2, 3)

traverseList(reverseThree)

print()


//----------------------------------------------------------
// Test 3
// Reverse First 1 Node
//----------------------------------------------------------

print("========== Test 3 : Reverse First 1 Node ==========")

let head3 = createList([1,2,3,4,5])

traverseList(head3)

let reverseOne = reverseFirstK(head3, 1)

traverseList(reverseOne)

print()


//----------------------------------------------------------
// Test 4
// Reverse Entire List
//----------------------------------------------------------

print("========== Test 4 : Reverse First 5 Nodes ==========")

let head4 = createList([1,2,3,4,5])

traverseList(head4)

let reverseFive = reverseFirstK(head4, 5)

traverseList(reverseFive)

print()


//----------------------------------------------------------
// Test 5
// K Greater Than Length
//----------------------------------------------------------

print("========== Test 5 : Find 10th Node ==========")

let head5 = createList([1,2,3,4,5])

traverseList(head5)

let kthNode = findKthNode(head5, 10)

print(kthNode == nil ? "Kth Node : nil" : "Found")

print()


//----------------------------------------------------------
// Test 6
// Empty List
//----------------------------------------------------------

print("========== Test 6 : Empty List ==========")

let head6 = createList([])

traverseList(head6)

let reverseEmpty = reverseFirstK(head6, 3)

traverseList(reverseEmpty)

print()


//----------------------------------------------------------
// Test 7
// Single Node
//----------------------------------------------------------

print("========== Test 7 : Single Node ==========")

let head7 = createList([1])

traverseList(head7)

let reverseSingle = reverseFirstK(head7, 1)

traverseList(reverseSingle)
