import Foundation

//==============================================================
// PHASE 07 REVISION — Linked List (Q57–Q65)
// Blind rewrite, corrected
//
// Regressions caught on this pass, all of them ORDERING errors
// rather than misremembered algorithms:
//
// createCycle   dropped the line that saves the cycle node, so
//               no test list ever had a cycle
// middleNode    guarded slow instead of fast
// Q62           assigned the victim to itself instead of past it
// Q63           read pointers off the blank COPY instead of the
//               original, so pass two did nothing
// Q64           nil-ed middle.next before reading it, so the
//               second half was always nil
// Q65           anchored groupPrev on head instead of dummy, so
//               the first group was never reversed
//
// The shared lesson: WHEN you read a pointer matters as much as
// what you write to it.
//==============================================================


// MARK: - Models

final class ListNode {
    var value: Int
    var next: ListNode?

    init(value: Int, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

final class ListNodeRandom {
    var value: Int
    var next: ListNodeRandom?
    var random: ListNodeRandom?

    init(value: Int, next: ListNodeRandom? = nil, random: ListNodeRandom? = nil) {
        self.value = value
        self.next = next
        self.random = random
    }
}


// MARK: - Helpers

// Time O(n) · Space O(n)
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

// Time O(n) · Space O(1)
func traverseList(_ head: ListNode?) {
    var current = head

    while let node = current {
        print(node.value, terminator: " -> ")

        current = node.next
    }

    print("nil")
}

// Test helper only — NEVER traverse the result, it will not terminate.
// Time O(n) · Space O(n)
func createCycle(_ values: [Int], position: Int) -> ListNode? {
    guard !values.isEmpty else { return nil }
    let head = ListNode(value: values[0])
    var current = head
    var cycleNode: ListNode? = nil

    if position == 0 {
        cycleNode = head
    }

    for i in 1..<values.count {
        let node = ListNode(value: values[i])
        current.next = node
        current = node

        if position == i {
            cycleNode = node
        }
    }

    current.next = cycleNode

    return head
}

// SECOND middle on even length — Q60
// Time O(n) · Space O(1)
func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head

    while let fastNode = fast, let fastNext = fastNode.next {
        slow = slow?.next
        fast = fastNext.next
    }

    return slow
}

// FIRST middle on even length — Q64 needs the shorter second half
// Time O(n) · Space O(1)
func middleNodeFirst(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head?.next

    while let fastNode = fast, let fastNext = fastNode.next {
        slow = slow?.next
        fast = fastNext.next
    }

    return slow
}

// Time O(k) · Space O(1)
func findKthNode(_ head: ListNode?, _ k: Int) -> ListNode? {
    var current = head

    for _ in 1..<k {
        current = current?.next

        if current == nil {
            return nil
        }
    }

    return current
}

// Time O(n) · Space O(1)
func printRandomList(_ head: ListNodeRandom?) {
    var current = head

    while let node = current {
        if let random = node.random {
            print("Value:", node.value, " Random:", random.value)
        } else {
            print("Value:", node.value, " Random: nil")
        }

        current = node.next
    }
}


//==============================================================
// Q57 - LC206 Reverse Linked List
//
// Pattern : Reverse
// Save next, flip, advance prev, advance current. Return prev —
// current is nil when the loop exits.
//
// Time O(n) · Space O(1)
//==============================================================

func reverseList(_ head: ListNode?) -> ListNode? {
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

print("\n========== Q57 - Reverse Linked List ==========")

traverseList(reverseList(createList([1, 2, 3, 4, 5])))      // 5 -> 4 -> 3 -> 2 -> 1 -> nil

traverseList(reverseList(createList([1, 2])))               // 2 -> 1 -> nil

traverseList(reverseList(createList([1])))                  // 1 -> nil

traverseList(reverseList(createList([])))                   // nil


//==============================================================
// Q58 - LC021 Merge Two Sorted Lists
//
// Pattern : Dummy Node + Merge
// <= keeps the merge stable. When one list runs out the whole
// remainder attaches in a single assignment.
//
// Time O(n+m) · Space O(1)
//==============================================================

func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    let dummy = ListNode(value: 0)
    var tail = dummy
    var first = list1
    var second = list2

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

    if let first = first {
        tail.next = first
    } else {
        tail.next = second
    }

    return dummy.next
}

print("\n========== Q58 - Merge Two Sorted Lists ==========")

traverseList(mergeTwoLists(createList([1, 2, 4]), createList([1, 3, 4])))        // 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> nil

traverseList(mergeTwoLists(createList([1, 3, 5, 7]), createList([2, 4, 6, 8])))  // 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> nil

traverseList(mergeTwoLists(createList([]), createList([0])))                     // 0 -> nil

traverseList(mergeTwoLists(createList([]), createList([])))                      // nil

traverseList(mergeTwoLists(createList([1, 2]), createList([9, 10])))             // 1 -> 2 -> 9 -> 10 -> nil


//==============================================================
// Q59 - LC141 Linked List Cycle
//
// Pattern : Slow & Fast
// === not ==. Values repeat, references do not. Move first,
// compare second — they start equal at the head.
//
// Time O(n) · Space O(1)
//==============================================================

func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head

