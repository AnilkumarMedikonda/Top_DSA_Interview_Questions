# 🚀 Top DSA Interview Questions — Swift

A curated collection of **85 interview-focused Data Structures & Algorithms problems** solved in **Swift**, organized by **9 core interview patterns**.

This repository is built for **Senior iOS Engineer interview preparation**, focusing on **pattern recognition**, **clean Swift implementations**, **interview explanations**, and **mock interview practice**.

> **Goal:** Learn patterns, explain solutions like an interviewer, and build interview-ready problem-solving skills.

📅 **Started:** August 16, 2026

---

# 🏆 Features

- ✅ 85 carefully selected interview questions
- ✅ Brute Force → Optimal, both kept in the file where a brute force exists
- ✅ Pure Swift implementations
- ✅ Interview-focused explanations
- ✅ Time & Space Complexity with reasoning
- ✅ Edge cases covered
- ✅ Pattern-based learning
- ✅ Mock interview preparation
- ✅ Senior iOS Engineer interview focused

---

# 📊 Progress

**Problems Solved:** **65 / 85**

**Mock Sessions Passed:** **6 / 15**

**Current Focus:** Phase 07 — Linked List, revision then Mock 10

---

# 🗺️ Roadmap

| Phase | Topic | Questions | Progress | Mock | Status |
|------|-------|----------:|---------:|------|:------:|
| 01 | Arrays | Q01–Q10 | **10 / 10** | Mock 01 | ✅ |
| 02 | Two Pointers | Q11–Q19 | **9 / 9** | Mock 02 | ✅ |
| 03 | Strings & Hashing | Q20–Q29 | **10 / 10** | Mock 04 | ✅ |
| 04 | Sliding Window | Q30–Q38 | **9 / 9** | Mock 06 | ✅ |
| 05 | Binary Search | Q39–Q47 | **9 / 9** | Mock 08 | ✅ |
| 06 | Stack & Queue | Q48–Q56 | **9 / 9** | Mock 09 | ✅ |
| 07 | Linked List | Q57–Q65 | **9 / 9** | Mock 10 | 🔄 |
| 08 | Trees & BST | Q66–Q74 | 0 / 9 | Mock 11 | ☐ |
| 09 | Advanced Patterns | Q75–Q85 | 0 / 11 | Mock 12 | ☐ |

A phase stays 🔄 until its mock is passed — problems solved is not the same as phase complete.

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
  - No `swapAt`, `max()`, `min()`, `sorted()`, `abs()`
  - No `Int(String)`, `Array(String)`, `isNumber`, `wholeNumberValue`
  - No nil-coalescing (`?? 0`) — explicit `if let / else`
  - No force unwraps, no force casts
- **Brute force where one exists naturally.** Pointer-based baselines get written (two-pass count in Q60, Q62). Array-based ones get named in the header and not implemented — dumping a list into an array is a different data structure, not a different algorithm. Where the naive approach is *wrong* rather than slow, the file states "none" and says why (Q61: `Int` overflows at 100 digits).
- Shared helpers live in the phase's `Sources/` folder, never pasted per file.
- **Test prints:** `print("\n========== Q## - Problem Name ==========")` per problem, then one print per case with the expected answer as an inline comment.
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
- Brute Force Solution (where one exists naturally)
- Optimal Solution
- Pattern Used
- Time Complexity
- Space Complexity
- Edge Cases
- Interview Notes

---

# 🎯 Mock Interview Plan

Each mock is cumulative. New mocks also include questions from previous phases.

| Mock | Covers | Status |
|------|--------|:------:|
| Mock 01 | Arrays | ✅ |
| Mock 02 | Two Pointers | ✅ |
| Mock 03 | Arrays + Two Pointers | ☐ |
| Mock 04 | Strings & Hashing | ✅ |
| Mock 05 | Phases 01–03 | ☐ |
| Mock 06 | Sliding Window | ✅ |
| Mock 07 | Phases 01–04 | ☐ |
| Mock 08 | Binary Search | ✅ |
| Mock 09 | Stack & Queue — Q48–Q54, Q56 | ✅ |
| Mock 10 | Linked List + Q55 LRU Cache | ☐ |
| Mock 11 | Trees & BST | ☐ |
| Mock 12 | Advanced Patterns | ☐ |
| Mock 13 | Mixed DSA | ☐ |
| Mock 14 | Company Style | ☐ |
| Mock 15 | Final Assessment | ☐ |

⚠️ Mock 03 (Q01–Q19 cumulative) drawn but not run. Mock 05 (Phases 01–03) due. Both cumulative — outstanding out of sequence.

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

Revision done. Mock 04 passed.

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

Revision done — 9 rewritten from memory, 5 clean first pass. Mock 06 passed.

## ✅ Phase 05 — Binary Search (Complete)

### Prerequisites — 🟡

Drills D1–D4 done: overflow-safe mid, isSorted, linearSearch (the O(n) baseline), halvingCount (the log n proof). `maxOf` / `sumOf` / `ceilDivide` live inside pattern 03 where the answer-space problems use them.

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

Revision done — all 9 optimals rewritten from memory, 9/9 recalled correct. Mock 08 passed.

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

Cut before writing: `Stack_Basics` and `Queue_Basics` (duplicate Prerequisites), `Previous_Greater_Element` (no problem behind it). `Next_Greater_Element` merged into `01_Monotonic_Stack` — NGE *is* the template. `06` added because Q55 was otherwise uncovered.

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

### Revision — ✅ (8 of 9) · Mock 09 — ✅

Covered Q48–Q54 and Q56. 7 of 8 recalled correct on the blind rewrite; the one
regression was Q48's missing `else` on the mismatch branch — every test still
passed because the unpopped opener failed the final `isEmpty` check.

**Q55 LRU Cache is the exception** — written and working, but its revision and
mock are deferred until after Phase 07. Mock 10 covers it alongside Q57–Q65.

---

## 🔄 Phase 07 — Linked List (In Progress)

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

Cut before writing: `Linked_List_Basics` (duplicate Prerequisites).
`Cycle_Detection` merged into `03_Slow_Fast_Pointer` — Floyd's *is* that loop
with `===` instead of a nil check. `Two_Pointers` renamed `04_Fixed_Gap_Pointer`;
everything in a linked-list phase is two pointers, the fixed gap is the mechanism.

Problems reordered easy → medium → hard: four easy, four medium, one hard.

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

Recurring miss this phase: writing a pointer MOVE where a list EDIT belonged —
`current = node` instead of `current = nextNode`, or `node.next = node`. Three
times across the drills and once in a reverse attempt. It never produces a wrong
answer; it produces an infinite loop or a self-cycle.

Two silent bugs caught only by identity assertions: `==` instead of `===` in Q59
(passes until two nodes share a value), and a double dereference `node.random?.random`
in Q63 (invisible when random points at itself). Both now have permanent regression
tests — `[1,1,1,1]` with no cycle, and `p.random = q` with `q.random` nil.

Revision and Mock 10 outstanding.

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
| **[DSA-Logic-and-Interview-Prep](https://github.com/AnilkumarMedikonda/DSA-Logic-and-Interview-Prep)** | 247 problems across 21 phases covering the complete DSA learning journey. |
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
