// ==========================================================
// LINKED LIST — NOTES
// ==========================================================
//
// A node holds a value and a reference to the next node.
// No index, no contiguous memory — the only way in is the head,
// and the only way forward is node.next.
//
// COST
// Access by position   O(n)   must walk from head
// Insert / delete      O(1)   IF you already hold the node before it
// Search               O(n)
// Space overhead       one reference per node
//
// vs ARRAY
// Array wins on random access and cache locality.
// List wins when you are splicing in the middle and already hold
// the pointer — no shifting. That "already hold it" is the catch.
//
// SWIFT SPECIFICS
// 1. class, not struct. A struct with a next of its own type is
//    infinitely sized and will not compile. Reference semantics
//    are what make a list a list.
// 2. next is Optional. Every traversal is an unwrap:
//       while let node = current { current = node.next }
//    Never while current != nil { current!.next }.
// 3. let node = head still allows node.next = x. let freezes the
//    variable, not the object. Only pointers you re-point need var.
// 4. === compares identity, == compares value. Cycle detection
//    needs ===; values repeat, references do not.
// 5. ARC frees a node when nothing points to it. Drop the head and
//    the whole chain goes. A cycle keeps itself alive — real leak.
//
// THE THREE MOVES
// Reverse      previous / current / next, re-point backwards
// Dummy node   fake head so the real head is never a special case
// Slow / fast  speed difference finds middle and cycle in one pass
//
// MOVE vs EDIT — the distinction behind every bug in this file
// current = node.next    moves YOUR pointer. The list is untouched.
// node.next = other      edits the LIST. The arrow itself changes.
// Traversal is all move. Insert and delete are all edit. Writing a
// move where an edit belongs leaves the list unchanged; writing
// node.next = node builds a self-cycle and hangs every later walk.
//
// UNIVERSAL TRAPS
// - Losing the tail: overwrite node.next before saving it and the
//   rest of the list is gone.
// - Returning current after a reverse loop — it is nil. Return previous.
// - Splitting without nil-ing the cut point; the halves stay joined.
// - Walking past the end: guard node.next, not just node, when you
//   need the last node rather than nil.
// - A loop with two exit conditions needs a check after it. Exiting
//   on "ran out of nodes" is not the same as arriving at the target.
// ==========================================================


final class ListNode {
    var val: Int
    var next: ListNode?

    init(_ val: Int) {
        self.val = val
    }
}


// ---------- D1 : Create and print ----------

