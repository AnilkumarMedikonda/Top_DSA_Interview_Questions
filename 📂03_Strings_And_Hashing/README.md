# 📂 Phase 03 — Strings & Hashing

Q20–Q29. Seven Easy, three Medium, no Hard.

The algorithms aren't hard — the difficulty is Swift. `String` isn't integer-indexable, `count` is O(n), and `index(_:offsetBy:)` inside a loop turns an O(n) scan into O(n²). Every problem here opens with `Array(s)`.

---

# 📚 Topics Covered

* String traversal and the `[Character]` conversion
* Character frequency — dictionary counter and 26-slot array
* HashMap as lookup, counter, and grouping structure
* Two pointers with conditional advancement
* Manual word splitting (no `split()`)
* Vertical scanning across an array of strings
* Canonical keys from frequency signatures
* Bucketing by count instead of sorting
* Two-map bijection

## 📂 Structure

```text
03_Strings_And_Hashing
│
├── README.md
├── Strings_And_Hashing_Prerequisites
│
├── Patterns
│   ├── 01_HashMap
│   ├── 02_Character_Frequency
│   ├── 03_String_Traversal
│   ├── 04_Two_Pointers_On_Strings
│   ├── 05_Word_Splitting
│   ├── 06_Vertical_Scanning
│   ├── 07_Frequency_Signature
│   ├── 08_Bucket_By_Frequency
│   └── 09_Two_Map_Bijection
│
└── Problems
    └── Q20_LC242 … Q29_LC387
```

No pattern file without a problem behind it.

---

## 🧩 Patterns

| # | Pattern | Feeds |
|---|---------|-------|
| 01 | HashMap | Q21, Q25, Q27, Q28 |
| 02 | Character Frequency | Q20, Q25, Q26, Q29 |
| 03 | String Traversal | all ten |
| 04 | Two Pointers on Strings | Q22 |
| 05 | Word Splitting | Q24, Q28 |
| 06 | Vertical Scanning | Q23 |
| 07 | Frequency Signature | Q21 |
| 08 | Bucket by Frequency | Q25 |
| 09 | Two-Map Bijection | Q27, Q28 |

---

## 📖 Problems

| # | Problem | LC | Approach | Complexity |
|---|---------|----|----------|------------|
| Q20 | Valid Anagram | 242 | One 26-slot array, increment on s, decrement on t | O(n) / O(1) |
| Q21 | Group Anagrams | 049 | Count signature as dictionary key | O(n·k) / O(n·k) |
| Q22 | Valid Palindrome | 125 | Lowercase once, two pointers, skip in place | O(n) / O(n) |
| Q23 | Longest Common Prefix | 014 | Horizontal fold with early exit | O(S) / O(k) |
| Q24 | Reverse Words | 151 | Manual split, prepend each finished word | O(n·k) / O(n) |
| Q25 | Top K Frequent | 347 | Bucket by count, walk backwards | O(n) / O(n) |
| Q26 | Ransom Note | 383 | One map of the magazine, decrement and prune | O(n+m) / O(1) |
| Q27 | Isomorphic Strings | 205 | Forward and backward map | O(n) / O(k) |
| Q28 | Word Pattern | 290 | Split, then bijection Character ↔ String | O(n) / O(k) |
| Q29 | First Unique Character | 387 | Count, then first index with count 1 | O(n) / O(1) |

S = total characters across all inputs. O(1) space = fixed 26 slots.

---

## ⚠️ Wrong Tool Per Problem

* **Q20** — sorting. O(n log n) when counting is O(n).
* **Q21** — sorted-string key, O(k log k) per word. A `[Character: Int]` can't be a key at all — Dictionary isn't Hashable.
* **Q22** — building a cleaned copy. Saves nothing.
* **Q23** — vertical scan is the alternative; same O(S), exits earlier.
* **Q24** — `.split()` / `.reversed()`. Banned, and the follow-up is "in place".
* **Q25** — sorting (O(n log n)) or a heap (O(n log k)). Buckets are O(n).
* **Q26** — comparing maps with `==`. The magazine is allowed extras.
* **Q27** — one map. Fails `"ab"` / `"aa"`.
* **Q28** — treating it as characters. The right side is words.
* **Q29** — iterating the map. Finds *a* unique character, not the *first*.

---

## 📌 House Rules

* Problem statement, example, constraints, and complexity at the top of every file.
* Brute force + optimal only. Alternatives get named in the notes, not implemented.
* No `reduce`, `map`, `filter`, `stride`, `max`, `min`, `swapAt`, `split`, `reversed`, `enumerated`.
* No `?? 0` on dictionary access — explicit `if let / else`.
* No force unwraps, no force casts.
* At most one blank line between logical blocks. Blank line after every print.
* `.sorted()` allowed in Q20 and Q21 only, so the stated complexity is honest.

---

## 📊 Status

Prerequisites ✅ · Patterns 9/9 ✅ · Problems 10/10 ✅ · Revision pending · Mock 04 (`mock_04_phase_03`) pending

➡️ Next: **Phase 04 — Sliding Window**. The prune-on-decrement idiom from `02_Character_Frequency` is what makes window matching work.