    while let fastNode = fast, let fastNext = fastNode.next {
        slow = slow?.next
        fast = fastNext.next

        if slow === fast {
            return true
        }
    }

    return false
}

print("\n========== Q59 - Linked List Cycle ==========")

print(hasCycle(createCycle([3, 2, 0, -4], position: 1)))    // true

print(hasCycle(createCycle([1, 2], position: 0)))           // true

print(hasCycle(createList([1, 2, 3, 4, 5])))                // false

print(hasCycle(createList([1])))                            // false

print(hasCycle(createList([1, 1, 1, 1])))                   // false


//==============================================================
// Q60 - LC876 Middle Of Linked List
//
// Pattern : Slow & Fast
// Returns the SECOND middle on even length. Brute force is
// count-then-walk: two passes, same O(1) space. Slow/fast buys
// one pass, not less memory.
//
// Time O(n) · Space O(1)
//==============================================================

print("\n========== Q60 - Middle Of Linked List ==========")

traverseList(middleNode(createList([1, 2, 3, 4, 5])))       // 3 -> 4 -> 5 -> nil

traverseList(middleNode(createList([1, 2, 3, 4, 5, 6])))    // 4 -> 5 -> 6 -> nil

traverseList(middleNode(createList([1])))                   // 1 -> nil

traverseList(middleNode(createList([1, 2])))                // 2 -> nil


//==============================================================
// Q61 - LC002 Add Two Numbers
//
// Pattern : Dummy Node + carry
// The || carry != 0 clause is what grows the list. Without it
// 9999999 + 9999 comes out one digit short.
//
// Brute force : none. Converting to Int overflows at 100 digits,
// so the naive version is wrong, not slow.
//
// Time O(max(n,m)) · Space O(max(n,m))
//==============================================================

func addTwoNumbers(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    let dummy = ListNode(value: 0)
    var tail = dummy
    var first = list1
    var second = list2
    var carry = 0

    while first != nil || second != nil || carry != 0 {
        var firstValue = 0
        var secondValue = 0

        if let firstNode = first {
            firstValue = firstNode.value
        }

        if let secondNode = second {
            secondValue = secondNode.value
        }

        let sum = firstValue + secondValue + carry
        carry = sum / 10

        let newNode = ListNode(value: sum % 10)
        tail.next = newNode
        tail = newNode

        first = first?.next
        second = second?.next
    }

    return dummy.next
}

print("\n========== Q61 - Add Two Numbers ==========")

traverseList(addTwoNumbers(createList([2, 4, 3]), createList([5, 6, 4])))                 // 7 -> 0 -> 8 -> nil

traverseList(addTwoNumbers(createList([0]), createList([0])))                             // 0 -> nil

