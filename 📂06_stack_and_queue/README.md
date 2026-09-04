# 📂 Phase 06 — Stack & Queue

Q48–Q56. Two Easy, six Medium, one Hard.

This is the first phase where the data structure *is* the insight. Arrays and Binary Search made you control traversal with indices; here you hand that control to a container whose ordering rule does the reasoning for you. LIFO answers one question — "what is the most recent unresolved thing?" — and nested brackets, expression evaluation, collisions and next-greater are all that question in different clothing. Push what you cannot answer yet; pop the moment something arrives that resolves it.

---

# 📚 Topics Covered

* Stack as deferred work — push the unresolved, pop on resolution
* `while let top = stack.last, condition` as the pop idiom
* Monotonic stack — decreasing answers "next greater", increasing answers "next smaller"
* Maintenance vs recording — popping keeps the stack ordered, the record line is where the answer happens
* Indices vs values on the stack — distance answers need indices, value answers need values
* Twin stacks — one for counts, one for partial results
* Auxiliary state per element — carrying the min at each depth
* Amortised O(1) — each element moves between two stacks exactly once
* FIFO with a head index instead of `removeFirst()`
* Map-to-node + doubly linked list for O(1) lookup with O(1) reorder
* `weak` back-pointers in a doubly linked list, and why strong ones leak

## 📂 Structure

```text
06_Stack_And_Queue
│
├── README.md
├── Stack_And_Queue_Prerequisites
│
├── Sources
│   └── Helpers.swift
│
├── Patterns
│   ├── 01_Monotonic_Stack
│   ├── 02_Parentheses_Matching
│   ├── 03_Min_Stack
│   ├── 04_Stack_Simulation
│   ├── 05_Two_Stack_Queue
│   └── 06_HashMap_Doubly_Linked_List
│
└── Problems
    └── Q48_LC020 … Q56_LC496
```

No pattern file without a problem behind it. Shared helpers live in `Sources/` and are never pasted per file.

---

## 🧩 Prerequisites

| # | Drill | Feeds |
|---|-------|-------|
| D1 | `Stack<Element>` — generic, push/pop/top/isEmpty | all |
| D2 | `Queue<Element>` — head index, amortised O(1) dequeue | Q53 |
| D3 | `charsOf`, `isDigit` | Q52 |
| D4 | `charToDigit`, `stringToInt` — handles leading `-` | Q51, Q52 |
| D5 | `repeatString` | Q52 |

`isMatchingPair` and the doubly linked node moved into patterns 02 and 06 — each serves exactly one pattern, so Prerequisites was the wrong home.

---

## 🧩 Patterns

| # | Pattern | Templates | Feeds |
|---|---------|-----------|-------|
| 01 | Monotonic Stack | `nextGreaterElement`, `nextGreaterDistance`, `nextSmallerElement` | Q50, Q54, Q56 |
| 02 | Parentheses Matching | `checkParentheses`, `isMatching`, `isOpeningBracket` | Q48, Q52 |
| 03 | Min Stack | paired auxiliary state on push and pop | Q49 |
| 04 | Stack Simulation | `evaluate`, `resolveOnConflict` | Q51, Q52, Q54 |
| 05 | Two Stack Queue | `enqueue`, `dequeue`, `front` with the emptiness guard | Q53 |
| 06 | HashMap + Doubly Linked List | `insertAfterHead`, `remove`, `moveToFront`, `evictLast` | Q55 |

`01_Monotonic_Stack` absorbed Next Greater Element — NGE *is* the template, not a variant of it. Three files were cut before writing: `Stack_Basics` and `Queue_Basics` duplicate the Prerequisites file, and `Previous_Greater_Element` has no Q48–Q56 problem behind it. `06` was added because Q55 was otherwise uncovered.

Four drills that must be explicit, not mentions:

* **Maintenance is not recording** (01) — the push/pop loop keeps the stack ordered and produces nothing on its own. `result[top] = nums[index]` at the pop is where the answer happens, and it belongs to the pattern, not to any one problem. Three templates share one loop and differ only in that line.
* **Indices or values** (01) — Q50 needs the day gap, so the stack holds indices and the answer is `index - top`. Q56 needs a value and all inputs are unique, so a value-keyed map is safe. Opposite choices, same template; the record line decides.
* **`while`, not `if`, on resolution** (01, 04) — Q54. One incoming element can destroy several stacked ones in sequence. `[10, 2, -5]` needs `-5` to beat `2` and then still face `10`.
* **Drain only when empty** (05) — Q53. Draining `in` into `out` on every dequeue is O(n) per call and reverses order twice. The emptiness guard is correctness, not an optimisation.

---

## 📖 Problems

