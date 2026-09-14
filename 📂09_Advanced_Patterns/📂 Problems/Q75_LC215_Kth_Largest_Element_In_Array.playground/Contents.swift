import Foundation

//==============================================================
// MARK: - Q75 - LC215 - Kth Largest Element In An Array
//==============================================================
//
// Return the kth largest element in sorted order — not the
// kth distinct element. Duplicates count separately.
//
// Example:
// [3, 2, 1, 5, 6, 4], k = 2          → 5
// [3, 2, 3, 1, 2, 4, 5, 5, 6], k = 4 → 4
//
// Constraints:
// 1 <= k <= nums.count <= 10^5
// -10^4 <= nums[i] <= 10^4
//
// Brute force: sort descending, take index k - 1. O(n log n)
// and it orders the whole array when only k elements matter.
// Not implemented.
//
// Optimal: min-heap capped at k. The root is the smallest of
// the k largest seen so far, which IS the kth largest once
// every element has passed through.
//
// Time:  O(n log k)
// Space: O(k)
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

    func peek() -> Int? {
        if heap.isEmpty {
            return nil
        }

        return heap[0]
    }

    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(of: heap.count - 1)
    }

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
            let parentIndex = getParentIndex(of: childIndex)

            if heap[parentIndex] <= heap[childIndex] {
                break
            }

            heap.swapAt(parentIndex, childIndex)
            childIndex = parentIndex
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

            heap.swapAt(parentIndex, smallest)
            parentIndex = smallest
        }
    }

    // MARK: - Helpers

    private func getParentIndex(of childIndex: Int) -> Int {
        return (childIndex - 1) / 2
    }

    private func getLeftChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }

    private func getRightChildIndex(of parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
}


//==============================================================
// MARK: - Solution
//==============================================================

func findKthLargestElement(_ nums: [Int], _ k: Int) -> Int? {
    let heap = MinHeap()

    for num in nums {
        heap.insert(num)

        if heap.count > k {
            heap.remove()
        }
    }

    return heap.peek()
}


//==============================================================
// MARK: - Tests
//==============================================================

func show(_ value: Int?) {
    if let value = value {
        print(value)
    } else {
        print("nil")
    }
}

print("\n========== Q75 - Kth Largest Element In An Array ==========")

show(findKthLargestElement([3, 2, 1, 5, 6, 4], 2))
// 5

show(findKthLargestElement([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))
// 4

show(findKthLargestElement([1], 1))
// 1

show(findKthLargestElement([3, 2, 1, 5, 6, 4], 6))
// 1

show(findKthLargestElement([-1, -5, -3], 2))
// -3
