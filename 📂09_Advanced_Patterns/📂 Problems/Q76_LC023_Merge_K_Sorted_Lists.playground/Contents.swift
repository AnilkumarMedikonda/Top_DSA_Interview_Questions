import Foundation

//==============================================================
// MARK: - Q76 - LC023 - Merge K Sorted Lists
//==============================================================
//
// Given an array of k linked lists, each sorted ascending,
// merge them into one sorted list and return its head.
//
// Example:
// [[1,4,5], [1,3,4], [2,6]]
// → 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil
//
// Constraints:
// 0 <= k <= 10^4
// 0 <= list length <= 500
// -10^4 <= node value <= 10^4
// total nodes <= 10^4
//
// Brute force: merge pairwise left to right. O(N * k) — the
// first list gets walked again on every merge. Not implemented.
//
// Optimal: min-heap of the current head of each list. Pop the
// smallest, append it, push its successor. The heap never
// holds more than k nodes, so each of the N nodes costs one
// log k insert and one log k removal.
//
// Time:  O(N log k)
// Space: O(k)
//
//==============================================================

final class ListNode {

    var value: Int
    var next: ListNode?

    init(value: Int, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

func createList(_ values: [Int]) -> ListNode? {
    if values.isEmpty {
        return nil
    }

    let head = ListNode(value: values[0])
    var current = head

    for i in 1..<values.count {
        let node = ListNode(value: values[i])
        current.next = node
        current = node
    }

    return head
}

func printListNode(_ node: ListNode?) {
    var current = node

    while let currentNode = current {
        print(currentNode.value, terminator: " -> ")
        current = currentNode.next
    }

    print("nil")
}


//==============================================================
// MARK: - Min Heap Of Nodes
//==============================================================

final class MinHeap {

    private var heap = [ListNode]()

    var count: Int {
        return heap.count
    }

    var isEmpty: Bool {
        return heap.isEmpty
    }

    func peek() -> Int? {
        if heap.isEmpty {
            return nil
        }

        return heap[0].value
    }

    func insert(_ node: ListNode) {
        heap.append(node)
        heapifyUp(heap.count - 1)
    }

    func remove() -> ListNode? {
        if heap.isEmpty {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let minNode = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(0)

        return minNode
    }

    // MARK: - Core Logic

    private func heapifyUp(_ index: Int) {
        var childIndex = index

        while childIndex > 0 {
            let parent = getParentIndex(childIndex)

            if heap[parent].value <= heap[childIndex].value {
                break
            }

            heap.swapAt(parent, childIndex)
            childIndex = parent
        }
    }

    private func heapifyDown(_ index: Int) {
        var parent = index

        while true {
            var smallest = parent
            let left = getLeftChildIndex(parent)
            let right = getRightChildIndex(parent)

            if left < heap.count && heap[left].value < heap[smallest].value {
                smallest = left
            }

            if right < heap.count && heap[right].value < heap[smallest].value {
                smallest = right
            }

            if smallest == parent {
                break
            }

            heap.swapAt(smallest, parent)
            parent = smallest
        }
    }

    // MARK: - Helpers

    private func getParentIndex(_ childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    private func getLeftChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }

    private func getRightChildIndex(_ parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
}


//==============================================================
// MARK: - Solution
//==============================================================

func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    let heap = MinHeap()

    // Seed with the head of every non-empty list
    for list in lists {
        if let node = list {
            heap.insert(node)
        }
    }

    let dummy = ListNode(value: 0)
    var tail = dummy

    while let node = heap.remove() {
        tail.next = node
        tail = node

        if let next = node.next {
            heap.insert(next)
        }
    }

    // The last node still points into its original list
    tail.next = nil

    return dummy.next
}


//==============================================================
// MARK: - Trace
//==============================================================
//
// lists [1,4,5] [1,3,4] [2,6]
//
// seed    heap 1a 1b 2
// pop 1a  append, push 4a     heap 1b 2 4a
// pop 1b  append, push 3      heap 2 3 4a
// pop 2   append, push 6      heap 3 4a 6
// pop 3   append, push 4b     heap 4a 4b 6
// pop 4a  append, push 5      heap 4b 5 6
// pop 4b  append, nothing     heap 5 6
// pop 5   append, nothing     heap 6
// pop 6   append, nothing     heap empty
//
// → 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil
//
//==============================================================


//==============================================================
// MARK: - Tests
//==============================================================

print("\n========== Q76 - Merge K Sorted Lists ==========")

let list1 = createList([1, 4, 5])
let list2 = createList([1, 3, 4])
let list3 = createList([2, 6])

printListNode(mergeKLists([list1, list2, list3]))
// 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil

printListNode(mergeKLists([]))
// nil

printListNode(mergeKLists([nil, nil]))
// nil

printListNode(mergeKLists([createList([1, 2, 3])]))
// 1 -> 2 -> 3 -> nil

printListNode(mergeKLists([nil, createList([2]), nil]))
// 2 -> nil

printListNode(mergeKLists([createList([1, 1]), createList([1])]))
// 1 -> 1 -> 1 -> nil
