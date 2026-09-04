import Foundation

//==============================================================
// Q48 - LC020 - Valid Parentheses
//==============================================================
//
// Problem
// -------
// Given a string containing only the characters ( ) { } [ ],
// determine whether it is valid.
//
// Valid means:
//   • every open bracket is closed by the same type
//   • brackets close in the correct order
//   • every close bracket has a matching open bracket
//
// Example
// -------
// "()"      -> true
// "()[]{}"  -> true
// "([{}])"  -> true
// "(]"      -> false
// "([)]"    -> false
// "((("     -> false
// "]"       -> false
//
// Constraints
// -----------
// 1 <= s.count <= 10^4
// s consists only of the six bracket characters
//
// Brute Force : O(n^3) time, O(n) space
// Optimal     : O(n)   time, O(n) space
//
//==============================================================


// MARK: - Helpers

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
func isOpeningBracket(_ character: Character) -> Bool {
    return character == "(" || character == "[" || character == "{"
}

// Time  : O(1)
// Space : O(1)
func isMatching(_ open: Character, _ close: Character) -> Bool {
    return (open == "(" && close == ")")
        || (open == "[" && close == "]")
        || (open == "{" && close == "}")
}


// MARK: - Brute Force

// Repeatedly strip any adjacent matching pair. A fully valid string
// collapses to nothing; anything left over means it was invalid.
//
// Time  : O(n^3)
//         each pass scans O(n) and removes one pair -> O(n) passes,
//         and remove(at:) is itself O(n) because the array shifts.
//         The shift cost is the part that is easy to miss.
// Space : O(n)
func isValidParenthesesBruteForce(_ s: String) -> Bool {
    var characters = charsOf(s)
    if characters.isEmpty {
        return true
    }

    var isRemoved = true
    while isRemoved {
        isRemoved = false
        var index = 0

        while index < characters.count - 1 {
            let first = characters[index]
            let second = characters[index + 1]

            if isMatching(first, second) {
                characters.remove(at: index + 1)
                characters.remove(at: index)
                isRemoved = true
                break
            }
            index += 1
        }
    }

    return characters.isEmpty
}


// MARK: - Optimal (Stack)

// Push every opener. On a closer, the only bracket that can match is
// the most recent unclosed one — which is exactly the stack top.
//
// Three ways to fail:
//   1. closer does not match the top      "(]"
//   2. closer arrives with nothing open   "]"
//   3. loop ends with the stack non-empty "((("
//
// Time  : O(n)
// Space : O(n)   worst case "(((((" pushes everything
func isValidParenthesesOptimal(_ s: String) -> Bool {
    var stack = [Character]()

    for character in s {
        if isOpeningBracket(character) {
            stack.append(character)
        } else if let top = stack.last, isMatching(top, character) {
            stack.removeLast()
        } else {
            return false
        }
    }

    return stack.isEmpty
}


// MARK: - Test Cases

print("========== BRUTE FORCE ==========")

print("()       :", isValidParenthesesBruteForce("()"))          // true

print("()[]{}   :", isValidParenthesesBruteForce("()[]{}"))      // true

print("([{}])   :", isValidParenthesesBruteForce("([{}])"))      // true

print("(]       :", isValidParenthesesBruteForce("(]"))          // false

print("([)]     :", isValidParenthesesBruteForce("([)]"))        // false

print("(((      :", isValidParenthesesBruteForce("((("))         // false

print("]        :", isValidParenthesesBruteForce("]"))           // false

print("(empty)  :", isValidParenthesesBruteForce(""))            // true

print()

print("========== OPTIMAL ==========")

print("()       :", isValidParenthesesOptimal("()"))             // true

print("()[]{}   :", isValidParenthesesOptimal("()[]{}"))         // true

print("([{}])   :", isValidParenthesesOptimal("([{}])"))         // true

print("(]       :", isValidParenthesesOptimal("(]"))             // false

print("([)]     :", isValidParenthesesOptimal("([)]"))           // false

print("(((      :", isValidParenthesesOptimal("((("))            // false

print("]        :", isValidParenthesesOptimal("]"))              // false

print("(empty)  :", isValidParenthesesOptimal(""))               // true


// MARK: - Notes

/*
 Why counting does not work
 --------------------------
 "([)]" has one of each pair and is invalid. The answer depends on
 order, not on counts, which is what forces a stack.

 The forgotten check
 -------------------
 The final stack.isEmpty is the one people skip. "(((" never hits a
 mismatch and never hits an empty stack — it just runs out of input
 with three brackets still open.

 Brute force complexity
 ----------------------
 O(n^3), not O(n^2). remove(at:) shifts every element after the
 removal point, so each removal is O(n) on top of the O(n) scan and
 the O(n) passes. Array removal is never O(1) except at the end.

 The empty-string case
 ---------------------
 Constraints say 1 <= s.count, so "" is out of range. Both versions
 return true for it, which is the defensible answer, and the test
 stays as a guard against a future refactor introducing a crash.
*/
