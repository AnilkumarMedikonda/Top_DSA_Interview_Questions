import Foundation

//==============================================================
// MARK: - PHASE 07: LINKED LIST
//==============================================================
//
// Q57 - Q65
//
// Focus:
// - Pointer Manipulation
// - Two Pointers
// - Fast & Slow Pointers
// - Dummy Node
// - Reverse Linked List
// - HashMap + Linked List
//
//==============================================================


//==============================================================
// MARK: - Linked List Helpers
//==============================================================

// Add your reusable Node / helper functions here.

final class LisNode{
    var value: Int
    var next: LisNode?
    
    init(value: Int, next: LisNode? = nil) {
        self.value = value
        self.next = next
    }
}

final class RandomListNode {
    
    var value: Int
    var next: RandomListNode?
    var ranodm: RandomListNode?
    
    init(value: Int, next: RandomListNode? = nil, ranodm: RandomListNode? = nil) {
        self.value = value
        self.next = next
        self.ranodm = ranodm
    }
    
}


func createList(_ values: [Int]) -> LisNode? {
    
    guard !values.isEmpty else { return nil }
    
    let head: LisNode? = LisNode(value: values[0])
    var current: LisNode? = head
    
    for i in 1..<values.count {
        let node = LisNode(value: values[i])
        current?.next = node
        current = node
    }
    return head
}

func printList(_ headNode: LisNode?) {
    
    var current: LisNode? = headNode
    
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print(" nil ")
}


func printRandomLis(_ headNode: RandomListNode?) {
    
    var current: RandomListNode? = headNode
    
    while let node = current {
        
        print("Node", node.value, terminator: "")
        
        if let random = node.ranodm {
            print(" (random", random.value, terminator: ")")
        } else {
            print(" (random nil", terminator: ")")
        }
        
        print(" -> ", terminator: "")
        
        current = node.next
    }
    print("nil")
    
}

func createCycleList(_ values: [Int], _ position: Int) -> LisNode? {
    
    guard !values.isEmpty else { return nil }
    
    var cycleNode: LisNode? = nil
    let headNode = LisNode(value: values[0])
    var current: LisNode? = headNode
    
    if position == 0 {
        cycleNode = headNode
    }
    
    for i in 1..<values.count {
        
        let node = LisNode(value: values[i])
        current?.next = node
        current = node
        
        if position == i {
            cycleNode = current
        }
    }
    
    if position >= 0 {
        current?.next = cycleNode
    }
    
    return headNode
    
}

func kthNode(_ headNode: LisNode?, _ k: Int) -> LisNode? {
    guard k >= 1 else { return nil }
    
    var current: LisNode? = headNode
    
    for _ in 1..<k {
        if current == nil {
            return nil
        }
        current = current?.next
    }
    
    return current
    
}


//==============================================================
// MARK: - Q57. Reverse Linked List
//==============================================================
//
// Difficulty: Easy
// LeetCode: 206
//
// Given the head of a singly linked list, reverse the list
// and return the reversed list.
//
// Example:
// Input:  1 → 2 → 3 → 4 → 5
// Output: 5 → 4 → 3 → 2 → 1
//
// Time: O(n)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------


func reverseList(_ headNode: LisNode?) -> LisNode? {
    
    var current: LisNode? = headNode
    var prevNode: LisNode? = nil
    
    while let node = current {
        
        let nextNode = node.next
        node.next = prevNode
        prevNode = node
        current = nextNode
    }
    
    
    return prevNode
}


//==============================================================
// MARK: Test Cases - Q57
//==============================================================

print("========== Q57: Reverse Linked List ==========")

printList(reverseList(createList([1, 2, 3, 4, 5])))   // Expected: 5 -> 4 -> 3 -> 2 -> 1 -> nil
printList(reverseList(createList([1, 2])))            // Expected: 2 -> 1 -> nil
printList(reverseList(createList([1])))               // Expected: 1 -> nil
printList(reverseList(createList([])))                // Expected: nil



//==============================================================
// MARK: - Q58. Merge Two Sorted Lists
//==============================================================
//
// Difficulty: Easy
// LeetCode: 21
//
// Merge two sorted linked lists into one sorted linked list
// and return its head.
//
// Example:
// Input:  l1 = [1,2,4], l2 = [1,3,4]
// Output: [1,1,2,3,4,4]
//
// Time: O(n+m)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

print("========== Q58: Merge Two Sorted Lists ==========")

