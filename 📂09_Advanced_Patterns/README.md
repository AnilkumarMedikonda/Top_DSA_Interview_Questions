# 📂 Phase 09 — Advanced Patterns (Q75–Q85)

The final phase, and the only one that introduces no new primitive. A heap is an
array with an ordering invariant maintained on the way in and out. A graph
traversal is BFS or DFS over neighbours that are computed rather than read.
Backtracking is DFS with an undo step. DP is recursion with the repeated work
cached. Eleven problems, seven patterns, every one medium or hard.

What makes it hard is not the individual pattern — it is that the problem
statement no longer names the tool. "Kth largest", "minutes until all rot" and
"can you finish the courses" are three different phrasings of *heap*, *level-order
BFS* and *cycle detection*, and none of them says so.

Swift-specific difficulty: there is no built-in priority queue, so pattern 01
carries a hand-written heap that Q75 and Q76 both depend on. It is the single
largest piece of template code in the repo.

---

## 🎯 Objective

Reach the point where the pattern is chosen from the *shape of the question*
rather than its vocabulary — "top k" without sorting, "shortest/fewest" as a
BFS level count, "prerequisites" as indegree, "all combinations" as choose →
recurse → undo, "best up to i" as a DP transition.

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

A sixth drill for the heap was proposed and cut — the index arithmetic is used
nowhere outside the heap itself, so it lives in pattern 01 rather than as a
standalone drill with no second consumer.

D1 matters more than it looks. `removeFirst` on a Swift array is O(n), so a BFS
written with it is quietly O(V²) — the answers stay correct and the complexity
header becomes a lie. Same failure mode as Q73 in Phase 08.

