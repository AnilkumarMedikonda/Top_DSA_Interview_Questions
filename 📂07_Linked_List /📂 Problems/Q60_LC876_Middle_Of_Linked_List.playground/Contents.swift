import Foundation

//==========================================================
// Q60 - LC876 Middle Of Linked List
//==========================================================
//
// Pattern : 03 Slow Fast Pointer
//
// Problem
// Given the head of a singly linked list, return the middle node.
// If there are two middle nodes, return the SECOND one.
//
// Example 1
// Input   1 -> 2 -> 3 -> 4 -> 5
// Output  3 -> 4 -> 5      (node 3)
//
// Example 2
// Input   1 -> 2 -> 3 -> 4 -> 5 -> 6
// Output  4 -> 5 -> 6      (node 4, the SECOND middle)
//
// Constraints
// 1 <= number of nodes <= 100
// 1 <= Node.val <= 100
//
// The function returns a NODE, not a value — LeetCode prints the
// rest of the list from it.
//
// Brute force : count the nodes, then walk count / 2 again.
// Two passes, but O(1) space — the SAME complexity class as the
// optimal. Slow/fast buys ONE PASS, not less memory. Worth saying
// out loud, because the usual assumption is that the optimal
// saves space. Here it saves a traversal, which matters when the
// list is a stream you can only walk once.
//
// TWO MIDDLES
// fast = head        even length gives the SECOND middle  <- this problem
// fast = head.next   even length gives the FIRST middle   <- Q64 needs this
// Odd length gives the same node either way. One character
// apart; know which one the problem wants before writing it.
//
// Time  : O(n)
// Space : O(1)
//
//==========================================================


final class ListNode {
    let val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
    }
}

// Reviewed createList — head from arr[0], empty guard, non-optional walker
func createList(_ arr: [Int]) -> ListNode? {
    guard !arr.isEmpty else { return nil }
    
    let head = ListNode(arr[0])       // from the data, NOT ListNode(0)
    var current = head
    
    for i in 1..<arr.count {
        let node = ListNode(arr[i])
        current.next = node
        current = node
    }
    return head
}

func traverse(_ head: ListNode?) {
    var current = head
    while let node = current {
        print(node.val, terminator: " -> ")
        current = node.next
    }
    print("nil")
}

// Brute force — count, then walk count/2
func middleNode(_ head: ListNode?) -> ListNode? {
    var count = 0
    var current = head
    while let node = current {
        count += 1
        current = node.next
    }
    
    var walker = head
    for _ in 0..<(count / 2) {
        walker = walker?.next
    }
    return walker
}

// Optimal — slow/fast, single .next condition → SECOND middle
func middleNodeOptimal(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head
    
    while let f = fast, let fNext = f.next {
        slow = slow?.next
        fast = fNext.next
    }
    return slow
}


print("\n========== Q60 - Middle Of Linked List ==========")

traverse(middleNodeOptimal(createList([1, 2, 3, 4, 5])))   // 3 -> 4 -> 5 -> nil

traverse(middleNodeOptimal(createList([1, 2, 3, 4])))      // 3 -> 4 -> nil

traverse(middleNodeOptimal(createList([1])))               // 1 -> nil

traverse(middleNode(createList([1, 2, 3, 4, 5])))          // 3 -> 4 -> 5 -> nil

traverse(middleNode(createList([1, 2, 3, 4])))             // 3 -> 4 -> nil

print(middleNodeOptimal(nil) == nil)                       // true