func mergeTwoLists(_ list1: LisNode?,  _ list2: LisNode?) -> LisNode? {
    
    let dummy = LisNode(value: 0)
    var tailNode: LisNode? = dummy
    var first = list1
    var second = list2
    
    
    while let firstNode = first, let secondNode = second {
        
        if firstNode.value <= secondNode.value {
            tailNode?.next = firstNode
            tailNode = firstNode
            first = firstNode.next
        } else {
            tailNode?.next = secondNode
            tailNode = secondNode
            second = secondNode.next
        }
        
    }
    
    if first != nil {
        tailNode?.next = first
    } else {
        tailNode?.next = second
    }
    
    
    return dummy.next
    
    
}

//==============================================================
// MARK: Test Cases - Q58
//==============================================================


printList(mergeTwoLists(
    createList([1, 2, 4]),
    createList([1, 3, 4])
))
// Expected: 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> nil

printList(mergeTwoLists(
    createList([]),
    createList([1, 2, 3])
))
// Expected: 1 -> 2 -> 3 -> nil

printList(mergeTwoLists(
    createList([1]),
    createList([])
))
// Expected: 1 -> nil

printList(mergeTwoLists(
    createList([]),
    createList([])
))
// Expected: nil



//==============================================================
// MARK: - Q59. Linked List Cycle
//==============================================================
//
// Difficulty: Easy
// LeetCode: 141
//
// Determine whether a linked list has a cycle.
//
// Example:
// Input:  3 → 2 → 0 → -4
//               ↑       |
//               └───────┘
// Output: true
//
// Time: O(n)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func hasCycle(_ headNode: LisNode?) -> Bool {
    
    var slow = headNode
    var fast = headNode
    
    while slow != nil, let fastNode = fast?.next {
        slow = slow?.next
        fast = fastNode.next
        
        if slow === fast {
            return true
        }
    }
    
    return false
}


//==============================================================
// MARK: Test Cases - Q59
//==============================================================

print("========== Q59: Linked List Cycle ==========")

// Cycle at index 1
let cycleList1 = createCycleList([3, 2, 0, -4], 1)
print(hasCycle(cycleList1))    // Expected: true

// Cycle at index 0
let cycleList2 = createCycleList([1, 2], 0)
print(hasCycle(cycleList2))    // Expected: true

// No cycle
let cycleList3 = createCycleList([1, 2, 3], -1)
print(hasCycle(cycleList3))    // Expected: false

// Single node, no cycle
let cycleList4 = createCycleList([1], -1)
print(hasCycle(cycleList4))    // Expected: false


//==============================================================
// MARK: - Q60. Middle of the Linked List
//==============================================================
//
// Difficulty: Easy
// LeetCode: 876
//
// Given the head of a singly linked list, return the middle
// node of the linked list.
//
// If there are two middle nodes, return the second middle node.
//
// Example:
// Input:  [1,2,3,4,5]
// Output: 3
//
// Time: O(n)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func middleNode(_ headNode: LisNode?) -> LisNode? {
    
    var slow = headNode
    var fast = headNode
    
    while let slowNode = slow , let fastNode = fast?.next {
        slow = slowNode.next
        fast = fastNode.next
    }
    
    
    return slow
    
}


//==============================================================
// MARK: Test Cases - Q60
//==============================================================

print("========== Q60: Middle of the Linked List ==========")

printList(middleNode(createList([1, 2, 3, 4, 5])))       // Expected: 3 -> 4 -> 5 -> nil
printList(middleNode(createList([1, 2, 3, 4, 5, 6])))    // Expected: 4 -> 5 -> 6 -> nil
printList(middleNode(createList([1, 2])))                // Expected: 2 -> nil
printList(middleNode(createList([1])))                   // Expected: 1 -> nil


//==============================================================
// MARK: - Q61. Add Two Numbers
//==============================================================
//
// Difficulty: Medium
// LeetCode: 2
//
// You are given two non-empty linked lists representing
// two non-negative integers.
//
// The digits are stored in reverse order. Add the two numbers
// and return the sum as a linked list.
//
// Example:
// Input:
// l1 = [2,4,3]
// l2 = [5,6,4]
//
// Output:
// [7,0,8]
//
// Explanation:
// 342 + 465 = 807
//
// Time: O(max(n, m))
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func addTwoNumbers(_ list1: LisNode?, _ list2: LisNode?) -> LisNode? {
    let dummy: LisNode? = LisNode(value: 0)
    var tail: LisNode? = dummy
    var first = list1
    var second = list2
    var carryOver = 0
    
    while first != nil ||  second != nil || carryOver != 0 {
        
        var firstValue = 0
        var secondValue = 0
        
        if let firstNode = first {
            firstValue = firstNode.value
        }
        
        if let secondNode = second {
            secondValue = secondNode.value
        }
        
        let sum = firstValue + secondValue + carryOver
        carryOver = sum / 10
        
        let newNode = LisNode(value: sum % 10 )
        tail?.next = newNode
        tail = newNode
        
        first = first?.next
        second = second?.next
        
    }
    
    return dummy?.next
    
}


