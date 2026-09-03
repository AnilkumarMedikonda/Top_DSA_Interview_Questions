# 📂 Phase 06 — Stack & Queue

Q48–Q56. Two Easy, six Medium, one Hard.

This is the first phase where the data structure *is* the insight. Arrays and Binary Search made you control traversal with indices; here you hand that control to a container whose ordering rule does the reasoning for you. LIFO answers one question — "what is the most recent unresolved thing?" — and nested brackets, expression evaluation, collisions and next-greater are all that question in different clothing. Push what you cannot answer yet; pop the moment something arrives that resolves it.

---

# 📚 Topics Covered

* Stack as deferred work — push the unresolved, pop on resolution
* `while let top = stack.last, condition` as the pop idiom
* Monotonic stack — decreasing answers "next greater", increasing answers "next smaller"
* Indices vs values on the stack — distance questions need indices
* Twin stacks — one for counts, one for partial results
* Auxiliary state per element — carrying the min at each depth
* Amortised O(1) — each element moves between two stacks exactly once
* FIFO with a head index instead of `removeFirst()`
* Map-to-node + doubly linked list for O(1) lookup with O(1) reorder

## 📂 Structure

```text
06_Stack_And_Queue
│
├── README.md
├── Stack_And_Queue_Prerequisites
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

No pattern file without a problem behind it.

---

## 🧩 Patterns

| # | Pattern | Templates | Feeds |
|---|---------|-----------|-------|
| 01 | Monotonic Stack | `nextGreater`, `nextGreaterIndices` | Q50, Q54, Q56 |
| 02 | Parentheses Matching | `isBalanced`, `isMatchingPair` | Q48, Q52 |
| 03 | Min Stack | `push`/`pop` with paired auxiliary state | Q49 |
| 04 | Stack Simulation | `evaluate`, `resolveCollision` | Q51, Q52, Q54 |
| 05 | Two Stack Queue | `enqueue`, `dequeue`, `drainIfNeeded` | Q53 |
| 06 | HashMap + Doubly Linked List | `insertAfterHead`, `removeNode`, `moveToFront` | Q55 |

`01_Monotonic_Stack` absorbed Next Greater Element — NGE *is* the template, not a variant of it. Three files were cut before writing: `Stack_Basics` and `Queue_Basics` duplicate the Prerequisites file, and `Previous_Greater_Element` has no Q48–Q56 problem behind it. `06` was added because Q55 was otherwise uncovered.

Three drills that must be explicit, not mentions:

* **Indices or values** (01) — Q50 needs the day gap, so the stack holds indices and the answer is `i - top`. Q54 only needs magnitude, so it holds values. Writing Q50 with temperatures on the stack produces correct pops and an uncomputable answer.
* **`while`, not `if`, on resolution** (01, 04) — Q54. One incoming asteroid can destroy several survivors in sequence; an `if` resolves one collision and moves on. `[10, 2, -5]` passes with `if` only by luck of ordering.
* **Drain only when empty** (05) — Q53. Draining `in` into `out` on every dequeue is O(n) per call and reverses order twice. The amortised argument depends on the emptiness guard, not on the drain itself.

---

## 📖 Problems

| # | Problem | LC | Approach | Complexity |
|---|---------|----|----------|------------|
| Q48 | Valid Parentheses | 020 | Push openers, pop-and-verify on closers, empty at end | O(n) / O(n) |
| Q49 | Min Stack | 155 | Pair each value with the min at that depth | O(1) / O(n) |
| Q50 | Daily Temperatures | 739 | Decreasing stack of indices, answer `i - top` on pop | O(n) / O(n) |
| Q51 | Evaluate RPN | 150 | Push operands, pop two on operator | O(n) / O(n) |
| Q52 | Decode String | 394 | Twin stacks — counts and partial strings | O(n·k) / O(n) |
| Q53 | Queue Using Stacks | 232 | in/out stacks, drain only when out is empty | O(1) amortised / O(n) |
| Q54 | Asteroid Collision | 735 | Stack of survivors, resolve in a `while` loop | O(n) / O(n) |
| Q55 | LRU Cache | 146 | Map to nodes, list for recency, dummy head/tail | O(1) / O(capacity) |
| Q56 | Next Greater Element I | 496 | Monotonic stack over `nums2`, map lookup for `nums1` | O(n + m) / O(n) |

k = the largest repeat count in Q52. Q53's O(1) is amortised, not worst case — a single dequeue can cost O(n) when it triggers the drain, but each element is moved exactly once across its lifetime. Saying plain "O(1)" without the word *amortised* is the tell that the two-stack argument was memorised rather than understood.

---

## ⚠️ Wrong Tool Per Problem

* **Q48** — counting openers and closers instead of stacking them. `"([)]"` has equal counts and is invalid; order is the whole problem. Trap: returning `true` without the final `isEmpty` check, so `"(("` passes.
* **Q49** — one running min variable. It survives pushes but cannot be restored on pop; the min at each depth must be stored with the element.
* **Q50** — nested loops scanning forward for a warmer day. O(n²). Trap: pushing temperatures instead of indices, which makes the pop correct and the distance uncomputable.
* **Q51** — evaluating left to right without a stack. Trap: operand order — the *second* pop is the left operand, so `-` and `/` come out reversed on `["4","13","-"]`.
* **Q52** — recursion on the bracket structure. Works, but the iterative twin-stack version is what is asked for. Trap: reading one character as one number, so `100[a]` decodes as three separate counts.
* **Q53** — a single array with `removeFirst()`. O(n) per dequeue. Trap: draining on every call rather than only when `out` is empty, which destroys the amortised bound.
* **Q54** — `if` instead of `while` on the collision check. Same shape as the Q19 First Missing Positive bug: one resolution where a loop was needed. Trap: forgetting that equal magnitudes destroy *both*.
* **Q55** — array or dictionary with a timestamp, then scanning for the oldest. O(n) per access. Only the map + doubly linked list gives O(1) on both operations. Trap: updating the map's value and never moving the node, so recency silently goes stale.
* **Q56** — searching `nums2` for each element of `nums1`. O(n·m). Build the answer map in one monotonic pass over `nums2`, then look up.

---

## 📌 House Rules

* Problem statement, example, constraints, and complexity at the top of every file.
* Brute force + optimal only. Alternatives get named in the notes, not implemented.
* No `reduce`, `map`, `filter`, `stride`, `max`, `min`, `sorted`, `enumerated`.
* No `?? 0` on dictionary access — explicit `if let / else`.
* No force unwraps, no force casts.
* At most one blank line between logical blocks. Blank line after every print.
* `while let top = stack.last, condition` as the pop idiom in every monotonic file.
* Every monotonic solution names in one line what the stack holds and what a pop means.

---

## 📊 Status

Prerequisites ⬜ (D1–D7) · Patterns 0/6 ⬜ · Problems 0/9 ⬜ · Revision ⬜ · Mock 09 (`mock_09_phase_06`) ⬜

**PHASE 06 IN PROGRESS** — started Sep 3, 2026.

Carried in from Phase 05: complexity headers were wrong on four of nine at the mock, always understating the work. Two headers in this phase are easy to get wrong the same way — Q53 is amortised O(1), not O(1), and Q52 is O(n·k), not O(n). The other carried-forward item is the `if`/`while` slip that first appeared on Q19 and is waiting for you again on Q54.

⬅️ Previous: **Phase 05 — Binary Search** ✅. Picking your interval there is the same discipline as picking what the stack holds here — the container has to match what you intend to read out of it.
➡️ Next: **Phase 07 — Linked List** (Q57–Q65).
