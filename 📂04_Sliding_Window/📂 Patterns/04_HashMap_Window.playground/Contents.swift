//
//  04_HashMap_Window.swift
//  Phase 04 — Sliding Window
//
//  Window state is a frequency map instead of a sum. Enter → increment.
//  Leave → decrement and prune at zero.
//
//  Comparing the window map against a needed map costs O(k) per step.
//  The matched counter (next drill) replaces it with one Int.
//
//  Feeds: Q31, Q32, Q33, Q34, Q36
//

import Foundation

// MARK: - Drill 1 — Window Frequencies

// Time: O(n) — one enter and one leave per step
// Space: O(k) — k = distinct characters in the window
//
// Fixed window, so left is always right - k. Deriving it removes a
// variable that can drift out of sync.
func printWindowFrequencies(_ s: String, _ k: Int) {
    guard k > 0 && k <= s.count else { return }

    let chars = Array(s)
    var frequency = [Character: Int]()

    // Build first window
    for i in 0..<k {
        let char = chars[i]
        if let count = frequency[char] {
            frequency[char] = count + 1
        } else {
            frequency[char] = 1
        }
    }

    print("Window: \(String(chars[0..<k])) \(frequency)")

    // Slide
    for right in k..<chars.count {
        let leftChar = chars[right - k]
        if let count = frequency[leftChar] {
            if count == 1 {
                frequency[leftChar] = nil
            } else {
                frequency[leftChar] = count - 1
            }
        }

        let rightChar = chars[right]
        if let count = frequency[rightChar] {
            frequency[rightChar] = count + 1
        } else {
            frequency[rightChar] = 1
        }

        print("Window: \(String(chars[(right - k + 1)...right])) \(frequency)")
    }
}

printWindowFrequencies("aabac", 3)

// MARK: - Drill 2 — Are Maps Equal

// Time: O(k) — k = distinct keys, one lookup each
// Space: O(1)
//
// The size check is CORRECTNESS, not speed. Walking only `first`,
// ["a": 1] vs ["a": 1, "b": 1] matches every key and wrongly returns true.
func areMapsEqual(_ first: [Character: Int], _ second: [Character: Int]) -> Bool {
    if first.count != second.count {
        return false
    }

    for (char, count) in first {
        guard let secondCount = second[char] else {
            return false
        }

        if count != secondCount {
            return false
        }
    }

    return true
}

let map1: [Character: Int] = ["a": 2, "b": 1]
let map2: [Character: Int] = ["b": 1, "a": 2]
let map3: [Character: Int] = ["a": 1, "b": 1]
let map4: [Character: Int] = ["a": 1]

print(areMapsEqual(map1, map2))   // true

print(areMapsEqual(map1, map3))   // false

print(areMapsEqual(map4, map3))   // false — subset, not equal