//==============================================================
// MARK: Test Cases - Q61
//==============================================================

print("========== Q61: Add Two Numbers ==========")

printList(addTwoNumbers(
    createList([2, 4, 3]),
    createList([5, 6, 4])
))
// Expected: 7 -> 0 -> 8 -> nil

printList(addTwoNumbers(
    createList([0]),
    createList([0])
))
// Expected: 0 -> nil

printList(addTwoNumbers(
    createList([9, 9, 9]),
    createList([9, 9])
))
// Expected: 8 -> 9 -> 0 -> 1 -> nil

printList(addTwoNumbers(
    createList([9]),
    createList([1])
))
// Expected: 0 -> 1 -> nil




//==============================================================
// MARK: - Q62. Remove Nth Node From End of List
//==============================================================
//
// Difficulty: Medium
// LeetCode: 19
//
// Given the head of a linked list, remove the nth node from
// the end of the list and return its head.
//
// Example:
// Input:  [1,2,3,4,5], n = 2
// Output: [1,2,3,5]
//
// Time: O(n)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------


func removeNthNode(_ headNode: LisNode?, _ n: Int) -> LisNode? {
    
    
    let dummyNode = LisNode(value: 0)
    dummyNode.next = headNode
    var slow: LisNode?  = dummyNode
    var fast: LisNode? = dummyNode
    
    
    for _ in 0..<n {
        
        if fast == nil {
            return headNode
        }
        
        fast = fast?.next

                
    }
    
    while let fastNode = fast?.next {
        
        slow = slow?.next
        fast = fastNode
        
        
    }
    
    if let slowNode = slow , let victim = slowNode.next {
        slowNode.next = victim.next
    }
    
    
    return dummyNode.next
}

//==============================================================
// MARK: Test Cases - Q62
//==============================================================

print("========== Q62: Remove Nth Node From End ==========")

printList(removeNthNode(
    createList([1, 2, 3, 4, 5]),
    2
))
// Expected: 1 -> 2 -> 3 -> 5 -> nil

printList(removeNthNode(
    createList([1]),
    1
))
// Expected: nil

printList(removeNthNode(
    createList([1, 2]),
    2
))
// Expected: 2 -> nil

printList(removeNthNode(
    createList([1, 2, 3]),
    1
))
// Expected: 1 -> 2 -> nil


//==============================================================
// MARK: - Q63. Copy List With Random Pointer
//==============================================================
//
// Difficulty: Medium
// LeetCode: 138
//
// Given a linked list where each node contains an additional
// random pointer that can point to any node or nil, create
// a deep copy of the list.
//
// Example:
// Input:
// [[7,nil],[13,0],[11,4],[10,2],[1,0]]
//
// Output:
// [[7,nil],[13,0],[11,4],[10,2],[1,0]]
//
// Time: O(n)
// Space: O(n)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func clone(_ headNode: RandomListNode?) -> RandomListNode? {
    
    guard let head = headNode else { return nil }
    
    var current: RandomListNode? = headNode
    var map = [ObjectIdentifier: RandomListNode]()
    
    while let node = current {
        map[ObjectIdentifier(node)] = RandomListNode(value: node.value)
        current = current?.next
    }
    
    current = headNode
    
    while let node = current {
        
        
        if let copy = map[ObjectIdentifier(node)] {
            
            if let next = node.next {
                copy.next = map[ObjectIdentifier(next)]
            }
            
            if let random = node.ranodm {
                copy.ranodm = map[ObjectIdentifier(random)]
            }
        }
        
        current = current?.next
        
    }
    
    return map[ObjectIdentifier(head)]
}


func createRandomList(_ values: [Int], _ randomIndexes: [Int?]) -> RandomListNode? {
    
    guard !values.isEmpty else { return nil }
    
    var nodes = [RandomListNode]()
    
    for value in values {
        nodes.append(RandomListNode(value: value))
    }
    
    for i in 0..<nodes.count {
        
        if i + 1 < nodes.count {
            nodes[i].next = nodes[i + 1]
        }
        
        if let randomIndex = randomIndexes[i] {
            nodes[i].ranodm = nodes[randomIndex]
        }
    }
    
    return nodes[0]
}


