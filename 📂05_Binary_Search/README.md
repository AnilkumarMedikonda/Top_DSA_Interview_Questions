# 📂 Phase 05 — Binary Search

Q39–Q47. Two Easy, six Medium, one Hard.

Every problem here is a linear scan collapsed into a halving. The loop carries a range — index bounds, or a range of candidate answers — and the only question is which half survives the comparison. Get the boundary move wrong and the skeleton still runs, either looping forever or returning the neighbour of the right answer.

---

# 📚 Topics Covered

* Overflow-safe mid — `low + (high - low) / 2`, never `(low + high) / 2`
* Closed interval `low <= high` paired with `mid ± 1`
* Half-open interval `low < high` paired with `high = mid`
* Why `low` is the answer on exit, not `mid`
* Monotonic predicate — the real precondition, not sortedness
* Feasibility check `isOk(candidate) -> Bool` over an answer range
* Picking answer bounds — `max(nums)` as the floor, `sum(nums)` as the ceiling
* One half is always sorted, in a rotated array
* Slope comparison on unsorted input
* Flattening a matrix to a virtual 1D index

## 📂 Structure

```text
05_Binary_Search
│
├── README.md
├── Binary_Search_Prerequisites
│
├── Patterns
│   ├── 01_Classic_Binary_Search
│   ├── 02_Boundary_Search
│   ├── 03_Search_On_Answer
│   ├── 04_Rotated_Array
│   ├── 05_Binary_Search_On_Slope
│   └── 06_Binary_Search_Matrix
│
└── Problems
    └── Q39_LC704 … Q47_LC410
```

No pattern file without a problem behind it.

---

## 🧩 Patterns

| # | Pattern | Feeds |
|---|---------|-------|
| 01 | Classic Binary Search | Q39, Q41, Q43 |
| 02 | Boundary Search | Q40, Q42 |
| 03 | Search On Answer | Q44, Q46, Q47 |
| 04 | Rotated Array | Q41, Q42 |
| 05 | Binary Search On Slope | Q45 |
| 06 | Binary Search Matrix | Q43 |

`02_Boundary_Search` holds lower bound and upper bound as two drills in one file. A separate `03_Upper_Bound` was dropped — no problem in Q39–Q47 needs "first index strictly greater", and an unbacked pattern file is a file you never revisit.

Three drills that must be explicit, not mentions:

* **`high = mid`, never `mid - 1`** (02, 03) — Q40, Q44, Q46, Q47. Paired with `low < high`. Mixing half-open bounds with `mid - 1` skips the answer; mixing `low <= high` with `high = mid` loops forever.
* **`ceilDivide(a, b) = (a + b - 1) / b`** (03) — Q44. Integer only. `Double` division plus rounding is a correctness bug at large inputs, not a style preference.
* **Bounds before predicate** (03) — Q46, Q47. Floor is `max(nums)` because no single item can be split; ceiling is `sum(nums)` because one container holds everything. Get these wrong and a correct predicate still fails.

---

## 📖 Problems

| # | Problem | LC | Approach | Complexity |
|---|---------|----|----------|------------|
| Q39 | Binary Search | 704 | Closed interval, return index or -1 | O(log n) / O(1) |
| Q40 | Search Insert Position | 035 | Half-open lower bound, `low` on exit | O(log n) / O(1) |
| Q41 | Search In Rotated Sorted Array | 033 | Identify sorted half, test target inside it | O(log n) / O(1) |
| Q42 | Find Minimum In Rotated Array | 153 | Compare `nums[mid]` to `nums[high]`, no target | O(log n) / O(1) |
| Q43 | Search A 2D Matrix | 074 | Virtual 1D, `row = mid / cols`, `col = mid % cols` | O(log(m·n)) / O(1) |
| Q44 | Koko Eating Bananas | 875 | Answer range `1…maxPile`, hours predicate with ceil | O(n log m) / O(1) |
| Q45 | Find Peak Element | 162 | Slope test `nums[mid] < nums[mid+1]`, walk uphill | O(log n) / O(1) |
| Q46 | Capacity To Ship Packages | 1011 | Answer range `maxWeight…sum`, greedy day count | O(n log s) / O(1) |
| Q47 | Split Array Largest Sum | 410 | Same range as Q46, greedy subarray count | O(n log s) / O(1) |

m = max pile size, s = sum of the array. The three answer-space problems are O(n log range), not O(log range) — the predicate walks the whole array on every guess, and stating it as O(log range) in an interview is the tell that you copied the pattern without understanding the cost.

---

## ⚠️ Wrong Tool Per Problem

* **Q39** — `firstIndex(of:)`, or a linear scan. Correct and O(n), which defeats the exercise.
* **Q40** — special-casing "not found" with an if-chain after a classic search. The half-open template returns the insertion point for free.
* **Q41** — finding the pivot first, then searching the correct half. Two passes where one works, and the pivot search is the harder half of Q42.
* **Q42** — comparing `nums[mid]` to `nums[low]`. Breaks on an unrotated array. Compare to `nums[high]`.
* **Q43** — binary search the rows, then binary search the row. Works, but two searches where the flattened index is one.
* **Q44** — linear scan of speeds from 1 upward. O(n·m), times out. Also `Double` division instead of integer ceil.
* **Q45** — scanning for the global maximum. O(n) and the problem explicitly wants log.
* **Q46** — searching from capacity 1. Anything below `max(weights)` is infeasible by definition, so the floor is `max`.
* **Q47** — DP over splits. O(n²·k) and correct, but the binary search on the answer is O(n log s) and the interviewer is asking for it by name.

---

## 📌 House Rules

* Problem statement, example, constraints, and complexity at the top of every file.
* Brute force + optimal only. Alternatives get named in the notes, not implemented.
* No `reduce`, `map`, `filter`, `stride`, `max`, `min`, `sorted`, `enumerated`.
* No `?? 0` on dictionary access — explicit `if let / else`.
* No force unwraps, no force casts.
* At most one blank line between logical blocks. Blank line after every print.
* `mid = low + (high - low) / 2` in every file, without exception.
* Every solution names its interval in one line: closed `low <= high` or half-open `low < high`.

---

## 📊 Status

Prerequisites ☐ · Patterns 0/6 ☐ · Problems 0/9 ☐ · Revision ☐ · Mock 07 (`mock_07_phase_05`) ☐

**PHASE 05 IN PROGRESS** — target 15 hrs across Days 13–15.

⬅️ Previous: **Phase 04 — Sliding Window** ✅. The shrink-while-valid vs shrink-while-invalid distinction from Q32 is the same discipline as picking your interval here — the loop shape has to match what you're recording.
➡️ Next: **Phase 06** (Q48 onwards).
