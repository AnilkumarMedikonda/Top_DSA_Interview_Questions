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
| Q14 | Squares of a Sorted Array | 977 | Opposite Ends | ⬜ |
| Q15 | Sort Colors | 075 | Dutch National Flag | ⬜ |
| Q16 | Next Permutation | 031 | Right-to-Left + Array Reverse | ⬜ |
| Q17 | Rotate Array | 189 | Array Reverse | ⬜ |
| Q18 | Merge Intervals | 056 | Interval Merge | ⬜ |
| Q19 | First Missing Positive | 041 | Cyclic Sort | ⬜ |
---

## 📝 Key Takeaways

- **Opposite Ends vs Array Reverse** — both converge, but reversal swaps blind while Opposite Ends *compares* and moves only one pointer. That comparison is what eliminates half the search space.
- **`write` is the new length** — after a read/write pass, the write pointer has counted every element it kept. Return it, don't recount.
- **Swap vs overwrite** — swapping preserves discarded elements at the tail; overwriting loses them. Sort Colors needs the swap, Remove Element doesn't.
- **`while mid <= high` in Dutch National Flag** — the element at `high` is unexamined; `<` leaves it unsorted.
- **`while`, not `if`, in Cyclic Sort** — after a swap the value that just arrived may also be misplaced, so re-check the same index.
- **Reduce `k` before rotating** — `k % count` first, and guard the empty array before the modulo.
- **Merge Intervals is Ω(n log n)** — turning each `x` into `[x, x]` would make interval merging a sort, so the sort is a permanent bottleneck. The merge scan itself is O(n).
- **Move on the heights, not the maxes** — in Trapping Rain Water the pointer moves on `heights[left] < heights[right]`. When the left bar is shorter, some bar on the right is already at least that tall, so `leftMax` alone decides the water there.
- **Sort is what buys the dedup in 3Sum** — a hash map finds a pair faster but gives no way to suppress duplicate triplets. Skip at `i`, then at `left` and `right` after every hit.
- **Ranges that include `i` make the water clamp unnecessary** — `0...i` and `i..<count` both contain `heights[i]`, so the difference can't go negative. Write the ranges as `0..<i` / `i+1..<count` and the clamp comes back.

---

## ⚠️ Common Mistakes

- `import UIKit` instead of `Foundation`
- Reaching for `swapAt`, `sorted`, `max`, `dropFirst` instead of manual implementations
- `for read in 0..<count` instead of a manual `while` — hides the pointer being learned
- Dead guards: `!nums.isEmpty` and `nums.count > 1` when a later condition already covers them
- Bound check placed after the index in a compound condition — must be `j >= 0 && ...`
- `i < j` in a swap helper — blocks reverse-order calls silently
- Naming a function for its side effect instead of its operation
- Missing T/S header and blank **Edge cases:** line
- Extra blank lines immediately inside braces
- Sorting into a copy then indexing the *original* array — shadow with `let nums = nums.sorted()` so only one name exists

---

## 📈 Progress

- [x] Prerequisites
- [x] Patterns (9/9)
- [ ] Problems (3/9)
- [ ] Mock Interview 02
- [ ] Revision
