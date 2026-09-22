import Foundation

//==============================================================
// MARK: - PHASE 06: STACK & QUEUE
//==============================================================
//
// Q48 - Q56
//
// Focus:
// - Valid Parentheses
// - Min Stack
// - Daily Temperatures
// - Evaluate Reverse Polish Notation
// - Decode String
// - Implement Queue Using Stacks
// - Asteroid Collision
// - LRU Cache
// - Next Greater Element I
//
//==============================================================


//==============================================================
// MARK: - Q48. Valid Parentheses
//==============================================================
//
// Difficulty: Easy
// LeetCode: 20
//
// Given a string s containing just the characters '(', ')', '{',
// '}', '[' and ']', determine if the input string is valid.
//
// An input string is valid if:
// - Open brackets are closed by the same type of brackets.
// - Open brackets are closed in the correct order.
// - Every closing bracket has a corresponding opening bracket.
//
// Example:
//
// Input: s = "()[]{}"
// Output: true
//
// Time: O(n)
// Space: O(n)                                                     // fixed
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func isOpen(_ char: Character) -> Bool {
    return char == "(" || char == "{" || char == "["
}

func isMatching(_ open: Character, _ close: Character) -> Bool {    // fixed
    
return (open == "(" && close == ")") || (open == "[" && close == "]") || (open == "{" && close == "}")
    
}

func isValid(_ str: String) -> Bool {
    
    var stack = [Character]()
    
    for ch in str {
        if isOpen(ch) {
            stack.append(ch)
        } else if let last = stack.last, isMatching(last, ch) {      // fixed
            stack.removeLast()
        } else {
            return false
        }
    }
    
    return stack.isEmpty
}


//==============================================================
// MARK: Test Cases - Q48
//==============================================================

print("========== Q48: Valid Parentheses ==========")

print(isValid("()"))              // Expected: true
print(isValid("()[]{}"))          // Expected: true
print(isValid("(]"))              // Expected: false
print(isValid("([{}])"))          // Expected: true
print(isValid("["))               // Expected: false



//==============================================================
// MARK: - Q49. Min Stack
//==============================================================
//
// Difficulty: Medium
// LeetCode: 155
//
// Design a stack that supports push, pop, top, and retrieving
// the minimum element in constant time.
//
// Implement:
// - push(val)
// - pop()
// - top()
// - getMin()
//
// Example:
//
// Input:
// push(-2)
// push(0)
// push(-3)
// getMin()
// pop()
// top()
// getMin()
//
// Output:
// -3
// 0
// -2
//
// Time: O(1) per operation                                        // fixed
// Space: O(n)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------


struct MiniStack {
    
    private var stack = [Int]()
    private var miniStack = [Int]()
    
    
    var isEmpty: Bool {
        stack.isEmpty
    }
    
    var count: Int {
        stack.count
    }
    
  mutating  func push(_ value: Int) {
        
        stack.append(value)
        
      if let currentMin = miniStack.last {
          if  value < currentMin {
              miniStack.append(value)
          } else {
              miniStack.append(currentMin)
          }
      } else {
          miniStack.append(value)
      }
        
    }
    
    
    mutating func popLast() -> Int? {
        
        if stack.isEmpty {
            return nil
        }
        miniStack.removeLast()                                     // fixed
        return stack.popLast()
    }
    
    func top() -> Int? {
        stack.last
    }
    
    
    func getMini() -> Int? {
        miniStack.last
    }

    
    func disPlay() {
        
        print("Stack", stack)
        print("Mini", miniStack)
    }
    
}

//==============================================================
// MARK: Test Cases - Q49
//==============================================================

print("========== Q49: Min Stack ==========")

var minStack = MiniStack()
minStack.push(-2)
minStack.push(0)
minStack.push(-3)
print(minStack.getMini())         // Expected: -3

print(minStack.popLast())         // Expected: -3
print(minStack.top())             // Expected: 0

print(minStack.getMini())         // Expected: -2