// createLinkedList
// Time  O(n) - one pass over values, one node allocated each step
// Space O(n) - the list itself; O(1) auxiliary
func createLinkedList(_ values: [Int]) -> ListNode? {
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

// printListNode
// Time  O(n) - visits every node once
// Space O(1) - one moving pointer
func printListNode(_ head: ListNode?) {
    var current = head

    while let node = current {
        print(node.val, terminator: " -> ")

        current = node.next
    }

    print("nil")
}


// ---------- D2 : Count and index ----------

// countNodes
// Time  O(n) - visits every node once
// Space O(1) - one pointer and one counter
func countNodes(_ head: ListNode?) -> Int {
    var current = head
    var count = 0

    while let node = current {
        current = node.next
        count += 1
    }

    return count
}

// nodeAt
// Time  O(n) - walks at most every node once
// Space O(1) - one pointer and one counter
func nodeAt(_ head: ListNode?, _ index: Int) -> ListNode? {
    guard index >= 0 else { return nil }

    var current = head
    var count = 0

    while let node = current {
        if count == index {
            return node
        }

        current = node.next
        count += 1
    }

    return nil
}


// ---------- D3 : Insert and delete ----------

// insert — by position, walks first
// Time  O(n) - walks to position - 1 before splicing
// Space O(1) - one new node, one moving pointer
func insert(_ head: ListNode?, _ value: Int, at position: Int) -> ListNode? {
    guard position >= 0 else { return head }
    let newNode = ListNode(value)

    if position == 0 {
        newNode.next = head
        return newNode
    }

    guard let head = head else { return nil }
    var current = head
    var index = 0

    while index < position - 1, let next = current.next {
        current = next
        index += 1
    }

    guard index == position - 1 else { return head }
    newNode.next = current.next
    current.next = newNode

    return head
}

// delete — by position, walks first
// Time  O(n) - walks to position - 1 before unlinking
// Space O(1) - one moving pointer
func delete(_ head: ListNode?, at position: Int) -> ListNode? {
    guard position >= 0 else { return head }

    if position == 0 {
        return head?.next
    }

    guard let head = head else { return nil }
    var current = head
    var index = 0

    while index < position - 1, let next = current.next {
        current = next
        index += 1
    }

    guard index == position - 1 else { return head }

    if let victim = current.next {
        current.next = victim.next
    }

    return head
}

// insertAfter — caller already holds the node
// Time  O(1) - no walk
// Space O(1) - one new node
func insertAfter(_ node: ListNode?, _ value: Int) {
    if let node = node {
        let newNode = ListNode(value)
        newNode.next = node.next
        node.next = newNode
    }
}

// deleteNext — caller already holds the node
// Time  O(1) - no walk
// Space O(1) - no allocation
func deleteNext(_ node: ListNode?) {
    if let node = node, let victim = node.next {
        node.next = victim.next
    }
}


// ---------- D4 : Reference identity ----------

// sameNode — identity, not value. Two nils count as the same.
// Time  O(1)
// Space O(1)
func sameNode(_ a: ListNode?, _ b: ListNode?) -> Bool {
    return a === b
}

// containsNode — is this exact node in the list?
// Time  O(n) - visits every node once
// Space O(1) - one moving pointer
func containsNode(_ head: ListNode?, _ target: ListNode?) -> Bool {
    var current = head

    while let node = current {
        if node === target {
            return true
        }

        current = node.next
    }

    return false
}


// ---------- D5 : Split ----------

// splitAfter — cut the list after the given node, return the second half
// Time  O(1) - no walk, the caller already holds the cut point
// Space O(1) - no allocation
func splitAfter(_ node: ListNode?) -> ListNode? {
    guard let node = node else { return nil }
    let secondHalf = node.next
    node.next = nil

    return secondHalf
}


// ---------- Tests ----------

print("\n========== D1 - Create And Print ==========")

printListNode(createLinkedList([1, 2, 3, 4, 5]))   // 1 -> 2 -> 3 -> 4 -> 5 -> nil

printListNode(createLinkedList([7]))               // 7 -> nil

printListNode(createLinkedList([]))                // nil

print("\n========== D2 - Count And Node At ==========")

let listD2 = createLinkedList([10, 20, 30, 40])

print(countNodes(listD2))                          // 4

print(countNodes(nil))                             // 0

if let node = nodeAt(listD2, 0) {
    print(node.val)                                // 10
} else {
    print("nil")
}

if let node = nodeAt(listD2, 3) {
    print(node.val)                                // 40
} else {
    print("nil")
}

if let node = nodeAt(listD2, 4) {
    print(node.val)
} else {
    print("nil")                                   // nil
}

if let node = nodeAt(listD2, -1) {
    print(node.val)
} else {
    print("nil")                                   // nil
}

print("\n========== D3 - Insert And Delete ==========")

printListNode(insert(createLinkedList([1, 2, 3]), 0, at: 0))    // 0 -> 1 -> 2 -> 3 -> nil

printListNode(insert(createLinkedList([1, 2, 3]), 9, at: 2))    // 1 -> 2 -> 9 -> 3 -> nil

printListNode(insert(createLinkedList([1, 2, 3]), 9, at: 50))   // 1 -> 2 -> 3 -> nil

printListNode(delete(createLinkedList([1, 2, 3]), at: 0))       // 2 -> 3 -> nil

printListNode(delete(createLinkedList([1, 2, 3]), at: 2))       // 1 -> 2 -> nil

printListNode(delete(createLinkedList([1, 2, 3]), at: 50))      // 1 -> 2 -> 3 -> nil

let listD3 = createLinkedList([1, 2, 3])

insertAfter(listD3, 9)

printListNode(listD3)                                           // 1 -> 9 -> 2 -> 3 -> nil

deleteNext(listD3)

printListNode(listD3)                                           // 1 -> 2 -> 3 -> nil

deleteNext(nodeAt(listD3, 2))

printListNode(listD3)                                           // 1 -> 2 -> 3 -> nil

print("\n========== D4 - Reference Identity ==========")

let listD4 = createLinkedList([1, 2, 3])

let insideNode = nodeAt(listD4, 1)

print(sameNode(insideNode, insideNode))            // true

print(sameNode(ListNode(5), ListNode(5)))          // false

print(containsNode(listD4, insideNode))            // true

print(containsNode(listD4, ListNode(2)))           // false

print("\n========== D5 - Split ==========")

let listD5 = createLinkedList([1, 2, 3, 4, 5])

let secondHalf = splitAfter(nodeAt(listD5, 1))

printListNode(listD5)                              // 1 -> 2 -> nil

printListNode(secondHalf)                          // 3 -> 4 -> 5 -> nil

printListNode(splitAfter(nil))                     // nil
