# 🚀 Top DSA Interview Questions — Swift

A curated collection of **85 interview-focused Data Structures & Algorithms problems** solved in **Swift**, organized by **9 core interview patterns**.

This repository is built for **Senior iOS Engineer interview preparation**, focusing on **pattern recognition**, **clean Swift implementations**, **interview explanations**, and **mock interview practice**.

> **Goal:** Learn patterns, explain solutions like an interviewer, and build interview-ready problem-solving skills.

📅 **Started:** August 16, 2026

---

# 🏆 Features

- ✅ 85 carefully selected interview questions
- ✅ Brute force where it teaches something — named in the header otherwise
- ✅ Pure Swift implementations
- ✅ Interview-focused explanations
- ✅ Time & Space Complexity with reasoning
- ✅ Edge cases covered
- ✅ Pattern-based learning
- ✅ Mock interview preparation
- ✅ Senior iOS Engineer interview focused

---

# 📊 Progress

**Problems Solved:** **85 / 85**

**Mock Sessions Passed:** **9 / 12**

**Full Revision:** **47 / 85** rewritten · 36 / 47 clean first pass (77%)

**Current Focus:** Full revision pass — Phase 06, Q48–Q56

---

# 🗺️ Roadmap

| Phase | Topic | Questions | Progress | Mock | Status |
|------|-------|----------:|---------:|------|:------:|
| 01 | Arrays | Q01–Q10 | **10 / 10** | Mock 01 | ✅ |
| 02 | Two Pointers | Q11–Q19 | **9 / 9** | Mock 02 | ✅ |
| 03 | Strings & Hashing | Q20–Q29 | **10 / 10** | Mock 03 | ✅ |
| 04 | Sliding Window | Q30–Q38 | **9 / 9** | Mock 04 | ✅ |
| 05 | Binary Search | Q39–Q47 | **9 / 9** | Mock 05 | ✅ |
| 06 | Stack & Queue | Q48–Q56 | **9 / 9** | Mock 06 | ✅ |
| 07 | Linked List | Q57–Q65 | **9 / 9** | Mock 07 | ✅ |
| 08 | Trees & BST | Q66–Q74 | **9 / 9** | Mock 08 | ✅ |
| 09 | Advanced Patterns | Q75–Q85 | **11 / 11** | Mock 09 | ✅ |

All nine phases complete. Revision status tracked separately in `Full_Revision/README.md`.

---

# 🧠 Patterns Covered

- Arrays
- Two Pointers
- Strings & Hashing
- Sliding Window
- Binary Search
- Stack & Queue
- Linked List
- Trees & Binary Search Trees
- Advanced Interview Patterns

---

# 📌 House Rules

- **Swift only.**
- **No shortcuts while learning.** Manual loops wherever possible:
  - No `reduce`, `map`, `filter`, `stride`, `split`, `reversed`, `enumerated`
    (`for _ in 0..<n` is fine for a plain repeat count)
  - No `sorted()`, `abs()` — `swapAt`, `min()` and `max()` are accepted
  - No `Int(String)`, `isNumber`, `wholeNumberValue`
    (`Array(String)` and `String([Character])` are permitted in Q80, where the
    transformation is character-wise and the lookup is word-wise)
  - No nil-coalescing (`?? 0`) — explicit `if let / else`
  - No force unwraps, no force casts
- **Brute force where it teaches something.** Baselines that use the same data
  structure get written. Ones that convert to a different structure get named in
  the header and not implemented. Where the naive approach is *wrong* rather than
  slow, the file states "none" and says why. Phases 08 and 09 are optimal-only:
  tree traversal is O(n) either way, so a brute force adds nothing — the
  exception is the exponential naive versions in Phase 09's backtracking and DP
  problems, where the repeated work is the whole reason memoization exists.
