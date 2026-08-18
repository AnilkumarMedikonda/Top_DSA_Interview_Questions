import Foundation

//==============================================================
// Pattern 02 — Same Direction (Read / Write Pointer)
//==============================================================
//
// IDEA
// Both pointers move left → right. `read` visits every element,
// `write` marks where the next kept element goes.
//
// INVARIANT
// nums[0..<write] = kept elements, in order. Everything from
// `write` to `read` is discarded. write <= read, always.
//
// RETURN VALUE
// After the loop, `write` is the new length.
//
// TRAPS
// Bumping write before the copy. Advancing read inside the if.
// Assuming the tail is cleaned — it isn't.
//
// COMPLEXITY
// Time O(n), Space O(1).
//
// USED BY
// Q15 Sort Colors, Q19 First Missing Positive.
//==============================================================

var nums = [0,1,2,2,3,0,4,2]
var val = 2


func removeElement(_ nums: inout [Int], _ val: Int) -> Int {

    var write = 0
    
    
    for read in 0..<nums.count {
        
        if nums[read] != val {
            let temp = nums[read]
            nums[read] = nums[write]
            nums[write] = temp
            write += 1
        }
    }
    
    return write
}

let write = removeElement(&nums, val)
print(nums)

for i  in 0..<write {
    print(nums[i], terminator: ", ")
}
