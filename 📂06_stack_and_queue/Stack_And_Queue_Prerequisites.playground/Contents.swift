import Foundation

//==============================================================
// Stack & Queue Prerequisites
//
// D1  Stack (generic, LIFO)
// D2  Queue (generic, FIFO, head index)
// D3  charsOf + isDigit
// D4  charToDigit + stringToInt
// D5  repeatString
//==============================================================

// MARK: - D1  Stack (LIFO)

// Time  : push O(1), pop O(1), top O(1), isEmpty O(1), count O(1)
// Space : O(n) storage, O(1) auxiliary per operation
struct Stack<Element> {
    private var elements = [Element]()

    var isEmpty: Bool {
        elements.isEmpty
    }

    var count: Int {
        elements.count
    }

    var top: Element? {
        elements.last
    }

    var items: [Element] {
        elements
    }

    mutating func push(_ value: Element) {
        elements.append(value)
    }

    mutating func pop() -> Element? {
        if elements.isEmpty {
            return nil
        }
        return elements.removeLast()
    }
}

// MARK: - D1 Traces

print("========== STACK ==========")

var stack = Stack<Int>()
stack.push(10)
stack.push(20)
stack.push(30)
stack.push(40)
print("Stack :", stack.items)

if let peeked = stack.top {
    print("Peek :", peeked)
}

if let removed = stack.pop() {
    print("Pop :", removed)
}

print("Stack :", stack.items)

print("Count :", stack.count)

print("isEmpty :", stack.isEmpty)

// Edge case: empty stack must return nil, never crash
var emptyStack = Stack<Int>()

if let removed = emptyStack.pop() {
    print("Pop :", removed)
} else {
    print("Pop on empty : nil")
}

if let peeked = emptyStack.top {
    print("Peek :", peeked)
} else {
    print("Peek on empty : nil")
}

// MARK: - D2  Queue (FIFO, head index)

// removeFirst() shifts every remaining element left, making dequeue O(n).
// Advancing a head pointer is O(1); the compaction block reclaims the dead
// prefix only once it passes half the array, so that single O(n) removeFirst
// is spread across the dequeues that earned it. That is the amortised O(1)
// argument Q53 rests on.

// Time  : enqueue O(1), dequeue O(1) amortised, front O(1), isEmpty O(1), count O(1)
// Space : O(n) storage, O(1) auxiliary per operation
struct Queue<Element> {
    private var elements = [Element]()
    private var head = 0

    var isEmpty: Bool {
        head >= elements.count
    }

    var count: Int {
        elements.count - head
    }

    var front: Element? {
        if head < elements.count {
            return elements[head]
        } else {
            return nil
        }
    }

    var rear: Element? {
        if head < elements.count {
            return elements[elements.count - 1]
        } else {
            return nil
        }
    }

    // O(n) — traces only, never call this inside a solution
    var items: [Element] {
        var result = [Element]()
        var index = head
        while index < elements.count {
            result.append(elements[index])
            index += 1
        }
        return result
    }

    mutating func enqueue(_ value: Element) {
        elements.append(value)
    }

    mutating func dequeue() -> Element? {
        if head >= elements.count {
            return nil
        }
        let item = elements[head]
        head += 1
        if head > 32 && head * 2 >= elements.count {
            elements.removeFirst(head)
            head = 0
        }
        return item
    }
}

// MARK: - D2 Traces

print("\n========== QUEUE ==========")

var queue = Queue<Int>()
queue.enqueue(10)
queue.enqueue(20)
queue.enqueue(30)
queue.enqueue(40)
print("Queue :", queue.items)

if let first = queue.front {
    print("Front :", first)
}

if let last = queue.rear {
    print("Rear :", last)
}

if let removed = queue.dequeue() {
    print("Dequeue :", removed)
}

print("Queue :", queue.items)

print("Count :", queue.count)

print("isEmpty :", queue.isEmpty)

// Edge case: drain to empty, then confirm nil rather than a crash
while let removed = queue.dequeue() {
    print("Draining :", removed)
}

print("Queue after drain :", queue.items)

print("isEmpty after drain :", queue.isEmpty)

if let first = queue.front {
    print("Front :", first)
} else {
    print("Front on empty : nil")
}

// MARK: - D3  Character Helpers

// String has no integer indexing in Swift — text[i] does not compile, and
// walking to an offset is O(n). Every problem in this phase converts once
// to [Character] up front, then indexes freely in O(1).

// Time  : O(n)
// Space : O(n)
func charsOf(_ text: String) -> [Character] {
    var result = [Character]()
    for character in text {
        result.append(character)
    }
    return result
}