- Shared helpers live in the phase's `Sources/` folder, never pasted per file.
- Never name a local after a function used in the same scope — `maximum`, not `max`.
- Declare nested helper functions before the loop that calls them.
- **Test prints:** `print("\n========== Q## - Problem Name ==========")` per problem, then one print per case with the expected answer as an inline comment. Full_Revision files use the three-line boxed header instead — see that folder's README.
- Every solution includes interview discussion.
- Every problem includes complexity analysis with reasoning.
- Edge cases are documented.
- **No pattern file without a problem behind it.** A pattern that no question in the phase actually needs does not get a file.
- A phase is complete only after passing its mock interview.

---

# 📚 Learning Approach

For every problem:

1. Read and understand the problem.
2. Dry run with sample input.
3. Write the brute-force solution.
4. Optimize the solution.
5. Identify the underlying pattern.
6. Explain Time & Space Complexity.
7. Handle edge cases.
8. Name the wrong-tool trap — which pattern *looks* right here but answers a different question.
9. Explain the solution aloud as if in a real interview.

---

# 📂 Repository Structure

```text
Top_DSA_Interview_Questions/
│
├── README.md
│
├── 01_Arrays/
├── 02_Two_Pointers/
├── 03_Strings_And_Hashing/
├── 04_Sliding_Window/
├── 05_Binary_Search/
├── 06_Stack_And_Queue/
├── 07_Linked_List/
├── 08_Trees_And_BST/
├── 09_Advanced_Patterns/
│
├── Full_Revision/
├── Sorting_Algorithms/
├── Cheat_Sheets/
├── Mock_Sessions/
├── Company_Wise/
├── Interview_Experiences/
└── Resources/
```

---

# 📁 Each Phase Contains

```text
0X_Phase_Name/
│
├── README.md                    — phase map, pattern table, problem→pattern table
├── Phase_Name_Prerequisites     — raw mechanics drilled before any pattern
├── Phase_0X_Revision            — blind rewrite of every optimal
│
├── Sources/                     — shared helpers, compiled once per phase
│   └── Helpers.swift
│
├── Patterns/                    — each pattern written from scratch, before solving
│   ├── 01_Pattern_Name
│   └── ...
│
└── Problems/
    ├── Q##_LC###_Problem_Name
    └── ...
```

---

# 📝 Every Problem Includes

- Problem Statement
- Examples
- Constraints
- Optimal Solution
- Pattern Used
- Time Complexity
- Space Complexity
- Edge Cases
- Interview Notes

---

# 🎯 Mock Interview Plan

One mock per phase, in phase order, plus three at the end.

| Mock | Covers | Status |
|------|--------|:------:|
| Mock 01 | Phase 01 — Arrays, Q01–Q10 | ✅ |
| Mock 02 | Phase 02 — Two Pointers, Q11–Q19 | ✅ |
| Mock 03 | Phase 03 — Strings & Hashing, Q20–Q29 | ✅ |
| Mock 04 | Phase 04 — Sliding Window, Q30–Q38 | ✅ |
| Mock 05 | Phase 05 — Binary Search, Q39–Q47 | ✅ |
| Mock 06 | Phase 06 — Stack & Queue, Q48–Q56 | ✅ |
| Mock 07 | Phase 07 — Linked List, Q57–Q65 | ✅ |
| Mock 08 | Phase 08 — Trees & BST, Q66–Q74 | ✅ |
| Mock 09 | Phase 09 — Advanced Patterns, Q75–Q85 | ✅ |
| Mock 10 | Mixed DSA | ☐ |
| Mock 11 | Company Style | ☐ |
| Mock 12 | Final Assessment | ☐ |

---

# 🎯 Current Progress

## ✅ Phase 01 — Arrays (Complete)

