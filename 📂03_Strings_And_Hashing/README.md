# 📂 Phase 03 — Strings & Hashing

## 🎯 Goal

Master the **String** and **Hashing** patterns behind Q20–Q29. The algorithms here are not hard — the difficulty is Swift itself. `String` is not integer-indexable, `count` is O(n), and `index(_:offsetBy:)` inside a loop silently turns an O(n) scan into O(n²).

By the end of this phase you should recognize the right pattern within seconds and implement the optimal solution confidently in Swift.

**Seven Easy, three Medium, no Hard.**

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

---

# 📂 Folder Structure

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
    ├── Q20_LC242_Valid_Anagram
    ├── Q21_LC049_Group_Anagrams
    ├── Q22_LC125_Valid_Palindrome
    ├── Q23_LC014_Longest_Common_Prefix
    ├── Q24_LC151_Reverse_Words
    ├── Q25_LC347_Top_K_Frequent_Elements
    ├── Q26_LC383_Ransom_Note
    ├── Q27_LC205_Isomorphic_Strings
    ├── Q28_LC290_Word_Pattern
    └── Q29_LC387_First_Unique_Character
```

**No pattern file without a problem behind it.** HashSet and Sorting_Strings were cut for this reason — no Q20–Q29 problem is Set-primary, and sorting is only the *suboptimal* alternative for Q20 and Q21. Both live in the notes below as "why not this", not as drills.

---

# 🧩 Patterns

| # | Pattern | What it does | Feeds |
|---|---------|--------------|-------|
| 01 | HashMap | Key → value, O(1) average lookup. Look up while building, never build then search | Q21, Q25, Q27, Q28 |
| 02 | Character Frequency | Dictionary counter and 26-slot array. Decrement must prune the key, not set 0 | Q20, Q25, Q26, Q29 |
| 03 | String Traversal | `Array(s)` once, manual alphanumeric check, manual case fold | all ten |
| 04 | Two Pointers on Strings | Converging pointers that move **conditionally** | Q22 |
| 05 | Word Splitting | Buffer, flush on separator, flush after the loop | Q24, Q28 |
| 06 | Vertical Scanning | Iterate across strings by column, not along one string | Q23 |
| 07 | Frequency Signature | 26 counts encoded with a delimiter — O(k) canonical key, no sort | Q21 |
| 08 | Bucket by Frequency | Array indexed by count, walked backwards. O(n) top-K | Q25 |
| 09 | Two-Map Bijection | Forward and reverse map. One map alone is not a bijection | Q27, Q28 |

---

# 📖 Problems

| #   | Problem                   | LeetCode | Approach | Complexity | Difficulty |
| --- | ------------------------- | -------- | -------- | ---------- | ---------- |
| Q20 | Valid Anagram             | LC242 | 26-slot count array, increment on s, decrement on t | O(n) / O(1) | Easy |
| Q21 | Group Anagrams            | LC049 | Count signature as dictionary key | O(n·k) / O(n·k) | Medium |
| Q22 | Valid Palindrome          | LC125 | Two pointers, skip non-alphanumeric, fold case | O(n) / O(n) | Easy |
| Q23 | Longest Common Prefix     | LC014 | Vertical scan, exit on first mismatch | O(S) / O(1) | Easy |
| Q24 | Reverse Words in a String | LC151 | Manual split, walk words backwards, manual join | O(n) / O(n) | Medium |
| Q25 | Top K Frequent Elements   | LC347 | Frequency map, bucket by count, walk backwards | O(n) / O(n) | Medium |
| Q26 | Ransom Note               | LC383 | One map of the magazine, decrement and prune | O(n+m) / O(1) | Easy |
| Q27 | Isomorphic Strings        | LC205 | Forward and backward map, both checked | O(n) / O(1) | Easy |
| Q28 | Word Pattern              | LC290 | Split into words, bijection Character ↔ String | O(n) / O(k) | Easy |
| Q29 | First Unique Character    | LC387 | Two passes — count, then first index with count 1 | O(n) / O(1) | Easy |

S = total characters across all input strings. O(1) space = fixed 26 or 128 slots.

---

# ⚠️ Wrong-Tool Trap Per Problem

* **Q20** — sorting both strings. Works, but O(n log n) when counting is O(n).
* **Q21** — sorted-string key. Correct, but O(k log k) per word; the count signature is O(k).
* **Q22** — building a cleaned copy first. O(n) extra space when two pointers need none.
* **Q23** — horizontal scanning. Same O(S), but rescans the shrinking prefix instead of exiting at the first bad column.
* **Q24** — `.split()` and `.reversed()`. Both banned, and the follow-up is "do it in place".
* **Q25** — sorting the frequency map (O(n log n)) or a heap (O(n log k)). Buckets are O(n).
* **Q26** — building a map for *both* strings. You only need one, then decrement.
* **Q27** — one map. Fails `"ab"` / `"aa"`.
* **Q28** — treating it as a character problem. The right side is *words* — the split is the hard part.
* **Q29** — nested loop searching for a repeat. Two passes over a count array is O(n).

---

# 🪤 Traps Logged This Phase

* `index(_:offsetBy:)` inside a loop is O(i) per call — an O(n) scan becomes O(n²). Convert to `[Character]` once.
* `s.count` walks the whole string. Cache it as `chars.count`.
* Setting `freq[c] = 0` instead of `nil` on decrement. The key survives and `isEmpty` never becomes true.
* `guard` states what must be **true** to continue, not what to reject.
* Empty-array guards are usually dead code — `0..<0` is a valid empty range. Only guard when the range can invert (`1..<0`).
* `left < right` when comparing pairs; `<=` only when the middle element itself matters.
* Conditional comparison requires conditional advancement — move only the pointer that failed the test.
* Dropping `left < right` from an inner skip loop. `",,,"` runs the pointers past each other.
* Omitting the delimiter in the count signature — `[1, 11]` and `[11, 1]` both encode to `"111"`.
* Checking the character before the length in Q23. Index out of range on `["abc", "ab"]`.
* Forgetting the flush after a split loop — the last word is dropped.
* Min-tracking needs a sentinel any real value beats (`Int.max`); max-tracking gets `0` free.
* Bucket arrays sized `n + 1` — the index *is* the count, so index `n` must exist.
* Walking frequency buckets forward returns the *least* frequent.
* Dictionary and Set have no iteration order. Never let output depend on it.

---

# 📌 House Rules

* Every solution file opens with the problem statement, an example, the constraints, and states time and space complexity.
* No predefined helper functions — no `reduce`, `map`, `filter`, `stride`, `max`, `min`, `swapAt`, `split`, `reversed`, `enumerated`. Write the loop.
* No nil-coalescing on dictionary access. Explicit `if let / else` for every increment and decrement.
* No force unwraps. `asciiValue` returns an optional — bind it.
* Compact formatting: at most one blank line, between logical blocks only. Blank line after every print statement.
* `.sorted()` is permitted inside Q20 and Q21 only, so the stated complexity is honest.
* Regression tests kept per problem: `",."`, `" "`, `""`, `"0P"`, `"ab"/"aa"`.

---

# 📈 Skills You'll Gain

* Efficient string traversal in Swift, and knowing what each access costs
* Character frequency counting with the right structure for the constraint
* Dictionary and Set mastery, including when a Set is the honest choice
* Canonical keys for grouping
* Bucketing as an alternative to sorting and heaps
* Solving mapping problems in both directions
* Recognizing the wrong tool before you write it

---

# 🎯 Interview Outcome

After this phase you should be able to:

* Identify the correct String & Hashing pattern quickly.
* Explain both brute-force and optimized approaches, and why the brute force fails.
* State the time/space **trade** rather than claiming the best of both.
* Implement clean, interview-ready Swift solutions.
* Solve most Easy and Medium String & Hashing problems asked at product companies.

---

# 📊 Status

Prerequisites ✅ · Patterns 9 / 9 ✅ · Problems 0 / 10 · Mock 04 (`mock_04_phase_03`) pending

---

## ✅ Next Phase

➡️ **Phase 04 — Sliding Window**

Build on String & Hashing to solve fixed-size and variable-size window problems. The prune-on-decrement idiom from `02_Character_Frequency` is what makes window matching work.
