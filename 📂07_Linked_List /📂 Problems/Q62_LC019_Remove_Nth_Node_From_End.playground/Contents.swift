import Foundation

//==========================================================
// Q62 - LC019 Remove Nth Node From End
//==========================================================
//
// Pattern : 02 Dummy Node + 04 Fixed Gap Pointer
//
// Problem
// Given the head of a linked list, remove the nth node from the
// end of the list and return the head.
//
// Example 1
// Input   1 -> 2 -> 3 -> 4 -> 5,  n = 2
// Output  1 -> 2 -> 3 -> 5
//
// Example 2
// Input   1,  n = 1
// Output  nil
//
// Example 3
// Input   1 -> 2,  n = 1
// Output  1
//
// Constraints
// number of nodes is sz, 1 <= sz <= 30
// 1 <= n <= sz
// 0 <= Node.val <= 100
//
// Follow-up: do it in one pass.
//
// WHY THE GAP IS n + 1, NOT n
// A gap of n lands slow ON the target, and a singly linked list
// gives no way back to its predecessor. Starting both pointers
// at the dummy and moving fast n + 1 leaves slow exactly one
// node short of the target — which is where the unlink happens.
//
// WHY THE DUMMY IS MANDATORY
// n == length removes the head. Without a dummy there is no
// previous node to write to. Example 2 is exactly that case.
//
// Time  : O(n)
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

func traverseList(_ headNode: ListNode?) {
    var current = headNode

    while let node = current {
        print(node.value, terminator: " -> ")

        current = node.next
    }

    print("nil")
}


//==========================================================
// Brute Force
// Count the length, then walk to the node BEFORE the target
// at index length - n - 1.
//
// Time  O(n) - two passes, 2n is O(n)
// Space O(1) - a counter and two pointers
//
// Same complexity class as the optimal. The fixed gap buys ONE
// PASS, not less memory — which is why the follow-up asks for
// one pass. It matters when the list is a stream you cannot
// rewind, or when the traversal itself is expensive.
//==========================================================

func removeNthNodeBruteForce(_ head: ListNode?, _ n: Int) -> ListNode? {
    guard n > 0 else { return head }

    var length = 0
    var current = head

    while let node = current {
        length += 1
        current = node.next
    }

    guard n <= length else { return head }

    let dummy = ListNode(value: 0)
    dummy.next = head
    var previous = dummy
    var index = 0

    while index < length - n, let next = previous.next {
        previous = next
        index += 1
    }

    if let victim = previous.next {
        previous.next = victim.next
    }

    return dummy.next
}


//==========================================================
// Optimal — fixed gap, one pass
//
// Step 1  dummy in front, both pointers start on it
// Step 2  advance fast n + 1 steps, bailing if the list is
//         shorter than n
// Step 3  move both together until fast falls off the end
// Step 4  slow is now one before the target — unlink it
// Step 5  return dummy.next
//
// Time  O(n) - fast walks the list once, slow walks part of it
// Space O(1) - two pointers and a dummy
//==========================================================

func removeNthNode(_ head: ListNode?, _ n: Int) -> ListNode? {
    guard n > 0 else { return head }

    //------------------------------------------------------
    // Step 1
    // Dummy so the head is not a special case
    //------------------------------------------------------

    let dummy = ListNode(value: 0)
    dummy.next = head
    var slow: ListNode? = dummy
    var fast: ListNode? = dummy

    //------------------------------------------------------
    // Step 2
    // Open the gap. Running out of nodes here means n is
    // larger than the list — leave it unchanged.
    //------------------------------------------------------

    for _ in 0...n {
        if fast == nil {
            return head
        }

        fast = fast?.next
    }

    //------------------------------------------------------
    // Step 3
    // Move together. The gap is fixed, so when fast reaches
    // nil, slow is n + 1 from the end.
    //------------------------------------------------------

    while let fastNode = fast {
        fast = fastNode.next
        slow = slow?.next
    }

    //------------------------------------------------------
    // Step 4
    // Unlink the node after slow — deleteNext from D3
    //------------------------------------------------------

    if let slowNode = slow, let victim = slowNode.next {
        slowNode.next = victim.next
    }

    //------------------------------------------------------
    // Step 5
    // The head may have changed, so read it off the dummy
    //------------------------------------------------------

    return dummy.next
}


//==========================================================
// Tests
//==========================================================

print("\n========== Q62 - Remove Nth Node From End ==========")

traverseList(removeNthNode(createList([1, 2, 3, 4, 5]), 2))              // 1 -> 2 -> 3 -> 5 -> nil

traverseList(removeNthNode(createList([1]), 1))                          // nil

traverseList(removeNthNode(createList([1, 2]), 1))                       // 1 -> nil

traverseList(removeNthNode(createList([1, 2]), 2))                       // 2 -> nil

traverseList(removeNthNode(createList([1, 2, 3, 4, 5]), 5))              // 2 -> 3 -> 4 -> 5 -> nil

traverseList(removeNthNode(createList([1, 2, 3, 4, 5]), 1))              // 1 -> 2 -> 3 -> 4 -> nil

traverseList(removeNthNode(createList([1, 2, 3]), 99))                   // 1 -> 2 -> 3 -> nil

traverseList(removeNthNodeBruteForce(createList([1, 2, 3, 4, 5]), 2))    // 1 -> 2 -> 3 -> 5 -> nil

traverseList(removeNthNodeBruteForce(createList([1]), 1))                // nil

traverseList(removeNthNodeBruteForce(createList([1, 2, 3, 4, 5]), 5))    // 2 -> 3 -> 4 -> 5 -> nil