// Time  : O(1)
// Space : O(1)
func isDigit(_ character: Character) -> Bool {
    return character >= "0" && character <= "9"
}

// MARK: - D3 Traces

print("\n========== CHARACTER HELPERS ==========")

print("charsOf(\"a2[bc]\") :", charsOf("a2[bc]"))

print("charsOf(\"\") :", charsOf(""))

print("charsOf(\"3[a]2[bc]\") :", charsOf("3[a]2[bc]"))

print("isDigit(\"7\") :", isDigit("7"))

print("isDigit(\"0\") :", isDigit("0"))

print("isDigit(\"9\") :", isDigit("9"))

print("isDigit(\"a\") :", isDigit("a"))

print("isDigit(\"-\") :", isDigit("-"))

print("isDigit(\" \") :", isDigit(" "))

// MARK: - D4  Number Parsing

// Time  : O(1)
// Space : O(1)
func charToDigit(_ character: Character) -> Int? {
    if let value = character.asciiValue, let zero = Character("0").asciiValue {
        let digit = Int(value) - Int(zero)
        if digit >= 0 && digit <= 9 {
            return digit
        } else {
            return nil
        }
    } else {
        return nil
    }
}

// Time  : O(n)
// Space : O(n)   // charsOf conversion
func stringToInt(_ text: String) -> Int? {
    let characters = charsOf(text)
    if characters.isEmpty {
        return nil
    }

    var isNegative = false
    var index = 0
    if characters[0] == "-" {
        isNegative = true
        index = 1
    }
    // rejects "-" alone; without this the loop never runs and returns -0
    if index >= characters.count {
        return nil
    }

    var result = 0
    while index < characters.count {
        if let digit = charToDigit(characters[index]) {
            result = result * 10 + digit
            index += 1
        } else {
            return nil
        }
    }

    if isNegative {
        return -result
    } else {
        return result
    }
}

// MARK: - D4 Traces

print("\n========== NUMBER PARSING ==========")

print("charToDigit(\"7\") :", charToDigit("7") as Any)

print("charToDigit(\"0\") :", charToDigit("0") as Any)

print("charToDigit(\"a\") :", charToDigit("a") as Any)

print("stringToInt(\"42\") :", stringToInt("42") as Any)

print("stringToInt(\"100\") :", stringToInt("100") as Any)

print("stringToInt(\"-7\") :", stringToInt("-7") as Any)

print("stringToInt(\"0\") :", stringToInt("0") as Any)

print("stringToInt(\"\") :", stringToInt("") as Any)

print("stringToInt(\"-\") :", stringToInt("-") as Any)

print("stringToInt(\"4a2\") :", stringToInt("4a2") as Any)

// MARK: - D5  Repeat String

// Time  : O(n · k)   n = text length, k = times
// Space : O(n · k)
func repeatString(_ text: String, times: Int) -> String {
    if times <= 0 {
        return ""
    }

    var result = ""
    var count = 0
    while count < times {
        result += text
        count += 1
    }
    return result
}

// MARK: - D5 Traces

print("\n========== REPEAT STRING ==========")

print("repeatString(\"ab\", times: 3) :", repeatString("ab", times: 3))

print("repeatString(\"a\", times: 1) :", repeatString("a", times: 1))

print("repeatString(\"xyz\", times: 0) :", repeatString("xyz", times: 0))

print("repeatString(\"xyz\", times: -2) :", repeatString("xyz", times: -2))

print("repeatString(\"\", times: 5) :", repeatString("", times: 5))

// MARK: - Complexity Summary

/*
 Stack
 -----
 push       -> O(1) time, O(1) space
 pop        -> O(1) time, O(1) space
 top        -> O(1) time, O(1) space
 count      -> O(1) time, O(1) space
 isEmpty    -> O(1) time, O(1) space
 Storage    -> O(n)

 Queue (head index)
 ------------------
 enqueue    -> O(1) time, O(1) space
 dequeue    -> O(1) amortised time, O(1) space
 front      -> O(1) time, O(1) space
 rear       -> O(1) time, O(1) space
 count      -> O(1) time, O(1) space
 Storage    -> O(n)

 Helpers
 -------
 charsOf      -> O(n) time,     O(n) space
 isDigit      -> O(1) time,     O(1) space
 charToDigit  -> O(1) time,     O(1) space
 stringToInt  -> O(n) time,     O(n) space
 repeatString -> O(n · k) time, O(n · k) space

 Two variables in the answer whenever there are two loops, or a loop
 plus a length. repeatString is O(n · k), not O(k) — k copies of an
 n-character string. Q52 inherits this and is O(n · k), not O(n).
*/
