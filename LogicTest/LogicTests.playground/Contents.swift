import UIKit

//MARK: Logic Test
//=========================================START===========================================
//MARK: Question 1
/*
1. Please write a function to find the index that has the sum of left’s elements equal to the sum of
right’s elements .
Example 1: input => [1, 3, 5, 7, 9] output => “middle index is 3”
Example 2: input => [3, 6, 8, 1, 5, 10, 1, 7] output => “middle index is 4”
Example 3: input => [3, 5, 6] output => “index not found”
 */

//MARK: Answer 1
func findMiddleIndex(_ array: [Int]) -> String {
    var leftSum = 0
    //".reduce" is high order function - this case use sum all array
    var rightSum = array.reduce(0, +)

    for (index, element) in array.enumerated() {
        rightSum -= element
        
        if leftSum == rightSum {
            return "middle index is \(index)"
        }
        
        leftSum += element
    }
    
    return "index not found"
}
print("findMiddleIndex : Answer 1")
print(findMiddleIndex([1, 3, 5, 7, 9])) // Output: "middle index is 3"
print(findMiddleIndex([3, 6, 8, 1, 5, 10, 1, 7])) // Output: "middle index is 4"
print(findMiddleIndex([3, 5, 6])) // Output: "index not found"

//====================================================================================

//MARK: Question 2
/*
2. Please write a function to detect that incoming string is palindrome or not
Example 1: input => “aka”, output => “aka is a palindrome”
Example 2: input => “Level”, output => “Level is a palindrome”
Example 3: input => “Hello”, output => “Hello isn’t a palindrome”
Note: Please use only the basic programming function like if-else, loop, etc.
 */

//MARK: Answer 2
func isPalindrome(_ text: String) -> String {
    let lowercasedInput = text.lowercased()
    let reversedInput = String(lowercasedInput.reversed())
    
    if lowercasedInput == reversedInput {
        return "\(text) is a palindrome"
    } else {
        return "\(text) isn't a palindrome"
    }
}

print("isPalindrome : Answer 2")
// Test Examples
print(isPalindrome("aka"))    // Output: "aka is a palindrome"
print(isPalindrome("Level"))  // Output: "Level is a palindrome"
print(isPalindrome("Hello"))  // Output: "Hello isn't a palindrome"
 
//====================================================================================
//MARK: Question 3
/*
3. [Bonus] Please write a function to find triplets array that the sum of the numbers is equal to
zero
Note:
1. The input array nums may contain duplicate elements, but the solution set must not contain
duplicate triplets.
2. The function should have a time complexity better than O(N^3), where N is the number of
elements in the array nums.
Example1:
input => [-1, -5, -3, 0, 1, 2, -1]
output => [[-3, 1, 2], [-1, -1, 2], [-1, 0, 1]]
Explanation:
-3 + 1 + 2 = 0
-1 + -1 + 2 = 0
-1 + 0 + 1 = 0
Example2:
input => [1, 1, 2]
output => []
Explanation:
There are no matched numbers
Example3:
input => [1]
output => []
Explanation:
There are no matched numbers
*/

//MARK: Answer 3
func findTripletsAndNumberIsZeroSum(_ nums: [Int]) -> [[Int]] {
    let sortedNums = nums.sorted()
    var triplets = [[Int]]()

    if nums.count > 1 {
        for i in 0..<sortedNums.count - 2 {
            if i == 0 || (i > 0 && sortedNums[i] != sortedNums[i - 1]) {
                var left = i + 1
                var right = sortedNums.count - 1
                let targetSum = 0 - sortedNums[i]
                while left < right {
                    //x + y = 0 - sortedNums[i]
                    let currentSum = sortedNums[left] + sortedNums[right]

                    if currentSum == targetSum {
                        triplets.append([sortedNums[i], sortedNums[left], sortedNums[right]])

                        // Skip duplicates
                        while left < right && sortedNums[left] == sortedNums[left + 1] {
                            left += 1
                        }

                        while left < right && sortedNums[right] == sortedNums[right - 1] {
                            right -= 1
                        }

                        left += 1
                        right -= 1
                    } else if currentSum < targetSum {
                        left += 1
                    } else {
                        right -= 1
                    }
                }
            }
        }
    }
    

    return triplets
}

print("findTripletsAndNumberIsZeroSum : Answer 3")
// Example 1
let example1 = [-1, -5, -3, 0, 1, 2, -1]
print(findTripletsAndNumberIsZeroSum(example1))
// Output: [[-3, 1, 2], [-1, -1, 2], [-1, 0, 1]]

// Example 2
let example2 = [1, 1, 2]
print(findTripletsAndNumberIsZeroSum(example2))
// Output: []

// Example 3
let example3 = [1]
print(findTripletsAndNumberIsZeroSum(example3))
// Output: []


//====================================================================================
//=========================================END===========================================

