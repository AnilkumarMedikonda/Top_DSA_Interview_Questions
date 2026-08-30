//
//  Q36_LC904_Fruits_Into_Baskets.swift
//
//  A row of fruit trees, fruits[i] = the type on tree i. You have two
//  baskets, each holding one type only, unlimited amount. Pick one fruit
//  from every tree moving right; stop when a type fits neither basket.
//  Return the maximum fruits you can pick.
//
//  [1,2,1]                       → 3   all three fit
//  [0,1,2,2]                     → 3   [1,2,2]
//  [1,2,3,2,2]                   → 4   [2,3,2,2]
//  [3,3,3,1,2,1,1,2,3,3,4]       → 5   [1,2,1,1,2]
//
//  Constraints: 1 <= fruits.length <= 10^5, 0 <= fruits[i] < length
//
//  TRANSLATION
//  "Two baskets, one type each"  → at most 2 DISTINCT values in the window
//  "Maximum fruits"              → LONGEST window
//  So it's a variable window: expand right, shrink while distinct > k,
//  record after shrinking.
//
//  WHY map.count IS THE DISTINCT CHECK
//  Only because decrement prunes at zero. A leftover [1: 0] reports a
//  fruit type that isn't in the window, so the shrink loop would keep
//  running on a window that was already valid.
//
//  SIGNATURE NOTE
//  k is parameterised instead of hardcoding 2 — the same function solves
//  LC 340, Longest Substring with At Most K Distinct Characters.
//
//  Brute   O(n²) / O(k)
//  Optimal O(n)  / O(k)   — map holds at most k+1 entries
//
//  WRONG TOOL
//  Two variables for "the two types". It's "at most 2 distinct", which
//  is a map with a size check — the two-variable version needs special
//  cases for which one to evict and breaks the moment k changes.
//


// MARK: - Brute Force  O(n²) time  O(k) space

/*
 Strategy:
 - Fix i as start
 - Expand j, track fruit types via hashMap
 - When types > 2 → break
 - Track max length

 INTERVIEW: Start here, explain before coding
*/

func bruteForce(_ fruits: [Int]) -> Int {

    let k      = 2
    var answer = 0

    for i in 0..<fruits.count {

        var hashMap        = [Int: Int]()
        var uniqueTypes    = 0

        for j in i..<fruits.count {

            let fruit = fruits[j]

            if let count = hashMap[fruit] {
                hashMap[fruit] = count + 1
            } else {
                hashMap[fruit] = 1
                uniqueTypes += 1
            }

            if uniqueTypes <= k {
                answer = max(answer, j - i + 1)
            } else {
                break
            }
        }
    }

    return answer
}

// MARK: - Optimal ⭐️  O(n) time  O(k) space

/*
 Strategy:
 - expand right → add fruit, increment count
 - while distinct > 2 → shrink left
   → decrement count, if 0 remove key, uniqueTypes--
   → left++
 - track max window

 INTERVIEW: Same sliding window as Problem 12 — k = 2
 INTERVIEW: Use leftFruit not fruit — avoid variable shadowing
*/

func optimised(_ fruits: [Int]) -> Int {

    let k           = 2
    var hashMap     = [Int: Int]()
    var uniqueTypes = 0
    var left        = 0
    var answer      = 0

    for right in 0..<fruits.count {

        let fruit = fruits[right]

        if let count = hashMap[fruit] {
            hashMap[fruit] = count + 1
        } else {
            hashMap[fruit] = 1
            uniqueTypes += 1
        }

        while uniqueTypes > k {

            let leftFruit = fruits[left]

            if let count = hashMap[leftFruit] {
                hashMap[leftFruit] = count - 1
                if hashMap[leftFruit] == 0 {
                    hashMap.removeValue(forKey: leftFruit)
                    uniqueTypes -= 1
                }
            }
            left += 1
        }

        answer = max(answer, right - left + 1)
    }

    return answer
}

// MARK: - Tests

let tests: [([Int], Int)] = [
    ([1, 2, 1],       3),
    ([0, 1, 2, 2],    3),
    ([1, 2, 3, 2, 2], 4),
    ([1, 1, 1, 1],    4),
    ([3, 3, 3, 1, 2, 1, 1, 2, 3, 3, 4], 5)
]

print("--- Brute Force ---")
for (i, t) in tests.enumerated() {
    let r = bruteForce(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r) | Expected: \(t.1)")
}

print("\n--- Optimal ⭐️ ---")
for (i, t) in tests.enumerated() {
    let r = optimised(t.0)
    print("Test \(i+1): \(r == t.1 ? "✅" : "❌") | Got: \(r) | Expected: \(t.1)")
}
