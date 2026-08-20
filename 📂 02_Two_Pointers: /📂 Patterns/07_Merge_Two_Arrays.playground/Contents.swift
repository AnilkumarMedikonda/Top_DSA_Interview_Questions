import Foundation

//==============================================================
// Pattern 07 — Merge Two Arrays
//==============================================================

/*
Objective
---------
Merge two sorted arrays into one sorted array.

Idea
----
Use one pointer for each array.
Compare both elements.
Take the smaller element.
Move that pointer.
Append remaining elements.

Pointers
--------
i -> nums1
j -> nums2

Pattern
-------
nums1: 1 3 5
        ↑
        i

nums2: 2 4 6
        ↑
        j

result:
        ↑

Template
--------
while i < nums1.count && j < nums2.count {

    if nums1[i] <= nums2[j] {
        result.append(nums1[i])
        i += 1
    } else {
        result.append(nums2[j])
        j += 1
    }
}

Append remaining elements.

Complexity
----------
Time  : O(m + n)
Space : O(m + n)

Edge Cases
----------
• nums1 is empty
• nums2 is empty
• Duplicate values
• Different array sizes

Applications
------------
• Merge Sorted Array (LC 88)
• Merge Sort
• Merge Intervals (similar merge idea)
• Merge Two Sorted Linked Lists
*/

var nums1 = [1,3,5]
var nums2 = [2,4,6]


func mergeSorted(_ a: [Int], _ b: [Int]) -> [Int] {
    
    var m = 0
    var n = 0
    
    var result = [Int]()
    
    while m < a.count && n < b.count {
        
        if a[m] < b[n] {
            result.append(a[m])
            m += 1
        } else {
            result.append(b[n])
            n += 1
        }
    }
    
    
    while m < a.count {
        result.append(a[m])
        m += 1
    }
    
    while n < b.count {
        result.append(b[n])
        n += 1
    }
    
    return result
    
}


print(mergeSorted(nums1, nums2))
