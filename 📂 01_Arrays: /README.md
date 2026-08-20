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
| Q01 | Two Sum | 001 | Counting | ✅ |
| Q02 | Best Time to Buy & Sell Stock | 121 | Kadane | ✅ |
| Q03 | Contains Duplicate | 217 | Counting | ✅ |
| Q04 | Maximum Subarray | 053 | Kadane | ✅ |
| Q05 | Move Zeroes | 283 | In-Place Update | ✅ |
| Q06 | Merge Sorted Array | 088 | In-Place Update | ✅ |
| Q07 | Remove Duplicates From Sorted Array | 026 | In-Place Update | ✅ |
| Q08 | Majority Element | 169 | Boyer-Moore | ✅ |
| Q09 | Missing Number | 268 | Counting | ✅ |
| Q10 | Product of Array Except Self | 238 | Prefix & Suffix Sum | ✅ |

---

## 📝 Key Takeaways

- Counting → Frequency & Lookup
- In-Place Update → Modify array without extra space
- Prefix & Suffix Products → Compute left/right products efficiently
- Kadane's Algorithm → Maximum subarray sum
- Cyclic Sort → Numbers in range `0...n` or `1...n`
- Boyer-Moore Voting Algorithm → Majority element (`> n/2`)

---

## ⚠️ Common Mistakes

- Dead guards — guard only when empty crashes or lies
- `min`/`max` are stdlib functions; locals shadow them
- Integer division truncates — convert both operands to `Double`
- Dictionary order is unspecified — don't rely on iteration order
- Starting Kadane with `0` instead of `nums[0]`
- Majority (`> n/2`) ≠ Most Frequent
- Cyclic Sort requires `while`, not `for`
- Prefix/Suffix product cannot use division when zeros exist
- Merge Sorted Array must merge **from the end**
- Remove Duplicates works because the array is **already sorted**

---

## 📈 Progress

- ✅ Prerequisites
- ✅ Patterns (6/6)
- ✅ Problems (10/10)
- ⬜ Mock Interview 01
- ⬜ Revision
