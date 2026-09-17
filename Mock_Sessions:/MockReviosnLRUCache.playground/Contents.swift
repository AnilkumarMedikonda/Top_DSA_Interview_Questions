import Foundation

//==============================================================
// MARK: - Q55 - LC146 - LRU Cache
//==============================================================
//
// PROBLEM
//
// Design a data structure that follows the constraints of a
// Least Recently Used (LRU) cache.
//
//   LRUCache(capacity)  initialise with a positive capacity
//   get(key)            return the value, or -1 if absent
//   put(key, value)     insert or update; evict the least
//                       recently used key when over capacity
//
// Both get and put must run in O(1) average time.
//
// EXAMPLE
//
// LRUCache(2)
// put(1, 1)   cache {1=1}
// put(2, 2)   cache {1=1, 2=2}
// get(1)      returns 1
// put(3, 3)   evicts key 2, cache {1=1, 3=3}
// get(2)      returns -1
// put(4, 4)   evicts key 1, cache {4=4, 3=3}
// get(1)      returns -1
// get(3)      returns 3
// get(4)      returns 4
//
// CONSTRAINTS
//
// 1 <= capacity <= 3000
// 0 <= key <= 10^4
// 0 <= value <= 10^5
// At most 2 * 10^5 calls to get and put
//
// APPROACH — HashMap + Doubly Linked List
//
// The O(1) requirement rules out anything that scans, so two
// structures work together:
//
//   dictionary  key → node, for O(1) lookup
//   linked list ordering, for O(1) move and evict
//
// The dictionary stores the NODE, not the value — that is what
// makes unlinking from the middle O(1).
//
// head ← least recently used … most recently used → tail
//
// Dummy head and tail sentinels mean every unlink has a real
// node on both sides, so there are no nil edge cases.
//
// get is NOT read-only: a hit moves its node to the MRU end.
//
// Time:  O(1) for get and put
// Space: O(capacity)
//
//==============================================================

// MARK: - Node

final class Node {
    var key: Int
    var value: Int
    var prev: Node?
    var next: Node?

    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
}

// MARK: - LRU Cache

final class LRUCache {
    private let capacity: Int
    private var cache: [Int: Node] = [:]

    private let head = Node(key: 0, value: 0)
    private let tail = Node(key: 0, value: 0)

    init(_ capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.prev = head
    }

    // MARK: Add Node to MRU

    private func addToMRU(_ node: Node) {
        let previousNode = tail.prev

        previousNode?.next = node
        node.prev = previousNode

        node.next = tail
        tail.prev = node
    }

    // MARK: Remove Node

    private func removeNode(_ node: Node) {
        let previousNode = node.prev
        let nextNode = node.next

        previousNode?.next = nextNode
        nextNode?.prev = previousNode
    }

    // MARK: Get

    func get(_ key: Int) -> Int {
        guard let node = cache[key] else {
            return -1
        }

        removeNode(node)
        addToMRU(node)

        return node.value
    }

    // MARK: Put

    func put(_ key: Int, _ value: Int) {
        // Existing key — update and move, do not insert
        if let existingNode = cache[key] {
            existingNode.value = value
            removeNode(existingNode)
            addToMRU(existingNode)
            return
        }

        let newNode = Node(key: key, value: value)
        cache[key] = newNode
        addToMRU(newNode)

        // Evict from BOTH the list and the dictionary
        if cache.count > capacity {
            if let lruNode = head.next {
                removeNode(lruNode)
                cache.removeValue(forKey: lruNode.key)
            }
        }
    }
}

//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== Q55 - LRU Cache - LeetCode Sequence ==========")

let cache1 = LRUCache(2)

cache1.put(1, 1)
cache1.put(2, 2)

print(cache1.get(1))
// 1

cache1.put(3, 3)

print(cache1.get(2))
// -1

cache1.put(4, 4)

print(cache1.get(1))
// -1

print(cache1.get(3))
// 3

print(cache1.get(4))
// 4


print("\n========== Q55 - LRU Cache - Capacity 1 ==========")

let cache2 = LRUCache(1)

cache2.put(1, 10)

print(cache2.get(1))
// 10

cache2.put(2, 20)

print(cache2.get(1))
// -1

print(cache2.get(2))
// 20


print("\n========== Q55 - LRU Cache - Update Existing ==========")

let cache3 = LRUCache(2)

cache3.put(1, 1)
cache3.put(2, 2)
cache3.put(1, 100)

print(cache3.get(1))
// 100

cache3.put(3, 3)

print(cache3.get(2))
// -1

print(cache3.get(1))
// 100

print(cache3.get(3))
// 3


print("\n========== Q55 - LRU Cache - Get Refreshes Order ==========")

let cache4 = LRUCache(3)

cache4.put(1, 1)
cache4.put(2, 2)
cache4.put(3, 3)

print(cache4.get(1))
// 1

cache4.put(4, 4)

print(cache4.get(2))
// -1

print(cache4.get(1))
// 1

print(cache4.get(3))
// 3

print(cache4.get(4))
// 4


print("\n========== Q55 - LRU Cache - Miss On Empty ==========")

let cache5 = LRUCache(2)

print(cache5.get(99))
// -1

cache5.put(1, 1)

print(cache5.get(99))
// -1

print(cache5.get(1))
// 1
