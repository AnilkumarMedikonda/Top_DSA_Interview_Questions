import Foundation

//==============================================================
// Parentheses Matching
//==============================================================
//
// Use Stack whenever you see:
//
// • ( )
// • { }
// • [ ]
// • Nested Expressions
// • Balanced Symbols
//
// Time  : O(n)
// Space : O(n)
//
//==============================================================



// MARK: - 1. Basic Parentheses Matching

func isMatching(_ open: Character, _ close: Character) -> Bool {

    return (open == "(" && close == ")") ||
           (open == "[" && close == "]") ||
           (open == "{" && close == "}")
}

print("========== Matching ==========")

print(isMatching("(", ")"))
print(isMatching("[", "]"))
print(isMatching("{", "}"))
print(isMatching("(", "]"))

print()



// MARK: - 2. Push Opening Brackets

print("========== Push Opening Brackets ==========")

let text1 = "({["

var stack1 = [Character]()

for character in text1 {

    if character == "(" ||
       character == "[" ||
       character == "{" {

        stack1.append(character)
    }

    print(stack1)
}

print()



// MARK: - 3. Pop Closing Brackets

print("========== Pop Closing Brackets ==========")

let text2 = "({[]})"

var stack2 = [Character]()

for character in text2 {

    if character == "(" ||
       character == "[" ||
       character == "{" {

        stack2.append(character)
        print("Push :", character)

    } else {

        if let top = stack2.last,
           isMatching(top, character) {

            stack2.removeLast()
            print("Pop  :", character)

        } else {

            print("Invalid")
            break
        }
    }

    print(stack2)
}

print()



// MARK: - 4. Generic Template

func checkParentheses(_ text: String) -> Bool {

    var stack = [Character]()

    for character in text {

        if character == "(" ||
           character == "[" ||
           character == "{" {

            stack.append(character)

        } else {

            guard let top = stack.last,
                  isMatching(top, character) else {

                return false
            }

            stack.removeLast()
        }
    }

    return stack.isEmpty
}

print("========== Template ==========")

print(checkParentheses("()"))
print(checkParentheses("()[]{}"))
print(checkParentheses("([{}])"))
print(checkParentheses("(]"))
print(checkParentheses("([)]"))
print(checkParentheses("((("))

print()



// MARK: - 5. Recognition

/*
 Think Parentheses Matching when you see:

 • Balanced Parentheses
 • Valid Parentheses
 • Matching Brackets
 • Nested Expressions
 • HTML/XML Tags
 • Compiler Parsing
 */




// MARK: - 6. Algorithm

/*
 For each character

 Opening Bracket ?

 YES
     Push

 NO
     Stack Empty ?

     YES
         Invalid

     NO
         Top Matches ?

         YES
             Pop

         NO
             Invalid

 End

 Stack Empty ?

 YES
     Valid

 NO
     Invalid
*/




// MARK: - 7. Complexity

/*
 Time  : O(n)

 Space : O(n)

 Every opening bracket is pushed once.

 Every closing bracket removes at most one element.
*/




// MARK: - Interview Notes

/*
 Pattern

 Opening Bracket
 ↓
 Push

 Closing Bracket
 ↓
 Compare with Stack Top

 Match
 ↓
 Pop

 No Match
 ↓
 Invalid


 Remember

 Opening  -> Push

 Closing  -> Match + Pop

 Stack Empty at End
 ↓
 Valid
*/
