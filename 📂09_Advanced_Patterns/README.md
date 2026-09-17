# 📂 Phase 09 — Advanced Patterns (Q75–Q85)

The final phase, and the only one that introduces no new primitive. A heap is an
array with an ordering invariant. A graph traversal is BFS or DFS over
neighbours that are computed rather than read. Backtracking is DFS with an undo
step. DP is recursion with the repeated work cached.

What makes it hard is that the problem statement no longer names the tool.
"Kth largest", "minutes until all rot" and "can you finish the courses" are
three phrasings of *heap*, *level-order BFS* and *cycle detection*, and none of
them says so.

---

## 🎯 Objective

Choose the pattern from the *shape of the question* rather than its vocabulary —
"top k" without sorting, "shortest/fewest" as a BFS level count, "prerequisites"
as indegree, "all combinations" as choose → recurse → undo, "best up to i" as a
DP transition.

---

## 📋 Prerequisites — ✅

`Advanced_Patterns_Prerequisites` — five drills, all graph and grid plumbing:

| # | Drill | Feeds |
|---|-------|-------|
| D1 | BFS queue with a head index (no `removeFirst`) | Q78, Q79, Q80 |
| D2 | Grid bounds check + four-direction neighbours | Q77, Q78 |
| D3 | Visited tracking — `Set` for graphs, 2D `[[Bool]]` for grids | Q77, Q78 |
| D4 | Adjacency list from edge pairs, directed and undirected | Q79, Q81 |
| D5 | Indegree array | Q79 |

The heap drill was cut — the index arithmetic has no consumer outside the heap,
so it lives in pattern 01.

D1 matters more than it looks. `removeFirst` on a Swift array is O(n), so a BFS
written with it is quietly O(V²) — answers stay correct, the complexity header
becomes a lie.

---

## 🧩 Patterns — 7 / 7 ✅

Template code only — generic skeleton, neutral name, no named LeetCode solutions.

| # | Pattern | What it is | Problems | Status |
|---|---------|------------|----------|:------:|
| 01 | Heap | Index arithmetic, sift up on insert, sift down on removal | Q75, Q76 | ✅ |
| 02 | Graph_DFS | Recurse into all neighbours, mark visited *before* recursing | Q77 | ✅ |
| 03 | Graph_BFS | Queue + level-size snapshot when distance matters | Q78, Q80 | ✅ |
| 04 | Topological_Sort | Kahn's — indegree queue, short count means cycle | Q79 | ✅ |
| 05 | Union_Find | Find with path compression, union by rank | Q81 | ✅ |
| 06 | Backtracking | Choose → recurse → undo | Q82, Q83 | ✅ |
| 07 | Dynamic_Programming | Cumulative and ending-at skeletons | Q84, Q85 | ✅ |

Ten proposed, cut to seven on review. `Trie`, `Greedy` and
`Binary_Search_On_Answer` dropped — no Q75–Q85 problem behind any of them.
DFS is numbered before BFS so the order tracks Q77 → Q78.

Pattern 01 carries the index arithmetic as well as the type: parent
`(i - 1) / 2`, children `2i + 1` and `2i + 2`. Largest template in the phase.

Pattern 03's level-size snapshot taken before the drain is the whole pattern —
read `queue.count` inside the drain instead and every level collapses into one.

Pattern 07 carries two skeletons: *cumulative* (answer is the last cell) and
*ending at* (answer is the max of the array).

**Known gaps.** `05_Union_Find` still holds the LC684 solution and debug logging
inside the pattern file, and `06_Backtracking` prints rather than returning.
Q81 was written from scratch rather than off the template as a result.

---

## 📝 Problems — 11 / 11 ✅

Kept in pattern order — grouping by tool is more useful than grouping by
difficulty when the whole point is tool selection.

| # | LC | Problem | Level | Pattern | Time | Space | Status |
|---|-----|---------|-------|---------|------|-------|:------:|
| Q75 | 215 | Kth Largest Element In An Array | 🟡 Medium | 01 | O(n log k) | O(k) | ✅ |
| Q76 | 023 | Merge K Sorted Lists | 🔴 Hard | 01 | O(N log k) | O(k) | ✅ |
| Q77 | 200 | Number Of Islands | 🟡 Medium | 02 | O(m·n) | O(m·n) | ✅ |
| Q78 | 994 | Rotting Oranges | 🟡 Medium | 03 | O(m·n) | O(m·n) | ✅ |
| Q79 | 207 | Course Schedule | 🟡 Medium | 04 | O(V+E) | O(V+E) | ✅ |
| Q80 | 127 | Word Ladder | 🔴 Hard | 03 | O(N·L²) | O(N·L) | ✅ |
| Q81 | 684 | Redundant Connection | 🟡 Medium | 05 | O(E·H) | O(V) | ✅ |
| Q82 | 078 | Subsets | 🟡 Medium | 06 | O(n·2ⁿ) | O(n) | ✅ |
| Q83 | 039 | Combination Sum | 🟡 Medium | 06 | O(n^(t/m)) | O(t/m) | ✅ |
| Q84 | 198 | House Robber | 🟡 Medium | 07 | O(n) | O(1) | ✅ |
| Q85 | 300 | Longest Increasing Subsequence | 🟡 Medium | 07 | O(n²) | O(n) | ✅ |

