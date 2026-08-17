import Foundation

/*
 Q02 — LC121 Best Time to Buy and Sell Stock               [Easy]

 prices[i] is the price of a stock on day i. Choose ONE day to
 buy and a LATER day to sell. Return the maximum profit, or 0 if
 no profit is possible.

 Example 1:  [7,1,5,3,6,4]  ->  5   (buy at 1, sell at 6)
 Example 2:  [7,6,4,3,1]    ->  0   (no transaction)

 Constraints:
   1 <= prices.length <= 10^5
   0 <= prices[i] <= 10^4
*/

//============================================================
// MARK: - Brute Force
// Time : O(n²)
// Space: O(1)
// TLE at n = 10^5. State it, don't submit it.
//============================================================

func maxProfitBruteForce(_ prices: [Int]) -> Int {
    var maxProfit = 0
    for i in 0..<prices.count {
        for j in (i + 1)..<prices.count {
            let profit = prices[j] - prices[i]
            if profit > maxProfit {
                maxProfit = profit
            }
        }
    }
    return maxProfit
}

//============================================================
// MARK: - Optimal (One Pass)
// Time : O(n)
// Space: O(1)
//
// Walk forward carrying the cheapest price seen so far. At each
// day, selling today means profit = today - cheapestBehindMe.
//
// The else matters: on a day that sets a new low, profit would
// be negative, so there is nothing to check.
//
// This is Kadane in disguise — on the array of day-to-day
// differences, the max subarray sum is the same answer.
//============================================================

func maxProfit(_ prices: [Int]) -> Int {
    var maxProfit = 0
    var minimumPrice = Int.max
    for price in prices {
        if price < minimumPrice {
            minimumPrice = price
        } else {
            let profit = price - minimumPrice
            if profit > maxProfit {
                maxProfit = profit
            }
        }
    }
    return maxProfit
}

//============================================================
// MARK: - Tests
//============================================================

print("========== Brute Force ==========")

print(maxProfitBruteForce([7, 1, 5, 3, 6, 4]))

print(maxProfitBruteForce([7, 6, 4, 3, 1]))

print("========== Optimal ==========")

print(maxProfit([7, 1, 5, 3, 6, 4]))

print(maxProfit([7, 6, 4, 3, 1]))

print(maxProfit([2]))
