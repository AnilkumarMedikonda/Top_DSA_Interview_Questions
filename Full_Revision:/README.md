# 📂 Full Revision — Q01 to Q85

Second pass over the whole repo. Every problem rewritten blind from an empty
file, one by one, oldest phase first.

This is separate from the `Phase_0X_Revision` files inside each phase — those
were written while the phase was fresh. This one measures what survived.

---

## 📏 Rules

- **Optimal only.** Brute force named out loud, not written.
- **Blind.** Empty file, no peeking until the tests run.
- **Build before calling it done.** Two of Mock 09's three failures were
  compiler errors.
- **Check the trace, not just the output.** Phase 09's misses were wrong
  computations producing right answers.
- **Expected answer in the comment, written before the run.** Every test line
  ends with `// expected`. Phase 01's Q10 bug survived a full pass because the
  console was bare numbers.
- `swapAt`, `min()` and `max()` are fine; everything else stays manual. No
  force unwraps, `let` over `var`, complexity stated with the reason.

Exception: **Q82–Q85** — sketch the naive version first. There the optimal is a
collapse of it, not a faster alternative. (Q13 and Q32 done: both written
directly, no naive sketch needed.)

---

## 📐 File Format

One playground per phase. Problems stacked as blocks inside the single file,
in Q order.

```swift
//==============================================================
// MARK: - Q01. Two Sum
// Difficulty: Easy
// LeetCode: LC001
//==============================================================
//
// Problem:
// <statement, wrapped>
//
// Example:
// Input: ...
// Output: ...
//
// Time: O(n)
// Space: O(n)
//
//==============================================================

print("\n==============================================================")
print("Q01 - Two Sum")
print("==============================================================")

// Solution

// Test cases
print("Input: ... -> \(call)")  // expected

print()
```

Shared types and helpers (`ListNode`, `TreeNode`, frequency maps, graph
builders) go in a `// MARK: - Helpers` block at the top of the phase file.
Phase 03 carries `getCharsFrequencyMap`, `getNumbersFrequencyMap`,
`signature`, `getWords` and `isAlphanumeric`; Phases 07–09 carry the node types
and builders. Phases 01, 02, 04–06 need none.

**Test count:** Easy 4 · Medium 4–5 · Hard 5–7. Always 1–2 meaningful edge
cases. Nothing artificial or repetitive.

---

## 📊 Progress

Clean first pass = solutions correct before review, counted blind.

| Phase | Questions | Rewritten | Clean first pass | Status |
|-------|-----------|----------:|-----------------:|:------:|
| 01 Arrays | Q01–Q10 | 10 / 10 | 8 / 10 | ✅ |
| 02 Two Pointers | Q11–Q19 | 9 / 9 | 5 / 9 | ✅ |
| 03 Strings & Hashing | Q20–Q29 | 10 / 10 | 8 / 10 | ✅ |
| 04 Sliding Window | Q30–Q38 | 9 / 9 | 6 / 9 | ✅ |
| 05 Binary Search | Q39–Q47 | 9 / 9 | 9 / 9 | ✅ |
| 06 Stack & Queue | Q48–Q56 | 0 / 9 | — | 🔄 |
| 07 Linked List | Q57–Q65 | 0 / 9 | — | ⏳ |
| 08 Trees & BST | Q66–Q74 | 0 / 9 | — | ⏳ |
| 09 Advanced Patterns | Q75–Q85 | 0 / 11 | — | ⏳ |

**47 / 85 rewritten · 36 / 47 clean first pass (77%)**

By phase: 80% · 56% · 80% · 67% · 100%

---

## 🔍 Misses So Far

Every miss has been mechanical, never a forgotten algorithm. The class shifts
by phase.

**Phases 01–02 — index mechanics (6)**

| # | Problem | What broke |
|---|---------|------------|
| Q04 | Maximum Subarray | Kadane reset compared `nums[i] > currentSum`, not `currentSum + nums[i]` |
| Q10 | Product Except Self | Prefix loop read `result[i]` instead of `result[i-1]` |
| Q12 | 3Sum | `left <= right` let one element be used twice |
| Q15 | Sort Colors | Incremented `low`/`mid` before the swap |
| Q17 | Rotate Array | `count / k` instead of `k % count`; then off-by-one reverse bounds |
| Q18 | Merge Intervals | Seeded `result` from the unsorted array |

