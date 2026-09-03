import Foundation

//==============================================================
// HashMap + Doubly Linked List
//==============================================================
//
// Used In
// -------
// LC146 - LRU Cache
//
// HashMap
// --------
// O(1) Lookup
//
// Doubly Linked List
// ------------------
// O(1) Insert
// O(1) Remove
// O(1) Move
//
//==============================================================



// MARK: - Node

final class Node {

    var key: Int
    var value: Int

    weak var prev: Node?
    var next: Node?

    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
}



// MARK: - Doubly Linked List

final class DoublyLinkedList {

    private let head = Node(key: -1, value: -1)
    private let tail = Node(key: -1, value: -1)

    init() {

        head.next = tail
        tail.prev = head
    }


    // MARK: Insert At Front

    func insertFront(_ node: Node) {

        guard let first = head.next else {
            return
        }

        node.next = first
        node.prev = head

        head.next = node
        first.prev = node
    }


    // MARK: Remove Node

    func remove(_ node: Node) {

        guard let previous = node.prev,
              let next = node.next else {
            return
        }

        previous.next = next
        next.prev = previous

        node.prev = nil
        node.next = nil
    }


    // MARK: Move To Front

    func moveToFront(_ node: Node) {

        remove(node)
        insertFront(node)
    }


    // MARK: Remove Tail

    func removeTail() -> Node? {

        guard let last = tail.prev,
              last !== head else {
            return nil
        }

        remove(last)

        return last
    }


    // MARK: Display

    func display() {

        var current = head.next

        while let node = current,
              node !== tail {

            print("[\(node.key):\(node.value)]", terminator: " ")

            current = node.next
        }

        print()
    }
}



// MARK: - HashMap

var cache = [Int: Node]()


// MARK: - Practice

let list = DoublyLinkedList()

let node1 = Node(key: 1, value: 10)
let node2 = Node(key: 2, value: 20)
let node3 = Node(key: 3, value: 30)

cache[1] = node1
cache[2] = node2
cache[3] = node3

list.insertFront(node1)
list.insertFront(node2)
list.insertFront(node3)

print("Initial")
list.display()

print()

print("Move 1 To Front")

list.moveToFront(node1)

list.display()

print()

print("Remove Tail")

if let removed = list.removeTail() {

    cache.removeValue(forKey: removed.key)

    print("Removed :", removed.key)
}

list.display()

print()

print("HashMap Keys")

print(cache.keys.sorted())



// MARK: - Interview Notes

/*
HashMap

Key -> Node

1 -> Node
2 -> Node
3 -> Node

Lookup

O(1)

----------------------------------

Doubly Linked List

Head

Newest

↓

Oldest

Tail

----------------------------------

Operations

insertFront()

remove()

moveToFront()

removeTail()

All O(1)

----------------------------------

Used In

LC146 - LRU Cache
*/