minStack = MiniStack()

minStack.push(2)
minStack.push(1)
minStack.push(3)

print(minStack.getMini())         // Expected: 1

print(minStack.popLast())         // Expected: 3                   // fixed
print(minStack.getMini())         // Expected: 1                   // fixed



//==============================================================
// MARK: - Q50. Daily Temperatures
//==============================================================
//
// Difficulty: Medium
// LeetCode: 739
//
// Given an array of daily temperatures, return an array where
// answer[i] is the number of days you have to wait after day i
// to get a warmer temperature.
//
// If there is no future day with a warmer temperature,
// answer[i] should be 0.
//
// Example:
//
// Input:
// temperatures = [73,74,75,71,69,72,76,73]
//
// Output:
// [1,1,4,2,1,1,0,0]
//
// Time: O(n)
// Space: O(n)
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func dailyTemperatures(_ temps: [Int]) -> [Int] {
    
    var result = Array(repeating: 0, count: temps.count)
    var stack = [Int]()
    
    for i in 0..<temps.count {
        
        while let last = stack.last , temps[last] < temps[i] {
            let waitingDay = stack.removeLast()
            result[waitingDay] = i - waitingDay
        }
        
        stack.append(i)
        
    }
    
    return result
    
}

//==============================================================
// MARK: Test Cases - Q50
//==============================================================

print("========== Q50: Daily Temperatures ==========")

print(dailyTemperatures([73,74,75,71,69,72,76,73]))
// Expected: [1,1,4,2,1,1,0,0]

print(dailyTemperatures([30,40,50,60]))
// Expected: [1,1,1,0]

print(dailyTemperatures([60,50,40,30]))
// Expected: [0,0,0,0]

print(dailyTemperatures([30,30,30]))
// Expected: [0,0,0]                                               // fixed

print(dailyTemperatures([70]))
// Expected: [0]



//==============================================================
// MARK: - Q51. Evaluate Reverse Polish Notation
//==============================================================
//
// Difficulty: Medium
// LeetCode: 150
//
// Evaluate the value of an arithmetic expression in Reverse
// Polish Notation.
//
// Valid operators are:
// +, -, *, /
//
// Division between two integers truncates toward zero.
//
// Example:
//
// Input: tokens = ["2","1","+","3","*"]
// Output: 9
//
// Explanation:
// (2 + 1) * 3 = 9
//
// Time: O(n)
// Space: O(n)                                                     // fixed
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func evalRPN(_ tokens: [String]) -> Int {
    
    var stack = [Int]()
    
    for token in tokens {
        
        if token != "+"  && token != "-" && token != "*" && token != "/" {
            if let value = Int(token) {
                stack.append(value)
            }
            
        } else {
            
            guard let a = stack.popLast(), let b = stack.popLast() else {   // fixed
                return 0
            }
            
            if token == "+" {
                stack.append(a+b)
            } else if token == "-" {
                stack.append(b-a)
            } else if token == "*"  {
                stack.append(a*b)
            } else if token == "/" {
                stack.append(b/a)
            }
        }
    }
    
    if let final = stack.last {
        
        return final
    }
    
    
    return 0
}


//==============================================================
// MARK: Test Cases - Q51
//==============================================================

print("========== Q51: Evaluate Reverse Polish Notation ==========")

print(evalRPN(["2","1","+","3","*"]))       // Expected: 9
print(evalRPN(["4","13","5","/","+"]))      // Expected: 6
print(evalRPN(["10","6","9","3","+","-11","*","/","*","17","+","5","+"]))
// Expected: 22
print(evalRPN(["3","4","+","2","*","7","/"])) // Expected: 2
print(evalRPN(["5"]))                        // Expected: 5



//==============================================================
// MARK: - Q52. Decode String
//==============================================================
//
// Difficulty: Medium
// LeetCode: 394
//
// Given an encoded string, return its decoded string.
//
// The encoding rule is:
// k[encoded_string]
//
// The encoded_string inside the square brackets is repeated
// exactly k times.
//
// Example:
//
// Input: s = "3[a]2[bc]"
// Output: "aaabcbc"
//
// Time: O(output length)                                          // fixed
// Space: O(output length)                                         // fixed
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------

