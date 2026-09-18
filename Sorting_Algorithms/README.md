# 📂 Sorting Algorithms

The one area the 85 never make you write. Five algorithms, no LeetCode numbers
behind them — this sits outside the phase sequence.

Every piece already exists in the repo: the merge step is Q58 and Q76, the
partition walk is Q15 Sort Colors, the heap is Phase 09's pattern 01.

---

## 📝 Algorithms

| # | Algorithm | Idea | Time | Space | Stable | In-place |
|---|-----------|------|------|-------|:------:|:--------:|
| 01 | Bubble Sort | Swap adjacent pairs, largest bubbles to the end | O(n²) · O(n) best | O(1) | ✅ | ✅ |
| 02 | Insertion Sort | Grow a sorted prefix, shift each new element into place | O(n²) · O(n) best | O(1) | ✅ | ✅ |
| 03 | Merge Sort | Divide, recurse, merge two sorted halves | O(n log n) | O(n) | ✅ | ❌ |
| 04 | Quick Sort | Partition around a pivot, recurse both sides | O(n log n) avg · O(n²) worst | O(log n) | ❌ | ✅ |
| 05 | Heap Sort | Build a heap, extract repeatedly | O(n log n) | O(1) | ❌ | ✅ |

**01** is here to make O(n²) concrete. The early exit on a zero-swap pass is
what turns the best case into O(n).

**02** is the O(n²) that is actually used — libraries fall back to it for small
subarrays. Shift rather than swap, and stop as soon as the element lands.

**03** is the one to write cold. Stable if `merge` takes from the left when the
two values are equal.

**04** is the one to explain. Worst case O(n²) on sorted input with a naive
pivot — that trade is the interview question.

**05** is the heap from Phase 09 plus an extraction loop. O(n log n) *and* O(1)
space, which neither of the others manages.

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

Standard test set for all four: `[5,2,9,1,7]`, `[1,2,3,4,5]`, `[5,4,3,2,1]`,
`[3,3,3]`, `[1]`, `[]`.

---

## 📊 Status

Bubble ⏳ · Insertion ⏳ · Merge ⏳ · Quick ⏳ · Heap ⏳

Branch: `sorting_algorithms`.
