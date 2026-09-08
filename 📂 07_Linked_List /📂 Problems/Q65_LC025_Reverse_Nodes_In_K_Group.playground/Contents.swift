import Foundation

//==========================================================
// Q65 - LC025 Reverse Nodes In K Group
//==========================================================
//
// Pattern : 06 K Group Reverse
//
// Problem
// Given the head of a linked list, reverse the nodes k at a time
// and return the modified list. If the number of nodes is not a
// multiple of k, the leftover nodes at the end stay as they are.
// Values may not be changed — only the nodes themselves may be
// relinked.
//
// Example 1
// Input   1 -> 2 -> 3 -> 4 -> 5,  k = 2
// Output  2 -> 1 -> 4 -> 3 -> 5
//
// Example 2
// Input   1 -> 2 -> 3 -> 4 -> 5,  k = 3
// Output  3 -> 2 -> 1 -> 4 -> 5
//
// Constraints
// number of nodes is n, 1 <= k <= n <= 5000
// 0 <= Node.val <= 1000
//
// Follow-up: O(1) extra memory.
//
// WHY IT IS HARD
// The reversal is Pattern 01, unchanged. What is new is the
// bookkeeping: each reversed group must be stitched to the group
// before it and to the group after it, and both of those pointers
// are destroyed by the reversal that produces them. So both get
// saved before the reversal runs.
//
// THE FACT THAT CARRIES IT
// groupStart is the group's HEAD going in and its TAIL coming
// out. That is why groupStart.next = groupNext reattaches the
// rest of the list, and why groupPrev = groupStart is the right
// advance for the next round.
//
// WHY THE DUMMY IS MANDATORY
// The first group's reversal changes the head, so the stitch
// needs a node in front to write to.
//
// THE CUT
// kth.next = nil before reversing means the plain reverse works
// unchanged and stops on its own. The alternative is seeding
// prev = groupNext and stopping on identity — same result, more
// to explain. The cut is clearer out loud.
//
// Brute force : none written. The array version — collect the
// values, reverse each chunk of k, rebuild — works but is O(n)
// space and teaches nothing about pointers.
//
// Time  : O(n) - each node is visited twice, once by the kth
//                walk and once by the reversal. 2n is O(n).
// Space : O(1) - four pointers, no allocation
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

func traverseList(_ head: ListNode?) {
    var current = head

    while let node = current {
        print(node.value, terminator: " -> ")

        current = node.next
    }

    print("nil")
}


//==========================================================
// Reverse — Pattern 01, unchanged
//
// Time  O(n)
// Space O(1)
//==========================================================

func reverseNode(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var current = head

    while let node = current {
        let nextNode = node.next
        node.next = prev
        prev = node
        current = nextNode
    }

    return prev
}


//==========================================================
// Find the kth node from a starting node.
// Returns nil when fewer than k nodes remain — that nil is the
// signal to stop, leaving the tail unreversed.
//
// Time  O(k)
// Space O(1)
//==========================================================

func kthNode(_ head: ListNode?, _ k: Int) -> ListNode? {
    var current = head

    for _ in 1..<k {
        current = current?.next

        if current == nil {
            return nil
        }
    }

    return current
}


//==========================================================
// Optimal
//
// Step 1  dummy in front, groupPrev starts on it
// Step 2  find kth, the last node of this group.
//         nil means fewer than k remain — stop.
// Step 3  save groupNext, then CUT so the reverse stops there
// Step 4  reverse the detached group
// Step 5  stitch the front: groupPrev.next = newHead
// Step 6  stitch the back: groupStart is now the tail
// Step 7  advance groupPrev to that tail
//
// TRACE  1 -> 2 -> 3 -> 4 -> 5,  k = 3
//   groupPrev = dummy, kth = 3, groupNext = 4
//   cut       1 -> 2 -> 3 -> nil
//   reverse   3 -> 2 -> 1
//   front     dummy -> 3
//   back      1 -> 4
//   advance   groupPrev = 1
//   next round: kth from 4 walks 4, 5, nil -> nil, stop
//   result    3 -> 2 -> 1 -> 4 -> 5
//
// Time  O(n)
// Space O(1)
//==========================================================

func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
    guard k > 1 else { return head }

    //------------------------------------------------------
    // Step 1
    // Dummy in front — the first group changes the head
    //------------------------------------------------------

    let dummy = ListNode(value: 0)
    dummy.next = head
    var groupPrev: ListNode? = dummy

    while true {

        //--------------------------------------------------
        // Step 2
        // Last node of this group, or nil to stop
        //--------------------------------------------------

        guard let kth = kthNode(groupPrev?.next, k) else {
            break
        }

        //--------------------------------------------------
        // Step 3
        // Save what follows, then cut the group loose
        //--------------------------------------------------

        let groupNext = kth.next
        kth.next = nil

        //--------------------------------------------------
        // Step 4
        // Reverse it. groupStart goes in as the head and
        // comes out as the tail.
        //--------------------------------------------------

        let groupStart = groupPrev?.next
        let newHead = reverseNode(groupStart)

        //--------------------------------------------------
        // Step 5 and 6
        // Stitch both ends
        //--------------------------------------------------

        groupPrev?.next = newHead
        groupStart?.next = groupNext

        //--------------------------------------------------
        // Step 7
        // The old head is the new tail — start there next
        //--------------------------------------------------

        groupPrev = groupStart
    }

    return dummy.next
}


//==========================================================
// Tests
//==========================================================

print("\n========== Q65 - Reverse Nodes In K Group ==========")

traverseList(reverseKGroup(createList([1, 2, 3, 4, 5]), 3))       // 3 -> 2 -> 1 -> 4 -> 5 -> nil

traverseList(reverseKGroup(createList([1, 2, 3, 4, 5]), 2))       // 2 -> 1 -> 4 -> 3 -> 5 -> nil

traverseList(reverseKGroup(createList([1, 2, 3, 4, 5, 6]), 3))    // 3 -> 2 -> 1 -> 6 -> 5 -> 4 -> nil

traverseList(reverseKGroup(createList([1, 2, 3, 4]), 4))          // 4 -> 3 -> 2 -> 1 -> nil

traverseList(reverseKGroup(createList([1, 2, 3]), 5))             // 1 -> 2 -> 3 -> nil

traverseList(reverseKGroup(createList([1, 2, 3]), 1))             // 1 -> 2 -> 3 -> nil

traverseList(reverseKGroup(createList([1]), 2))                   // 1 -> nil

traverseList(reverseKGroup(createList([]), 3))                    // nil
