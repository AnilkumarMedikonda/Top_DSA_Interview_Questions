# Phase 01 — Arrays

## 🎯 Objective

Master the fundamental Array patterns frequently asked in coding interviews.

---

## 📚 Prerequisites

- Arrays Basics
- Time & Space Complexity
- Traversal
- Searching
- Updating Elements

---

## 🧩 Patterns

| # | Pattern | Status |
|---|---------|:-----:|
| 01 | Counting | ✅ |
| 02 | In-Place Update | ✅ |
| 03 | Prefix & Suffix Sum | ✅ |
| 04 | Kadane's Algorithm | ✅ |
| 05 | Cyclic Sort | ✅ |
| 06 | Boyer-Moore Voting Algorithm | ✅ |

---

## 💻 Problems

| # | Problem | LC | Pattern | Status |
|---|---------|----|---------|:-----:|
| Q01 | Two Sum | 001 | Counting | ⬜ |
| Q02 | Best Time to Buy & Sell Stock | 121 | Kadane | ⬜ |
| Q03 | Contains Duplicate | 217 | Counting | ⬜ |
| Q04 | Maximum Subarray | 053 | Kadane | ⬜ |
| Q05 | Move Zeroes | 283 | In-Place Update | ⬜ |
| Q06 | Merge Sorted Array | 088 | In-Place Update | ⬜ |
| Q07 | Remove Duplicates From Sorted Array | 026 | In-Place Update | ⬜ |
| Q08 | Majority Element | 169 | Boyer-Moore | ⬜ |
| Q09 | Missing Number | 268 | Counting | ⬜ |
| Q10 | Product of Array Except Self | 238 | Prefix & Suffix Sum | ⬜ |

---

## 📝 Key Takeaways

- Counting → Frequency & Lookup
- In-Place Update → Modify array without extra space
- Prefix & Suffix Sum → Fast range calculations
- Kadane's Algorithm → Maximum subarray
- Cyclic Sort → Numbers in range 1...n
- Boyer-Moore → Majority Element (> n/2)

---

## ⚠️ Common Mistakes

- Dead guards — guard only when empty crashes or lies
- `min`/`max` are stdlib functions; locals shadow them
- Integer division truncates — convert both operands to Double
- Dictionary order is unspecified — walk the array for output
- Starting Kadane with `0` instead of `nums[0]`
- Majority (>n/2) ≠ Most Frequent
- Cyclic sort needs `while`, not `for`
- Prefix products can't divide — one zero kills it

---

## 📈 Progress

- ✅ Prerequisites
- ✅ Patterns (6/6)
- ⬜ Problems (0/10)
- ⬜ Revision
