import Foundation

//==============================================================
// Q50 - LC739 - Daily Temperatures
//==============================================================
//
// Problem
// -------
// Given an array temperatures where temperatures[i] is the temperature
// on day i, return an array answer where answer[i] is the number of
// days to wait after day i for a warmer temperature. If no future day
// is warmer, answer[i] is 0.
//
// Example
// -------
// temperatures = [73, 74, 75, 71, 69, 72, 76, 73]
// answer       = [ 1,  1,  4,  2,  1,  1,  0,  0]
//
// temperatures = [30, 40, 50, 60]
// answer       = [ 1,  1,  1,  0]
//
// temperatures = [30, 60, 90]
// answer       = [ 1,  1,  0]
//
// Constraints
// -----------
// 1 <= temperatures.count <= 10^5
// 30 <= temperatures[i] <= 100
//
// 10^5 means O(n^2) is 10^10 operations and will time out. The brute
// force is here for the contrast, not because it passes.
//
// Pattern : Monotonic Stack (01_Monotonic_Stack)
//
// Brute Force : O(n^2) time, O(1) auxiliary
// Optimal     : O(n)   time, O(n) space
//
//==============================================================


// MARK: - Brute Force

// For each day, walk forward until something warmer shows up.
//
// Time  : O(n^2)
// Space : O(1) auxiliary   (result is required output, not working space)
func dailyTemperaturesBruteForce(_ temps: [Int]) -> [Int] {
    var result = [Int](repeating: 0, count: temps.count)

    for i in 0..<temps.count {
        var j = i + 1
        while j < temps.count {
            if temps[j] > temps[i] {
                result[i] = j - i
                break
            }
            j += 1
        }
    }

    return result
}


// MARK: - Optimal (Monotonic Stack)

// Decreasing stack of INDICES. A pop means that day's answer has just
// arrived — the current day is warmer than it.
//
// Indices, not temperatures: the answer is a gap between two days, and
// a stack of temperatures pops correctly while making the distance
// impossible to compute.
//
// result seeded to 0 means "never resolved" needs no cleanup — whatever
// is still on the stack when the loop ends is already correct.
//
// Strict < so equal temperatures do not resolve each other.
//
// Time  : O(n)   each index pushed once, popped at most once
// Space : O(n)
func dailyTemperaturesOptimal(_ temps: [Int]) -> [Int] {
    var result = [Int](repeating: 0, count: temps.count)
    var indexes = [Int]()

    for i in 0..<temps.count {
        while let last = indexes.last, temps[last] < temps[i] {
            let waitingDay = indexes.removeLast()
            result[waitingDay] = i - waitingDay
        }
        indexes.append(i)
    }

    return result
}


// MARK: - Test Cases

print("========== BRUTE FORCE ==========")

print("[73,74,75,71,69,72,76,73] :", dailyTemperaturesBruteForce([73, 74, 75, 71, 69, 72, 76, 73]))
// [1, 1, 4, 2, 1, 1, 0, 0]

print("[30,40,50,60] :", dailyTemperaturesBruteForce([30, 40, 50, 60]))
// [1, 1, 1, 0]

print("[30,60,90] :", dailyTemperaturesBruteForce([30, 60, 90]))
// [1, 1, 0]

print("[73,73,74] :", dailyTemperaturesBruteForce([73, 73, 74]))
// [2, 1, 0]

print("[90,80,70] :", dailyTemperaturesBruteForce([90, 80, 70]))
// [0, 0, 0]

print("[50] :", dailyTemperaturesBruteForce([50]))
// [0]

print()

print("========== OPTIMAL ==========")

print("[73,74,75,71,69,72,76,73] :", dailyTemperaturesOptimal([73, 74, 75, 71, 69, 72, 76, 73]))
// [1, 1, 4, 2, 1, 1, 0, 0]

print("[30,40,50,60] :", dailyTemperaturesOptimal([30, 40, 50, 60]))
// [1, 1, 1, 0]

print("[30,60,90] :", dailyTemperaturesOptimal([30, 60, 90]))
// [1, 1, 0]

print("[73,73,74] :", dailyTemperaturesOptimal([73, 73, 74]))
// [2, 1, 0]

print("[90,80,70] :", dailyTemperaturesOptimal([90, 80, 70]))
// [0, 0, 0]

print("[50] :", dailyTemperaturesOptimal([50]))
// [0]


// MARK: - Dry Run

/*
 temps = [73, 74, 75, 71, 69, 72, 76, 73]

 i=0  73                     stack []            push 0    [0]
 i=1  74  temps[0]=73 < 74   pop 0  result[0]=1  push 1    [1]
 i=2  75  temps[1]=74 < 75   pop 1  result[1]=1  push 2    [2]
 i=3  71  temps[2]=75 < 71?  no                  push 3    [2,3]
 i=4  69  temps[3]=71 < 69?  no                  push 4    [2,3,4]
 i=5  72  temps[4]=69 < 72   pop 4  result[4]=1
          temps[3]=71 < 72   pop 3  result[3]=2
          temps[2]=75 < 72?  no                  push 5    [2,5]
 i=6  76  temps[5]=72 < 76   pop 5  result[5]=1
          temps[2]=75 < 76   pop 2  result[2]=4  push 6    [6]
 i=7  73  temps[6]=76 < 73?  no                  push 7    [6,7]

 stack [6,7] never resolved -> result[6]=0, result[7]=0

 result = [1, 1, 4, 2, 1, 1, 0, 0]

 i=5 is the multi-pop step — one warm day resolves two earlier days.
 An `if` in place of the `while` would resolve only day 4 and leave
 result[3] at 0.
*/


// MARK: - Notes

/*
 The trap: indices, not values
 -----------------------------
 A stack of temperatures pops in exactly the same order and produces
 exactly the same sequence of resolutions. What it cannot do is tell
 you WHEN each resolution happened, and the answer here is a gap.
 The bug is invisible in the pop logic and fatal at the record line.

 Why strict <
 ------------
 [73, 73, 74] -> [2, 1, 0]. The second 73 is not warmer than the
 first, so it must not resolve it. With <= the first day would get
 answer 1, which is wrong.

 No guard on count
 -----------------
 A single-element input must return [0], not []. Sizing result to
 temps.count and letting the loop run zero useful iterations gives
 the right answer with no special case. Guarding on count > 1 and
 returning [] breaks the 1 <= count constraint.

 Complexity
 ----------
 Brute force  O(n^2) time, O(1) auxiliary
 Optimal      O(n)   time, O(n) space

 The nested while does not make the optimal quadratic. Count pops,
 not loop nesting: there are at most n of them across the entire run,
 because each index is pushed exactly once and popped at most once.
*/
