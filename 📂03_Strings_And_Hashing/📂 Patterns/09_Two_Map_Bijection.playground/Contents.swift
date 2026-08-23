import Foundation

//
//  09_Two_Map_Bijection
//  Phase 03 — Strings and Hashing
//
//  Maintain a one-to-one mapping between two sequences.
//
//  Forward Map : Left  -> Right
//  Reverse Map : Right -> Left
//
//  Both maps must agree.
//
//  Feeds:
//  • Q27 — LC205 Isomorphic Strings
//  • Q28 — LC290 Word Pattern
//

//============================================================
// MARK: - Two Map Bijection
//
// Time: O(n)
// Space: O(n)
//============================================================

func isBijection(_ left: [Character], _ right: [Character]) -> Bool {

    guard left.count == right.count else { return false }

    var forward = [Character: Character]()
    var reverse = [Character: Character]()

    for i in 0..<left.count {

        let l = left[i]
        let r = right[i]

        // Left -> Right
        if let mapped = forward[l] {

            if mapped != r {
                return false
            }

        } else {

            forward[l] = r
        }

        // Right -> Left
        if let mapped = reverse[r] {

            if mapped != l {
                return false
            }

        } else {

            reverse[r] = l
        }
    }

    return true
}

// MARK: - Tests

print(isBijection(Array("egg"), Array("add")))      // true

print(isBijection(Array("foo"), Array("bar")))      // false

print(isBijection(Array("paper"), Array("title")))  // true

print(isBijection(Array("ab"), Array("aa")))        // false
