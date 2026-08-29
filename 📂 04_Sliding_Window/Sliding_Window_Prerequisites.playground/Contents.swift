import Foundation

// MARK: - 01 Characters Of

// Time: O(n) — one pass over the string
// Space: O(n) — a new array of n characters
//
// Swift Strings aren't integer-indexable: s[0] doesn't compile because
// String.Index isn't Int. And s.count is O(n) — it counts grapheme
// clusters every call. Converting once up front makes every later
// access O(1). In real solutions this is written Array(s); the loop
// below is what that call does internally.
func charsOf(_ s: String) -> [Character] {
    var chars = [Character]()
    for ch in s {
        chars.append(ch)
    }

    return chars
}

// MARK: - 02 Max / Min

// Time: O(1) — one comparison
// Space: O(1)
func maxOf(_ a: Int, _ b: Int) -> Int {
    if a > b {
        return a
    } else {
        return b
    }
}

// Time: O(1) — one comparison
// Space: O(1)
func minOf(_ a: Int, _ b: Int) -> Int {
    if a < b {
        return a
    } else {
        return b
    }
}

// MARK: - 03 Sum Of Range

// Time: O(n) — n = range length (to - from + 1), not nums.count
// Space: O(1) — one accumulator
//
// Inclusive both ends, so the loop is `while index <= to`. This is the
// brute-force half of every fixed-window problem.
func sumOfRange(_ nums: [Int], _ from: Int, _ to: Int) -> Int {
    if from < 0 || to >= nums.count || from > to {
        return 0
    }

    var sum = 0
    var index = from
    while index <= to {
        sum += nums[index]
        index += 1
    }

    return sum
}

// MARK: - 04 Window Size

// Time: O(1) — one subtraction
// Space: O(1)
//
// +1 because both edges are inside the window: indices 2...5 is four
// elements, not three. After a shrink left becomes right + 1, so this
// returns 0 for an empty window with no guard needed.
func windowSize(_ left: Int, _ right: Int) -> Int {
    return (right - left) + 1
}

// MARK: - 05 Increment

// Time: O(1) — amortised hash lookup and write
// Space: O(1) — at most one new key
func increment(_ key: Character, in map: inout [Character: Int]) {
    if let count = map[key] {
        map[key] = count + 1
    } else {
        map[key] = 1
    }
}

// MARK: - 06 Decrement

// Time: O(1) — one lookup plus one write or removal
// Space: O(1)
//
// Prunes at zero — a surviving ["a": 0] would break distinctCount and
// every "at most k distinct" check built on map.count. Missing key
// falls through: nothing to decrement is a no-op, not a crash.
func decrement(_ key: Character, in map: inout [Character: Int]) {
    if let count = map[key] {
        if count == 1 {
            map[key] = nil
        } else {
            map[key] = count - 1
        }
    }
}

// MARK: - 07 Build Frequency

// Time: O(n) — one pass, O(1) work per character
// Space: O(k) — k = distinct characters, bounded by the alphabet
func buildFrequency(_ chars: [Character]) -> [Character: Int] {
    var map = [Character: Int]()
    for ch in chars {
        increment(ch, in: &map)
    }

    return map
}

// MARK: - 08 Are Maps Equal

// Time: O(k) — k = distinct keys; one hash lookup each
// Space: O(1)
//
// Runs once per window step in the naive Q33/Q34 → O(n·k) overall.
// Pattern 04's `matched` counter replaces this whole loop with one Int
// comparison: O(1) per step, O(n) total.
func areMapsEqual(_ a: [Character: Int], _ b: [Character: Int]) -> Bool {
    if a.count != b.count {
        return false
    }

    for (aKey, count) in a {
        if let countB = b[aKey] {
            if count != countB {
                return false
            }
        } else {
            return false
        }
    }

    return true
}

// MARK: - 09 Distinct Count

// Time: O(1) — Dictionary.count is stored, not computed
// Space: O(1)
//
// Only correct because decrement prunes at zero. A surviving ["a": 0]
// would count as a distinct character that isn't in the window, and
// Q36's `while distinctCount(map) > 2` would shrink a valid window.
func distinctCount(_ map: [Character: Int]) -> Int {
    return map.count
}

// MARK: - 10 Deque Ops

// Time: O(1) — amortised append
// Space: O(1)
func pushBack(_ value: Int, into deque: inout [Int]) {
    deque.append(value)
}

// Time: O(n) — removeFirst() shifts every remaining element left
// Space: O(1)
//
// Q38 tolerates this: the deque holds at most k indices, and each index
// enters and leaves exactly once across the whole scan. Total shifting
// work stays bounded, so the solution is still O(n) overall.
func popFront(_ deque: inout [Int]) -> Int? {
    guard !deque.isEmpty else {
        return nil
    }

    return deque.removeFirst()
}

// Time: O(1) — removes the last element, nothing shifts
// Space: O(1)
func popBack(_ deque: inout [Int]) -> Int? {
    guard !deque.isEmpty else {
        return nil
    }

    return deque.removeLast()
}

// Time: O(1) — read only
// Space: O(1)
func peekFront(_ deque: [Int]) -> Int? {
    return deque.first
}

// MARK: - Traces

print("01 charsOf(\"abc\"): \(charsOf("abc"))")

print("02 maxOf(3, -7): \(maxOf(3, -7)) | minOf(3, -7): \(minOf(3, -7))")

print("03 sumOfRange([2,1,5,1], 1, 2): \(sumOfRange([2, 1, 5, 1], 1, 2)) | invalid: \(sumOfRange([2, 1], 1, 0))")

print("04 windowSize(2, 5): \(windowSize(2, 5)) | empty: \(windowSize(3, 2))")

var frequency: [Character: Int] = [:]
increment("a", in: &frequency)
increment("a", in: &frequency)
increment("b", in: &frequency)
print("05 after increments: \(frequency)")

decrement("b", in: &frequency)
decrement("z", in: &frequency)
print("06 after decrements (b pruned, z no-op): \(frequency)")

print("07 buildFrequency([a,b,a]): \(buildFrequency(["a", "b", "a"]))")

print("08 areMapsEqual: \(areMapsEqual(["a": 2, "b": 1], ["b": 1, "a": 2])) | \(areMapsEqual(["a": 1], ["a": 1, "b": 1]))")

print("09 distinctCount([a:2, b:1]): \(distinctCount(["a": 2, "b": 1]))")

var deque: [Int] = []
pushBack(3, into: &deque)
pushBack(7, into: &deque)
print("10 peekFront: \(String(describing: peekFront(deque))) | deque: \(deque)")

print("10 popBack: \(String(describing: popBack(&deque))) | popFront: \(String(describing: popFront(&deque))) | empty popFront: \(String(describing: popFront(&deque)))")
