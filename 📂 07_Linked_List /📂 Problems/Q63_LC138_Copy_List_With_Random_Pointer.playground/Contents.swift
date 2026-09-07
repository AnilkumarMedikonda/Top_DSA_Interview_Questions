import Foundation

//==========================================================
// Q63 - LC138 Copy List With Random Pointer
//==========================================================
//
// Pattern : 07 Random Pointer Clone
//
// Problem
// A linked list where each node has a next pointer and a random
// pointer that may point to any node in the list or to nil.
// Construct a DEEP COPY: the copied list must be made entirely of
// new nodes, where every next and random points into the copy and
// never into the original. The original must be left unchanged.
//
// Example 1
// Input   [[7,nil],[13,0],[11,4],[10,2],[1,0]]
// Output  [[7,nil],[13,0],[11,4],[10,2],[1,0]]
//         (same shape, entirely different objects)
//
// Example 2
// Input   [[1,1],[2,1]]
// Output  [[1,1],[2,1]]
//
// Example 3
// Input   nil
// Output  nil
//
// Constraints
// 0 <= number of nodes <= 1000
// -10^4 <= Node.val <= 10^4
// random points to a node in the list, or nil
//
// WHY TWO PASSES ARE UNAVOIDABLE
// Copying next is easy — walk and append. random is not: when
// copying node A whose random points at node C, the copy of C
// may not exist yet. Nothing can be wired until every copy
// exists, so pass one creates, pass two connects.
//
// THE TRAP
// A deep-copy bug survives every value-based test. A clone whose
// random points into the ORIGINAL list prints identically to a
// correct one. Only identity assertions with === catch it, which
// is why the tests below compare references, not values.
//
// Time  : O(n)
// Space : O(n) - the map
//
// LeetCode's follow-up asks for O(1) space via interleaving.
// The template for it lives in Patterns/07_Random_Pointer_Clone.
//
//==========================================================


final class ListNode {
    var value: Int
    var next: ListNode?
    var random: ListNode?

    init(value: Int, next: ListNode? = nil, random: ListNode? = nil) {
        self.value = value
        self.next = next
        self.random = random
    }
}

//==========================================================
// Print value and random value
//
// Time  O(n)
// Space O(1)
//==========================================================

func printRandomList(_ head: ListNode?) {
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


//==========================================================
// Optimal — hash map keyed by identity
//
// Pass 1  create a copy of every node, wire nothing
// Pass 2  every copy now exists, so both pointers resolve
//         through the map
//
// The key is ObjectIdentifier because ListNode is a class and
// identity is what matters — two nodes holding the same value
// are different nodes and need different entries.
//
// Time  O(n) - two passes
// Space O(n) - one map entry per node
//==========================================================

func clone(_ headNode: ListNode?) -> ListNode? {
    guard let headNode = headNode else { return nil }

    var map = [ObjectIdentifier: ListNode]()

    //------------------------------------------------------
    // Pass 1
    // Copy every node with no pointers set
    //------------------------------------------------------

    var current: ListNode? = headNode

    while let node = current {
        map[ObjectIdentifier(node)] = ListNode(value: node.value)

        current = node.next
    }

    //------------------------------------------------------
    // Pass 2
    // Wire next and random, both looked up in the map.
    // node.random — ONE dereference. node.random?.random
    // follows the pointer twice and silently produces a
    // clone wired two hops away.
    //------------------------------------------------------

    current = headNode

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

    //------------------------------------------------------
    // The copy of the original head is the new head
    //------------------------------------------------------

    return map[ObjectIdentifier(headNode)]
}


//==========================================================
// Tests
//==========================================================

print("\n========== Q63 - Copy List With Random Pointer ==========")

print(clone(nil) == nil)                          // true

let single = ListNode(value: 1)

printRandomList(clone(single))                    // Value: 1  Random: nil

let selfRef = ListNode(value: 10)
selfRef.random = selfRef

let selfCopy = clone(selfRef)

print(selfCopy?.random === selfCopy)              // true - self-reference preserved

print(selfCopy?.random === selfRef)               // false - not the original

let p = ListNode(value: 1)
let q = ListNode(value: 2)

p.next = q
p.random = q

let forwardCopy = clone(p)

print(forwardCopy?.random === forwardCopy?.next)  // true

print(forwardCopy?.random === q)                  // false - must point at the COPY

print(forwardCopy === p)                          // false - must be a new object

let first = ListNode(value: 1)
let second = ListNode(value: 2)
let third = ListNode(value: 3)

first.next = second
second.next = third

first.random = third
second.random = first
third.random = second

printRandomList(clone(first))                     // 1/3, 2/1, 3/2

printRandomList(first)                            // 1/3, 2/1, 3/2 - original unchanged