func decodeString( _ str: String) -> String {
    
    var stringStack = [String]()
    var numberStack = [Int]()
    var currentStr = ""
    var currentNumber = 0
    
    for char in str {
        
        
        if char.isNumber {
            if let number = char.wholeNumberValue {
                currentNumber = currentNumber * 10 + number
            }
        } else if char == "[" {
            
            numberStack.append(currentNumber)
            stringStack.append(currentStr)
            currentStr = ""
            currentNumber = 0
        } else if char == "]" {
            
            guard let prevStr = stringStack.popLast(), let countNumber = numberStack.popLast() else {
                return ""
            }
            
            var repeatStr = ""
            
            for _ in 0..<countNumber {
                repeatStr += currentStr
            }
            
            currentStr =  prevStr + repeatStr
            
        } else {
            currentStr.append(char)
        }
        
    }
    
    
    return currentStr
}


//==============================================================
// MARK: Test Cases - Q52
//==============================================================

print("========== Q52: Decode String ==========")

print(decodeString("3[a]2[bc]"))       // Expected: "aaabcbc"
print(decodeString("3[a2[c]]"))        // Expected: "accaccacc"
print(decodeString("2[abc]3[cd]ef"))   // Expected: "abcabccdcdcdef"
print(decodeString("10[a]"))           // Expected: "aaaaaaaaaa"
print(decodeString("3[z]2[2[y]pq4[2[jk]e1[f]]]ef"))
// Expected: "zzzyypqjkjkefjkjkefjkjkefjkjkefyypqjkjkefjkjkefjkjkefjkjkefef"   // fixed



 //==============================================================
 // MARK: - Q53. Implement Queue Using Stacks
 //==============================================================
//
// Difficulty: Easy
// LeetCode: 232
//
// Implement a first in first out (FIFO) queue using only
// two stacks.
//
// The queue should support:
// - push
// - pop
// - peek
// - empty
//
// Example:
//
// Input:
// push(1)
// push(2)
// peek()
// pop()
// empty()
//
// Output:
// 1
// 1
// false
//
// Time: O(1) amortised per operation                              // fixed
// Space: O(n)                                                     // fixed
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------


struct MyQueue {
    
   private var inputStack = [Int]()
    private var outPutStack = [Int]()
    
    var isEmpty: Bool {
        inputStack.isEmpty && outPutStack.isEmpty
    }
    
    var count: Int {
        inputStack.count + outPutStack.count                       // fixed
    }
    
    mutating func eneque(_ value: Int) {
        inputStack.append(value)
    }
    
    mutating func dequeue() -> Int? {
        
        if outPutStack.isEmpty {
            
            while let last = inputStack.popLast() {                // fixed
                outPutStack.append(last)
            }
        }
        return outPutStack.popLast()
        
    }
    
    mutating func front() -> Int? {
        
        if outPutStack.isEmpty {
            
            while let last = inputStack.popLast() {                // fixed
                outPutStack.append(last)
            }
        }
        return outPutStack.last
    }
    
    
}


//==============================================================
// MARK: Test Cases - Q53
//==============================================================

print("========== Q53: Implement Queue Using Stacks ==========")

var quue = MyQueue()
quue.eneque(1)
quue.eneque(2)

print(quue.front())               // Expected: 1                   // fixed
print(quue.dequeue())             // Expected: 1                   // fixed
print(quue.isEmpty)               // Expected: false               // fixed

quue.eneque(3)
print(quue.count)                 // Expected: 2                   // fixed
print(quue.dequeue())             // Expected: 2                   // fixed
print(quue.dequeue())             // Expected: 3                   // fixed
print(quue.isEmpty)               // Expected: true                // fixed