- ✅ Q01 — Two Sum (LC001)
- ✅ Q02 — Best Time to Buy and Sell Stock (LC121)
- ✅ Q03 — Contains Duplicate (LC217)
- ✅ Q04 — Maximum Subarray (LC053)
- ✅ Q05 — Move Zeroes (LC283)
- ✅ Q06 — Merge Sorted Array (LC088)
- ✅ Q07 — Remove Duplicates from Sorted Array (LC026)
- ✅ Q08 — Majority Element (LC169)
- ✅ Q09 — Missing Number (LC268)
- ✅ Q10 — Product of Array Except Self (LC238)

Mock 01 passed.

## ✅ Phase 02 — Two Pointers (Complete)

- ✅ Q11 — Container With Most Water (LC011)
- ✅ Q12 — Three Sum (LC015)
- ✅ Q13 — Trapping Rain Water (LC042)
- ✅ Q14 — Squares of a Sorted Array (LC977)
- ✅ Q15 — Sort Colors (LC075)
- ✅ Q16 — Next Permutation (LC031)
- ✅ Q17 — Rotate Array (LC189)
- ✅ Q18 — Merge Intervals (LC056)
- ✅ Q19 — First Missing Positive (LC041)

Mock 02 passed.

## ✅ Phase 03 — Strings & Hashing (Complete)

### Patterns — 9 / 9

- ✅ 01_HashMap — Q21, Q25, Q27, Q28
- ✅ 02_Character_Frequency — Q20, Q25, Q26, Q29
- ✅ 03_String_Traversal — foundation for all ten
- ✅ 04_Two_Pointers_On_Strings — Q22
- ✅ 05_Word_Splitting — Q24, Q28
- ✅ 06_Vertical_Scanning — Q23
- ✅ 07_Frequency_Signature — Q21
- ✅ 08_Bucket_By_Frequency — Q25
- ✅ 09_Two_Map_Bijection — Q27, Q28

### Problems — 10 / 10

- ✅ Q20 — Valid Anagram (LC242)
- ✅ Q21 — Group Anagrams (LC049)
- ✅ Q22 — Valid Palindrome (LC125)
- ✅ Q23 — Longest Common Prefix (LC014)
- ✅ Q24 — Reverse Words in a String (LC151)
- ✅ Q25 — Top K Frequent Elements (LC347)
- ✅ Q26 — Ransom Note (LC383)
- ✅ Q27 — Isomorphic Strings (LC205)
- ✅ Q28 — Word Pattern (LC290)
- ✅ Q29 — First Unique Character in a String (LC387)

Revision done. Mock 03 passed.

## ✅ Phase 04 — Sliding Window (Complete)

### Prerequisites — ✅

10 mechanics drills: character conversion, max/min, range sum, window size, increment, decrement with prune-at-zero, frequency map, map equality, distinct count, deque operations.

### Patterns — 6 / 6

- ✅ 01_Fixed_Window — Q33, Q34, Q35, Q38
- ✅ 02_Variable_Window — Q30, Q31, Q36
- ✅ 03_Shrink_To_Minimum — Q32, Q37
- ✅ 04_HashMap_Window — Q31, Q32, Q33, Q34, Q36
- ✅ 05_HashSet_Window — Q30
- ✅ 06_Monotonic_Deque — Q38

### Problems — 9 / 9

- ✅ Q30 — Longest Substring Without Repeating Characters (LC003)
- ✅ Q31 — Longest Repeating Character Replacement (LC424)
- ✅ Q32 — Minimum Window Substring (LC076)
- ✅ Q33 — Permutation in String (LC567)
- ✅ Q34 — Find All Anagrams in a String (LC438)
- ✅ Q35 — Maximum Average Subarray I (LC643)
- ✅ Q36 — Fruit Into Baskets (LC904)
- ✅ Q37 — Minimum Size Subarray Sum (LC209)
- ✅ Q38 — Sliding Window Maximum (LC239)

Revision done — all 9 rewritten from memory, all eventually correct. Mock 04 passed.

## ✅ Phase 05 — Binary Search (Complete)

### Prerequisites — ✅

