# 📂 Phase 04 — Sliding Window

Q30–Q38. Two Easy, six Medium, one Hard.

Every problem here is a brute force over all subarrays collapsed into one pass. The window carries state — a sum, a frequency map, a deque — and the only question is what happens when the right edge moves in and when the left edge moves out. Get the move rule wrong and the skeleton still runs, silently returning the wrong answer.

---

# 📚 Topics Covered

* Fixed window — enter one, leave one, never recompute
* Variable window — expand always, shrink while invalid
* Shrink-to-minimum — record before shrinking, not after
* Frequency map as window state, with prune-on-zero
* The `matched` counter instead of comparing whole maps
* `maxCount` that never decreases
* Last-index jump map vs. HashSet
* Monotonic deque holding indices, not values

## 📂 Structure

```text
04_Sliding_Window
│
├── README.md
├── Sliding_Window_Prerequisites
│
├── Patterns
│   ├── 01_Fixed_Window
│   ├── 02_Variable_Window
│   ├── 03_Shrink_To_Minimum
│   ├── 04_HashMap_Window
│   ├── 05_HashSet_Window
│   └── 06_Monotonic_Deque
│
└── Problems
    └── Q30_LC003 … Q38_LC239
```

No pattern file without a problem behind it.

---

## 🧩 Patterns

| # | Pattern | Feeds |
|---|---------|-------|
| 01 | Fixed Window | Q33, Q34, Q35, Q38 |
| 02 | Variable Window (expand & shrink) | Q30, Q31, Q36 |
| 03 | Shrink to Minimum | Q32, Q37 |
| 04 | HashMap Window | Q31, Q32, Q33, Q34, Q36 |
| 05 | HashSet Window | Q30 |
| 06 | Monotonic Deque | Q38 |

`05_HashSet_Window` is deliberately thin — Q30's kept optimal is the last-index jump map, not the set. The set version stays because the contrast is what makes the jump map stick.

Three drills that must be explicit, not mentions:

* **`matched` counter** (04) — Q32, Q33, Q34. Without it, map comparison every step makes an O(n) solution O(n·k).
* **`maxCount` never decreases** (04) — Q31. Valid when `length - maxCount <= k`. Never recompute on shrink.
* **`left = max(left, lastIndex + 1)`** (05) — Q30. The jump can only move left forward, never backward.

---

## 📖 Problems

| # | Problem | LC | Approach | Complexity |
|---|---------|----|----------|------------|
| Q30 | Longest Substring Without Repeating | 003 | Last-index map, jump left forward | O(n) / O(k) |
| Q31 | Longest Repeating Character Replacement | 424 | Freq map + non-decreasing maxFreq | O(n) / O(k) |
| Q32 | Minimum Window Substring | 076 | Need map + `formed` counter, shrink while valid | O(n+m) / O(k) |
| Q33 | Permutation in String | 567 | Fixed window of `s1.count`, map comparison | O(n·k) / O(k) |
| Q34 | Find All Anagrams | 438 | Same as Q33, record every valid start | O(n·k) / O(k) |
| Q35 | Max Average Subarray | 643 | Fixed window sum, add-in subtract-out | O(n) / O(1) |
| Q36 | Fruits Into Baskets | 904 | Variable window, at most 2 distinct keys | O(n) / O(k) |
| Q37 | Min Size Subarray Sum | 209 | Running sum, shrink while `sum >= target` | O(n) / O(1) |
| Q38 | Sliding Window Maximum | 239 | Deque of indices, decreasing values | O(n) / O(k) |

k = distinct characters, bounded by the alphabet (≤ 26). O(1) space would need a fixed 26-slot array instead of a dictionary — only Q35 and Q37 avoid maps entirely.

---

## ⚠️ Wrong Tool Per Problem

* **Q30** — a HashSet with a one-step shrink. Correct but O(n) with a redundant inner loop; the jump map skips it.
* **Q31** — recomputing `maxCount` when the window shrinks. Turns O(n) into O(n·26) and isn't needed.
* **Q32** — shrinking while invalid. This problem wants the *minimum*, so you shrink while still valid and record before each shrink.
* **Q33** — sorting both strings, or comparing frequency maps every step. Both work, both are slower than a matched counter.
* **Q34** — rebuilding the window at every index instead of sliding it.
* **Q35** — recomputing the sum per window. O(n·k) when add-in/subtract-out is O(n).
* **Q36** — treating it as "two types" with two variables. It's "at most 2 distinct", which is a map with a size check.
* **Q37** — binary search on the answer (O(n log n)) or prefix sums. The window is O(n) and simpler.
* **Q38** — a heap. O(n log k) and removing the outgoing element is awkward. A monotonic stack is the wrong shape entirely — you need eviction from *both* ends.

---

## 📌 House Rules

* Problem statement, example, constraints, and complexity at the top of every file.
* Brute force + optimal only. Alternatives get named in the notes, not implemented.
* No `reduce`, `map`, `filter`, `stride`, `max`, `min`, `swapAt`, `sorted`, `enumerated`.
* No `?? 0` on dictionary access — explicit `if let / else`.
* No force unwraps, no force casts.
* At most one blank line between logical blocks. Blank line after every print.
* Window size is always `right - left + 1`. State it in the file where it's used.
* Every solution names its shrink rule in one line: shrink-while-invalid or shrink-while-valid.

---

## 📊 Status

Prerequisites ✅ · Patterns 6/6 ✅ · Problems 9/9 ✅ · Revision ✅ · Mock 06 (`mock_06_phase_04`) ✅

**PHASE 04 COMPLETE** — all six cycle steps done.

Revision: 9 rewritten from memory, 5 clean first pass. Four mechanical failures — prune writing 1 instead of nil (Q31), `left += 1` inside the `if let` (Q36), record condition and missing sentinel (Q37), deque eviction order (Q38). Complexity headers wrong on 5 of 9, all understating space where a map was allocated.

⬅️ Previous: **Phase 03 — Strings & Hashing** ✅. The prune-on-decrement idiom from `02_Character_Frequency` is what makes window matching work.
➡️ Next: **Phase 05 — Binary Search** (Q39–Q47).
