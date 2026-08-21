//
//  Strings_And_Hashing_Prerequisites.swift
//

import Foundation

//============================================================
// MARK: - String Basics
//============================================================

let str = "Hello, Swift!"

print(str)
print("Count:", str.count)
print("Is Empty:", str.isEmpty)

//============================================================
// MARK: - Character
//============================================================

let ch: Character = "A"

print(ch)

//============================================================
// MARK: - String Traversal
//============================================================

for character in str {
    print(character)
}

//============================================================
// MARK: - First Character
//============================================================

if let first = str.first {
    print("First:", first)
}

//============================================================
// MARK: - Last Character
//============================================================

if let last = str.last {
    print("Last:", last)
}

//============================================================
// MARK: - String Indexing
//============================================================

let firstIndex = str.startIndex
print(str[firstIndex])

let secondIndex = str.index(after: firstIndex)
print(str[secondIndex])

let lastIndex = str.index(before: str.endIndex)
print(str[lastIndex])

//============================================================
// MARK: - Substring
//============================================================

let start = str.startIndex
let end = str.index(start, offsetBy: 4)

let substring = str[start...end]

print(substring)

//============================================================
// MARK: - Prefix
//============================================================

print(str.prefix(5))

//============================================================
// MARK: - Suffix
//============================================================

print(str.suffix(5))

//============================================================
// MARK: - Contains
//============================================================

print(str.contains("Swift"))

//============================================================
// MARK: - Has Prefix
//============================================================

print(str.hasPrefix("Hello"))

//============================================================
// MARK: - Has Suffix
//============================================================

print(str.hasSuffix("Swift!"))

//============================================================
// MARK: - Uppercase
//============================================================

print(str.uppercased())

//============================================================
// MARK: - Lowercase
//============================================================

print(str.lowercased())

//============================================================
// MARK: - Reverse String
//============================================================

let reversed = String(str.reversed())

print(reversed)

//============================================================
// MARK: - Split
//============================================================

let sentence = "I Love Swift"

let words = sentence.split(separator: " ")

print(words)

//============================================================
// MARK: - Join
//============================================================

let joined = words.joined(separator: "-")

print(joined)

//============================================================
// MARK: - String to Character Array
//============================================================

let characters = Array(str)

print(characters)

//============================================================
// MARK: - Character Array to String
//============================================================

let newString = String(characters)

print(newString)

//============================================================
// MARK: - String Comparison
//============================================================

let s1 = "Apple"
let s2 = "Apple"

print(s1 == s2)

//============================================================
// MARK: - Lexicographical Comparison
//============================================================

print("abc" < "xyz")

//============================================================
// MARK: - Remove Whitespace
//============================================================

let text = "   Swift   "

let trimmed = text.trimmingCharacters(in: .whitespaces)

print(trimmed)

//============================================================
// MARK: - Replace
//============================================================

let replaced = str.replacingOccurrences(of: "Swift", with: "iOS")

print(replaced)

//============================================================
// MARK: - Append
//============================================================

var greeting = "Hello"

greeting.append("!")

print(greeting)

greeting += " Welcome"

print(greeting)

//============================================================
// MARK: - Insert Character
//============================================================

var language = "Swft"

language.insert("i", at: language.index(after: language.startIndex))

print(language)

//============================================================
// MARK: - Remove Character
//============================================================

var sample = "ABCDE"

sample.remove(at: sample.startIndex)

print(sample)

//============================================================
// MARK: - Iterate with Index
//============================================================

for index in str.indices {
    print(index, str[index])
}
