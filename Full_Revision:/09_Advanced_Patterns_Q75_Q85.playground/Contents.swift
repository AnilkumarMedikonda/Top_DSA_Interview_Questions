import Foundation

//==============================================================
// MARK: - 09_Advanced_Patterns_Q75_Q85
//==============================================================

//==============================================================
// MARK: - Phase 09. Advanced Patterns
//==============================================================

// Problems: Q75 - Q85
// Focus: Heap, Linked List + Heap, Advanced DSA Patterns
//==============================================================



//==============================================================
// MARK: - Helper - Min Heap
//==============================================================

final class MiniHeap {
    
    private var heap = [Int]()
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    var count: Int {
        heap.count
    }
    
    func peek() -> Int? {
        
        if heap.isEmpty {
            return nil
        }
        
        return heap.first
    }
    
    func insert(_ value: Int) {
        heap.append(value)
        heapifyUp(heap.count - 1)
    }
    
    func remove() -> Int? {
        
        guard !heap.isEmpty else { return nil }
        guard heap.count > 1 else { return heap.removeLast() }
        
        let mini = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(0)
        return mini
    }
    
    // CoreLogic functions
    
    private func heapifyUp(_ index: Int) {
        var childIndex = index
        
        while childIndex > 0 {
            let parentIndex = getParentIndex(childIndex)
            
            if heap[parentIndex] <= heap[childIndex] {
                break
            }
            heap.swapAt(parentIndex, childIndex)
            childIndex = parentIndex
        }
    }
    
    private func heapifyDown(_ index: Int) {
        var parentIndex = index
        
        while true {
            
            var smallest = parentIndex
            let leftIndex = getLeftChildIndex(parentIndex)
            let rightIndex = getRightChildIndex(parentIndex)
            
            if leftIndex < heap.count, heap[leftIndex] < heap[smallest] {
                smallest = leftIndex
            }
            
            if rightIndex < heap.count, heap[rightIndex] < heap[smallest] {
                smallest = rightIndex
            }
            
            if parentIndex == smallest {
                break
            }
            
            heap.swapAt(smallest, parentIndex)
            parentIndex = smallest
        }
        
    }
    
    
    // Helper for index
    
    
    private func getParentIndex(_ index: Int) -> Int {
        (index-1)/2
    }
    
    private func getLeftChildIndex(_ index: Int) -> Int {
        2 * index + 1
    }
    
    private func getRightChildIndex(_ index: Int) -> Int {
        2 * index + 2
    }

}


//==============================================================
// MARK: - Helper - Linked List
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
    
    guard !values.isEmpty else { return nil }
    let headNode: ListNode? = ListNode(value: values[0])
    var current: ListNode? = headNode
    
    for i in 1..<values.count {
        let node = ListNode(value: values[i])
        current?.next =  node
        current = node
    }
    
    return headNode
    
}

func printListNode(_ headNode: ListNode?) {
    
    var current: ListNode? = headNode
    
    while let node = current {
        print(node.value, terminator: " -> ")
        current = node.next
    }
    print("nil")
}


//==============================================================
// MARK: - Helper - Linked List Min Heap
//==============================================================

final class MiniHeapList {

    private var heap = [ListNode]()
    