**Phase 03 — guard clauses (2)**

| # | Problem | What broke |
|---|---------|------------|
| Q26 | Ransom Note | Exhausted count nil-ed the entry instead of returning false |
| Q23 | Longest Common Prefix | `words.count > 1` returned `""` for a single-word array |

Both Phase 03 misses were on the two easiest problems in the set. Q21, Q25,
Q27 and Q28 — the four with real structure — came back clean.

**Phase 04 — counters and sentinels (3)**

| # | Problem | What broke |
|---|---------|------------|
| Q30 | Longest Substring | `Int.min` sentinel returned -1 on empty input |
| Q34 | Find All Anagrams | Window sized by `patternMap.count` (distinct) instead of `p.count` (length) |
| Q36 | Fruit Into Baskets | `uniquTypes -= 1` on every shrink step, not only when a type hit zero |

Q36 is the same shape as Q26 in Phase 03 — a counter changed on the wrong side
of the zero-check. Twice across two phases: worth one extra glance at every
decrement-and-prune. Both hards, Q32 and Q38, came back clean.

**Phase 05 — none**

All nine correct on the first attempt, including the Hard. The review caught
only hygiene: Q43's loop locals shadowing the outer `row`/`colum`, and
complexity headers on the answer-space problems stating the log over n instead
of over the search range.

---

## 📋 Question List

☐ as you rewrite. 🟢 Easy · 🟡 Medium · 🔴 Hard

### 01 Arrays — Q01–Q10 ✅

| File | Level | ☐ |
|------|-------|:-:|
| `Q01_LC001_Two_Sum` | 🟢 Easy | ☑ |
| `Q02_LC121_Best_Time_To_Buy_And_Sell_Stock` | 🟢 Easy | ☑ |
| `Q03_LC217_Contains_Duplicate` | 🟢 Easy | ☑ |
| `Q04_LC053_Maximum_Subarray` | 🟡 Medium | ☑ |
| `Q05_LC283_Move_Zeroes` | 🟢 Easy | ☑ |
| `Q06_LC088_Merge_Sorted_Array` | 🟢 Easy | ☑ |
| `Q07_LC026_Remove_Duplicates_From_Sorted_Array` | 🟢 Easy | ☑ |
| `Q08_LC169_Majority_Element` | 🟢 Easy | ☑ |
| `Q09_LC268_Missing_Number` | 🟢 Easy | ☑ |
| `Q10_LC238_Product_Of_Array_Except_Self` | 🟡 Medium | ☑ |

### 02 Two Pointers — Q11–Q19 ✅

| File | Level | ☐ |
|------|-------|:-:|
| `Q11_LC011_Container_With_Most_Water` | 🟡 Medium | ☑ |
| `Q12_LC015_Three_Sum` | 🟡 Medium | ☑ |
| `Q13_LC042_Trapping_Rain_Water` | 🔴 Hard | ☑ |
| `Q14_LC977_Squares_Of_A_Sorted_Array` | 🟢 Easy | ☑ |
| `Q15_LC075_Sort_Colors` | 🟡 Medium | ☑ |
| `Q16_LC031_Next_Permutation` | 🟡 Medium | ☑ |
| `Q17_LC189_Rotate_Array` | 🟡 Medium | ☑ |
| `Q18_LC056_Merge_Intervals` | 🟡 Medium | ☑ |
| `Q19_LC041_First_Missing_Positive` | 🔴 Hard | ☑ |

### 03 Strings & Hashing — Q20–Q29 ✅

| File | Level | ☐ |
|------|-------|:-:|
| `Q20_LC242_Valid_Anagram` | 🟢 Easy | ☑ |
| `Q21_LC049_Group_Anagrams` | 🟡 Medium | ☑ |
| `Q22_LC125_Valid_Palindrome` | 🟢 Easy | ☑ |
| `Q23_LC014_Longest_Common_Prefix` | 🟢 Easy | ☑ |
| `Q24_LC151_Reverse_Words_In_A_String` | 🟡 Medium | ☑ |
| `Q25_LC347_Top_K_Frequent_Elements` | 🟡 Medium | ☑ |
| `Q26_LC383_Ransom_Note` | 🟢 Easy | ☑ |
| `Q27_LC205_Isomorphic_Strings` | 🟢 Easy | ☑ |
| `Q28_LC290_Word_Pattern` | 🟢 Easy | ☑ |
| `Q29_LC387_First_Unique_Character_In_A_String` | 🟢 Easy | ☑ |

