
//
//  05_Word_Splitting
//  Phase 03 — Strings and Hashing
//
//  Manual tokenisation on spaces — no split(), no components().
//  Accumulate characters into a buffer, flush the buffer on a separator,
//  flush once more after the loop.
//  The isEmpty guard on each flush is what handles leading, trailing and
//  repeated spaces; without it you collect phantom "" entries.
//
//  Feeds: Q24 Reverse Words, Q28 Word Pattern
//

import Foundation

// 1 — the split itself. Q28 needs the array, not a rebuilt string.
// Time O(n), Space O(n)
func splitOnSpaces(_ s: String) -> [String] {
    var word = ""
    var words = [String]()

    for char in s {
        if char == " " {
            if !word.isEmpty {
                words.append(word)
                word = ""
            }
        } else {
            word.append(char)
        }
    }

    if !word.isEmpty {
        words.append(word)
    }

    return words
}

print(splitOnSpaces("the sky is blue"))

print(splitOnSpaces("  hello   world  "))

print(splitOnSpaces("   "))

// 2 — Q24. Split, then walk backwards joining with single spaces.
// Separator goes after each word except the last (i > 0).
// Time O(n), Space O(n)
func reverseWordsInAString(_ s: String) -> String {
    let words = splitOnSpaces(s)
    var result = ""
    var i = words.count - 1

    while i >= 0 {
        result += words[i]

        if i > 0 {
            result += " "
        }

        i -= 1
    }

    return result
}

print(reverseWordsInAString("the sky is blue"))

print(reverseWordsInAString("  hello   world  "))

print(reverseWordsInAString("a"))

print(reverseWordsInAString("   "))


// 3 — word count. Same buffer-and-flush shape.
// Time O(n), Space O(k) longest word
func countWords(_ s: String) -> Int {
    var word = ""
    var count = 0

    for ch in s {
        if ch == " " {
            if !word.isEmpty {
                count += 1
                word = ""
            }
        } else {
            word.append(ch)
        }
    }

    if !word.isEmpty {
        count += 1
    }

    return count
}

print(countWords("the sky is blue"))

print(countWords("  hello   world  "))

print(countWords("   "))

print(countWords(""))


// 4 — longest word. Ties keep the first.
// Time O(n), Space O(k) longest word
func longestWord(_ s: String) -> String {
    var word = ""
    var longest = ""

    for ch in s {
        if ch == " " {
            if !word.isEmpty {
                if word.count > longest.count {
                    longest = word
                }

                word = ""
            }
        } else {
            word.append(ch)
        }
    }

    if word.count > longest.count {
        longest = word
    }

    return longest
}

print(longestWord("the sky is blue"))

print(longestWord("  hello   world  "))

print(longestWord("I love programming"))

print(longestWord("   "))




func shortestWord(_ s: String) -> String {
    var word = ""
    var shortest = ""
    var shortestLength = Int.max

    for ch in s {
        if ch == " " {
            if !word.isEmpty {
                if word.count < shortestLength {
                    shortestLength = word.count
                    shortest = word
                }

                word = ""
            }
        } else {
            word.append(ch)
        }
    }

    if !word.isEmpty && word.count < shortestLength {
        shortest = word
    }

    return shortest
}

print(shortestWord("the sky is blue"))

print(shortestWord("  hello   world  "))

print(shortestWord("I love programming"))

print(shortestWord("hello"))

print(shortestWord("   "))


// 6 — reverse each word in place, keep word order.
// Prepending builds the reversal for free, but each prepend is O(k).
// Time O(n·k), Space O(n)
func reverseEachWord(_ s: String) -> String {
    var word = ""
    var result = ""

    for ch in s {
        if ch == " " {
            if !word.isEmpty {
                result += word + " "
                word = ""
            }
        } else {
            word = String(ch) + word
        }
    }

    if !word.isEmpty {
        result += word
    }

    return result
}

print(reverseEachWord("Hello World"))
print(reverseEachWord("Let's code"))
print(reverseEachWord("  a  bc  "))
