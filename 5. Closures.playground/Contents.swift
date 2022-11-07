import Darwin
import UIKit

// Closures are discrete bundles of functionality that can be used in your application
// to accomplish specific tasks
// Global functions are not defined on any specific type, and for this reason they are
// also called free functions

// Closures differ from functions in that they have a more compact and lightweight syntax.
// They allow you to write a “function-like” construct without having to give it a name and a full function declaration.

let volunteerCounts = [1,3,40,32,2,53,77,13]

// Example 1.
func isAscending(_ i: Int, _ j: Int) -> Bool {
    i < j
}
let volunteersSorted = volunteerCounts.sorted(by: isAscending)
print(volunteersSorted)

// Remark: `is` is a common prefix in the names of functions that return a Boolean, so the
// name isAscending implies that the function will be sorting two things.

// {(parameters) -> return type in
//      Code
// }

// You write a closure expression inside braces ({}).
// The keyword in is used to separate the closure’s parameters and return type from the
// statements in its body.

// Example 2. Using closures
let _volunteersSorted = volunteerCounts.sorted(by: { i, j in i < j })

// Remark: Any function or closure with only one expression can implicitly return the
// value of that expression by omitting the return keyword

// Your closure is getting fairly compact, but it can become even more succinct. Swift provides
// positional variable names that you can refer to in inline closure expressions

// Example 3. Using closures v2
let _volunteersSorted1 = volunteersSorted.sorted(by: { $0 < $1 })

// Since we know that <, >, <=, >= are already implemented for Int data type

// Example 4. Comparable comformance
let _volunteersSorted2 = volunteersSorted.sorted(by: <)

// Notice that when the closure moves outside the parentheses, its argument label is removed
// from the call. If there are multiple trailing closures, this only applies to the first;
// subsequent trailing closures retain their argument labels

// Example 5.
func doAwesomeWork(on input: String,
                      using transformer: () -> Void,
                   then completion: () -> Void) { }

doAwesomeWork(on: "My Project") {
    print("Doing work on \(5) in `transformer`")
} then: {
    print("Finishing up in `completion`")
}

// MARK: Functions as Arguments
func format(
    numbers: [Double],
    using formatter: (Double) -> String = {"\($0)"} // with default formatting
) -> [String] {
    var result = [String]()
    for number in numbers {
        let transformed = formatter(number)
        result.append(transformed)
    }
    return result
}

100.formatted(.currency(code: "EUR"))

let rounder: (Double) -> String = {
    (num: Double) -> String in
    return "\(Int(num.rounded()))"
}

let volunteerAverages = [10.75, 4.2, 1.5, 12.12, 16.815]
format(numbers: volunteerAverages, using: rounder)
let exactAveragesAsStrings = format(numbers: volunteerAverages)

// MARK: Scopes of closures

func experimentWithScopes() {
    let rounder: (Double) -> String = {
        (num: Double) -> String in
        return "\(Int(num.rounded()))"
    }
    let volunteerAverages = [10.75, 4.2, 1.5, 12.12, 16.815]
    let roundedAveragesAsStrings = format(numbers: volunteerAverages, using: rounder)
    let exactAveragesAsStrings = format(numbers: volunteerAverages)
}

experimentWithScopes()

//The experimentWithScopes() function provides a nested scope so you can inspect the interactions between declarations in different scopes. After defining the function, you call it so that your code will execute when the playground updates.

// MARK: Capturing enclosing scope
func experimentWithScopes1() {
    var numberOfTransformations = 0
    let rounder: (Double) -> String = { (num: Double) -> String in
        numberOfTransformations += 1
        return "\(Int(num.rounded()))"
    }
    let volunteerAverages = [10.75, 4.2, 1.5, 12.12, 16.815]
    let roundedAveragesAsStrings = format(numbers: volunteerAverages, using: rounder)
    let exactAveragesAsStrings = format(numbers: volunteerAverages)
}

print(experimentWithScopes1())

//A function or variable that is declared outside any other scope is considered to be in the global scope, and it is visible to any function or closure in the program

// MARK: Functional Programming ~ Paradigm
// Includes:
//• First-class functions – functions can be returned from and passed as arguments to other functions, can be stored in variables, etc.; they are just like any other type.
//• Pure functions – functions have no side effects; functions, given the same input, always return the same output and do not modify other states elsewhere in the program. Most math functions like sin, cos, fibonacci, and factorial are pure.
//• Immutability – mutability is de-emphasized, because it is more difficult to reason about data whose values can change.
//• Strong typing – a strong type system increases the runtime safety of the code because the guarantees of the language’s type system are checked at compile time.

// MARK: Higher-order functions
// Higher-order functions are functions that can take another function as an argument or can return a function
//map(_:), filter(_:), and reduce(_:_:), zip()

// MARK: map(_:)
//The Swift standard library provides an implementation of map(_:) as a method on the Array type. It is used to transform an array’s contents. You map an array’s contents from one value to another and put the new values into a new array. Because map(_:) is a higher-order function, you provide it with another function that tells it how to transform the array’s contents.

// Ex. Transforming values with map
let roundedAverages = volunteerAverages.map {
    (avg: Double) -> Int in
    return Int(avg.rounded())
}

// MARK: filter(_:)
//Where the map(_:) method expects a closure that will transform a value, the filter(_:) method expects a closure that will decide whether each value should be added to the result array. Your closure will receive each value, one at a time, and should return true if the value passes your test and false if it does not. The result array will contain a subset of the original array’s items: only those for which your closure returns true.
let passingAverages = roundedAverages.filter {
    (avg: Int) -> Bool in
    return avg >= 10
}

// MARK: reduce(_:_:)
let estimatedParticipation = passingAverages.reduce(5) {
    (estimationSoFar: Int, currentOrgAverage: Int) -> Int in
    return estimationSoFar + currentOrgAverage
}

// MARK: Bronze Challenge
var vals = volunteerCounts
vals = vals.sorted(by: <)

// MARK: Silver Challenge
vals.sort(by: <)

// MARK: Gold Challenge
let sortedRoundedAverages = volunteerAverages.sorted(by: <).map{ "\(Int($0.rounded()))" }
print(sortedRoundedAverages)

//Functions as Return Types
typealias RemovedCharacters = (String) -> String
func makeCharacterRemover(for character: Character) -> RemovedCharacters {
    func removeFrom(_ input: String) -> String {
        return input.filter { $0 != character }
    }
    return removeFrom
}

let removeLowerCaseLs = makeCharacterRemover(for: "l")
let strangeGreeting = removeLowerCaseLs("Hello, World!")
let removeLowerCaseOs = makeCharacterRemover(for: "o")
let strangerGreeting = removeLowerCaseOs(strangeGreeting)

func remove(_ character: Character, from string: String) -> String {
    return string.filter { $0 != character }
}
let britishGreeting = remove("H", from: "Hello, World!")