traverseList(addTwoNumbers(createList([9, 9, 9, 9, 9, 9, 9]), createList([9, 9, 9, 9])))  // 8 -> 9 -> 9 -> 9 -> 0 -> 0 -> 0 -> 1 -> nil

traverseList(addTwoNumbers(createList([5]), createList([5])))                             // 0 -> 1 -> nil

traverseList(addTwoNumbers(createList([9, 9]), createList([1])))                          // 0 -> 0 -> 1 -> nil


//==============================================================
// Q62 - LC019 Remove Nth Node From End
//
// Pattern : Dummy Node + Fixed Gap
// The gap is n+1, not n: a gap of n lands slow ON the target and
// a singly linked list gives no way back to its predecessor.
//
// The unlink is slowNode.next = victim.next. Writing
// slowNode.next = victim assigns the victim to itself and the
// list comes back unchanged.
//
// Time O(n) · Space O(1)
//==============================================================

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    guard n > 0 else { return head }

    let dummy = ListNode(value: 0)
    dummy.next = head
    var slow: ListNode? = dummy
    var fast: ListNode? = dummy

    for _ in 0...n {
        if fast == nil {
            return head
        }

        fast = fast?.next
    }

    while let fastNode = fast {
        slow = slow?.next
        fast = fastNode.next
    }

    if let slowNode = slow, let victim = slowNode.next {
        slowNode.next = victim.next
    }

    return dummy.next
}

print("\n========== Q62 - Remove Nth Node From End ==========")

traverseList(removeNthFromEnd(createList([1, 2, 3, 4, 5]), 2))   // 1 -> 2 -> 3 -> 5 -> nil

traverseList(removeNthFromEnd(createList([1]), 1))               // nil

traverseList(removeNthFromEnd(createList([1, 2]), 1))            // 1 -> nil

traverseList(removeNthFromEnd(createList([1, 2, 3]), 3))         // 2 -> 3 -> nil

traverseList(removeNthFromEnd(createList([1, 2, 3]), 99))        // 1 -> 2 -> 3 -> nil


//==============================================================
// Q63 - LC138 Copy List With Random Pointer
//
// Pattern : Random Pointer Clone
// Pass one creates every copy wired to nothing. Pass two reads
// the ORIGINAL's pointers and writes them onto the copy —
// reading copy.next or copy.random gives nil and pass two does
// nothing at all.
//
// A deep-copy bug survives every value-based test. Only ===
// catches it.
//
// Time O(n) · Space O(n)
//==============================================================

func copyRandomList(_ head: ListNodeRandom?) -> ListNodeRandom? {
    guard let head = head else { return nil }

    var map = [ObjectIdentifier: ListNodeRandom]()
    var current: ListNodeRandom? = head

    while let node = current {
        map[ObjectIdentifier(node)] = ListNodeRandom(value: node.value)

        current = node.next
    }

    current = head

    while let node = current {
        if let copy = map[ObjectIdentifier(node)] {

            if let next = node.next {
                copy.next = map[ObjectIdentifier(next)]
            }

            if let random = node.random {
                copy.random = map[ObjectIdentifier(random)]
            }
        }

        current = node.next
    }

    return map[ObjectIdentifier(head)]
}

print("\n========== Q63 - Copy List With Random Pointer ==========")

let q63a = ListNodeRandom(value: 7)
let q63b = ListNodeRandom(value: 13)
let q63c = ListNodeRandom(value: 11)

q63a.next = q63b
q63b.next = q63c

q63b.random = q63a
q63c.random = q63c

printRandomList(copyRandomList(q63a))       // 7/nil, 13/7, 11/11

let q63p = ListNodeRandom(value: 1)
let q63q = ListNodeRandom(value: 2)

q63p.next = q63q
q63p.random = q63q

let q63copy = copyRandomList(q63p)

print(q63copy?.random === q63copy?.next)    // true

print(q63copy?.random === q63q)             // false - must point at the COPY

print(q63copy === q63p)                     // false - must be a new object

print(copyRandomList(nil) == nil)           // true