//==============================================================
// MARK: Test Cases - Q63
//==============================================================

print("========== Q63: Copy List With Random Pointer ==========")

printRandomLis(clone(createRandomList([7, 13, 11, 10, 1], [nil, 0, 4, 2, 0])))
// Expected: Node 7 (random nil) -> Node 13 (random 7) -> Node 11 (random 1) -> Node 10 (random 11) -> Node 1 (random 7) -> nil

printRandomLis(clone(createRandomList([1, 2], [1, 1])))
// Expected: Node 1 (random 2) -> Node 2 (random 2) -> nil

printRandomLis(clone(createRandomList([3, 3, 3], [nil, 0, nil])))
// Expected: Node 3 (random nil) -> Node 3 (random 3) -> Node 3 (random nil) -> nil

printRandomLis(clone(createRandomList([], [])))
// Expected: nil


//==============================================================
// MARK: - Q64. Reorder List
//==============================================================
//
// Difficulty: Medium
// LeetCode: 143
//
// Given a singly linked list:
//
// L0 → L1 → L2 → ... → Ln
//
// Reorder it to:
//
// L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → ...
//
// Example:
// Input: [1,2,3,4]
// Output: [1,4,2,3]
//
// Time: O(n)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------


func reorderList(_ headNode: LisNode?)  {
    guard let head = headNode, headNode?.next != nil else { return  }
    let middleNode = middleNode(head)
    var second = reverseList(middleNode?.next)
    var first = headNode
    middleNode?.next = nil

    
    
    while let firstNode = first, let secondNode = second {
        
        let temp1 = firstNode.next
        let temp2 = secondNode.next
        
        firstNode.next =  secondNode
        secondNode.next = temp1
        
        first = temp1
        second = temp2
    }
        
}

//==============================================================
// MARK: Test Cases - Q64
//==============================================================

print("========== Q64: Reorder List ==========")

let reorderList1 = createList([1, 2, 3, 4])
reorderList(reorderList1)
printList(reorderList1)
// Expected: 1 -> 4 -> 2 -> 3 -> nil

let reorderList2 = createList([1, 2, 3, 4, 5])
reorderList(reorderList2)
printList(reorderList2)
// Expected: 1 -> 5 -> 2 -> 4 -> 3 -> nil

let reorderList3 = createList([1, 2])
reorderList(reorderList3)
printList(reorderList3)
// Expected: 1 -> 2 -> nil

let reorderList4 = createList([1])
reorderList(reorderList4)
printList(reorderList4)
// Expected: 1 -> nil


//==============================================================
// MARK: - Q65. Reverse Nodes In K-Group
//==============================================================
//
// Difficulty: Hard
// LeetCode: 25
//
// Given the head of a linked list, reverse the nodes of the
// list k at a time and return the modified list.
//
// If the number of nodes is not a multiple of k, leave the
// remaining nodes as they are.
//
// Example:
// Input: [1,2,3,4,5], k = 2
// Output: [2,1,4,3,5]
//
// Time: O(n)
// Space: O(1)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func reverseKGroup(_ headNode: LisNode?, _ k: Int) -> LisNode? {
    
    let dummyNode = LisNode(value: 0)
    dummyNode.next = headNode
    var groupPrev: LisNode? = dummyNode
    
    while true {
        
        guard let kthNode = kthNode(groupPrev?.next, k) else {
            break
        }
        
        let nextNode = kthNode.next
        kthNode.next = nil
        
        let groupStart = groupPrev?.next
        let head = reverseList(groupStart)
        
        groupPrev?.next = head
        groupStart?.next = nextNode
        
        groupPrev = groupStart
        
    }
    
    return dummyNode.next
}




//==============================================================
// MARK: Test Cases - Q65
//==============================================================

print("========== Q65: Reverse Nodes In K-Group ==========")

printList(reverseKGroup(
    createList([1, 2, 3, 4, 5]),
    2
))
// Expected: 2 -> 1 -> 4 -> 3 -> 5 -> nil

printList(reverseKGroup(
    createList([1, 2, 3, 4, 5]),
    3
))
// Expected: 3 -> 2 -> 1 -> 4 -> 5 -> nil

printList(reverseKGroup(
    createList([1, 2, 3, 4]),
    4
))
// Expected: 4 -> 3 -> 2 -> 1 -> nil

printList(reverseKGroup(
    createList([1, 2]),
    3
))
// Expected: 1 -> 2 -> nil


//==============================================================
// MARK: - PHASE 07 COMPLETE
//==============================================================
//
// Q57 - Q65
//
//==============================================================
