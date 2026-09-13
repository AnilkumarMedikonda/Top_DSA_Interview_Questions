import Foundation

//==========================================================
// Q61 - LC002 Add Two Numbers
//==========================================================
//
// Pattern : 02 Dummy Node
//
// Problem
// Two non-empty linked lists represent two non-negative integers.
// The digits are stored in REVERSE order — the head is the ones
// digit — and each node holds a single digit. Add the two numbers
// and return the sum as a linked list, also in reverse order.
//
// Neither number has leading zeros, except the number 0 itself.
//
// Example 1
// Input   l1 = 2 -> 4 -> 3,  l2 = 5 -> 6 -> 4
// Output  7 -> 0 -> 8
// Reason  342 + 465 = 807
//
// Example 2
// Input   l1 = 0,  l2 = 0
// Output  0
//
// Example 3
// Input   l1 = 9 -> 9 -> 9 -> 9 -> 9 -> 9 -> 9,  l2 = 9 -> 9 -> 9 -> 9
// Output  8 -> 9 -> 9 -> 9 -> 0 -> 0 -> 0 -> 1
// Reason  9999999 + 9999 = 10009998
//
// Constraints
// 1 <= number of nodes in each list <= 100
// 0 <= Node.val <= 9
// No leading zeros
//
// Brute force : NONE
// Converting each list to an Int, adding, and rebuilding looks
// obvious and fails: 100 digits overflows Int by roughly 80
// orders of magnitude. That is not a slower solution, it is a
// wrong one. Digit-by-digit with a carry is the only correct
// approach, which is also why this problem is asked.
//
// Reverse order is a gift. The heads are the ones digits, so the
// carry flows in the same direction you are already walking —
// no reversal needed at either end.
//
// Time  : O(max(n, m)) - one pass over the longer list
// Space : O(max(n, m)) - the output list; O(1) auxiliary
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

func traverseList(_ headNode: ListNode?) {
    var current = headNode

    while let node = current {
        print(node.value, terminator: " -> ")

        current = node.next
    }

    print("nil")
}


//==========================================================
// Optimal — dummy node plus a carry
//
// Step 1  dummy in front, tail starts on it
// Step 2  loop while EITHER list has digits OR a carry remains
// Step 3  a missing digit reads as 0, which is what lets lists
//         of different lengths share one loop
// Step 4  sum = value1 + value2 + carry
//         digit = sum % 10, carry = sum / 10
// Step 5  append the digit, advance tail and both lists
// Step 6  return dummy.next
//
// THE LOOP CONDITION IS THE PROBLEM. Writing
//     while first != nil || second != nil
// passes Examples 1 and 2 and fails Example 3 — the final carry
// has nowhere to go and the answer is one digit short. The
// || carry != 0 clause is what grows the list.
//
// Time  O(max(n, m)) - one node produced per iteration
// Space O(max(n, m)) - the output; O(1) auxiliary
//==========================================================

func addTwoNumbers(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {

    //------------------------------------------------------
    // Step 1
    // Dummy in front — the answer's head is not known yet
    //------------------------------------------------------

    let dummy = ListNode(value: 0)
    var tail = dummy
    var first = list1
    var second = list2
    var carry = 0

    //------------------------------------------------------
    // Step 2
    // Digits left, or a carry still to place
    //------------------------------------------------------

    while first != nil || second != nil || carry != 0 {

        //--------------------------------------------------
        // Step 3
        // A list that has run out contributes 0
        //--------------------------------------------------

        var value1 = 0
        var value2 = 0

        if let firstNode = first {
            value1 = firstNode.value
        }

        if let secondNode = second {
            value2 = secondNode.value
        }

        //--------------------------------------------------
        // Step 4
        // Split the sum into the digit kept and the carry
        //--------------------------------------------------

        let sum = value1 + value2 + carry
        carry = sum / 10

        //--------------------------------------------------
        // Step 5
        // Append the digit, advance everything
        //--------------------------------------------------

        let newNode = ListNode(value: sum % 10)
        tail.next = newNode
        tail = newNode

        first = first?.next
        second = second?.next
    }

    //------------------------------------------------------
    // Step 6
    // Whatever landed after the dummy is the answer
    //------------------------------------------------------

    return dummy.next
}


//==========================================================
// Tests
//==========================================================

print("\n========== Q61 - Add Two Numbers ==========")

traverseList(addTwoNumbers(createList([2, 4, 3]), createList([5, 6, 4])))                    // 7 -> 0 -> 8 -> nil

traverseList(addTwoNumbers(createList([0]), createList([0])))                                // 0 -> nil

traverseList(addTwoNumbers(createList([9, 9, 9, 9, 9, 9, 9]), createList([9, 9, 9, 9])))     // 8 -> 9 -> 9 -> 9 -> 0 -> 0 -> 0 -> 1 -> nil

traverseList(addTwoNumbers(createList([1, 8]), createList([0])))                             // 1 -> 8 -> nil

traverseList(addTwoNumbers(createList([5]), createList([5])))                                // 0 -> 1 -> nil

traverseList(addTwoNumbers(createList([9, 9]), createList([1])))                             // 0 -> 0 -> 1 -> nil

traverseList(addTwoNumbers(createList([2, 4, 3]), createList([5])))                          // 7 -> 4 -> 3 -> nil
