import UIKit

//============================================================
// 02 In-Place Update Pattern
// Modify the original array without creating another array.
//============================================================


//------------------------------------------------------------
// 01 Multiply Every Element by 2
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

var numbers1 = [10, 20, 30, 40, 50]

func multiplyByTwo(_ nums: inout [Int]) {

    for i in 0..<nums.count {
        nums[i] *= 2
    }
}

print("========== Multiply Every Element by 2 ==========")
print("Before:", numbers1)

multiplyByTwo(&numbers1)

print("After :", numbers1)


//------------------------------------------------------------
// 02 Replace Even Numbers With 0
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

var numbers2 = [10, 15, 20, 25, 30]

func replaceEvenWithZero(_ nums: inout [Int]) {

    for i in 0..<nums.count {

        if nums[i] % 2 == 0 {
            nums[i] = 0
        }
    }
}

print()
print("========== Replace Even Numbers With 0 ==========")
print("Before:", numbers2)

replaceEvenWithZero(&numbers2)

print("After :", numbers2)


//------------------------------------------------------------
// 03 Increase Every Element By 5
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

var numbers3 = [10, 20, 30, 40, 50]

func increaseByFive(_ nums: inout [Int]) {

    for i in 0..<nums.count {
        nums[i] += 5
    }
}

print()
print("========== Increase Every Element By 5 ==========")
print("Before:", numbers3)

increaseByFive(&numbers3)

print("After :", numbers3)


//------------------------------------------------------------
// 04 Reverse Array
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

var numbers4 = [10, 20, 30, 40, 50]

func reverseArray(_ nums: inout [Int]) {

    var left = 0
    var right = nums.count - 1

    while left < right {

        let temp = nums[left]
        nums[left] = nums[right]
        nums[right] = temp

        left += 1
        right -= 1
    }
}

print()
print("========== Reverse Array ==========")
print("Before:", numbers4)

reverseArray(&numbers4)

print("After :", numbers4)


//------------------------------------------------------------
// 05 Swap Two Elements
//------------------------------------------------------------
// Time : O(1)
// Space: O(1)

var numbers5 = [10, 20, 30, 40, 50]

func swapTwoElements(_ nums: inout [Int], first: Int, second: Int) {

    guard first >= 0,
          second >= 0,
          first < nums.count,
          second < nums.count else {
        return
    }

    let temp = nums[first]
    nums[first] = nums[second]
    nums[second] = temp
}

print()
print("========== Swap Two Elements ==========")
print("Before:", numbers5)

swapTwoElements(&numbers5, first: 1, second: 3)

print("After :", numbers5)


//------------------------------------------------------------
// 06 Remove Target Value (LC 27)
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

var numbers6 = [3, 2, 2, 3, 4, 2, 5]

func removeValue(_ nums: inout [Int], _ target: Int) -> Int {

    var write = 0

    for read in 0..<nums.count {

        if nums[read] != target {

            nums[write] = nums[read]
            write += 1
        }
    }

    return write
}

print()
print("========== Remove Target Value ==========")
print("Before:", numbers6)

let length1 = removeValue(&numbers6, 2)

print("Valid Length:", length1)

print("Valid Elements:", terminator: " ")

for i in 0..<length1 {
    print(numbers6[i], terminator: " ")
}

print()


//------------------------------------------------------------
// 07 Remove Duplicates From Sorted Array (LC 26)
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

var numbers7 = [1,1,2,2,3,4,4,5]

func removeDuplicates(_ nums: inout [Int]) -> Int {

    guard !nums.isEmpty else { return 0 }

    var write = 1

    for read in 1..<nums.count {

        if nums[read] != nums[write - 1] {

            nums[write] = nums[read]
            write += 1
        }
    }

    return write
}

print()
print("========== Remove Duplicates ==========")
print("Before:", numbers7)

let length2 = removeDuplicates(&numbers7)

print("Valid Length:", length2)

print("Valid Elements:", terminator: " ")

for i in 0..<length2 {
    print(numbers7[i], terminator: " ")
}

print()


//------------------------------------------------------------
// 08 Move Zeroes (LC 283)
//------------------------------------------------------------
// Time : O(n)
// Space: O(1)

var numbers8 = [0, 1, 0, 3, 12]

func moveZeroes(_ nums: inout [Int]) {

    var write = 0

    for read in 0..<nums.count {

        if nums[read] != 0 {

            let temp = nums[write]
            nums[write] = nums[read]
            nums[read] = temp

            write += 1
        }
    }
}

print()
print("========== Move Zeroes ==========")
print("Before:", numbers8)

moveZeroes(&numbers8)

print("After :", numbers8)
