import Foundation

// Q80 - LeetCode 127: Word Ladder
//
// Problem:
//
// Transform beginWord into endWord by changing one character
// at a time.
//
// Every transformed word must exist in wordList.
//
// Return the number of words in the shortest transformation sequence.
// Return 0 if no transformation is possible.
//
// Example:
//
// beginWord = "hit"
// endWord = "cog"
// wordList = ["hot", "dot", "dog", "lot", "log", "cog"]
//
// hit → hot → dot → dog → cog
//
// Answer: 5
//
// Pattern:
// BFS + Shortest Path
//
// Key Idea:
// Each word is a node.
// A valid one-character transformation is an edge.
// BFS finds the shortest transformation.
//
// Steps:
//
// 1. Check if endWord exists
// 2. Convert wordList into Set for O(1) lookup
// 3. Add beginWord to Queue
// 4. Process BFS level by level
// 5. Change one character at a time
// 6. Restore the character before moving to the next position
// 7. Check if generated word exists in wordSet
// 8. Remove visited word and add it to Queue
// 9. Increase step after each BFS level
// 10. Return step when endWord is found
//
// Time: O(N × L² × 26)
// Space: O(N × L)
//
// N = Number of words
// L = Length of each word

// Step 1: Create Function

func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {

    // Step 2: Check End Word

    guard wordList.contains(endWord) else {
        return 0
    }

    // Step 3: Create Word Set

    var wordSet = Set(wordList)
    wordSet.remove(beginWord)

    // Step 4: Create BFS Queue

    var queue = [String]()
    var head = 0
    var step = 1

    queue.append(beginWord)

    // Step 5: BFS

    let letters = Array("abcdefghijklmnopqrstuvwxyz")

    while head < queue.count {

        // Current BFS level size
        let levelSize = queue.count - head

        // Process current level
        for _ in 0..<levelSize {

            let currentWord = queue[head]
            head += 1

            // Step 6: Convert Word to Characters

            var characters = Array(currentWord)

            // Step 7: Change One Character at a Time

            for i in 0..<characters.count {

                let original = characters[i]

                for letter in letters {

                    if letter == original {
                        continue
                    }

                    characters[i] = letter

                    let newWord = String(characters)

                    // Step 8: Check End Word

                    if newWord == endWord {
                        return step + 1
                    }

                    // Step 9: Check Valid Word

                    if wordSet.contains(newWord) {
                        wordSet.remove(newWord)
                        queue.append(newWord)
                    }
                }

                // Step 10: Restore before the next position
                characters[i] = original
            }
        }

        // Step 11: Move to Next BFS Level

        step += 1
    }

    return 0
}

print("\n========== Q80 - Word Ladder ==========")

print(ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]))
// 5

print(ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log"]))
// 0

print(ladderLength("a", "c", ["a", "b", "c"]))
// 2

print(ladderLength("hot", "dog", ["hot", "dog"]))
// 0

// Regression: the answer needs position 2, not position 0.
// Without the restore, characters[0] stays "z" and the
// candidate becomes "zig" instead of "hig" — returns 0.

print(ladderLength("hit", "hig", ["hig"]))
// 2
print(ladderLength("hot", "hot", ["hot"]))