Drills D1–D4: overflow-safe mid, isSorted, linearSearch (the O(n) baseline), halvingCount (the log n proof). `maxOf` / `sumOf` / `ceilDivide` live inside pattern 03 where the answer-space problems use them.

### Patterns — 6 / 6

- ✅ 01_Classic_Binary_Search — Q39, Q43
- ✅ 02_Boundary_Search — Q40 (lower/upper bound + first/last occurrence)
- ✅ 03_Search_On_Answer — Q44, Q46, Q47
- ✅ 04_Rotated_Array — Q41, Q42 (search + find minimum)
- ✅ 05_Binary_Search_On_Slope — Q45
- ✅ 06_Binary_Search_Matrix — Q43

### Problems — 9 / 9

- ✅ Q39 — Binary Search (LC704)
- ✅ Q40 — Search Insert Position (LC035)
- ✅ Q41 — Search in Rotated Sorted Array (LC033)
- ✅ Q42 — Find Minimum in Rotated Sorted Array (LC153)
- ✅ Q43 — Search a 2D Matrix (LC074)
- ✅ Q44 — Koko Eating Bananas (LC875)
- ✅ Q45 — Find Peak Element (LC162)
- ✅ Q46 — Capacity to Ship Packages Within D Days (LC1011)
- ✅ Q47 — Split Array Largest Sum (LC410)

Revision done — all 9 optimals rewritten from memory, 9/9 recalled correct. Mock 05 passed.

## ✅ Phase 06 — Stack & Queue (Complete)

### Prerequisites — ✅

5 mechanics drills: generic Stack, head-index Queue with amortised O(1) dequeue, `charsOf` / `isDigit`, `charToDigit` / `stringToInt` with sign handling, `repeatString`.

### Patterns — 6 / 6

- ✅ 01_Monotonic_Stack — Q50, Q54, Q56
- ✅ 02_Parentheses_Matching — Q48, Q52
- ✅ 03_Min_Stack — Q49
- ✅ 04_Stack_Simulation — Q51, Q52, Q54
- ✅ 05_Two_Stack_Queue — Q53
- ✅ 06_HashMap_Doubly_Linked_List — Q55

### Problems — 9 / 9

- ✅ Q48 — Valid Parentheses (LC020)
- ✅ Q49 — Min Stack (LC155)
- ✅ Q50 — Daily Temperatures (LC739)
- ✅ Q51 — Evaluate Reverse Polish Notation (LC150)
- ✅ Q52 — Decode String (LC394)
- ✅ Q53 — Implement Queue Using Stacks (LC232)
- ✅ Q54 — Asteroid Collision (LC735)
- ✅ Q55 — LRU Cache (LC146)
- ✅ Q56 — Next Greater Element I (LC496)

### Revision — ✅ (9 of 9) · Mock 06 — ✅

All nine rewritten blind, all eventually correct. The one regression was Q48's
missing `else` on the mismatch branch — every test still passed because the
unpopped opener failed the final `isEmpty` check.

**Q55 LRU Cache** — revision done: blind rewrite clean on the first pass,
HashMap plus doubly linked list, dummy head and tail sentinels, and eviction
removing from both the list and the dictionary.

---

## ✅ Phase 07 — Linked List (Complete)

### Prerequisites — ✅

5 mechanics drills: `ListNode` + create/print, `countNodes` / `nodeAt`,
insert and delete by position and by node, identity via `===`, split-and-nil.

### Patterns — 7 / 7

- ✅ 01_Reverse_Linked_List — Q57, Q64, Q65
- ✅ 02_Dummy_Node — Q58, Q61, Q62
- ✅ 03_Slow_Fast_Pointer — Q59, Q60, Q64
- ✅ 04_Fixed_Gap_Pointer — Q62
- ✅ 05_Merge_Two_Lists — Q58, Q61, Q64
- ✅ 06_K_Group_Reverse — Q65
- ✅ 07_Random_Pointer_Clone — Q63

### Problems — 9 / 9