    var count: Int {
        heap.count
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    func peek() -> ListNode? {
        if heap.isEmpty {
            return nil
        }
        return heap.first
    }
    
    func insert(_ node: ListNode) {
        heap.append(node)
        heapifyUp(heap.count - 1)
    }
    
    func remove() -> ListNode? {
        
        guard !heap.isEmpty else {
            return nil
        }
        
        guard heap.count > 1 else {
            return heap.removeLast()
        }
        
        let mini = heap[0]
        heap[0] = heap.removeLast()
        heapifyDown(0)
        return mini
        
    }
    
    private func heapifyUp(_ index: Int) {
        var childIndex = index
        
        while childIndex > 0 {
            let parentIndex = getParentIndex(childIndex)
            
            if heap[parentIndex].value <=  heap[childIndex].value {
                break
            }
            heap.swapAt(parentIndex, childIndex)
            childIndex = parentIndex
        }
    }
    
    private func heapifyDown(_ index: Int) {
        var parentIndex = index
        
        while true {
            
            var smallest = parentIndex
            let left = getLeftChildIndex(parentIndex)
            let right = getRightChildIndex(parentIndex)
            
            if left < heap.count , heap[left].value < heap[smallest].value {
                smallest = left
            }
            
            if right < heap.count , heap[right].value < heap[smallest].value {
                smallest = right
            }
            
            if smallest == parentIndex {
                break
            }
            
            heap.swapAt(parentIndex, smallest)
            parentIndex = smallest
        }
    }
        
    // helpers
    
    private func getParentIndex(_ index: Int) -> Int {
        (index-1)/2
    }
    
    private func getLeftChildIndex(_ index: Int) -> Int {
        2 * index + 1
    }
    
    private func getRightChildIndex(_ index: Int) -> Int {
        2 * index + 2
    }
}




//==============================================================
// MARK: - Q75. Kth Largest Element in an Array
//==============================================================
//
// Difficulty: Medium
// LeetCode: 215
//
// Given an integer array nums and an integer k, return the kth
// largest element in the array.
//
// Example:
// Input:  nums = [3,2,1,5,6,4], k = 2
// Output: 5
//
// Pattern:
// Min Heap
//
// Time: O(n log k)
// Space: O(k)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func findKthLargestElement(_ nums: [Int], _ k: Int) -> Int {
    let heap = MiniHeap()
    
    for num in nums {
        
        heap.insert(num)
        
        if heap.count > k {
            _ = heap.remove()
        }
    }
    
    return heap.peek() ?? -1
}


//--------------------------------------------------------------
// Test Cases
//--------------------------------------------------------------

print("========== Q75: Kth Largest Element in an Array ==========")

print(findKthLargestElement([3, 2, 1, 5, 6, 4], 2))
// Expected: 5

print(findKthLargestElement([3, 2, 3, 1, 2, 4, 5, 5, 6], 4))
// Expected: 4

print(findKthLargestElement([7, 6, 5, 4, 3, 2, 1], 5))
// Expected: 3

print(findKthLargestElement([2, 2, 2, 1, 1, 3], 3))
// Expected: 2

print(findKthLargestElement([1], 1))
// Expected: 1



//==============================================================
// MARK: - Q76. Merge K Sorted Lists
//==============================================================
//
// Difficulty: Hard
// LeetCode: 23
//
// You are given an array of k linked lists, where each linked
// list is sorted in ascending order.
//
// Merge all the linked lists into one sorted linked list.
//
// Example:
// Input:
// [1 -> 4 -> 5]
// [1 -> 3 -> 4]
// [2 -> 6]
//
// Output:
// 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6
//
// Pattern:
// Linked List + Min Heap
//
// Time: O(n log k)
// Space: O(k)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    
    let dummy: ListNode? = ListNode(value: 0)
    var tail: ListNode? = dummy
    
    let heap = MiniHeapList()
    
    for list in lists {
        
        if let node = list {
            heap.insert(node)
        }
    }
    
    while let node = heap.remove() {
        
        tail?.next = node
        tail = node
        
        if let nextNode = node.next {
            heap.insert(nextNode)
        }
    }

    tail?.next = nil
    
    return dummy?.next
    
}


//--------------------------------------------------------------
// Test Cases
//--------------------------------------------------------------

print("========== Q76: Merge K Sorted Lists ==========")

printListNode(mergeKLists([
    createList([1, 4, 5]),
    createList([1, 3, 4]),
    createList([2, 6])
]))
// Expected: 1 -> 1 -> 2 -> 3 -> 4 -> 4 -> 5 -> 6 -> nil

printListNode(mergeKLists([
    createList([1]),
    createList([2]),
    createList([3])
]))
// Expected: 1 -> 2 -> 3 -> nil

printListNode(mergeKLists([
    createList([1, 1, 1]),
    createList([1, 1])
]))
// Expected: 1 -> 1 -> 1 -> 1 -> 1 -> nil

printListNode(mergeKLists([
    createList([]),
    createList([2, 4]),
    createList([])
]))
// Expected: 2 -> 4 -> nil

printListNode(mergeKLists([createList([])]))
// Expected: nil

printListNode(mergeKLists([]))
// Expected: nil
