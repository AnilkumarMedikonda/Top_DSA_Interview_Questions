// Q20_LC242_Valid_Anagram

// MARK: - Helper

func buildFreqMap(_ s: String) -> [Character: Int] {
    var freq = [Character: Int]()

    for ch in s {
        if let count = freq[ch] {
            freq[ch] = count + 1
        } else {
            freq[ch] = 1
        }
    }

    return freq
}

// MARK: - Better — two frequency maps
// Works for any character set, including Unicode.
// T - O(n)  S - O(k) distinct characters

func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    let freq1 = buildFreqMap(s)
    let freq2 = buildFreqMap(t)

    return freq1 == freq2
}

print(isAnagram("anagram", "nagaram"))

print(isAnagram("car", "rat"))

// MARK: - Optimal — single 26-slot array
// Increment on s, decrement on t. All zeros means anagram.
// Valid only because the constraint says lowercase a-z.
// T - O(n)  S - O(1)

func isAnagramOptimal(_ s: String, _ t: String) -> Bool {
    let a = Array(s)
    let b = Array(t)

    guard a.count == b.count else { return false }

    var counts = Array(repeating: 0, count: 26)

    for i in 0..<a.count {
        if let ascii = a[i].asciiValue {
            counts[Int(ascii) - 97] += 1
        }

        if let ascii = b[i].asciiValue {
            counts[Int(ascii) - 97] -= 1
        }
    }

    for i in 0..<26 {
        if counts[i] != 0 {
            return false
        }
    }

    return true
}

print(isAnagramOptimal("anagram", "nagaram"))

print(isAnagramOptimal("car", "rat"))