Corrections made on review: three of the five drills were missing on the first
pass (D2, D3, D5 — the grid and Kahn's plumbing); the adjacency-list builders
sat at file scope rather than in functions; and space was headed O(V) where the
function allocates the list itself, which is O(V + E). The understated-complexity
miss is now four phases old.

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
| 07 | Dynamic_Programming | State as "answer ending at i", then the transition | Q84, Q85 | ✅ |

Ten proposed, cut to seven on review. `Trie`, `Greedy` and
`Binary_Search_On_Answer` dropped — no Q75–Q85 problem behind any of them.
DFS is numbered before BFS so the pattern order tracks Q77 → Q78.

Parent is `(i - 1) / 2`, children `2i + 1` and `2i + 2`. Pattern 01 carries the
index arithmetic as well as the type, since the prerequisites file deliberately
does not. Both sift directions are needed: Q75 removes, Q76 removes and inserts
on every step. It is the largest template file in the phase and the other six
are short by comparison.

Pattern 03 carries the level-counting shape. The snapshot taken before the drain
is the whole pattern — read `queue.count` inside the drain instead and every
level collapses into one.

Pattern 07 carries two skeletons rather than one, because the two DP problems
have different shapes: *cumulative* (answer is the last cell) and *ending at*
(answer is the max of the array). The nested loop in the second is what makes
Q85 O(n²) where Q84 is O(n).

Pattern 05 exists for exactly one problem. That passes the no-unbacked-pattern
rule, but it is the highest write-cost file in the phase for the least reuse.

**Known gaps carried forward.** `05_Union_Find` still holds the LC684 solution
and its debug logging inside the pattern file, and `06_Backtracking` prints
rather than returning a result. Both work; neither is reusable as a template
yet, which is what the pattern/problem split exists for.

---

## 📝 Problems — 2 / 11

Kept in pattern order. No easy → medium → hard renumbering this phase; the
grouping by tool is more useful than the grouping by difficulty when the whole
point is tool selection.

| # | LC | Problem | Level | Pattern | Time | Space | Status |
|---|-----|---------|-------|---------|------|-------|:------:|
| Q75 | 215 | Kth Largest Element In An Array | 🟡 Medium | 01 | O(n log k) | O(k) | ✅ |
| Q76 | 023 | Merge K Sorted Lists | 🔴 Hard | 01 | O(N log k) | O(k) | ✅ |
| Q77 | 200 | Number Of Islands | 🟡 Medium | 02 | O(m·n) | O(m·n) | ☐ |
| Q78 | 994 | Rotting Oranges | 🟡 Medium | 03 | O(m·n) | O(m·n) | ☐ |
| Q79 | 207 | Course Schedule | 🟡 Medium | 04 | O(V+E) | O(V+E) | ☐ |
| Q80 | 127 | Word Ladder | 🔴 Hard | 03 | O(N·L²) | O(N·L²) | ☐ |
| Q81 | 684 | Redundant Connection | 🟡 Medium | 05 | O(n·α(n)) | O(n) | ☐ |
| Q82 | 078 | Subsets | 🟡 Medium | 06 | O(n·2ⁿ) | O(n) | ☐ |
| Q83 | 039 | Combination Sum | 🟡 Medium | 06 | O(n^(t/m)) | O(t/m) | ☐ |
| Q84 | 198 | House Robber | 🟡 Medium | 07 | O(n) | O(1) | ☐ |
| Q85 | 300 | Longest Increasing Subsequence | 🟡 Medium | 07 | O(n²) | O(n) | ☐ |

Three facts do most of the work in this phase: **a size-k heap beats a full sort
whenever k is small**, **BFS counts levels and DFS does not**, and **the DP answer
is sometimes the last cell and sometimes the max of all of them.**

Q84 and Q85 are the two that were left pending out of Strategy 75. They close
here.

Q76 re-declares `ListNode` locally rather than referencing Phase 07, so the
playground page compiles standalone.

---

## ⚠️ Wrong Tool Traps

Predicted from the problem statements. Confirm or correct after solving.

| # | Reaches for | Should reach for |
|---|-------------|------------------|
| Q75 | Sorting the array | Size-k min-heap — sorting ignores the k in the question |
| Q76 | Merging pairwise left to right | Heap of heads; pairwise copies early nodes k times |
| Q77 | BFS | DFS — needs no queue, and sinking the cell replaces the visited array |
| Q78 | DFS from each rotten orange | Multi-source BFS; DFS overwrites shorter distances |
| Q79 | DFS without on-path state | A revisited node is only a cycle if it is on the *current* path |
| Q80 | Comparing every word pair to build edges | Wildcard buckets — pairwise is O(N²·L) before BFS starts |
| Q81 | Re-running DFS after each insert | DSU answers it in one pass |
| Q82 | Recording only at the leaf | Every node is a subset, not just the bottom row |
| Q83 | Advancing the index after choosing | Stay on the same index — reuse is allowed |
| Q84 | Greedy alternate houses | `[2,1,1,2]` breaks it; the answer skips two in a row |
| Q85 | Kadane | Subsequence ≠ subarray — elements need not be adjacent |

The question that catches most of these: **does this answer need a distance, or
just a reachability?** Distance means BFS with levels. Reachability means DFS is
free to wander.

The second one, for the two backtracking problems: **am I recording at the node
or at the leaf, and does the next call move the index or not?** Q82 and Q83 differ
in exactly those two lines and nothing else.

### Caught while writing

| # | The miss | Why it survived testing |
|---|----------|-------------------------|
| 02 | `explore(node)` instead of `explore(neighbour)` | No crash, no hang — the visited guard bounced it immediately, so the traversal silently visited only the start node |
| 04 | No `result.count != graph.count` check after the drain | A partial cycle returns a non-empty, plausible-looking array with half the graph missing. That comparison IS Q207 |
| Q76 | `heapifyUp` broke on `<` instead of `<=` | Equal values kept climbing and swapping. Output correct, work wasted — and this input has two 1s and two 4s |
| Q76 | Last merged node kept its original `next` | Nil by luck on these inputs, not by construction |

The heap is now written three times — pattern 01, Q75, and Q76 with a `ListNode`
payload. A generic `Heap<Element>` with an ordering closure would have collapsed
all three into one; the two-class `Int`-only decision is what cost it. Worth
remembering before the next phase that needs a priority queue.

---

## 🔁 Revision — ⏳

Blind rewrite of all eleven optimals from an empty template, same format as
Phases 01–08.

Two phases of data point the same way and are worth watching here: Phase 07's
four misses were all **ordering** — reading or nil-ing a pointer at the wrong
moment. Phase 08's three were all **boundary** — equality, empty, negative.
Neither was ever a misremembered algorithm.

Phase 09 has fresh surface for both. Ordering risk: marking visited *after*
enqueue instead of before, which lets the same cell enter the queue twice.
Boundary risk: `Int.min` seeds, the empty-grid guard, and `k` vs `k - 1` in the
heap size.

---

## 📏 House Rules

- **Optimal only.** Brute force is named in the header with one line on why it
  loses, not implemented — same carve-out as Phase 08. The exception is the
  exponential naive versions in the backtracking and DP problems, where the
  repeated work is the whole reason memoization exists.
- No built-in helpers — no `reduce`, `map`, `filter`, `stride`, `enumerated`,
  `reversed`, `sorted`, `min`, `max`, `removeFirst`. `swapAt` is accepted.
  `for _ in 0..<n` is fine for a plain repeat count. Manual loops otherwise.
  Shared helpers live in `Sources/`, never pasted per file.
- No force unwraps. No `?? 0` — explicit `if let` / `else`.
- `final class` for reference types; `let` wherever there is no reassignment.
- LeetCode's own signatures and property names, so anything written here pastes
  straight in.
- Pattern files hold the generic template only. Named LeetCode solutions belong
  in `Problems/`.
- Every file opens with the problem statement, an example, and constraints.
- Time and space stated with the reason, not just the notation. Say what `k`,
  `V`, `E`, `L` and `α` refer to unprompted.
- Every test grid or graph carries its ASCII sketch above it.
- Test prints only, in this format:
  `print("\n========== Q75 - Kth Largest Element In An Array ==========")`
  then one print per case with the expected answer as an inline comment.
  No debug logging inside solutions.

---

## 📊 Status

Prerequisites ✅ · Patterns 7/7 ✅ · Problems 2/11 🔄 · Revision ⏳ · Mock 12 ⏳

**PHASE 09 IN PROGRESS** — steps 1–2 of 6 done, step 3 underway.

Branch: `phase_09_advanced_patterns`. Mock branch: `mock_12_phase_09`.

Time budget: patterns 8 hrs, problems 10 hrs, revision + mock 7 hrs — 25 total.

Carry-in: none from Phase 08 — Mock 11 cleared Q55 LRU Cache, so the deferral
that ran from Phase 06 through Phase 07 is closed. Mocks 03, 05 and 07 (the
cumulative ones) remain outstanding from the earlier phases and are independent
of this phase.

After Mock 12 the phase work is done and only Mocks 13–15 remain — mixed DSA,
company style, and the final assessment.
