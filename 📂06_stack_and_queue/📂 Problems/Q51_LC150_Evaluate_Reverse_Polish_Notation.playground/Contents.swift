import Foundation

//==============================================================
// Q51 - LC150 - Evaluate Reverse Polish Notation
//==============================================================
//
// Problem
// -------
// Given an array of strings representing an arithmetic expression in
// Reverse Polish Notation, evaluate it and return the result. In RPN
// the operator comes after its operands: ["2","1","+"] means 2 + 1.
//
// Example
// -------
// ["2","1","+","3","*"]                                  -> 9
//     ((2 + 1) * 3)
//
// ["4","13","5","/","+"]                                 -> 6
//     (4 + (13 / 5)) = 4 + 2
//
// ["10","6","9","3","+","-11","*","/","*","17","+","5","+"] -> 22
//
// Constraints
// -----------
// 1 <= tokens.count <= 10^4
// each token is "+", "-", "*", "/", or an integer in [-200, 200]
// division truncates toward zero
// the expression is always valid, no division by zero
//
// Pattern : Stack Simulation (04_Stack_Simulation)
//
// Time  : O(n)
// Space : O(n)
//
//==============================================================


// MARK: - Brute Force
/*
 Repeatedly scan the array for the first operator, apply it to the two
 numbers immediately before it, collapse the triplet into one value,
 and rescan from the start. Each collapse is O(n) (array rebuild) and
 there are O(n) operators → O(n²) total.
 */
func evalRPNBrute(_ tokens: [String]) -> Int {
    var work = tokens

    while work.count > 1 {
        var i = 0
        while i < work.count {
            let token = work[i]
            if Int(token) == nil {
                // token is an operator; operands are at i-2 and i-1
                var a = 0
                var b = 0
                if let left = Int(work[i - 2]) {
                    b = left
                }
                if let right = Int(work[i - 1]) {
                    a = right
                }

                var computed = 0
                if token == "+" {
                    computed = b + a
                } else if token == "-" {
                    computed = b - a
                } else if token == "*" {
                    computed = b * a
                } else if token == "/" {
                    computed = b / a
                }

                // rebuild array with the triplet collapsed
                var next = [String]()
                var j = 0
                while j < work.count {
                    if j == i - 2 {
                        next.append(String(computed))
                        j = i + 1
                    } else {
                        next.append(work[j])
                        j += 1
                    }
                }
                work = next
                break // rescan from the start
            }
            i += 1
        }
    }

    if let final = Int(work[0]) {
        return final
    }
    return 0
}

// MARK: - Optimised (Stack)
/*
 Single left-to-right pass:
 - Number  → push
 - Operator → pop two, compute, push result
 Answer is the single value left on the stack.
 */
func evalRPN(_ tokens: [String]) -> Int {
    var result = [Int]()

    for char in tokens {

        if char != "+", char != "-", char != "*", char != "/" {
            if let value = Int(char) {
                result.append(value)
            }
        } else {
            let a = result.removeLast()   // right operand (popped first)
            let b = result.removeLast()   // left operand

            if char == "+" {
                result.append(a + b)
            } else if char == "-" {
                result.append(b - a)      // order matters
            } else if char == "*" {
                result.append(a * b)
            } else if char == "/" {
                result.append(b / a)      // order matters
            }
        }
    }

    if let final = result.last {
        return final
    }
    return 0
}

// MARK: - Dry Run
/*
 tokens = ["2","1","+","3","*"]

 char  action              stack
 "2"   push 2              [2]
 "1"   push 1              [2, 1]
 "+"   pop 1, pop 2 → 3    [3]
 "3"   push 3              [3, 3]
 "*"   pop 3, pop 3 → 9    [9]

 return 9 ✓

 Order check with ["4","13","5","/","+"]:
 "/"  → a = 5 (first pop), b = 13 → b / a = 13/5 = 2 (truncates) ✓
 "+"  → a = 2, b = 4 → 6 ✓
 */

// MARK: - Complexity
/*
 Optimised: Time O(n) — each token processed once.
            Space O(n) — stack can hold up to ~n/2 operands.
 Brute:     Time O(n²) — O(n) collapses × O(n) rescan/rebuild each.
            Space O(n) — working copy of the array.
 */

// MARK: - Traps
/*
 1. Pop order for - and /: FIRST pop is the RIGHT operand.
    b - a and b / a, never a - b. (#1 bug on this problem)
 2. Don't detect operators by first character: "-11" starts with "-"
    but is a number. Int(token) failing IS the operator check.
 3. Int(token) returns an optional → if let, never force unwrap.
 4. Return the single remaining value, not the stack; guard with if let.
 5. Swift Int division already truncates toward zero — no extra
    handling needed for negative division (unlike some languages).
 6. removeLast() crashes on empty array; safe with LC's validity
    guarantee, but popLast() + if let is the defensive pattern.
 */

// MARK: - Tests
let test1 = ["2", "1", "+", "3", "*"]                                    // 9
let test2 = ["4", "13", "5", "/", "+"]                                   // 6
let test3 = ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"] // 22
let test4 = ["-7", "2", "/"]                                             // -3 (truncates toward zero)
let test5 = ["42"]                                                       // 42 (single token)

print(evalRPN(test1))       // 9
print(evalRPN(test2))       // 6
print(evalRPN(test3))       // 22
print(evalRPN(test4))       // -3
print(evalRPN(test5))       // 42

print(evalRPNBrute(test1))  // 9
print(evalRPNBrute(test2))  // 6
print(evalRPNBrute(test3))  // 22
print(evalRPNBrute(test4))  // -3
print(evalRPNBrute(test5))  // 42

// MARK: - Interview Q&A
/*
 Q1. Why is a stack the natural structure here?
 A.  Postfix operators apply to the two most recently seen operands —
     "most recent first" is LIFO by definition.

 Q2. How do you handle negative numbers like "-11"?
 A.  Parse with Int(token). If parsing succeeds it's a number
     (including negatives); if it fails it's an operator. Never check
     the first character.

 Q3. Why does pop order matter only for - and /?
 A.  + and * are commutative; - and / are not. First pop is the right
     operand, so compute b - a and b / a.

 Q4. How does division "truncate toward zero" and does Swift need
     special handling?
 A.  6 / -132 = 0 and -7 / 2 = -3 (not -4). Swift's Int division
     already truncates toward zero, so no extra code. In Python you'd
     need int(a / b) instead of a // b (floor division).

 Q5. What's the state of the stack at the end of a valid expression?
 A.  Exactly one value — the answer. Each operator reduces stack size
     by one (pop 2, push 1); a valid RPN of k operands and k-1
     operators nets to 1.

 Q6. Can this be done in O(1) extra space?
 A.  Yes, if you're allowed to mutate the input: use the front of the
     tokens array itself as the stack (write index). Same O(n) time.

 Q7. Follow-up: how would you convert infix to postfix?
 A.  Shunting-yard algorithm — an operator stack + output list, popping
     by precedence. Natural next problem after this one.
 */
