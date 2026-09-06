# 📂 Phase 07 — Linked List (Q57–Q65)

Nine problems on pointer manipulation. Three techniques carry the whole phase —
**reverse**, **dummy node**, **slow/fast** — and the two hard problems (Q62, Q65)
are those three composed rather than anything new.

Swift-specific difficulty: every pointer is an `Optional`, so every traversal is
an unwrap. `while let` everywhere, no force unwraps.

---

## 🎯 Objective

Reach the point where reverse-in-place, dummy-node building, and the fast/slow
scan can be written cold, without a reference, and combined without losing the tail.

---

## 📋 Prerequisites

`Linked_List_Prerequisites` — five drills, written before any problem is attempted.

| # | Drill | Feeds |
|---|-------|-------|
| D1 | `ListNode` (final class) + manual `buildList` / `printList` | every problem |
| D2 | Traversal with `while let` + node count | Q60, Q61 |
| D3 | Insert at head · insert after node · delete next node | Q60, Q64 |
| D4 | Reference identity — `===` vs `==` | Q59 |
| D5 | Split a list at a node (cut and nil the tail) | Q62, Q65 |

---

## 🧩 Patterns

Template code only — generic skeleton, neutral name, no named LeetCode solutions.

| # | Pattern | What it is | Problems | Status |
|---|---------|------------|----------|:------:|
| 01 | Reverse_Linked_List | Three-pointer in-place reversal (`previous` / `current` / `next`) | Q57, Q64, Q65 | ☐ |
| 02 | Dummy_Node | Throwaway head so the real head is never a special case | Q58, Q61, Q62 | ☐ |
| 03 | Slow_Fast_Pointer | Speed-difference scan — middle, and cycle detection via `===` | Q59, Q60, Q64 | ☐ |
| 04 | Fixed_Gap_Pointer | Advance one pointer n steps, then move both together | Q62 | ☐ |
| 05 | Merge_Two_Lists | Pick-smaller-and-append against a dummy tail | Q58, Q61, Q64 | ☐ |
| 06 | K_Group_Reverse | Reverse a window, reconnect to the previous group's tail | Q65 | ☐ |
| 07 | Random_Pointer_Clone | Clone nodes plus a second pointer (map or interleave) | Q63 | ☐ |

Every pattern has a problem behind it; every problem has a pattern.

---

## 📝 Problems

Ordered easy → medium → hard.

| # | LC | Problem | Level | Pattern | Time | Space | Status |
|---|-----|---------|-------|---------|------|-------|:------:|
| Q57 | 206 | Reverse Linked List | 🟢 Easy | 01 | O(n) | O(1) | ☐ |
| Q58 | 021 | Merge Two Sorted Lists | 🟢 Easy | 02 + 05 | O(n+m) | O(1) | ☐ |
| Q59 | 141 | Linked List Cycle | 🟢 Easy | 03 | O(n) | O(1) | ☐ |
| Q60 | 876 | Middle Of Linked List | 🟢 Easy | 03 | O(n) | O(1) | ☐ |
| Q61 | 002 | Add Two Numbers | 🟡 Medium | 02 | O(n+m) | O(n) | ☐ |
| Q62 | 019 | Remove Nth Node From End | 🟡 Medium | 02 + 04 | O(n) | O(1) | ☐ |
| Q63 | 138 | Copy List With Random Pointer | 🟡 Medium | 07 | O(n) | O(n) / O(1) | ☐ |
| Q64 | 143 | Reorder List | 🟡 Medium | 03 + 01 + 05 | O(n) | O(1) | ☐ |
| Q65 | 025 | Reverse Nodes In K Group | 🔴 Hard | 06 | O(n) | O(1) | ☐ |

Q63 space is O(n) with the hash map, O(1) with interleaving. Q64 is the three core
patterns composed and is the lead-in to Q65 — it belongs last among the mediums.
---

## ⚠️ Wrong Tool Traps

Logged per problem as it is solved — real misses only, not anticipated ones.

---

## 📏 House Rules

- No built-in helpers — no `reduce`, `map`, `filter`, `stride`, `min`, `max`, `abs`.
  Manual loops. Shared helpers live in `Sources/Helpers.swift`, never pasted per file.
- No force unwraps. No `?? 0` — explicit `if let` / `else`.
- `final class` for `ListNode`; `let` wherever there is no reassignment.
- Brute force only where one exists naturally — otherwise the header states **none**.
- Every file opens with the problem statement, an example, and constraints.
- Time and space stated with the reason, not just the notation.
- Test prints only, in this format:
  `print("\n========== Q57 - Reverse Linked List ==========")`
  then one print per case with the expected answer as an inline comment.
  No debug logging inside solutions.

---

## 📊 Status

Prerequisites ☐ · Patterns 0/7 ☐ · Problems 0/9 ☐ · Revision ☐ · Mock 10 ☐

**PHASE 07 IN PROGRESS** — step 1 of six.

Mock 10 covers Q57–Q65 **plus Q55 LRU Cache**, carried over from Phase 06.