- ✅ Q57 — Reverse Linked List (LC206)
- ✅ Q58 — Merge Two Sorted Lists (LC021)
- ✅ Q59 — Linked List Cycle (LC141)
- ✅ Q60 — Middle Of Linked List (LC876)
- ✅ Q61 — Add Two Numbers (LC002)
- ✅ Q62 — Remove Nth Node From End (LC019)
- ✅ Q63 — Copy List With Random Pointer (LC138)
- ✅ Q64 — Reorder List (LC143)
- ✅ Q65 — Reverse Nodes In K Group (LC025)

### Revision — ✅ (9 of 9) · Mock 07 — ✅

Blind rewrite of all nine, all eventually correct. Four needed a second pass,
plus two shared helpers — and every miss was an **ordering** error, not a
misremembered algorithm.

| # | Problem | The miss |
|---|---------|----------|
| Q62 | Remove Nth From End | `slowNode.next = victim` instead of `victim.next` — assigned the victim to itself, list came back unchanged |
| Q63 | Copy Random Pointer | Pass two read `copy.next` / `copy.random` instead of the original's, so it wired nothing |
| Q64 | Reorder List | Nil-ed `middle.next` before reading it, so the second half was always nil; weave assignments crossed |
| Q65 | K-Group Reverse | `groupPrev` anchored on `head` instead of `dummy`, leaving the first group unreversed |
| — | `createCycle` | Dropped the line saving the cycle node — no test list ever had a cycle, so Q59 was passing against nothing |
| — | `middleNode` | Guarded `slow` instead of `fast` |

The question that catches all six: **at the moment I read this pointer, has
anything already changed it?**

Mock 07 covered Q57–Q65.

**PHASE 07 COMPLETE** — all six cycle steps done, no carry-over.

---

## ✅ Phase 08 — Trees & BST (Complete)

### Prerequisites — ✅

`TreeNode` + `buildTree` / `printTree`. Four of five planned drills cut — each
was already covered by a pattern file.

### Patterns — 7 / 7

- ✅ 01_DFS_Preorder — Q67, Q68, Q70
- ✅ 02_DFS_Inorder — Q70, Q73
- ✅ 03_DFS_Postorder — Q66
- ✅ 04_BFS_Level_Order — Q69
- ✅ 05_Iterative_DFS — Q73
- ✅ 06_BST_Property_Walk — Q70, Q72, Q73
- ✅ 07_Tree_DP — Q71, Q74

### Problems — 9 / 9

- ✅ Q66 — Maximum Depth Of Binary Tree (LC104)
- ✅ Q67 — Same Tree (LC100)
- ✅ Q68 — Invert Binary Tree (LC226)
- ✅ Q69 — Binary Tree Level Order Traversal (LC102)
- ✅ Q70 — Validate Binary Search Tree (LC098)
- ✅ Q71 — Diameter Of Binary Tree (LC543)
- ✅ Q72 — Lowest Common Ancestor Of A BST (LC235)
- ✅ Q73 — Kth Smallest Element In A BST (LC230)
- ✅ Q74 — Binary Tree Maximum Path Sum (LC124)

### Revision — ✅ (9 of 9) · Mock 08 — ✅

Blind rewrite of all nine, all eventually correct. Three needed a second pass —
and every miss was a **boundary** condition, not a misremembered algorithm.

| # | Problem | The miss |
|---|---------|----------|
| Q70 | Validate BST | Comparison written from the bound's side (`min > val`) instead of the node's (`val <= min`), dropping the equality — duplicates passed as valid |
| Q73 | Kth Smallest | No `k > 0` in the guard, so the traversal never stopped. Every answer correct, complexity O(n) not O(h + k) — second time this exact miss |
| Q74 | Max Path Sum | Seeded at 0 instead of `Int.min`; an all-negative tree returned 0, which is not a path |

The question that catches all three: **what does this need to do at the
boundary — empty, equal, negative, or already-found?**

Mock 08 covered Q66–Q74.

