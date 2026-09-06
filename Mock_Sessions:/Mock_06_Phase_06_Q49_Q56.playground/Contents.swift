import Foundation

//==============================================================
// Stack & Queue Revision (Mock)
//==============================================================


//==============================================================
// Q48 - LC20 Valid Parentheses
// Pattern : Stack
// T - O(n)
// S - O(n)
//==============================================================

func isMatching(_ open: Character, _ close: Character) -> Bool {
    return (open == "(" && close == ")"
            || open == "{" && close == "}"
            || open == "[" && close == "]")

}

func isValidParentheses(_ s: String) -> Bool {
    
    var stack = [Character]()
    
    for char in s {
        
        if char == "(" || char == "{" || char == "["  {
            stack.append(char)
        } else if let last = stack.last, isMatching(last, char) {
            stack.removeLast()
        } else {
            return false
        }
    }
    
    return stack.isEmpty

}

print("========== Q48 - Valid Parentheses ==========")

print(isValidParentheses("()"))             // true

print(isValidParentheses("()[]{}"))         // true

print(isValidParentheses("([{}])"))         // true

print(isValidParentheses("(]"))             // false

print(isValidParentheses("([)]"))           // false

print(isValidParentheses("((("))            // false

print(isValidParentheses("()]"))            // false

print(isValidParentheses(""))               // true


//==============================================================
// Q49 - LC155 Min Stack
// Pattern : Two Stacks
// T - O(1)
// S - O(n)
//==============================================================

struct MinStack {
    
    var stack = [Int]()
    var minStack = [Int]()
    

    mutating func push(_ value: Int) {
        
        stack.append(value)
        
        if let last = minStack.last {
            if last < value {
                minStack.append(last)
            } else {
                minStack.append(value)
            }
        } else {
            minStack.append(value)
        }

    }

    mutating func pop() -> Int? {
        
        guard let top = stack.popLast() else { return nil }
        _ = minStack.popLast()
        return top

    }

    func top() -> Int? {
        return stack.last
    }

    func getMin() -> Int? {
        return minStack.last
    }

    func isEmpty() -> Bool {
        return stack.isEmpty
    }

    func display() {

        print("Stack", stack)

        print("MiniStack", minStack)
    }
}

print("\n========== Q49 - Min Stack ==========")

var miniStack = MinStack()
miniStack.push(10)
miniStack.push(5)
miniStack.push(8)
miniStack.push(2)
miniStack.display()

print("min", miniStack.getMin() as Any)             // 2

_ = miniStack.pop()

print("min after pop", miniStack.getMin() as Any)   // 5

var duplicateMin = MinStack()
duplicateMin.push(5)
duplicateMin.push(5)
_ = duplicateMin.pop()

print("dup min", duplicateMin.getMin() as Any)      // 5


//==============================================================
// Q50 - LC739 Daily Temperatures
// Pattern : Monotonic Stack
// T - O(n)
// S - O(n)
//==============================================================

func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
    
    var result = Array(repeating: 0, count: temperatures.count)
    var stack = [Int]()
    
    for i in 0..<temperatures.count {
        
        while let last = stack.last , temperatures[last] < temperatures[i] {
            let waitingDay = stack.removeLast()
            result[waitingDay] = i - waitingDay
        }
        
        stack.append(i)
    }
    
    return result

}

print("\n========== Q50 - Daily Temperatures ==========")

print(dailyTemperatures([30,40,50,60]))                     // [1,1,1,0]

print(dailyTemperatures([73,74,75,71,69,72,76,73]))         // [1,1,4,2,1,1,0,0]

print(dailyTemperatures([30,60,90]))                        // [1,1,0]

print(dailyTemperatures([73,73,74]))                        // [2,1,0]

print(dailyTemperatures([50]))                              // [0]


//==============================================================
// Q51 - LC150 Evaluate Reverse Polish Notation
// Pattern : Stack
// T - O(n)
// S - O(n)
//==============================================================

