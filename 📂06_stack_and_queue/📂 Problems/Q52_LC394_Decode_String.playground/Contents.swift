import Foundation

//==============================================================
// Q52 - LC394 Decode String
//==============================================================
//
// Pattern : Stack Simulation
//
// Idea
// • Number Stack -> Stores repeat count
// • String Stack -> Stores previous string
//
// Time  : O(n)
// Space : O(n)
//
//==============================================================

// MARK: - Decode String

func decodeString(_ s: String) -> String {

    var stringStack = [String]()
    var numberStack = [Int]()

    var currentString = ""
    var currentNumber = 0

    for char in s {

        if char.isNumber {

            if let number = char.wholeNumberValue {
                currentNumber = currentNumber * 10 + number
            }

        } else if char == "[" {

            numberStack.append(currentNumber)
            stringStack.append(currentString)

            currentNumber = 0
            currentString = ""

        } else if char == "]" {

            guard
                let count = numberStack.popLast(),
                let previousString = stringStack.popLast()
            else {
                return ""
            }

            var repeatedString = ""

            for _ in 0..<count {
                repeatedString += currentString
            }

            currentString = previousString + repeatedString

        } else {

            currentString.append(char)
        }
    }

    return currentString
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print(decodeString("3[a]"))              // aaa

print(decodeString("3[a]2[bc]"))         // aaabcbc

print(decodeString("3[a2[c]]"))          // accaccacc

print(decodeString("2[abc]3[cd]ef"))     // abcabccdcdcdef

print(decodeString("10[a]"))             // aaaaaaaaaa

print(decodeString("abc"))               // abc

print(decodeString(""))                  // ""

//==============================================================
// High Level Notes
//==============================================================

/*

Pattern
-------
Stack Simulation

Need Two Stacks
---------------
1. Number Stack
2. String Stack

Digit
-----
Build currentNumber

Letter
------
Append to currentString

[
-
Push currentNumber
Push currentString
Reset both

]
-
Pop count
Pop previousString
Repeat currentString
Merge

currentString = previousString + repeatedString

*/