### 04 Sliding Window — Q30–Q38 ✅

| File | Level | ☐ |
|------|-------|:-:|
| `Q30_LC003_Longest_Substring_Without_Repeating_Characters` | 🟡 Medium | ☑ |
| `Q31_LC424_Longest_Repeating_Character_Replacement` | 🟡 Medium | ☑ |
| `Q32_LC076_Minimum_Window_Substring` | 🔴 Hard | ☑ |
| `Q33_LC567_Permutation_In_String` | 🟡 Medium | ☑ |
| `Q34_LC438_Find_All_Anagrams_In_A_String` | 🟡 Medium | ☑ |
| `Q35_LC643_Maximum_Average_Subarray_I` | 🟢 Easy | ☑ |
| `Q36_LC904_Fruit_Into_Baskets` | 🟡 Medium | ☑ |
| `Q37_LC209_Minimum_Size_Subarray_Sum` | 🟡 Medium | ☑ |
| `Q38_LC239_Sliding_Window_Maximum` | 🔴 Hard | ☑ |

### 05 Binary Search — Q39–Q47 ✅

| File | Level | ☐ |
|------|-------|:-:|
| `Q39_LC704_Binary_Search` | 🟢 Easy | ☑ |
| `Q40_LC035_Search_Insert_Position` | 🟢 Easy | ☑ |
| `Q41_LC033_Search_In_Rotated_Sorted_Array` | 🟡 Medium | ☑ |
| `Q42_LC153_Find_Minimum_In_Rotated_Sorted_Array` | 🟡 Medium | ☑ |
| `Q43_LC074_Search_A_2D_Matrix` | 🟡 Medium | ☑ |
| `Q44_LC875_Koko_Eating_Bananas` | 🟡 Medium | ☑ |
| `Q45_LC162_Find_Peak_Element` | 🟡 Medium | ☑ |
| `Q46_LC1011_Capacity_To_Ship_Packages_Within_D_Days` | 🟡 Medium | ☑ |
| `Q47_LC410_Split_Array_Largest_Sum` | 🔴 Hard | ☑ |

### 06 Stack & Queue — Q48–Q56 🔄

| File | Level | ☐ |
|------|-------|:-:|
| `Q48_LC020_Valid_Parentheses` | 🟢 Easy | ☐ |
| `Q49_LC155_Min_Stack` | 🟡 Medium | ☐ |
| `Q50_LC739_Daily_Temperatures` | 🟡 Medium | ☐ |
| `Q51_LC150_Evaluate_Reverse_Polish_Notation` | 🟡 Medium | ☐ |
| `Q52_LC394_Decode_String` | 🟡 Medium | ☐ |
| `Q53_LC232_Implement_Queue_Using_Stacks` | 🟢 Easy | ☐ |
| `Q54_LC735_Asteroid_Collision` | 🟡 Medium | ☐ |
| `Q55_LC146_LRU_Cache` | 🟡 Medium | ☐ |
| `Q56_LC496_Next_Greater_Element_I` | 🟢 Easy | ☐ |

### 07 Linked List — Q57–Q65

| File | Level | ☐ |
|------|-------|:-:|
| `Q57_LC206_Reverse_Linked_List` | 🟢 Easy | ☐ |
| `Q58_LC021_Merge_Two_Sorted_Lists` | 🟢 Easy | ☐ |
| `Q59_LC141_Linked_List_Cycle` | 🟢 Easy | ☐ |
| `Q60_LC876_Middle_Of_Linked_List` | 🟢 Easy | ☐ |
| `Q61_LC002_Add_Two_Numbers` | 🟡 Medium | ☐ |
| `Q62_LC019_Remove_Nth_Node_From_End` | 🟡 Medium | ☐ |
| `Q63_LC138_Copy_List_With_Random_Pointer` | 🟡 Medium | ☐ |
| `Q64_LC143_Reorder_List` | 🟡 Medium | ☐ |
| `Q65_LC025_Reverse_Nodes_In_K_Group` | 🔴 Hard | ☐ |