**PHASE 08 COMPLETE** — all six cycle steps done, no carry-over.

---

## ✅ Phase 09 — Advanced Patterns (Complete)

### Prerequisites — ✅

5 drills: BFS queue with head index, grid bounds + four-direction neighbours,
visited tracking (`Set` for graphs, 2D `[[Bool]]` for grids), adjacency list
from edge pairs, indegree array.

### Patterns — 7 / 7

- ✅ 01_Heap — Q75, Q76
- ✅ 02_Graph_DFS — Q77
- ✅ 03_Graph_BFS — Q78, Q80
- ✅ 04_Topological_Sort — Q79
- ✅ 05_Union_Find — Q81
- ✅ 06_Backtracking — Q82, Q83
- ✅ 07_Dynamic_Programming — Q84, Q85

Ten proposed, cut to seven: `Trie`, `Greedy` and `Binary_Search_On_Answer`
dropped — no Q75–Q85 problem behind any of them.

### Problems — 11 / 11

- ✅ Q75 — Kth Largest Element In An Array (LC215)
- ✅ Q76 — Merge K Sorted Lists (LC023)
- ✅ Q77 — Number Of Islands (LC200)
- ✅ Q78 — Rotting Oranges (LC994)
- ✅ Q79 — Course Schedule (LC207)
- ✅ Q80 — Word Ladder (LC127)
- ✅ Q81 — Redundant Connection (LC684)
- ✅ Q82 — Subsets (LC078)
- ✅ Q83 — Combination Sum (LC039)
- ✅ Q84 — House Robber (LC198)
- ✅ Q85 — Longest Increasing Subsequence (LC300)

### Revision — ✅ (11 of 11) · Mock 09 — ✅

Blind rewrite of all eleven, all eventually correct. Five needed a second pass,
and none of the five was a forgotten algorithm.

| # | Problem | The miss |
|---|---------|----------|
| Q75 | Kth Largest | `remove()` lost its empty guard — traps on `heap[0]`. No test calls it that way |
| Q80 | Word Ladder | `return steps` instead of `steps + 1` — endWord sits one level deeper than the level being drained |
| Q82 | Subsets | `dfs` never called, and the loop ran `0..<start` instead of `start..<count` |
| Q84 | House Robber | `prev1` and `prev2` swapped. The two swaps cancel, so every answer was right while the code said "rob adjacent houses" |
| Q85 | LIS | `var max` shadowed the `max` function. Compile error |

All five corrected on the same sitting.

Mock 09 covered Q75–Q85. First attempt 8/11 — Q77 and Q85 did not compile, Q83
returned duplicate orderings. All three were repeats of misses already caught
once, and two were compiler errors Xcode flags in under a second. Re-run passed.

Across all eleven rewrites, three mechanical habits slipped every time: `var`
where `let` belongs, method-name typos, and `private` dropped from helpers. The
algorithms came back; the discipline did not.

**PHASE 09 COMPLETE** — all six cycle steps done.

Three phases of revision data now read: Phase 07 **ordering**, Phase 08
**boundary**, Phase 09 **mechanism**. None was ever a forgotten algorithm.

---

# 🔁 Full Revision — In Progress

Second pass over all 85, rewritten blind from an empty file, oldest phase
first. One playground per phase, problems stacked as blocks. Full rules and
per-problem checklist in `Full_Revision/README.md`.

| Phase | Questions | Rewritten | Clean first pass |
|-------|-----------|----------:|-----------------:|
| 01 Arrays | Q01–Q10 | 10 / 10 | 8 / 10 |
| 02 Two Pointers | Q11–Q19 | 9 / 9 | 5 / 9 |
| 03 Strings & Hashing | Q20–Q29 | 10 / 10 | 8 / 10 |
| 04 Sliding Window | Q30–Q38 | 9 / 9 | 6 / 9 |
| 05 Binary Search | Q39–Q47 | 9 / 9 | 9 / 9 |
| 06 Stack & Queue | Q48–Q56 | in progress | — |

