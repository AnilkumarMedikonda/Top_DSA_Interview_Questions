import Foundation

//==============================================================
// Q54 - LC735 - Asteroid Collision
//==============================================================
//
// Problem
// -------
// Given an array asteroids, each value is an asteroid in a row. The
// absolute value is its size, the sign is its direction — positive
// moves right, negative moves left. All move at the same speed.
//
// Two asteroids collide only when one moving right meets one moving
// left. The smaller one explodes; if both are the same size, both
// explode. Asteroids moving the same way never meet.
//
// Return the state of the row after all collisions resolve.
//
// Example
// -------
// [5, 10, -5]     -> [5, 10]     -5 explodes against 10
// [8, -8]         -> []          equal sizes, both explode
// [10, 2, -5]     -> [10]        -5 destroys 2, then loses to 10
// [-2, -1, 1, 2]  -> [-2,-1,1,2] nothing ever meets
//
// Constraints
// -----------
// 2 <= asteroids.count <= 10^4
// -1000 <= asteroids[i] <= 1000
// asteroids[i] != 0
//
// Pattern : Stack Simulation + Monotonic Stack (destroy, not record)
//
// Brute Force : none. Repeated passes until stable is the same
//               algorithm with array shifts bolted on.
//
// Time  : O(n)   each asteroid pushed once, popped at most once
// Space : O(n)
//
// Collision happens on exactly one of four sign combinations:
//   stack top > 0, incoming < 0   -> collide, moving toward each other
//   stack top < 0, incoming < 0   -> no, both moving left
//   stack top > 0, incoming > 0   -> no, both moving right
//   stack top < 0, incoming > 0   -> no, moving apart
//
// The while loop is the trap. One incoming asteroid can destroy
// several stacked ones in sequence — [10, 2, -5] needs -5 to beat 2
// and then still face 10. An `if` resolves one collision and moves on.
//
//==============================================================

func asteroidCollision(_ asteroids: [Int]) -> [Int] {

    var stack = [Int]()

    for asteroid in asteroids {

        let current = asteroid
        var isDestroyed = false

        while let last = stack.last,
              last > 0,
              current < 0 {

            var currentSize = current
            if currentSize < 0 {
                currentSize = -currentSize
            }
            

            if currentSize > last {

                // Stack asteroid explodes
                stack.removeLast()

            } else if currentSize == last {

                // Both explode
                stack.removeLast()
                isDestroyed = true
                break

            } else {

                // Current asteroid explodes
                isDestroyed = true
                break
            }
        }

        if !isDestroyed {
            stack.append(current)
        }
    }

    return stack
}

//==============================================================
// MARK: - Test Cases
//==============================================================

print("========== Asteroid Collision ==========")

print(asteroidCollision([5, 10, -5]))          // [5, 10]

print(asteroidCollision([8, -8]))              // []

print(asteroidCollision([10, 2, -5]))          // [10]

print(asteroidCollision([-2, -1, 1, 2]))       // [-2, -1, 1, 2]

print(asteroidCollision([1, -2, -2, -2]))      // [-2, -2, -2]

print(asteroidCollision([2, -1]))              // [2]

print(asteroidCollision([1, -1]))              // []

print(asteroidCollision([3, 5, -2]))           // [3, 5]

print(asteroidCollision([3, 5, -10]))          // [-10]

print(asteroidCollision([4, 3, -5]))           // [-5]

print(asteroidCollision([10]))                 // [10]

print(asteroidCollision([]))                   // []
