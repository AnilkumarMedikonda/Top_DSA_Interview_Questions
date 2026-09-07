import Foundation


// Q64_LC143_Reorder_List

final class ListNode {
    let value: Int
    var next: ListNode?
    
    init(value: Int, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}


func middleNode(_ head: ListNode?) -> ListNode? {
    
    guard let head else { return nil }
    var slow: ListNode? = head
    var fast: ListNode? = head.next
    
    while fast != nil, fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    return slow
    
}


func revesrNode(_ headNode: ListNode?) -> ListNode? {
    
    guard let headNode else { return nil }
    var current: ListNode? = headNode
    var prev: ListNode? = nil
    
    while let node = current {
        let nextNode = node.next
        current?.next = prev
        prev = nextNode
        current = nextNode
    }
    
    return prev
}


func reOrderList(_ headNode: ListNode?){
    
    guard headNode != nil, headNode?.next != nil else { return }
    var middleNode = middleNode(headNode)
    var second = revesrNode(middleNode?.next)
    middleNode?.next = nil
    
    var first = headNode
    
    
    while second != nil {
        
        let temp1 = first?.next
        let temp2 = second?.next
        
        first?.next = second?.next
        second?.next = temp2
        
        first = temp1
        second = temp2
    }
    
}
