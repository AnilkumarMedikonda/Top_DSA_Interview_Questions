# Phase 02 — Two Pointers

## 🎯 Objective

Master the Two Pointer technique to solve array and string problems efficiently by reducing time complexity and performing in-place operations whenever possible.

---

## 📚 Prerequisites

- [x] Arrays
- [x] Time & Space Complexity
- [x] Array Traversal
- [x] In-Place Updates
- [x] Swapping Elements
- [x] Sorted Arrays
- [x] Read & Write Technique
- [x] Opposite Ends Technique

---

## 🧩 Patterns

| # | Pattern | Status |
|---|---------|:-----:|
| 01 | Opposite Ends | ✅ |
| 02 | Same Direction (Read & Write) | ✅ |
| 03 | Same Direction (Read & Swap) | ✅ |
| 04 | Dutch National Flag | ✅ |
| 05 | Array Reverse | ✅ |
| 06 | Merge Two Arrays | ✅ |
| 07 | Right-to-Left Traversal | ✅ |
| 08 | Interval Merge | ✅ |
| 09 | Cyclic Sort | ✅ |

---

## 💻 Problems

| # | Problem | LC | Pattern | Status |
|---|---------|----|---------|:-----:|
| Q11 | Container With Most Water | 011 | Opposite Ends | ✅ |
| Q12 | 3Sum | 015 | Opposite Ends + Duplicate Skip | ✅ |
| Q13 | Trapping Rain Water | 042 | Opposite Ends | ✅ |
| Q14 | Squares of a Sorted Array | 977 | Opposite Ends | ✅ |
| Q15 | Sort Colors | 075 | Dutch National Flag | ✅ |
| Q16 | Next Permutation | 031 | Right-to-Left + Array Reverse | ✅ |
| Q17 | Rotate Array | 189 | Array Reverse | ✅ |
| Q18 | Merge Intervals | 056 | Interval Merge | ✅ |
| Q19 | First Missing Positive | 041 | Cyclic Sort | ✅ |

---

## 📝 Key Takeaways

- **Opposite Ends vs Array Reverse** — both converge, but reversal swaps blind while Opposite Ends *compares* and moves only one pointer. That comparison is what eliminates half the search space.
- **Same motion, different reasons** — Q11 moves the shorter line because the taller one can't improve the area; Q12 moves on whether the sum is too small or too big; Q13 moves the shorter side because that side's answer is already determined. Recognising the shape is easy; knowing why the pointer moves is what makes it stick.
- **`write` is the new length** — after a read/write pass, the write pointer has counted every element it kept. Return it, don't recount.
- **Swap vs overwrite** — swapping preserves discarded elements at the tail; overwriting loses them. Sort Colors needs the swap, Remove Element doesn't.
- **`while mid <= high` in Dutch National Flag** — the element at `high` is unexamined; `<` leaves it unsorted. And `mid` does not advance after a high swap.
- **Sorting buys dedup in 3Sum** — a hash map finds a pair faster but can't suppress duplicate triplets. Skip at `i`, then at `left` and `right` after every hit.
- **Fill backwards in Squares of a Sorted Array** — the largest square is always at one of the two ends; the smallest is somewhere in the middle and can't be found in O(1).
- **Next Permutation's swap target needs `<=`** — an equal value isn't greater, so the right-scan must walk past it.
- **Reduce `k` before rotating** — `k % count` first, guard the array before the modulo, and `shift > 0` not `> 1`.
- **`while`, not `if`, in Cyclic Sort** — after a swap the value that just arrived may also be misplaced, so re-check the same index. Guard on values, not indices.
- **Merge Intervals is Ω(n log n)** — turning each `x` into `[x, x]` would make interval merging a sort. Sorting also buys a *simpler* overlap test: one-sided instead of two-sided.
- **The array can be its own hash table** — First Missing Positive is O(1) space because value `v` belongs at index `v - 1`. The bound `1...n+1` is what makes everything outside that range ignorable.

---

## ⚠️ Common Mistakes

- `import UIKit` instead of `Foundation`
- Reaching for `swapAt`, `sorted`, `max`, `dropFirst` instead of manual implementations
- `for read in 0..<count` instead of a manual `while` — hides the pointer being learned
- Dead guards: `!nums.isEmpty` and `nums.count > 1` when a later condition already covers them
- Guards that return the wrong value on a single element — `guard count > 1 else { return nums }` skipped the squaring in Q14
- Bound check placed after the index in a compound condition — must be `j >= 0 && ...`
- `i < j` in a swap helper — blocks reverse-order calls silently
- Sorting into a copy then indexing the *original* array — shadow with `var nums = nums` so only one name exists
- Testing a single input value — `k = 3` on 7 elements hid two off-by-ones in Q17
- Naming a function for its side effect instead of its operation
- Missing T/S header and blank **Edge cases:** line
- Extra blank lines immediately inside braces

---

## 📈 Progress

- [x] Prerequisites
- [x] Patterns (9/9)
- [x] Problems (9/9)
- [ ] Revision
- [ ] Mock Interview 02
