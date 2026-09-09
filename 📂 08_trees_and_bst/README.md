# 📂 Phase 08 — Trees & Binary Search Trees (Q66–Q74)

Nine problems where recursion stops being a technique and becomes the default shape
of the answer. Seven of the nine are **base case + two recursive calls**, and what
varies is only *where the work sits* relative to those calls. The other two need an
explicit queue or stack, because recursion can't express level-by-level or
pausable traversal.

Swift-specific difficulty: both children are `Optional`, so let `nil` **be** the base
case rather than unwrapping before every descent. `guard let node = node else { return }`,
never `node!.left`.

---

## 🎯 Objective

Reach the point where the three traversal orders can be written cold and chosen
correctly from the problem statement alone — information flowing **down** means
preorder, flowing **up** means postorder, sorted order on a BST means inorder.

---

## 📋 Prerequisites

`Trees_And_BST_Prerequisites` — five drills, written before any problem is attempted.

| # | Drill | Feeds |
|---|-------|-------|
| D1 | `TreeNode` + `buildTree` / `printTree`, ASCII sketch per test tree | every problem |
| D2 | `preorder` / `inorder` / `postorder` — same walk, three placements | Q66–Q68, Q70, Q73 |
| D3 | `height` vs `depth` — edges vs nodes, leaf = both children nil | Q66, Q71 |
| D4 | `levelOrder` — queue with the level-size snapshot | Q69 |
| D5 | `searchBST` — compare, discard half, O(h) walk | Q70, Q72, Q73 |

---

## 🧩 Patterns

Template code only — generic skeleton, neutral name, no named LeetCode solutions.

| # | Pattern | What it is | Problems | Status |
|---|---------|------------|----------|:------:|
| 01 | DFS_Preorder | Work before both calls — state flows down the tree | Q67, Q68, Q70 | ⏳ |
| 02 | DFS_Inorder | Work between the calls — on a BST, emits sorted ascending | Q70, Q73 | ⏳ |
| 03 | DFS_Postorder | Work after both calls — results flow up from children | Q66 | ⏳ |
| 04 | BFS_Level_Order | Queue plus a level-size snapshot taken before draining | Q69 | ⏳ |
| 05 | Iterative_DFS | Explicit stack instead of the call stack, so traversal can stop mid-way | Q73 | ⏳ |
| 06 | BST_Property_Walk | Compare and discard half — O(h), no recursion needed | Q70, Q72, Q73 | ⏳ |
| 07 | Tree_DP | Return one value up while a global tracks a different answer | Q71, Q74 | ⏳ |

Nine proposed, cut to seven on review. `Tree_Basics` dropped as a duplicate of the
prerequisites file; `Recursive_DFS` dropped because 01–03 *are* the recursive DFS
templates. Every pattern has a problem behind it; every problem has a pattern.

---

## 📝 Problems

Ordered easy → medium → hard.

| # | LC | Problem | Level | Pattern | Time | Space | Status |
|---|-----|---------|-------|---------|------|-------|:------:|
| Q66 | 104 | Maximum Depth Of Binary Tree | 🟢 Easy | 03 | O(n) | O(h) | ⏳ |
| Q67 | 100 | Same Tree | 🟢 Easy | 01 | O(n) | O(h) | ⏳ |
| Q68 | 226 | Invert Binary Tree | 🟢 Easy | 01 | O(n) | O(h) | ⏳ |
| Q71 | 543 | Diameter Of Binary Tree | 🟢 Easy | 07 | O(n) | O(h) | ⏳ |
| Q69 | 102 | Binary Tree Level Order Traversal | 🟡 Medium | 04 | O(n) | O(w) | ⏳ |
| Q70 | 098 | Validate Binary Search Tree | 🟡 Medium | 01 + 06 | O(n) | O(h) | ⏳ |
| Q72 | 235 | Lowest Common Ancestor Of A BST | 🟡 Medium | 06 | O(h) | O(1) | ⏳ |
| Q73 | 230 | Kth Smallest Element In A BST | 🟡 Medium | 02 + 05 | O(h+k) | O(h) | ⏳ |
| Q74 | 124 | Binary Tree Maximum Path Sum | 🔴 Hard | 07 | O(n) | O(h) | ⏳ |

Two facts do most of the work in this phase: **the BST invariant is about entire
subtrees, not parent/child pairs**, and **Tree DP returns a different value than
the one it's tracking**.

Q71 is LeetCode-Easy but is pure Tree DP, so it sits with the easies by label and
must be solved **before Q74** — same split-versus-return mistake, far cheaper to
learn on. Q73 is the lead-in to nothing but is where iterative DFS earns itself:
the recursive version works and is worse, because it can't stop at k.

---

## ⚠️ Wrong Tool Traps

Anticipated from the problem set — to be replaced with what's actually found while
writing.

| # | Reaches for | Should reach for |
|---|-------------|------------------|
| Q66 | Counting edges | Counting nodes — LC104's base case makes a single node depth 1 |
| Q69 | Recursion | Queue — recursion cannot group by level |
| Q70 | Parent/child comparison | Range carried from the root; local checks pass non-BSTs |
| Q71 | Returning the diameter | Return height, keep diameter in a global |
| Q72 | General LCA (LC236) | BST walk — the ordering makes it O(h) with no recursion |
| Q73 | Full inorder into an array | Iterative inorder, stop early at the kth pop |
| Q74 | Returning the path sum | Return single-branch max, track the split sum globally |

The question that catches most of these: **is this value going down the tree or
coming back up it?**

---

## 📏 House Rules

- No built-in helpers — no `reduce`, `map`, `filter`, `stride`, `min`, `max`, `abs`.
  Manual loops. Shared helpers live in `Sources/Helpers.swift`, never pasted per file.
- No force unwraps. No `?? 0` — explicit `if let` / `else`.
- `final class` for `TreeNode`; `let` wherever there is no reassignment.
- **Brute force:** optimal solutions only in this phase. Trees are O(n) at
  brute force anyway — every node must be visited, so there is no slower
  version to compare against for Q66–Q69, Q71, Q74. Where a genuine
  alternative exists (Q70 inorder-into-array, Q72 general LCA, Q73 full
  inorder) it is named in the header with one line on why it loses, not
  implemented.
- Every file opens with the problem statement, an example, and constraints.
- Time and space stated with the reason, not just the notation. Say the
  balanced-vs-skewed split on `O(h)` unprompted.
- Every test tree carries its ASCII sketch above it.
- Test prints only, in this format:
  `print("\n========== Q66 - Maximum Depth Of Binary Tree ==========")`
  then one print per case with the expected answer as an inline comment.
  No debug logging inside solutions.

---

## 📊 Status

Prerequisites ⏳ · Patterns 0/7 ⏳ · Problems 0/9 ⏳ · Revision ⏳ · Mock 11 ⏳

**PHASE 08 NOT STARTED.**

**Q55 LRU Cache is on its third deferral** — carried out of Phase 06, then Phase 07,
now due with Mock 11 alongside this phase's nine. It is not a tree problem and will
not get absorbed by this phase's work; schedule it explicitly or it slips again.