**47 / 85 · 36 / 47 clean (77%)**

Phases 01–02 missed on **index mechanics** — Kadane's reset comparison, prefix
`result[i]` vs `result[i-1]`, swap-before-increment, `k % n` and its reverse
bounds, `left <= right`, seeding from the unsorted array. Phase 03 missed on
**guard clauses** — an exhausted count that did not return false, and a
single-element array rejected by a `count > 1` check. Phase 04 missed on
**counters and sentinels** — an `Int.min` seed returning -1 on empty input, a
window sized by distinct count instead of length, and a type counter
decremented on every shrink instead of only at zero. Phase 05 missed on
**nothing** — 9/9 on the first attempt, including the Hard.

The right algorithm was picked 47 out of 47 times.

The right algorithm was picked 38 out of 38 times.

That makes four phases of revision data plus this pass: Phase 07 **ordering**,
Phase 08 **boundary**, Phase 09 **mechanism**, Full Revision **index, guards
and counters**. None was ever a forgotten algorithm.

Branch: `full_revision`.

---

# 🔜 What Comes Next

In order:

**1. Full revision pass** — in progress, Phase 06 next. Weak areas from the
mocks are being caught inside this pass rather than separately.

**2. Every mock re-run, phase by phase.** `Mock_Reruns/` on branch
`mock_reruns`.

**3. Sorting algorithms.** Merge, quick and heap sort — `Sorting_Algorithms/`
at the repo root, branch `sorting_algorithms`. Assembled from pieces already in
the repo.

---

# 🕳️ Known Gaps

Sorting algorithms are the one thing the 85 never make you write. No new
problems are being added for this — the pieces already exist in the repo and
just need assembling.

| Algorithm | What it needs | Already in the repo |
|-----------|---------------|---------------------|
| **Merge sort** | Divide, recurse, merge two sorted halves | The merge step is Q58 Merge Two Sorted Lists and Q76 Merge K Sorted Lists |
| **Heap sort** | Build the heap, then extract repeatedly | The heap is Phase 09's pattern 01, written for Q75 and Q76 |
| **Quick sort** | Lomuto partition, then recurse on both sides | The partition is Q15 Sort Colors — the same three-way swap walk |

Merge sort is the one worth being able to write cold. Quick sort is the one
worth being able to explain: average O(n log n), worst O(n²), why the pivot
choice decides which, and why it is in-place but unstable.

---

# 💡 Repository Philosophy

This repository focuses on **learning patterns instead of memorizing solutions**.

For every problem:

- Understand **why** the brute-force solution works.
- Learn the **pattern** that improves it.
- Implement the **optimal solution** confidently.
- Practice explaining the solution as you would during an interview.

---

# 🚀 Related Repositories

| Repository | Description |
|------------|-------------|
| **[DSA-Logic-and-Interview-Prep](https://github.com/AnilkumarMedikonda/DSA-Logic-and-Interview-Prep)** | 246 problems across 21 phases covering the complete DSA learning journey. |
| **[iOS-Architecture-Patterns](https://github.com/AnilkumarMedikonda/iOS-Architecture-Patterns)** | Swift, UIKit, and SwiftUI architecture patterns for iOS development. |

---

# 👨‍💻 Author

**Medikonda Anil Kumar**

Senior iOS Engineer

### Skills

- Swift
- UIKit
- SwiftUI
- Objective-C
- iOS Architecture
- Data Structures & Algorithms

### Connect

- GitHub: https://github.com/AnilkumarMedikonda
- LinkedIn: https://www.linkedin.com/in/anil-kumar-118524283/
- Email: anil.medikonda.ios@gmail.com

---

# 📄 License

MIT License.

All solutions and explanations are written by me for educational purposes.

Problem statements are paraphrased. Original problems belong to their respective platforms (e.g., LeetCode).
