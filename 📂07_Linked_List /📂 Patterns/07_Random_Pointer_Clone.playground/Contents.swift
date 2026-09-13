import Foundation

//==========================================================
// PATTERN 07 — RANDOM POINTER CLONE
//==========================================================
//
// WHAT
// Deep copy a linked list where each node has two pointers:
// next, and random — which may point anywhere in the list,
// backwards, forwards, at itself, or nowhere.
//
// WHY IT IS NOT A NORMAL COPY
// Copying next is easy: walk and append. random is the problem.
// When you copy node A and its random points at node C, C may
// not exist as a copy yet. You cannot wire random until every
// copy exists, so this needs two passes minimum.
//
// EVERY copied pointer must land on a COPY, never an original.
// A clone that points into the original list is the bug this
// pattern exists to prevent, and value-based tests will not
// catch it — only identity checks will.
//
// TWO APPROACHES
//
// 1. MAP        original -> copy, O(n) space. Obvious, safe.
// 2. INTERLEAVE weave copies into the original list so every
//               copy sits behind its original, O(1) space.
//               This is the LC138 follow-up; interviewers ask.
//
// WHY ObjectIdentifier AS THE KEY
// Node is a class and not Hashable. ObjectIdentifier wraps the
// reference itself, so two distinct nodes holding the same value
// are distinct keys — which is exactly what identity demands.
//
// COMPLEXITY
// Map          Time O(n), Space O(n)
// Interleave   Time O(n) over three passes, Space O(1) auxiliary
//
// USED IN
//
// ✓ Q63 LC138 Copy List With Random Pointer
//
//==========================================================


final class Node {
    var value: Int
    var next: Node?
    var random: Node?

    init(value: Int, next: Node? = nil, random: Node? = nil) {
        self.value = value
        self.next = next
        self.random = random
    }
}

//==========================================================
// Print a random-pointer list
//
// Time  O(n)
// Space O(1)
//==========================================================

func printRandomList(_ head: Node?) {
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
// Approach 1 — Map
//
// Pass 1 copies every node with no pointers wired.
// Pass 2 wires next and random, looking both up in the map.
//
// Time  O(n)
// Space O(n)
//==========================================================

func cloneRandomList(_ head: Node?) -> Node? {

    //------------------------------------------------------
    // Step 1
    // Empty list
    //------------------------------------------------------

    guard let head = head else { return nil }

    //------------------------------------------------------
    // Step 2
    // original -> copy, keyed by identity
    //------------------------------------------------------

    var map: [ObjectIdentifier: Node] = [:]

    //------------------------------------------------------
    // Step 3
    // Pass 1 — copy every node, wire nothing yet.
    // random may point at a node not copied so far.
    //------------------------------------------------------

    var current: Node? = head

    while let node = current {
        map[ObjectIdentifier(node)] = Node(value: node.value)

        current = node.next
    }

    //------------------------------------------------------
    // Step 4
    // Pass 2 — every copy now exists, so both pointers
    // resolve through the map
    //------------------------------------------------------

    current = head

    while let node = current {
        let copy = map[ObjectIdentifier(node)]

        if let next = node.next {
            copy?.next = map[ObjectIdentifier(next)]
        }

        if let random = node.random {
            copy?.random = map[ObjectIdentifier(random)]
        }

        current = node.next
    }

    //------------------------------------------------------
    // Step 5
    // The copy of the original head is the new head
    //------------------------------------------------------

    return map[ObjectIdentifier(head)]
}


//==========================================================
// Approach 2 — Interleave, O(1) space
//
// The map exists only to answer "what is the copy of X?".
// Weaving each copy directly behind its original answers that
// with a single hop: the copy of X is X.next.
//
// Time  O(n) - three passes
// Space O(1) - auxiliary; the copies are the output
//==========================================================

func cloneRandomListInterleave(_ head: Node?) -> Node? {
    guard let head = head else { return nil }

    //------------------------------------------------------
    // Pass 1
    // Weave: A -> A' -> B -> B' -> C -> C'
    //------------------------------------------------------

    var current: Node? = head

    while let node = current {
        let copy = Node(value: node.value)
        copy.next = node.next
        node.next = copy
        current = copy.next
    }

    //------------------------------------------------------
    // Pass 2
    // Wire random. Every copy sits behind its original, so
    // original.random.next IS the copy of original.random.
    //------------------------------------------------------

    current = head

    while let node = current {
        if let random = node.random {
            node.next?.random = random.next
        }

        current = node.next?.next
    }

    //------------------------------------------------------
    // Pass 3
    // Unweave. The original must be left intact — this
    // restore is the step people skip.
    //------------------------------------------------------

    let cloneHead = head.next
    current = head

    while let node = current {
        let copy = node.next
        node.next = copy?.next

        if let copyNext = copy?.next {
            copy?.next = copyNext.next
        }

        current = node.next
    }

    return cloneHead
}


//==========================================================
// Tests
//==========================================================

print("\n========== Test 1 : Empty List ==========")

if cloneRandomList(nil) == nil {
    print("Clone : nil")                                    // Clone : nil
} else {
    print("Clone Failed")
}

print("\n========== Test 2 : Single Node ==========")

let node1 = Node(value: 1)

printRandomList(cloneRandomList(node1))                     // Value: 1  Random: nil

print("\n========== Test 3 : Random To Self ==========")

let node2 = Node(value: 10)
node2.random = node2

let clone2 = cloneRandomList(node2)

printRandomList(clone2)                                     // Value: 10  Random: 10

print(clone2?.random === clone2)                            // true - self-reference preserved

print(clone2?.random === node2)                             // false - not the original

print("\n========== Test 4 : Three Nodes ==========")

let first = Node(value: 1)
let second = Node(value: 2)
let third = Node(value: 3)

first.next = second
second.next = third

first.random = third
second.random = first
third.random = second

printRandomList(cloneRandomList(first))                     // 1/3, 2/1, 3/2

print("\n========== Test 5 : Random Nil ==========")

let a = Node(value: 5)
let b = Node(value: 6)

a.next = b

printRandomList(cloneRandomList(a))                         // 5/nil, 6/nil

print("\n========== Test 6 : Cross Random ==========")

let x = Node(value: 100)
let y = Node(value: 200)

x.next = y
x.random = y
y.random = x

printRandomList(cloneRandomList(x))                         // 100/200, 200/100

print("\n========== Test 7 : Deep Copy Proof ==========")

let p = Node(value: 1)
let q = Node(value: 2)

p.next = q
p.random = q

let cloneDeep = cloneRandomList(p)

print(cloneDeep === p)                                      // false - different object

print(cloneDeep?.next === q)                                // false - copy points at copy

print(cloneDeep?.random === cloneDeep?.next)                // true - wiring preserved

print("\n========== Test 8 : Interleave Approach ==========")

let m = Node(value: 7)
let n = Node(value: 8)

m.next = n
m.random = n
n.random = n

let cloneWoven = cloneRandomListInterleave(m)

printRandomList(cloneWoven)                                 // 7/8, 8/8

print(cloneWoven?.random === cloneWoven?.next)              // true

print("\n========== Test 9 : Original Intact After Interleave ==========")

printRandomList(m)                                          // 7/8, 8/8 - unchanged

print(m.next === n)                                         // true - restore worked