func evalRPN(_ tokens: [String]) -> Int {
    
    var stack = [Int]()
    
    for token in tokens {
        
        if token != "+" , token != "-" , token != "*" , token != "/" {
            if let value = Int(token) {
                stack.append(value)
            }

        } else  {
            
            let a = stack.removeLast()
            let b = stack.removeLast()
            
            if token == "+" {
                stack.append(a + b)
            } else if token == "-" {
                stack.append(b - a)
            } else if token == "*" {
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

print("\n========== Q51 - Evaluate RPN ==========")

print(evalRPN(["2","1","+","3","*"]))                       // 9

print(evalRPN(["4","13","5","/","+"]))                      // 6

print(evalRPN(["10","6","9","3","+","-11","*","/","*","17","+","5","+"]))   // 22

print(evalRPN(["4","13","-"]))                              // -9

print(evalRPN(["8","2","/"]))                               // 4


//==============================================================
// Q52 - LC394 Decode String
// Pattern : Stack
// T - O(n·k)
// S - O(n·k)
//==============================================================

func decodeString(_ s: String) -> String {
    
    var numberStack = [Int]()
    var stringStack = [String]()
    var currentNumber = 0
    var currentStr = ""
    
    for char in s {
        
        if char.isNumber {
            if let digit = char.wholeNumberValue {
                currentNumber = currentNumber * 10 + digit
            }
        } else if char == "[" {
            stringStack.append(currentStr)
            numberStack.append(currentNumber)
            currentStr = ""
            currentNumber = 0
            
        } else if char == "]" {
            
            let count = numberStack.removeLast()
            let prev = stringStack.removeLast()
            
            var repeatValue = ""
            for _ in 0..<count {
                repeatValue += currentStr
            }
            
            currentStr = prev + repeatValue
            
        } else {
            currentStr.append(char)
        }
        
    }
    
    return currentStr

}

print("\n========== Q52 - Decode String ==========")

print(decodeString("3[a]2[bc]"))                    // aaabcbc

print(decodeString("3[a2[c]]"))                     // accaccacc

print(decodeString("2[abc]3[cd]ef"))                // abcabccdcdcdef

print(decodeString("2[a3[b]]"))                     // abbbabbb

print(decodeString("100[a]").count)                 // 100


//==============================================================
// Q53 - LC232 Implement Queue Using Stacks
// Pattern : Two Stacks
// T - O(1) Amortized
// S - O(n)
//==============================================================

struct MyQueue {
    
    var inPutStack = [Int]()
    var outPutStack = [Int]()
    

    mutating func enqueue(_ value: Int) {
        inPutStack.append(value)
    }

    mutating func dequeue() -> Int? {
    
        if outPutStack.isEmpty {
            
            while let last = inPutStack.popLast() {
                outPutStack.append(last)
            }
        }
        
        return outPutStack.popLast()

    }

    mutating func front() -> Int? {
        
        if outPutStack.isEmpty {
            
            while let last = inPutStack.popLast() {
                outPutStack.append(last)
            }
        }
        
        return outPutStack.last

    }

    func isEmpty() -> Bool {
        
        return outPutStack.isEmpty && inPutStack.isEmpty

    }

    func count() -> Int {
        return outPutStack.count + inPutStack.count

    }

    func display() {
        print("input Stack:", inPutStack)

        print("OutPut Stack:", outPutStack)
    }
}

print("\n========== Q53 - Queue Using Stacks ==========")

var queue = MyQueue()
queue.enqueue(10)
queue.enqueue(20)
queue.enqueue(30)
_ = queue.dequeue()
queue.enqueue(40)
queue.display()

print(queue.dequeue() as Any, queue.dequeue() as Any, queue.dequeue() as Any)   // 20 30 40


//==============================================================
// Q54 - LC735 Asteroid Collision
// Pattern : Stack
// T - O(n)
// S - O(n)
//==============================================================

func asteroidCollision(_ asteroids: [Int]) -> [Int] {
    var stack = [Int]()
    
    for asteroid in asteroids {
        
        var isDestriyed = false
        
        var currentSize = asteroid
        
        if asteroid < 0 {
            currentSize = -asteroid
        }
        
        while let top = stack.last , top > 0, asteroid < 0 {
            
            if currentSize > top {
                stack.removeLast()
            } else if currentSize == top {
                stack.removeLast()
                isDestriyed = true
                break
            } else {
                isDestriyed = true
                break
            }
            
        }
        
        if !isDestriyed {
            stack.append(asteroid)
        }
    }
    
    return stack

}

print("\n========== Q54 - Asteroid Collision ==========")

print(asteroidCollision([5,10,-5]))                 // [5, 10]

print(asteroidCollision([8,-8]))                    // []

print(asteroidCollision([10,2,-5]))                 // [10]

print(asteroidCollision([-2,-1,1,2]))               // [-2, -1, 1, 2]

print(asteroidCollision([3,5,-10]))                 // [-10]


//==============================================================
// Q56 - LC496 Next Greater Element I
// Pattern : Monotonic Stack + Dictionary
// T - O(n + m)
// S - O(m)
//==============================================================

func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    
    var answer = [Int: Int]()
    var stack = [Int]()
    
    for num in nums2 {
        
        while let top = stack.last, num > top {
            stack.removeLast()
            answer[top] = num
        }
        
        stack.append(num)
    }
    
    var result = [Int]()
    
    for num in nums1 {
        
        if let nextGreter = answer[num] {
            result.append(nextGreter)
        } else {
            result.append(-1)
        }
    }
    
    return result

}

print("\n========== Q56 - Next Greater Element I ==========")

print(nextGreaterElement([4,1,2], [1,3,4,2]))       // [-1, 3, -1]

print(nextGreaterElement([2,4], [1,2,3,4]))         // [3, -1]

print(nextGreaterElement([3,2,1], [3,2,1]))         // [-1, -1, -1]
