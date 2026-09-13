# 📂 Phase 07 — Linked List (Q57–Q65)

Nine problems on pointer manipulation. Three techniques carry the whole phase —
**reverse**, **dummy node**, **slow/fast** — and the last two problems (Q64, Q65)
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
| D1 | `ListNode` + `createLinkedList` / `printListNode` | every problem |
| D2 | `countNodes`, `nodeAt` — traversal with `while let` | Q60, Q62 |
| D3 | `insert` / `delete` by position, `insertAfter` / `deleteNext` by node | Q61, Q62 |
| D4 | `sameNode`, `containsNode` — identity via `===` | Q59 |
| D5 | `splitAfter` — cut and nil the tail | Q64, Q65 |

---

## 🧩 Patterns

Template code only — generic skeleton, neutral name, no named LeetCode solutions.

| # | Pattern | What it is | Problems | Status |
|---|---------|------------|----------|:------:|
| 01 | Reverse_Linked_List | Three-pointer in-place reversal (`prev` / `current` / `nextNode`) | Q57, Q64, Q65 | ✅ |
| 02 | Dummy_Node | Throwaway head so the real head is never a special case | Q58, Q61, Q62 | ✅ |
| 03 | Slow_Fast_Pointer | Speed-difference scan — both middles, and cycle detection via `===` | Q59, Q60, Q64 | ✅ |
| 04 | Fixed_Gap_Pointer | Advance one pointer n+1 steps, then move both together | Q62 | ✅ |
| 05 | Merge_Two_Lists | Pick-smaller-and-append against a dummy tail | Q58, Q61, Q64 | ✅ |
| 06 | K_Group_Reverse | Reverse a window, seed `prev` with `groupNext` to reattach | Q65 | ✅ |
| 07 | Random_Pointer_Clone | Map by `ObjectIdentifier`, or interleave for O(1) | Q63 | ✅ |

Every pattern has a problem behind it; every problem has a pattern.

---

## 📝 Problems

Ordered easy → medium → hard.

| # | LC | Problem | Level | Pattern | Time | Space | Status |
|---|-----|---------|-------|---------|------|-------|:------:|
| Q57 | 206 | Reverse Linked List | 🟢 Easy | 01 | O(n) | O(1) | ✅ |
| Q58 | 021 | Merge Two Sorted Lists | 🟢 Easy | 02 + 05 | O(n+m) | O(1) | ✅ |
| Q59 | 141 | Linked List Cycle | 🟢 Easy | 03 | O(n) | O(1) | ✅ |
| Q60 | 876 | Middle Of Linked List | 🟢 Easy | 03 | O(n) | O(1) | ✅ |
| Q61 | 002 | Add Two Numbers | 🟡 Medium | 02 | O(max(n,m)) | O(max(n,m)) | ✅ |
| Q62 | 019 | Remove Nth Node From End | 🟡 Medium | 02 + 04 | O(n) | O(1) | ✅ |
| Q63 | 138 | Copy List With Random Pointer | 🟡 Medium | 07 | O(n) | O(n) | ✅ |
| Q64 | 143 | Reorder List | 🟡 Medium | 03 + 01 + 05 | O(n) | O(1) | ✅ |
| Q65 | 025 | Reverse Nodes In K Group | 🔴 Hard | 06 | O(n) | O(1) | ✅ |

Two pointer-manipulation facts do most of the work in this phase: **`groupStart`
becomes the group's tail after a reversal**, and **identity (`===`) not value
(`==`)** is what makes cycle detection and group boundaries work.

Q63 is O(n) with the hash map; the O(1) interleave version lives in the pattern
file, not the solution. Q64 is the three core patterns composed and is the
lead-in to Q65 — it belongs last among the mediums.

---

## ⚠️ Wrong Tool Traps

Found while writing the problems:

| # | The miss | Why it survived testing |
|---|----------|-------------------------|
| — | Pointer MOVE written where a list EDIT belonged (`current = node` instead of `current = nextNode`, `node.next = node`) | Hit three times across D2, D3 and a reverse attempt. Produces an infinite loop or a self-cycle, not a wrong answer |
| Q59 | `==` instead of `===` on nodes | Passes every test until two distinct nodes hold the same value. `[1,1,1,1]` with no cycle is the regression test |
| Q63 | `node.random?.random` — one dereference too many | Invisible when random points at itself. `p.random = q` with `q.random = nil` is the regression test |
| Q64 | Second-middle variant where the first is needed | Odd lengths are identical either way. Only even lengths expose it, and the failure is a cycle, not a wrong order |
| Q62 | Loop that ran out of nodes treated as a loop that arrived | Out-of-range `n` silently deletes the head instead of doing nothing |

Found on the blind revision pass — all six are **ordering** errors, not
misremembered algorithms:

| # | The miss |
|---|----------|
| Q62 | `slowNode.next = victim` instead of `victim.next` — assigned the victim to itself, list came back unchanged |
| Q63 | Pass two read `copy.next` / `copy.random` instead of the original's, so it wired nothing |
| Q64 | Nil-ed `middle.next` before reading it, so the second half was always nil; weave assignments crossed |
| Q65 | `groupPrev` anchored on `head` instead of `dummy`, leaving the first group unreversed |
| — | `createCycle` dropped the line saving the cycle node — no test list ever had a cycle, so Q59 was passing against nothing |
| — | `middleNode` guarded `slow` instead of `fast` |

The question that catches every one: **at the moment I read this pointer, has
anything already changed it?**
---

## 📏 House Rules

- No built-in helpers — no `reduce`, `map`, `filter`, `stride`, `min`, `max`, `abs`.
  Manual loops. Shared helpers live in `Sources/Helpers.swift`, never pasted per file.
- No force unwraps. No `?? 0` — explicit `if let` / `else`.
- `final class` for `ListNode`; `let` wherever there is no reassignment.
- **Brute force:** pointer-based ones get written (two-pass count in Q60, Q62).
  Array-based ones get named in the header and not implemented — dumping to an
  array is a different data structure, not a different algorithm, and teaches
  nothing about pointers. Q61 states **none** for a stronger reason: converting
  to `Int` overflows at 100 digits, so the naive version is wrong, not slow.
- Every file opens with the problem statement, an example, and constraints.
- Time and space stated with the reason, not just the notation.
- Test prints only, in this format:
  `print("\n========== Q57 - Reverse Linked List ==========")`
  then one print per case with the expected answer as an inline comment.
  No debug logging inside solutions.

---

## 📊 Status

Prerequisites ✅ · Patterns 7/7 ✅ · Problems 9/9 ✅ · Revision 🟡 (5 of 9) · Mock 10 ✅

**PHASE 07 COMPLETE** — all six cycle steps done, with one carry-over.

Revision recalled Q57–Q61 clean; Q62–Q65 and two shared helpers regressed, all
on ordering. Mock 10 covered Q57–Q65.

**Q55 LRU Cache is still outstanding** — deferred from Phase 06, not done here
either. Now due with Mock 11. Second deferral.