Three facts do most of the work: **a size-k heap beats a full sort when k is
small**, **BFS counts levels and DFS does not**, and **the DP answer is
sometimes the last cell and sometimes the max of all of them.**

Q81 uses a plain parent array with neither path compression nor union by rank —
deliberate at n ≤ 1000, but it means O(E·H) degrades to O(E·V) where the
template's would be O(E·α(n)).

---

## ⚠️ Wrong Tool Traps

| # | Reaches for | Should reach for |
|---|-------------|------------------|
| Q75 | Sorting the array | Size-k min-heap — sorting ignores the k in the question |
| Q76 | Merging pairwise left to right | Heap of heads; pairwise copies early nodes k times |
| Q77 | BFS | DFS — needs no queue, and sinking the cell replaces the visited array |
| Q78 | DFS from each rotten orange | Multi-source BFS; DFS overwrites shorter distances |
| Q79 | DFS without on-path state | A revisited node is only a cycle if it is on the *current* path |
| Q80 | Comparing every word pair to build edges | Generated neighbours — pairwise is O(N²·L) before BFS starts |
| Q81 | Re-running DFS after each insert | DSU answers it in one pass |
| Q82 | Recording only at the leaf | Every node is a subset, not just the bottom row |
| Q83 | Advancing the index after choosing | Stay on the same index — reuse is allowed |
| Q84 | Greedy alternate houses | `[2,1,1,2]` breaks it; the answer skips two in a row |
| Q85 | Kadane | Subsequence ≠ subarray — elements need not be adjacent |

The question that catches most of these: **does this answer need a distance, or
just a reachability?** Distance means BFS with levels. Reachability means DFS is
free to wander.

For the two backtracking problems: **am I recording at the node or at the leaf,
and does the next call move the index or not?** Q82 and Q83 differ in exactly
those two lines.

---

## 🔁 Revision — ✅ (11 of 11)

Blind rewrite of all eleven optimals from an empty template, all eventually
correct. Five needed a second pass — and none of the five was an algorithm.

| # | Problem | The miss |
|---|---------|----------|
| Q75 | Kth Largest | `remove()` lost its empty guard, so an empty heap traps on `heap[0]`. Nothing in the problem calls it that way, so every test passed |
| Q80 | Word Ladder | `return steps` instead of `steps + 1` — endWord is generated from the level being drained, so it sits one level deeper |
| Q82 | Subsets | `dfs` never called, and the loop ran `0..<start` instead of `start..<count` |
| Q84 | House Robber | `prev1` and `prev2` swapped in the transition. The two swaps cancel arithmetically, so every answer was right while the code said "rob adjacent houses" |
| Q85 | LIS | `var max = Int.min` shadowed the `max` function, breaking the `max()` call above it. Compile error |

Phase 07's misses were all **ordering**, Phase 08's all **boundary**. Phase 09's
were **mechanism** — the wrong thing computed, the right answer out. Q84 is the
clearest case.

Separately, three mechanical habits slipped on every one of the eleven rewrites:
`var` where `let` belongs, method-name typos, and `private` dropped from
helpers. The algorithms came back; the discipline did not.

---

## 🎯 Mock 09 — ✅

Q75–Q85. First attempt: **8 / 11**. Three failures, all repeats of something
already caught once:

| # | The failure |
|---|-------------|
| Q77 | `dfs` declared after the loop that calls it — a nested func capturing mutable locals cannot be used above its own declaration. Compile error, second occurrence |
| Q83 | `dfs(index, …)` instead of `dfs(i, …)`. Every level restarted from the same position, so `[2,2,3]`, `[2,3,2]` and `[3,2,2]` all appeared |
| Q85 | `var max` shadowing `max()` again. Compile error, second occurrence |

Two of the three were compiler errors that Xcode flags in under a second. The
lesson is not more practice — it is **build before calling it done**.

Re-run passed after fixing all three.

---

## 📏 House Rules

- **Optimal only.** Brute force named in the header, not implemented.
- No built-ins — no `reduce`, `map`, `filter`, `stride`, `enumerated`,
  `reversed`, `sorted`, `removeFirst`. `swapAt`, `min()` and `max()` are fine.
  `for _ in 0..<n` is fine for a plain repeat count.
- No force unwraps, no `?? 0` — explicit `if let` / `else`.
- `let` wherever there is no reassignment.
- Never name a local after a function used in the same scope — `maximum`, not
  `max`.
- Declare nested helpers before the loop that calls them.
- Every file opens with the problem statement, example, constraints and
  complexity.
- Test prints only: section header, then one print per case with the expected
  answer as an inline comment.

---

## 📊 Status

Prerequisites ✅ · Patterns 7/7 ✅ · Problems 11/11 ✅ · Revision ✅ 11/11 · Mock 09 ✅

**PHASE 09 COMPLETE** — all six cycle steps done, no carry-over.

Branch: `phase_09_advanced_patterns`. Mock branch: `mock_09_phase_09`.

Time budget: patterns 8 hrs, problems 10 hrs, revision + mock 7 hrs — 25 total.

Next: weak areas first, then the full Q01–Q85 revision pass, then every mock
re-run phase by phase, then sorting algorithms.
