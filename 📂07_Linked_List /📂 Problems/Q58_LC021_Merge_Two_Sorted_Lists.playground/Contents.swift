import Foundation

//==========================================================
// Q58 - LC021 Merge Two Sorted Lists
//==========================================================
//
// Pattern : 02 Dummy Node + 05 Merge Two Lists
//
// Problem
// Merge two sorted linked lists into one sorted list by splicing
// the existing nodes together. Return the head of the merged list.
//
// Example 1
// Input   list1 = 1 -> 2 -> 4,  list2 = 1 -> 3 -> 4
// Output  1 -> 1 -> 2 -> 3 -> 4 -> 4 -> nil
//
// Example 2
// Input   list1 = nil,  list2 = nil
// Output  nil
//
// Example 3
// Input   list1 = nil,  list2 = 0
// Output  0 -> nil
//
// Constraints
// 0 <= number of nodes in each list <= 50
// -100 <= Node.val <= 100
// Both lists are sorted in non-decreasing order
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
//
// Time  O(n)
// Space O(n)
//==========================================================

func createLinkList(_ values: [Int]) -> ListNode? {
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
// Brute Force
// Collect both lists into an array, merge the arrays by index,
// rebuild a new list from the result.
//
// Time  O(n + m) - three linear passes
// Space O(n + m) - the values array plus a whole new list
//
// Worse than optimal on space for no gain. It also allocates n+m
// new nodes where the optimal splices the existing ones, so the
// input lists survive here but are consumed by the optimal.
//==========================================================

func mergeTwoSortListBruteForce(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    var firstValues: [Int] = []
    var secondValues: [Int] = []
    var current = list1

    while let node = current {
        firstValues.append(node.value)
        current = node.next
    }

    current = list2

    while let node = current {
        secondValues.append(node.value)
        current = node.next
    }

    var merged: [Int] = []
    var i = 0
    var j = 0

    while i < firstValues.count, j < secondValues.count {
        if firstValues[i] <= secondValues[j] {
            merged.append(firstValues[i])
            i += 1
        } else {
            merged.append(secondValues[j])
            j += 1
        }
    }

    while i < firstValues.count {
        merged.append(firstValues[i])
        i += 1
    }

    while j < secondValues.count {
        merged.append(secondValues[j])
        j += 1
    }

    return createLinkList(merged)
}


//==========================================================
// Optimal
// Dummy node plus a moving tail. Compare the two heads, splice
// the smaller one on, advance that list. When one runs out, the
// remainder of the other attaches in a single move — it is
// already sorted and already linked.
//
// Step 1  dummy in front, tail starts on it
// Step 2  while BOTH lists have nodes, attach the smaller
// Step 3  advance tail to the node just attached
// Step 4  one list is now empty; attach whatever is left
// Step 5  return dummy.next
//
// <= not < keeps the merge stable: on a tie, list1 goes first.
// Irrelevant to correctness here, relevant in merge sort, and
// it gets asked.
//
// Time  O(n + m) - each node is visited exactly once
// Space O(1) - one dummy node, no allocation per element
//==========================================================

func mergeTwoSortList(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {

    //------------------------------------------------------
    // Step 1
    // Dummy in front so the smaller head is not a special case
    //------------------------------------------------------

    let dummy = ListNode(value: 0)
    var tail = dummy
    var first = list1
    var second = list2

    //------------------------------------------------------
    // Step 2
    // Both lists still have nodes — compare and attach
    //------------------------------------------------------

    while let firstNode = first, let secondNode = second {

        if firstNode.value <= secondNode.value {
            tail.next = firstNode
            tail = firstNode
            first = firstNode.next
        } else {
            tail.next = secondNode
            tail = secondNode
            second = secondNode.next
        }
    }

    //------------------------------------------------------
    // Step 3
    // One list is exhausted. The other is sorted and linked,
    // so the entire remainder attaches in one assignment.
    //------------------------------------------------------

    if let first = first {
        tail.next = first
    } else {
        tail.next = second
    }

    //------------------------------------------------------
    // Step 4
    // The real head is whatever ended up after the dummy
    //------------------------------------------------------

    return dummy.next
}


//==========================================================
// Tests
//==========================================================

print("\n========== Q58 - Merge Two Sorted Lists ==========")

traverseList(mergeTwoSortList(createLinkList([1, 2, 4]), createLinkList([1, 3, 4])))          // 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> nil

traverseList(mergeTwoSortList(createLinkList([1, 3, 5, 7]), createLinkList([2, 4, 6, 8])))    // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> nil

traverseList(mergeTwoSortList(createLinkList([]), createLinkList([1, 2, 3])))                 // 1 -> 2 -> 3 -> nil

traverseList(mergeTwoSortList(createLinkList([5, 6, 7]), createLinkList([])))                 // 5 -> 6 -> 7 -> nil

traverseList(mergeTwoSortList(createLinkList([]), createLinkList([])))                        // nil

traverseList(mergeTwoSortList(createLinkList([-5, -3, -1]), createLinkList([-4, -2, 0])))     // -5 -> -4 -> -3 -> -2 -> -1 -> 0 -> nil

traverseList(mergeTwoSortList(createLinkList([1, 2]), createLinkList([9, 10])))               // 1 -> 2 -> 9 -> 10 -> nil

traverseList(mergeTwoSortList(createLinkList([1, 1]), createLinkList([1, 1])))                // 1 -> 1 -> 1 -> 1 -> nil

traverseList(mergeTwoSortListBruteForce(createLinkList([1, 2, 4]), createLinkList([1, 3, 4])))   // 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> nil
