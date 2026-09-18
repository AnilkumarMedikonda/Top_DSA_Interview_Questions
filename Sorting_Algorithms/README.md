# 📂 Sorting Algorithms

The one area the 85 never make you write. Six algorithms, no LeetCode numbers
behind them — this sits outside the phase sequence.

Every piece already exists in the repo: the merge step is Q58 and Q76, the
partition walk is Q15 Sort Colors, the heap is Phase 09's pattern 01.

---

## 📝 Algorithms

| # | Algorithm | Idea | Time | Space | Stable | In-place |
|---|-----------|------|------|-------|:------:|:--------:|
| 01 | Bubble Sort | Swap adjacent pairs, largest bubbles to the end | O(n²) · O(n) best | O(1) | ✅ | ✅ |
| 02 | Selection Sort | Find the minimum, swap it into place | O(n²) always | O(1) | ❌ | ✅ |
| 03 | Insertion Sort | Grow a sorted prefix, shift each new element into place | O(n²) · O(n) best | O(1) | ✅ | ✅ |
| 04 | Merge Sort | Divide, recurse, merge two sorted halves | O(n log n) | O(n) | ✅ | ❌ |
| 05 | Quick Sort | Partition around a pivot, recurse both sides | O(n log n) avg · O(n²) worst | O(log n) | ❌ | ✅ |
| 06 | Heap Sort | Build a heap, extract repeatedly | O(n log n) | O(1) | ❌ | ✅ |

**01** is here to make O(n²) concrete. The early exit on a zero-swap pass is
what turns the best case into O(n).

**02** has no early exit — sorted input still costs O(n²). Its one advantage is
exactly n-1 swaps whatever the input, which wins when writes are expensive.

**03** is the O(n²) that is actually used — libraries fall back to it for small
subarrays. Shift rather than swap, and stop as soon as the element lands.

**04** is the one to write cold. Stable if `merge` takes from the left when the
two values are equal.

**05** is the one to explain. Worst case O(n²) on sorted input with a naive
pivot — that trade is the interview question.

**06** is the heap from Phase 09 plus an extraction loop. O(n log n) *and* O(1)
space, which neither of the others manages.

---

## 🎯 What To Master

Merge and quick are the only two you would be asked to write. The heap as a
*structure* matters more than heap sort does — Q75, Q76 and every top-k problem
need it. The three O(n²) sorts are context, not practice.

| | Write cold | Explain | Know it exists |
|---|:---:|:---:|:---:|
| Merge | ✅ | ✅ | |
| Quick | ✅ | ✅ | |
| Heap (structure) | ✅ | ✅ | |
| Heap sort | | ✅ | |
| Insertion | | ✅ | |
| Selection, Bubble | | | ✅ |

---

## ⚖️ Choosing Between Them

| Question | Answer |
|----------|--------|
| Guaranteed O(n log n)? | Merge or heap |
| Stability? | Merge |
| O(1) extra space? | Heap or quick |
| Linked list? | Merge — no random access needed |
| Fastest in practice? | Quick, on average |
| Small or nearly sorted input? | Insertion — O(n) when the array is close to done |
| Writes are expensive? | Selection — exactly n-1 swaps |

The follow-up that catches most people: **why is quick sort the library default
when heap sort has a better worst case?** Cache locality and a smaller constant.

---

## 📏 House Rules

- No built-ins — `swapAt`, `min()` and `max()` are fine.
- No force unwraps, no `?? 0`.
- `let` wherever there is no reassignment.
- Never name a local after a function used in the same scope.
- Declare nested helpers before the loop that calls them.
- Every file opens with the idea, a trace, and time/space with the reason.
- Test prints only: section header, then one print per case with the expected
  answer inline.

Standard test set for all six: `[5,3,8,4,2]`, `[1,2,3,4,5]`, `[5,4,3,2,1]`,
`[3,3,3]`, `[2,2,1,3,1]`, `[1]`, `[]`.

---

## 📊 Status

Bubble ✅ · Selection ✅ · Insertion ✅ · Merge ✅ · Quick ✅ · Heap ✅

**COMPLETE** — all six written and tested.

Branch: `sorting_algorithms`.
