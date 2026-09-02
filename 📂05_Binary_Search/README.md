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

| # | Pattern | Templates | Feeds |
|---|---------|-----------|-------|
| 01 | Classic Binary Search | `binarySearch` | Q39, Q43 |
| 02 | Boundary Search | `lowerBound`, `upperBound`, `firstOccurrence`, `lastOccurrence` | Q40 |
| 03 | Search On Answer | `minimumValidAnswer`, `maximumValidAnswer` + `ceilDivide`/`maxOf`/`sumOf` | Q44, Q46, Q47 |
| 04 | Rotated Array | `search`, `findMinimum` | Q41, Q42 |
| 05 | Binary Search On Slope | `findPeakElement` | Q45 |
| 06 | Binary Search Matrix | `searchMatrix` | Q43 |

`02_Boundary_Search` holds lower/upper bound plus first/last occurrence (LC 34), all on the closed-interval record-and-narrow shape. A separate upper-bound file was dropped — no Q39–Q47 problem needs "first index strictly greater" on its own, and an unbacked pattern file is one you never revisit.

Three drills that must be explicit, not mentions:

* **Interval must match the job** (01–06) — exact match → closed `low <= high` + `mid ± 1`; boundary/minimum/slope → half-open `low < high` + `high = mid`. Mixing half-open with `mid - 1` skips the answer; mixing closed with `high = mid` loops forever. Two files use closed (01, 06), four use half-open.
* **`ceilDivide(a, b) = (a + b - 1) / b`** (03) — Q44. Integer only. `Double` division plus rounding is a correctness bug at large inputs, not a style preference.
* **Bounds before predicate** (03) — Q46, Q47. Floor is `max(nums)` because no single item can be split; ceiling is `sum(nums)` because one container holds everything. Get these wrong and a correct predicate still fails.

---

## 📖 Problems

| # | Problem | LC | Approach | Complexity |
|---|---------|----|----------|------------|
| Q39 | Binary Search | 704 | Closed interval, return index or -1 | O(log n) / O(1) |
| Q40 | Search Insert Position | 035 | Lower bound, `answer` seeded to `count` | O(log n) / O(1) |
| Q41 | Search In Rotated Sorted Array | 033 | Find the sorted half, test target inside it | O(log n) / O(1) |
| Q42 | Find Minimum In Rotated Array | 153 | Compare `nums[mid]` to `nums[high]`, converge | O(log n) / O(1) |
| Q43 | Search A 2D Matrix | 074 | Virtual 1D, `mid / cols`, `mid % cols` | O(log(m·n)) / O(1) |
| Q44 | Koko Eating Bananas | 875 | Speed range `1…maxPile`, hours predicate with ceil | O(n log m) / O(1) |
| Q45 | Find Peak Element | 162 | Slope test `nums[mid] < nums[mid+1]`, walk uphill | O(log n) / O(1) |
| Q46 | Capacity To Ship Packages | 1011 | Cap range `maxW…sum`, greedy day count | O(n log s) / O(1) |
| Q47 | Split Array Largest Sum | 410 | Same range as Q46, greedy subarray count | O(n log s) / O(1) |

m = max pile, s = sum of the array. The three answer-space problems (Q44, Q46, Q47) are O(n log range), not O(log range) — the predicate walks the whole array on every guess. Stating it as O(log range) in an interview is the tell that the pattern was copied without costing it.

---

## ⚠️ Wrong Tool Per Problem

* **Q39** — a linear scan. Correct and O(n), which is the baseline binary search exists to beat.
* **Q40** — a classic search with an if-chain for "not found". Lower bound returns the insertion point for free; the `answer = count` seed handles past-the-end.
* **Q41** — finding the pivot first, then searching. Two passes; branch on `nums[low] <= nums[mid]` instead. Trap: strict `<` / `>` against `nums[mid]` (already ruled out).
* **Q42** — comparing `nums[mid]` to `nums[low]`. Breaks on an unrotated array (`[11,13,15,17]` returned 15). Compare to `nums[high]`; use `high = mid`, not `mid - 1`.
* **Q43** — two searches (rows, then row). Flatten to one virtual index; divide AND mod by `columns`, not `rows` (the shadow bug).
* **Q44** — linear scan of speeds, or `pile / k` instead of `ceilDivide`. Also the swapped move: feasible → `right = mid - 1`, not `left = mid - 1` (infinite loop).
* **Q45** — scanning for the global max. O(n); the slope test finds a peak in O(log n).
* **Q46** — searching capacity from 1. Floor is `max(weights)` — anything smaller can't hold the heaviest package.
* **Q47** — DP over splits (O(n²·m)). Identical to Q46: binary search the cap, greedy-count parts. Trap: `totalSum += num`, not the running max.

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

Prerequisites 🟡 (D1–D4 done; `safeNext` skipped, `maxOf`/`sumOf`/`ceilDivide` moved into pattern 03) · Patterns 6/6 ✅ · Problems 9/9 ✅ · Revision ☐ · Mock 08 (`mock_08_phase_05`) ☐

**PHASE 05 IN PROGRESS** — problems complete, revision + mock left.

Recurring bug this phase was mechanical, never conceptual: the swapped binary-search move (Q41, Q44) and the seed/init slips (`Int.min`, `totalSum += maxElement`). The algorithm was right every time; the direction and initialisation were the misses.

⬅️ Previous: **Phase 04 — Sliding Window** ✅. The shrink-while-valid vs shrink-while-invalid distinction from Q32 is the same discipline as picking your interval here — the loop shape has to match what you're recording.
➡️ Next: **Phase 06 — Stack & Queue** (Q48–Q56).