### 08 Trees & BST — Q66–Q74

| File | Level | ☐ |
|------|-------|:-:|
| `Q66_LC104_Maximum_Depth_Of_Binary_Tree` | 🟢 Easy | ☐ |
| `Q67_LC100_Same_Tree` | 🟢 Easy | ☐ |
| `Q68_LC226_Invert_Binary_Tree` | 🟢 Easy | ☐ |
| `Q69_LC102_Binary_Tree_Level_Order_Traversal` | 🟡 Medium | ☐ |
| `Q70_LC098_Validate_Binary_Search_Tree` | 🟡 Medium | ☐ |
| `Q71_LC543_Diameter_Of_Binary_Tree` | 🟢 Easy | ☐ |
| `Q72_LC235_Lowest_Common_Ancestor_Of_A_BST` | 🟡 Medium | ☐ |
| `Q73_LC230_Kth_Smallest_Element_In_A_BST` | 🟡 Medium | ☐ |
| `Q74_LC124_Binary_Tree_Maximum_Path_Sum` | 🔴 Hard | ☐ |

### 09 Advanced Patterns — Q75–Q85

| File | Level | ☐ |
|------|-------|:-:|
| `Q75_LC215_Kth_Largest_Element_In_An_Array` | 🟡 Medium | ☐ |
| `Q76_LC023_Merge_K_Sorted_Lists` | 🔴 Hard | ☐ |
| `Q77_LC200_Number_Of_Islands` | 🟡 Medium | ☐ |
| `Q78_LC994_Rotting_Oranges` | 🟡 Medium | ☐ |
| `Q79_LC207_Course_Schedule` | 🟡 Medium | ☐ |
| `Q80_LC127_Word_Ladder` | 🔴 Hard | ☐ |
| `Q81_LC684_Redundant_Connection` | 🟡 Medium | ☐ |
| `Q82_LC078_Subsets` | 🟡 Medium | ☐ |
| `Q83_LC039_Combination_Sum` | 🟡 Medium | ☐ |
| `Q84_LC198_House_Robber` | 🟡 Medium | ☐ |
| `Q85_LC300_Longest_Increasing_Subsequence` | 🟡 Medium | ☐ |

**Totals: 🟢 29 Easy · 🟡 48 Medium · 🔴 8 Hard**

---

## 🎯 Next

**Phase 06 — Stack & Queue, Q48–Q56. In progress.**

Phase 05 answered the question Phase 04 left open. Phase 04 dipped to 67% and
raised the worry that decay was across the board; Phase 05 came back 9/9. The
patterns drilled hardest held completely. The misses cluster in counters,
guards and index arithmetic around the core loop — not in any one phase.

Phase 06 has no Hard, but Q55 LRU Cache is the longest implementation in the
set: HashMap plus doubly linked list, sentinels at both ends, and eviction
from both structures. It was clean on the original revision. Q48's missing
`else` on the mismatch branch was the one regression last time — worth a
trace, since every test passed with it wrong.

---

## 📁 Structure

```text
Full_Revision/
│
├── README.md
│
├── 01_Arrays_Q01_Q10.playground
├── 02_Two_Pointers_Q11_Q19.playground
├── 03_Strings_And_Hashing_Q20_Q29.playground
├── 04_Sliding_Window_Q30_Q38.playground
├── 05_Binary_Search_Q39_Q47.playground
├── 06_Stack_And_Queue_Q48_Q56.playground
├── 07_Linked_List_Q57_Q65.playground
├── 08_Trees_And_BST_Q66_Q74.playground
└── 09_Advanced_Patterns_Q75_Q85.playground
```

One playground per phase, Q-range in the name, matching the `Mock_Sessions`
convention. All problems for a phase live in the single file, so the whole
phase runs in one go.

No `Patterns/` or `Prerequisites` here — those were learning aids and do not
get rewritten.

Branch: `full_revision`.

Mock re-runs live in `Mock_Reruns/` on branch `mock_reruns`.