//==============================================================
// MARK: - Q54. Asteroid Collision
//==============================================================
//
// Difficulty: Medium
// LeetCode: 735
//
// We are given an array asteroids representing asteroids
// moving in a row.
//
// Positive values move right.
// Negative values move left.
//
// When two asteroids collide:
// - The smaller asteroid explodes.
// - If both are the same size, both explode.
// - Asteroids moving in the same direction never collide.
//
// Return the state of the asteroids after all collisions.
//
// Example:
//
// Input: asteroids = [5,10,-5]
// Output: [5,10]
//
// Time:
// Space:
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------


//==============================================================
// MARK: Test Cases - Q54
//==============================================================

print("========== Q54: Asteroid Collision ==========")

// Uncomment once asteroidCollision is written                     // fixed
// print(asteroidCollision([5,10,-5]))
// // Expected: [5,10]
//
// print(asteroidCollision([8,-8]))
// // Expected: []
//
// print(asteroidCollision([10,2,-5]))
// // Expected: [10]
//
// print(asteroidCollision([-2,-1,1,2]))
// // Expected: [-2,-1,1,2]
//
// print(asteroidCollision([1,-1]))
// // Expected: []



//==============================================================
// MARK: - Q55. LRU Cache
//==============================================================
//
// Difficulty: Medium
// LeetCode: 146
//
// Design a data structure that follows the constraints of
// a Least Recently Used (LRU) cache.
//
// Implement:
// - get(key)
// - put(key, value)
//
// Both operations should run in O(1) average time.
//
// When the cache reaches its capacity, remove the least
// recently used item before inserting a new item.
//
// Example:
//
// Input:
// capacity = 2
// put(1,1)
// put(2,2)
// get(1)
// put(3,3)
// get(2)
//
// Output:
// 1
// -1
//
// Time:
// Space:
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------


//==============================================================
// MARK: Test Cases - Q55
//==============================================================

print("========== Q55: LRU Cache ==========")

// Test Case 1
// capacity = 2
// put(1,1)
// put(2,2)
// get(1)
// Expected: 1

// Test Case 2
// put(3,3)
// get(2)
// Expected: -1

// Test Case 3
// put(4,4)
// get(1)
// Expected: -1

// Test Case 4
// get(3), get(4)
// Expected: 3, 4

// Test Case 5
// capacity = 1
// put(1,1)
// put(2,2)
// get(1)
// Expected: -1



//==============================================================
// MARK: - Q56. Next Greater Element I
//==============================================================
//
// Difficulty: Easy
// LeetCode: 496
//
// Given two arrays nums1 and nums2, where nums1 is a subset
// of nums2, return the next greater element for each element
// of nums1.
//
// The next greater element is the first greater element
// to its right in nums2.
//
// If no greater element exists, return -1.
//
// Example:
//
// Input:
// nums1 = [4,1,2]
// nums2 = [1,3,4,2]
//
// Output:
// [-1,3,-1]
//
// Time:
// Space:
//
//--------------------------------------------------------------
// MARK: Solution
//--------------------------------------------------------------


//==============================================================
// MARK: Test Cases - Q56
//==============================================================

print("========== Q56: Next Greater Element I ==========")

// Uncomment once nextGreaterElement is written                    // fixed
// print(nextGreaterElement([4,1,2], [1,3,4,2]))
// // Expected: [-1,3,-1]
//
// print(nextGreaterElement([2,4], [1,2,3,4]))
// // Expected: [3,-1]
//
// print(nextGreaterElement([1], [1]))
// // Expected: [-1]
//
// print(nextGreaterElement([3,1], [2,3,1]))
// // Expected: [-1,-1]
//
// print(nextGreaterElement([1,3,5], [1,2,3,4,5]))
// // Expected: [2,4,-1]



//==============================================================
// MARK: - PHASE 06 COMPLETE
//==============================================================
//
// Q48 - Q56
//
// Stack
// Monotonic Stack
// Two Stacks
// HashMap + Doubly Linked List
//
//==============================================================