| # | Problem | LC | Approach | Complexity |
|---|---------|----|----------|------------|
| Q48 | Valid Parentheses | 020 | Push openers, pop-and-verify on closers, empty at end | O(n) / O(n) |
| Q49 | Min Stack | 155 | Pair each value with the min at that depth | O(1) / O(n) |
| Q50 | Daily Temperatures | 739 | Decreasing stack of indices, answer `i - top` on pop | O(n) / O(n) |
| Q51 | Evaluate RPN | 150 | Push operands, pop two on operator | O(n) / O(n) |
| Q52 | Decode String | 394 | Twin stacks — counts and partial strings | O(n·k) / O(n·k) |
| Q53 | Queue Using Stacks | 232 | in/out stacks, drain only when out is empty | O(1) amortised / O(n) |
| Q54 | Asteroid Collision | 735 | Stack of survivors, resolve in a `while` loop | O(n) / O(n) |
| Q55 | LRU Cache | 146 | Map to nodes, list for recency, dummy head/tail | O(1) / O(capacity) |
| Q56 | Next Greater Element I | 496 | Monotonic stack over `nums2`, map lookup for `nums1` | O(n + m) / O(m) |

k = the product of nested repeat counts in Q52, so the output can dwarf the input.

Two headers here are wrong in opposite directions if written carelessly. Q53's O(1) is **amortised** — one dequeue can cost O(n) when it triggers the transfer, and dropping the word is the tell that the two-stack argument was memorised rather than understood. Q55's O(1) is **worst case** — nothing there touches more than a fixed number of nodes.

---

## ⚠️ Wrong Tool Per Problem

* **Q48** — counting openers and closers instead of stacking them. `"([)]"` has equal counts and is invalid; order is the whole problem. Trap: returning `true` without the final `isEmpty` check, so `"(("` passes.
* **Q49** — one running min variable. It survives pushes but cannot be restored on pop; the min at each depth must be stored with the element.
* **Q50** — nested loops scanning forward for a warmer day. O(n²). Trap: guarding on `count > 1` and returning `[]`, which breaks the single-element case — `[50]` must return `[0]`.
* **Q51** — evaluating left to right without a stack. Trap: operand order. The first pop is the **right** operand; `+` and `*` commute, so the bug survives every test built from them and shows only on `-` and `/`.
* **Q52** — recursion on the bracket structure. Works, and it is a second optimal rather than a brute force. Trap: reading one character as one number, so `100[a]` decodes as three separate counts.
* **Q53** — a single array with `removeFirst()`. O(n) per dequeue. Trap: draining on every call rather than only when `out` is empty, which destroys the amortised bound.
* **Q54** — `if` instead of `while` on the collision check. Same shape as the Q19 First Missing Positive bug. Only one of four sign combinations collides: top positive, incoming negative.
* **Q55** — dictionary with a timestamp, then scanning for the oldest. O(n) per put. Traps: a node without its own `key` field, so eviction cannot clear the map entry; strong `prev`, which makes every adjacent pair a retain cycle.
* **Q56** — searching `nums2` for each element of `nums1`. O(n·m). Build the answer map in one monotonic pass over `nums2`, then look up.

---

## 📌 House Rules

* Problem statement, example, constraints, and complexity at the top of every file.
* Brute force **only where one exists naturally** (Q49, Q50, Q53, Q55, Q56). State "none" otherwise (Q51, Q52, Q54) rather than inventing a contrived baseline — amended Sep 3, after Q48's pair-stripping cost an O(n³) analysis and taught nothing.
* Shared helpers live in `Sources/Helpers.swift`. Never pasted per file.
* Notes are two or three lines — the trap only.
* No `reduce`, `map`, `filter`, `stride`, `max`, `min`, `sorted`, `enumerated`, `abs`, `isNumber`, `wholeNumberValue`, `Int(String)`, `Array(String)`.
* No `?? 0` on dictionary access — explicit `if let / else`.
* No force unwraps, no force casts.
* At most one blank line between logical blocks. Blank line after every print.
* `while let top = stack.last, condition` as the pop idiom in every monotonic file.
* Every monotonic solution names in one line what the stack holds and what a pop means.

---

## 📊 Status

Prerequisites ✅ (D1–D5) · Patterns 6/6 ✅ · Problems 9/9 ✅ · Revision ⬜ · Mock 09 (`mock_09_phase_06`) ⬜

**PHASE 06 — problems complete, two cycle steps remaining.**

Clean first try: Q54 Asteroid Collision, flagged going in as the highest-risk problem in the phase and returned with the `while` correct and all three outcomes handled. Q50's monotonic loop and Q56's map-then-lookup structure were also right first time.

The recurring miss is unchanged from Phase 05 and got worse: **complexity headers understate the work**. Six times this phase — `remove(at:)`'s array-shift cost written as O(n²) when it is O(n³), `repeatString` and Q52 written as O(n) when both are O(n·k). The algorithm has been right nearly every time; the costing has not. The rule that catches it: two loops, or a loop plus a length, means two variables in the answer.

Second recurring miss: **banned built-ins keep reappearing** — `min`, `abs`, `Array(s)`, `Int(token)`, `isNumber`, `wholeNumberValue`, `keys.sorted()`. Each was written after the manual equivalent already existed in `Sources/`.

One real logic bug: Q51's operand order came out reversed on `-` while `/` was correct in the same block, which means the rule was applied inconsistently rather than not known.

⬅️ Previous: **Phase 05 — Binary Search** ✅. Picking your interval there is the same discipline as picking what the stack holds here — the container has to match what you intend to read out of it.
➡️ Next: **Phase 07 — Linked List** (Q57–Q65). Q55's doubly linked node is the only one in the roadmap; Phase 07 is `next`-only throughout.
