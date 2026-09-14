import Foundation

//======================================================================
// MARK: - Union-Find / Disjoint Set Union
//======================================================================
//
// HIGH-LEVEL PATTERN
//
// Find  → Find the ROOT / GROUP of a node
// Union → Connect two different groups
//
// IMPORTANT RULE:
//
// Same Root
//     ↓
// Already Connected
//     ↓
// Adding this edge creates a Cycle
//     ↓
// Redundant Connection
//
// Optimizations:
//
// 1. Path Compression
//    → Make nodes point directly to the root
//
// 2. Union by Rank
//    → Attach smaller tree under larger tree
//    → Keep the tree shallow
//
// Time Complexity:
// O(α(n)) ≈ O(1) amortized
//
// Space Complexity:
// O(n)
//======================================================================


//======================================================================
// MARK: - Problem
//======================================================================
//
// LeetCode 684 - Redundant Connection
//
// Given an undirected graph that started as a tree,
// one extra edge was added.
//
// Return the edge that creates a cycle.
//
// Example:
//
// edges = [[1,2],[1,3],[2,3]]
//
// Graph:
//
//       1
//      / \
//     2---3
//
// [2,3] is redundant because 2 and 3 are already connected
// through 1.
//
//======================================================================


//======================================================================
// MARK: - Solution
//======================================================================

func findRedundantConnection(_ edges: [[Int]]) -> [Int] {

    //==================================================================
    // STEP 1: Initialize Parent and Rank
    //==================================================================

    print("\n========================================")
    print("STEP 1: INITIALIZE UNION-FIND")
    print("========================================")

    let n = edges.count

    // Nodes are 1...n.
    // Index 0 is unused.
    var parent = Array(0..<(n + 1))

    // Rank represents approximately the height of the tree.
    var rank = Array(repeating: 0, count: n + 1)

    print("Number of nodes : \(n)")
    print("Parent          : \(parent)")
    print("Rank            : \(rank)")
    print("Index 0         : Unused")

    //==================================================================
    // STEP 2: Find Root
    //==================================================================

    print("\n========================================")
    print("STEP 2: FIND ROOT")
    print("========================================")

    func findParent(_ x: Int) -> Int {

        print("\n🔍 findParent(\(x))")
        print("   parent[\(x)] = \(parent[x])")

        //--------------------------------------------------------------
        // Base Case
        //--------------------------------------------------------------
        //
        // If parent[x] == x,
        // x is the root.
        //--------------------------------------------------------------

        if parent[x] == x {

            print("   ✅ \(x) is the ROOT")

            return x
        }

        //--------------------------------------------------------------
        // Recursive Find
        //--------------------------------------------------------------
        //
        // x is not the root.
        // Move to its parent and find the root.
        //--------------------------------------------------------------

        print("   ↳ \(x) is not root")
        print("   ↳ Moving to parent[\(x)] = \(parent[x])")

        let root = findParent(parent[x])

        //--------------------------------------------------------------
        // Path Compression
        //--------------------------------------------------------------
        //
        // Directly connect x to the root.
        //--------------------------------------------------------------

        print("   🔗 Path Compression")
        print("   ↳ parent[\(x)] = \(root)")

        parent[x] = root

        print("   ↳ Updated parent: \(parent)")

        return parent[x]
    }

    //==================================================================
    // STEP 3: Union Two Groups
    //==================================================================

    print("\n========================================")
    print("STEP 3: UNION TWO GROUPS")
    print("========================================")

    func union(_ x: Int, _ y: Int) -> Bool {

        print("\n🔗 union(\(x), \(y))")

        //--------------------------------------------------------------
        // Find Root of x
        //--------------------------------------------------------------

        let rootX = findParent(x)

        //--------------------------------------------------------------
        // Find Root of y
        //--------------------------------------------------------------

        let rootY = findParent(y)

        print("\n   Root of \(x): \(rootX)")
        print("   Root of \(y): \(rootY)")

        //==================================================================
        // CASE 1: Same Root
        //==================================================================

        if rootX == rootY {

            print("\n   ❌ SAME ROOT")
            print("   \(x) and \(y) are already connected")
            print("   Adding [\(x), \(y)] creates a CYCLE")

            return false
        }

        //==================================================================
        // CASE 2: Different Roots
        //==================================================================

        print("\n   ✅ DIFFERENT ROOTS")
        print("   Two different groups will be connected")

        print("   Rank[\(rootX)] = \(rank[rootX])")
        print("   Rank[\(rootY)] = \(rank[rootY])")

        //--------------------------------------------------------------
        // Union by Rank
        //--------------------------------------------------------------

        if rank[rootX] < rank[rootY] {

            print("   ↳ Root \(rootX) has smaller rank")
            print("   ↳ parent[\(rootX)] = \(rootY)")

            parent[rootX] = rootY

        } else if rank[rootY] < rank[rootX] {

            print("   ↳ Root \(rootY) has smaller rank")
            print("   ↳ parent[\(rootY)] = \(rootX)")

            parent[rootY] = rootX

        } else {

            print("   ↳ Both roots have same rank")
            print("   ↳ parent[\(rootY)] = \(rootX)")
            print("   ↳ rank[\(rootX)] += 1")

            parent[rootY] = rootX
            rank[rootX] += 1
        }

        print("\n   Updated Parent: \(parent)")
        print("   Updated Rank  : \(rank)")

        return true
    }

    //==================================================================
    // STEP 4: Process Every Edge
    //==================================================================

    print("\n========================================")
    print("STEP 4: PROCESS EDGES")
    print("========================================")

    for (index, edge) in edges.enumerated() {

        let u = edge[0]
        let v = edge[1]

        print("\n----------------------------------------")
        print("EDGE \(index + 1): [\(u), \(v)]")
        print("----------------------------------------")

        //--------------------------------------------------------------
        // Try to connect u and v.
        //--------------------------------------------------------------

        if !union(u, v) {

            //==========================================================
            // STEP 5: Redundant Edge Found
            //==========================================================

            print("\n========================================")
            print("STEP 5: REDUNDANT EDGE FOUND")
            print("========================================")

            print("❌ Edge [\(u), \(v)] creates a cycle")
            print("✅ Redundant Connection: [\(u), \(v)]")

            return [u, v]
        }

        print("\n✅ Edge [\(u), \(v)] successfully connected")
    }

    //==================================================================
    // STEP 6: No Redundant Edge
    //==================================================================

    print("\n========================================")
    print("STEP 6: NO REDUNDANT EDGE")
    print("========================================")

    return []
}


//======================================================================
// MARK: - Test Case 1
//======================================================================

print("\n\n##################################################")
print("TEST CASE 1")
print("##################################################")

let edges1 = [[1,2],[1,3],[2,3]]

let result1 = findRedundantConnection(edges1)

print("\n🎯 FINAL RESULT: \(result1)")
print("Expected: [2, 3]")


//======================================================================
// MARK: - Test Case 2
//======================================================================

print("\n\n##################################################")
print("TEST CASE 2")
print("##################################################")

let edges2 = [[1,2],[2,3],[3,4],[1,4]]

let result2 = findRedundantConnection(edges2)

print("\n🎯 FINAL RESULT: \(result2)")
print("Expected: [1, 4]")


//======================================================================
// MARK: - Test Case 3
//======================================================================

print("\n\n##################################################")
print("TEST CASE 3")
print("##################################################")

let edges3 = [[1,2],[2,3],[3,1]]

let result3 = findRedundantConnection(edges3)

print("\n🎯 FINAL RESULT: \(result3)")
print("Expected: [3, 1]")
