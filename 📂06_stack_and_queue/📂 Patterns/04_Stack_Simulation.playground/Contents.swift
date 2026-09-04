import Foundation

//==============================================================
// Stack Simulation
//==============================================================
//
// The stack is the machine's working memory. You replay the input
// one token at a time, and each token either goes on the stack or
// consumes what is already there.
//
// Two shapes live here:
//
//   1. Consume-and-replace  — pop operands, push the result
//   2. Resolve-on-conflict  — the incoming element fights the top,
//                             and may itself be destroyed
//
// The second shape is where the if/while slip lives. One incoming
// element can destroy several stacked elements in sequence, so the
// conflict check is a while loop, never an if.
//
// Time  : O(n)   each element pushed once, popped at most once
// Space : O(n)
//
//==============================================================


// MARK: - Shape 1: Consume And Replace

// Stack pops in reverse order: the FIRST pop is the right operand,
// the SECOND pop is the left. Getting this backwards still passes
// + and * because they commute — it fails only on - and /, which is
// why the trace below uses subtraction.
//
// Time  : O(n)
// Space : O(n)
func evaluate(_ tokens: [String]) -> Int? {
    var stack = [Int]()

    for token in tokens {
        if token == "+" || token == "-" || token == "*" || token == "/" {
            guard let right = stack.popLast(), let left = stack.popLast() else {
                return nil
            }

            if token == "+" {
                stack.append(left + right)
            } else if token == "-" {
                stack.append(left - right)
            } else if token == "*" {
                stack.append(left * right)
            } else {
                if right == 0 {
                    return nil
                }
                // Swift / truncates toward zero, which is what this shape wants
                stack.append(left / right)
            }
        } else {
            if let number = stringToInt(token) {
                stack.append(number)
            } else {
                return nil
            }
        }
    }

    if stack.count == 1 {
        return stack[0]
    } else {
        return nil
    }
}


// MARK: - Shape 1 Traces

print("========== CONSUME AND REPLACE ==========")

print("evaluate([\"2\",\"1\",\"+\",\"3\",\"*\"]) :", evaluate(["2", "1", "+", "3", "*"]) as Any)

// The operand-order test. Correct -> 9. Reversed -> -9.
print("evaluate([\"4\",\"13\",\"-\"]) :", evaluate(["4", "13", "-"]) as Any)

// Correct -> 4. Reversed -> 0.
print("evaluate([\"8\",\"2\",\"/\"]) :", evaluate(["8", "2", "/"]) as Any)

print("evaluate([\"-4\",\"2\",\"+\"]) :", evaluate(["-4", "2", "+"]) as Any)

print("evaluate([\"5\"]) :", evaluate(["5"]) as Any)

print("evaluate([\"+\"]) :", evaluate(["+"]) as Any)

print()


// MARK: - Shape 2: Resolve On Conflict

// The incoming element fights the stack top and one of three things
// happens: the top dies and the fight continues, both die, or the
// incoming element dies. Only the first outcome loops.
//
// Conflict here is "incoming is larger than top" and the loser is
// destroyed; a real problem substitutes its own conflict rule.
//
// Time  : O(n)
// Space : O(n)
func resolveOnConflict(_ values: [Int]) -> [Int] {
    var stack = [Int]()

    for value in values {
        var survives = true

        while let top = stack.last, top < value {
            if top < value {
                stack.removeLast()
                // top destroyed — value keeps fighting the next one down
            }
        }

        if let top = stack.last, top == value {
            stack.removeLast()
            survives = false
            // tie destroys both
        }

        if survives {
            stack.append(value)
        }
    }

    return stack
}

// MARK: - Helpers (from Stack_And_Queue_Prerequisites)

func charsOf(_ text: String) -> [Character] {
    var result = [Character]()
    for character in text {
        result.append(character)
    }
    return result
}

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


// MARK: - Shape 2 Traces

print("========== RESOLVE ON CONFLICT ==========")

// 5 destroys 3, then destroys 2, then lands on an empty stack
print("resolveOnConflict([2, 3, 5]) :", resolveOnConflict([2, 3, 5]))

// nothing conflicts — strictly decreasing input
print("resolveOnConflict([5, 3, 2]) :", resolveOnConflict([5, 3, 2]))

// equal values destroy each other
print("resolveOnConflict([4, 4]) :", resolveOnConflict([4, 4]))

// the one that catches an `if` written where `while` belongs
print("resolveOnConflict([2, 3, 4, 9]) :", resolveOnConflict([2, 3, 4, 9]))

print("resolveOnConflict([]) :", resolveOnConflict([]))

print()


// MARK: - Interview Notes

/*
 Shape 1 — Consume And Replace
 -----------------------------
 for token in input
     operator ?  pop the operands, push the result
     operand  ?  push it
 one value left on the stack at the end = the answer

 The pop order is the whole trap. First pop is the RIGHT operand.
 Commutative operators hide the bug; test with - or / or not at all.


 Shape 2 — Resolve On Conflict
 -----------------------------
 for element in input
     survives = true
     while conflict with top
         incoming loses  -> survives = false, break
         tie             -> pop top, survives = false, break
         top loses       -> pop top, keep looping
     if survives, push

 Three outcomes, and only one of them continues the loop. Writing
 `if` instead of `while` resolves a single conflict and moves on,
 which passes small traces and fails the moment one element has to
 destroy two things in a row.


 Why this is not Monotonic Stack
 -------------------------------
 A monotonic stack pops to RECORD an answer — the popped element's
 result has arrived. This shape pops to DESTROY — the popped element
 is gone and nothing is recorded. Same loop skeleton, opposite intent.


 Complexity
 ----------
 Time  : O(n)   each element pushed once, popped at most once
 Space : O(n)

 The nested while does not make it quadratic. Count pops, not loop
 nesting: there are at most n of them across the entire run.
*/