//==============================================================
// Q64 - LC143 Reorder List
//
// Pattern : Slow & Fast + Reverse + Merge
// Needs the FIRST middle so the second half is the shorter one.
//
// SAVE middle.next BEFORE nil-ing it. Nil first and the second
// half is always nil, so the weave loop never runs.
//
// The weave: save both nexts, cross-link, then advance to the
// SAVED pointers — advancing via first.next after the relink
// walks into the wrong list.
//
// Time O(n) · Space O(1)
//==============================================================

func reorderList(_ head: ListNode?) {
    guard let head = head, head.next != nil else { return }

    let middle = middleNodeFirst(head)
    let secondHalf = middle?.next
    middle?.next = nil

    var first: ListNode? = head
    var second = reverseList(secondHalf)

    while let firstNode = first, let secondNode = second {
        let temp1 = firstNode.next
        let temp2 = secondNode.next

        firstNode.next = secondNode
        secondNode.next = temp1

        first = temp1
        second = temp2
    }
}

print("\n========== Q64 - Reorder List ==========")

let q64a = createList([1, 2, 3, 4])
reorderList(q64a)
traverseList(q64a)                          // 1 -> 4 -> 2 -> 3 -> nil

let q64b = createList([1, 2, 3, 4, 5])
reorderList(q64b)
traverseList(q64b)                          // 1 -> 5 -> 2 -> 4 -> 3 -> nil

let q64c = createList([1, 2])
reorderList(q64c)
traverseList(q64c)                          // 1 -> 2 -> nil

let q64d = createList([1])
reorderList(q64d)
traverseList(q64d)                          // 1 -> nil

let q64e = createList([1, 2, 3])
reorderList(q64e)
traverseList(q64e)                          // 1 -> 3 -> 2 -> nil

let q64f = createList([1, 2, 3, 4, 5, 6])
reorderList(q64f)
traverseList(q64f)                          // 1 -> 6 -> 2 -> 5 -> 3 -> 4 -> nil


//==============================================================
// Q65 - LC025 Reverse Nodes In K Group
//
// Pattern : K Group Reverse
// groupPrev starts on the DUMMY, not head — anchoring on head
// leaves the first group unreversed.
//
// groupStart is the group's head going in and its TAIL coming
// out. That is why groupStart.next = nextGroup reattaches the
// rest, and why groupPrev = groupStart is the right advance.
//
// k <= 1 returns the list unchanged, not nil.
//
// Time O(n) · Space O(1)
//==============================================================

func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
    guard k > 1 else { return head }

    let dummy = ListNode(value: 0)
    dummy.next = head
    var groupPrev: ListNode? = dummy

    while true {
        guard let kth = findKthNode(groupPrev?.next, k) else {
            break
        }

        let nextGroup = kth.next
        kth.next = nil

        let groupStart = groupPrev?.next
        let newHead = reverseList(groupStart)
        groupPrev?.next = newHead
        groupStart?.next = nextGroup
        groupPrev = groupStart
    }

    return dummy.next
}

print("\n========== Q65 - Reverse Nodes In K Group ==========")

traverseList(reverseKGroup(createList([1, 2, 3, 4, 5]), 2))      // 2 -> 1 -> 4 -> 3 -> 5 -> nil

traverseList(reverseKGroup(createList([1, 2, 3, 4, 5]), 3))      // 3 -> 2 -> 1 -> 4 -> 5 -> nil

traverseList(reverseKGroup(createList([1, 2, 3, 4, 5]), 1))      // 1 -> 2 -> 3 -> 4 -> 5 -> nil

traverseList(reverseKGroup(createList([1, 2]), 3))               // 1 -> 2 -> nil

traverseList(reverseKGroup(createList([1, 2, 3, 4, 5, 6]), 3))   // 3 -> 2 -> 1 -> 6 -> 5 -> 4 -> nil

traverseList(reverseKGroup(createList([1, 2, 3, 4]), 4))         // 4 -> 3 -> 2 -> 1 -> nil

traverseList(reverseKGroup(createList([]), 3))                   // nil
