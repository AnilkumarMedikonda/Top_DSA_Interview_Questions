import Foundation

//==============================================================
// Q55 - LC146 - LRU Cache
//==============================================================
//
// Problem
// -------
// Design a cache with a fixed capacity that evicts the least recently
// used entry when full. Support:
//
//   get(key)         return the value, or -1 if absent
//   put(key, value)  insert or update; evict the LRU entry if over
//                    capacity
//
// Both operations must run in O(1) average time. A get counts as a
// use, so reading an entry protects it from the next eviction.
//
// Example
// -------
// LRUCache(capacity: 2)
// put(1, 1)
// put(2, 2)
// get(1)     -> 1        1 is now the most recently used
// put(3, 3)  evicts 2    because 1 was just used
// get(2)     -> -1
// put(4, 4)  evicts 1
// get(1)     -> -1
// get(3)     -> 3
// get(4)     -> 4
//
// Constraints
// -----------
// 1 <= capacity <= 3000
// 0 <= key <= 10^4
// 0 <= value <= 10^5
// at most 2 * 10^5 calls to get and put
//
// Pattern : HashMap + Doubly Linked List (06_HashMap_Doubly_Linked_List)
//
// Brute Force : dictionary + timestamp, O(n) scan to find the oldest
// Optimal     : O(1) worst case both operations, O(capacity) space
//
// head <-> most recently used <-> ... <-> least recently used <-> tail
//
//==============================================================


// MARK: - Brute Force (dictionary + timestamp)

// Correct, and it is the version to say out loud first. Lookup is
// O(1) but eviction has to walk every entry to find the oldest stamp.
//
// get : O(1)
// put : O(n) when evicting
final class LRUCacheBruteForce {

    private let capacity: Int
    private var values = [Int: Int]()
    private var stamps = [Int: Int]()
    private var clock = 0

    init(capacity: Int) {
        self.capacity = capacity
    }

    func get(_ key: Int) -> Int {
        if let value = values[key] {
            clock += 1
            stamps[key] = clock
            return value
        } else {
            return -1
        }
    }

    func put(_ key: Int, _ value: Int) {
        clock += 1
        values[key] = value
        stamps[key] = clock

        if values.count > capacity {
            var oldestKey = -1
            var oldestStamp = Int.max
            for (candidateKey, stamp) in stamps {
                if stamp < oldestStamp {
                    oldestStamp = stamp
                    oldestKey = candidateKey
                }
            }
            if oldestKey != -1 {
                values[oldestKey] = nil
                stamps[oldestKey] = nil
            }
        }
    }
}


// MARK: - Node

// A class, not a struct — the dictionary and the node's neighbours
// must all see the same instance.
//
// `key` is stored on the node because eviction finds the node first
// and then has to erase its dictionary entry. Without the back
// reference there is no way to know which key that was.
//
// `prev` is weak. Strong in both directions makes every adjacent pair
// a retain cycle and the whole list leaks when the cache is released.
// The `next` chain from head keeps every node alive, so weak is safe.
final class Node {

    let key: Int
    var value: Int
    var next: Node?
    weak var prev: Node?

    init(_ key: Int, _ value: Int) {
        self.key = key
        self.value = value
    }
}


// MARK: - Optimal (HashMap + Doubly Linked List)

final class LRUCache {

    private let capacity: Int
    private var cache = [Int: Node]()

    // sentinels — never hold data, so insert and remove always have a
    // real node on both sides and need no nil branches
    private let head = Node(0, 0)
    private let tail = Node(0, 0)

    init(capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.prev = head
    }

    // Time : O(1)
    private func add(_ node: Node) {
        node.next = head.next
        node.prev = head
        head.next?.prev = node
        head.next = node
    }

    // Time : O(1)
    private func remove(_ node: Node) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
        // clearing the node's own pointers matters on eviction: without
        // it the removed node keeps a strong `next` into the list and
        // never deallocates
        node.next = nil
        node.prev = nil
    }

    // Time : O(1)
    private func moveToHead(_ node: Node) {
        remove(node)
        add(node)
    }

    // Time : O(1)
    private func removeTail() -> Node? {
        guard let node = tail.prev, node !== head else {
            return nil
        }
        remove(node)
        return node
    }

    // Time : O(1)
    func get(_ key: Int) -> Int {
        guard let node = cache[key] else {
            return -1
        }
        moveToHead(node)
        return node.value
    }

    // Time : O(1)
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node)
            return
        }

        let newNode = Node(key, value)
        cache[key] = newNode
        add(newNode)

        if cache.count > capacity {
            if let removed = removeTail() {
                cache[removed.key] = nil
            }
        }
    }

    // O(n) — traces only, never call this inside a solution
    func display() {
        print("MRU ---------------------> LRU")

        var current = head.next
        while let node = current, node !== tail {
            print("[\(node.key):\(node.value)]", terminator: " ")
            current = node.next
        }

        print()
    }
}


// MARK: - Test Cases (LC146 example)

print("========== LC146 EXAMPLE ==========")

let lru = LRUCache(capacity: 2)

lru.put(1, 1)
lru.put(2, 2)
lru.display()

print("get(1) :", lru.get(1))          // 1

lru.display()

lru.put(3, 3)                          // evicts 2, not 1
lru.display()

print("get(2) :", lru.get(2))          // -1

lru.put(4, 4)                          // evicts 1
lru.display()

print("get(1) :", lru.get(1))          // -1

print("get(3) :", lru.get(3))          // 3

print("get(4) :", lru.get(4))          // 4


// MARK: - Update Existing Key

print("\n========== UPDATE EXISTING ==========")

let updater = LRUCache(capacity: 2)
updater.put(1, 10)
updater.put(2, 20)
updater.put(1, 100)                    // updates and promotes, no eviction
updater.display()

updater.put(3, 30)                     // evicts 2, because 1 was just touched
updater.display()

print("get(2) :", updater.get(2))      // -1

print("get(1) :", updater.get(1))      // 100


// MARK: - Capacity One

print("\n========== CAPACITY ONE ==========")

let single = LRUCache(capacity: 1)
single.put(1, 1)
single.put(2, 2)
single.display()

print("get(1) :", single.get(1))       // -1

print("get(2) :", single.get(2))       // 2


// MARK: - Brute Force Comparison

print("\n========== BRUTE FORCE ==========")

let slow = LRUCacheBruteForce(capacity: 2)
slow.put(1, 1)
slow.put(2, 2)

print("get(1) :", slow.get(1))         // 1

slow.put(3, 3)                         // O(n) scan to evict 2

print("get(2) :", slow.get(2))         // -1

print("get(3) :", slow.get(3))         // 3


// MARK: - Notes

/*
 The three bugs
 --------------
 1. Node without a `key` field — eviction finds the node but cannot
    remove the dictionary entry, so the map grows unbounded.
 2. Updating the value and skipping moveToHead — values stay correct,
    recency goes stale, the wrong key gets evicted later.
 3. Strong `prev` — every adjacent pair is a retain cycle. Not a
    correctness bug, which is why it survives review.

 Why doubly linked
 -----------------
 Unlinking needs the predecessor. A singly linked list walks from the
 head to find it, which is O(n) and removes the only reason this
 structure exists.

 Why not a dictionary alone
 --------------------------
 No order. A timestamp per entry needs an O(n) scan to find the
 oldest, which is the brute force above.

 Submission note
 ---------------
 O(1) here is worst case, not amortised — unlike Q53. Nothing touches
 more than a fixed number of nodes per operation.
*/
