import Foundation

//==============================================================
// MARK: - 01. Heap
//==============================================================
//
// A heap is a plain array read as a complete binary tree.
//
//   parent(i) = (i - 1) / 2
//   left(i)   = 2i + 1
//   right(i)  = 2i + 2
//
// Invariant is parent-to-child only — siblings are unordered,
// so the root is the extreme value but the array is NOT sorted.
//
// Insert → append, then heapify UP
// Remove → take root, move last to root, heapify DOWN
//
// Fires on "kth", "top k", "merge k streams", "smallest so far".
//
// Time:  insert O(log n), remove O(log n), peek O(1)
// Space: O(n)
//
//==============================================================

final class MinHeap {

    private var heap = [Int]()

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    // Time: O(1), Space: O(1)
    func peek() -> Int? {
        if heap.isEmpty {
            return nil
        }

        return heap[0]
    }

    // Time: O(log n), Space: O(1)
    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(of: heap.count - 1)
    }

    // Time: O(log n), Space: O(1)
    func remove() -> Int? {
        if heap.isEmpty {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let minValue = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(of: 0)

        return minValue
    }

    // MARK: - Core Logic

    private func heapifyUp(of index: Int) {
        var childIndex = index

        while childIndex > 0 {
            let parent = getParentIndex(of: childIndex)

            if heap[parent] <= heap[childIndex] {
                break
            }

            swapValues(parent, childIndex)
            childIndex = parent
        }
    }

    private func heapifyDown(of index: Int) {
        var parentIndex = index

        while true {
            var smallest = parentIndex
            let left = getLeftChildIndex(of: parentIndex)
            let right = getRightChildIndex(of: parentIndex)

            if left < heap.count && heap[left] < heap[smallest] {
                smallest = left
            }

            if right < heap.count && heap[right] < heap[smallest] {
                smallest = right
            }

            if smallest == parentIndex {
                break
            }

            swapValues(smallest, parentIndex)
            parentIndex = smallest
        }
    }

    // MARK: - Helper Functions

    private func getParentIndex(of childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    private func getLeftChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }

    private func getRightChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }

    private func swapValues(_ i: Int, _ j: Int) {
        let temporary = heap[i]
        heap[i] = heap[j]
        heap[j] = temporary
    }
}

//==============================================================
// MARK: - Max Heap
//==============================================================
//
// Identical to MinHeap with every comparison flipped.
// Only heapifyUp and heapifyDown differ.
//
//==============================================================

final class MaxHeap {

    private var heap = [Int]()

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    // Time: O(1), Space: O(1)
    func peek() -> Int? {
        if heap.isEmpty {
            return nil
        }

        return heap[0]
    }

    // Time: O(log n), Space: O(1)
    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(of: heap.count - 1)
    }

    // Time: O(log n), Space: O(1)
    func remove() -> Int? {
        if heap.isEmpty {
            return nil
        }

        if heap.count == 1 {
            return heap.removeLast()
        }

        let maxValue = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(of: 0)

        return maxValue
    }

    // MARK: - Core Logic

    private func heapifyUp(of index: Int) {
        var childIndex = index

        while childIndex > 0 {
            let parent = getParentIndex(of: childIndex)

            if heap[parent] >= heap[childIndex] {
                break
            }

            swapValues(parent, childIndex)
            childIndex = parent
        }
    }

    private func heapifyDown(of index: Int) {
        var parentIndex = index

        while true {
            var greatest = parentIndex
            let left = getLeftChildIndex(of: parentIndex)
            let right = getRightChildIndex(of: parentIndex)

            if left < heap.count && heap[left] > heap[greatest] {
                greatest = left
            }

            if right < heap.count && heap[right] > heap[greatest] {
                greatest = right
            }

            if greatest == parentIndex {
                break
            }

            swapValues(greatest, parentIndex)
            parentIndex = greatest
        }
    }

    // MARK: - Helper Functions

    private func getParentIndex(of childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    private func getLeftChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }

    private func getRightChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }

    private func swapValues(_ i: Int, _ j: Int) {
        let temporary = heap[i]
        heap[i] = heap[j]
        heap[j] = temporary
    }
}

//==============================================================
// MARK: - Trace
//==============================================================
//
// Min-heap, insert 5, 3, 8, 1
//
// append 5 → [5]
// append 3 → [5, 3]        up: 3 < 5        → [3, 5]
// append 8 → [3, 5, 8]     up: 8 > 3, stop  → [3, 5, 8]
// append 1 → [3, 5, 8, 1]  up: 1 < 5 → swap → [3, 1, 8, 5]
//                              1 < 3 → swap → [1, 3, 8, 5]
//
// remove → root 1, last 5 to root → [5, 3, 8]
//          down: 3 < 5 → swap     → [3, 5, 8]
//
// [1, 3, 8, 5] is a valid heap and not sorted — 8 before 5.
//
//==============================================================

func show(_ value: Int?) {
    if let value = value {
        print(value)
    } else {
        print("nil")
    }
}

print("\n========== 01 - Heap - Min ==========")

let minHeap = MinHeap()

minHeap.insert(5)
minHeap.insert(3)
minHeap.insert(8)
minHeap.insert(1)

show(minHeap.peek())
// 1

show(minHeap.remove())
// 1

show(minHeap.remove())
// 3

show(minHeap.remove())
// 5

show(minHeap.remove())
// 8

print(minHeap.isEmpty)
// true

print("\n========== 01 - Heap - Max ==========")

let maxHeap = MaxHeap()

maxHeap.insert(5)
maxHeap.insert(3)
maxHeap.insert(8)
maxHeap.insert(1)

show(maxHeap.peek())
// 8

show(maxHeap.remove())
// 8

show(maxHeap.remove())
// 5

print("\n========== 01 - Heap - Edges ==========")

let emptyHeap = MinHeap()

show(emptyHeap.remove())
// nil

let singleHeap = MinHeap()

singleHeap.insert(7)

show(singleHeap.remove())
// 7

let duplicateHeap = MinHeap()

duplicateHeap.insert(4)
duplicateHeap.insert(2)
duplicateHeap.insert(4)

show(duplicateHeap.remove())
// 2

let negativeHeap = MinHeap()

negativeHeap.insert(-1)
negativeHeap.insert(-9)
negativeHeap.insert(3)

show(negativeHeap.remove())
// -9
