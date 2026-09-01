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
| Q39 | Binary Search | 704 | | |
| Q40 | Search Insert Position | 035 | | |
| Q41 | Search In Rotated Sorted Array | 033 | | |
| Q42 | Find Minimum In Rotated Array | 153 | | |
| Q43 | Search A 2D Matrix | 074 | | |
| Q44 | Koko Eating Bananas | 875 | | |
| Q45 | Find Peak Element | 162 | | |
| Q46 | Capacity To Ship Packages | 1011 | | |
| Q47 | Split Array Largest Sum | 410 | | |

The three answer-space problems (Q44, Q46, Q47) are O(n log range), not O(log range) — the predicate walks the whole array on every guess. Stating it as O(log range) in an interview is the tell that the pattern was copied without costing it.

---

## ⚠️ Wrong Tool Per Problem

_Fill in as each problem is solved._

* **Q39** —
* **Q40** —
* **Q41** —
* **Q42** —
* **Q43** —
* **Q44** —
* **Q45** —
* **Q46** —
* **Q47** —

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

Prerequisites 🟡 (D1–D4 done; `safeNext` skipped, `maxOf`/`sumOf`/`ceilDivide` moved into pattern 03) · Patterns 6/6 ✅ · Problems 0/9 ☐ · Revision ☐ · Mock 08 (`mock_08_phase_05`) ☐

**PHASE 05 IN PROGRESS** — patterns complete, problems next.

⬅️ Previous: **Phase 04 — Sliding Window** ✅. The shrink-while-valid vs shrink-while-invalid distinction from Q32 is the same discipline as picking your interval here — the loop shape has to match what you're recording.
➡️ Next: **Phase 06 — Stack & Queue** (Q48–Q56).
