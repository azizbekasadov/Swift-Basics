import Foundation

//A function is a named set of code that is used to accomplish some specific task
//The function’s name describes the task the function performs
//Functions execute code. Some functions define arguments that you can use to pass
//in data to help the function do its work. Some functions return something after
//they have completed their work

// MARK: Basic functions
func printSomething() {
    // do here
}

// MARK: Functions with parameters
func printPersonalGreeting(name: String) {
     print("Hello, \(name). Welcome to your playground.")
}
printPersonalGreeting(name: "Step")
//A function’s parameters name the inputs that the function accepts, and the function
//takes the data passed to its parameters to execute a task or produce a result.

//When you call a function, you include the parameter name and a value of the correct type,
//called an argument.

// MARK: Parameters Names
//parameter names are included when you call the function and are available for use within
//the body of the function

//A parameter name used only when the function is called is known as an `external` parameter.
func printPersonalGreeting(to name: String) {
     print("Hello, \(name). Welcome to your playground.")
}
printPersonalGreeting(to: "Paul")
//The Swift naming guidelines suggest that if a function has multiple parameters that formulate
//a single concept, then the preposition should be placed at the end of the function name.

// MARK: Default parameter values
//As the caller, you provide values by passing in arguments.
//Swift’s parameters can also take default values. If a parameter has a default value, you can
//omit that argument when calling the function
func divisionDescriptionFor(numerator: Double,
                            denominator: Double,
                            withPunctuation punctuation: String = ".") {
    print("\(numerator) divided by \(denominator) is \(numerator / denominator)\(punctuation)")
}
    
divisionDescriptionFor(numerator: 12, denominator: 3)
// TODO: Consider call-by-value & call-by-reference in Swift

// MARK: Inout argument
//Sometimes there is a reason to have a function modify the value of an argument. In-out parameters
//allow a function’s impact on a variable to live beyond the function’s body.
var error = "The request failed:"
func appendErrorCode(_ code: Int, toErrorString errorString: inout String) {
    if code == 400 {
        errorString += " bad request."
    }
}
appendErrorCode(400, toErrorString: &error)
print(error)

// MARK: INOUT
//The inout keyword is added prior to String to express that the function expects to modify the original value.
//It does this by taking as its argument not a copy of the passed-in value, but a reference to the original.
//This way, any changes it makes to the string affect the original string, and those changes will remain after
//the function is done executing.

//When you call the function, the variable you pass into the inout parameter must be preceded by an ampersand (&)
//to acknowledge that you are providing shared access to your variable instead of just a copy of it and that you
//understand that the variable’s value may be directly modified by the function.

//Note that in-out parameters cannot have default values
//in-out parameters are not the same as a function returning a value

//because in-out parameters grant shared access to a variable, you cannot pass a constant or literal value into
//an in-out parameter. If you want your function to produce something, there is a more elegant way to accomplish
//that goal

// MARK: Return functions
//This return value is denoted by the -> syntax at the end of the function signature, which indicates that the
//function will return an instance of the type that follows the arrow.

// MARK: Nested Function Definitions and Scope
//Nested functions are declared and implemented within the definition of another function. The nested function
//is not available outside the enclosing function.

//A function’s scope describes the visibility an instance or function will have. It is a sort of horizon.
//Anything defined within a function’s scope will be visible to that function; anything that is not is past
//that function’s field of vision
//rectangle is visible to the divide() function because they share the same enclosing scope.
func areaOfTriangleWith(base: Double, height: Double) -> Double {
    let rectangle = base * height
    func divide() -> Double {
        return rectangle / 2
    }
    return divide()
}
print(areaOfTriangleWith(base: 3.0, height: 5.0))

// MARK: Multiple Return values
//Functions can only return one value – but they can pretend to return more than one value.
//To do this, a function can return an instance of the tuple data type to encapsulate multiple values into one.
// - Recall that a tuple is an ordered list of related values
func sortedEvenOddNumbers(_ numbers: [Int]) -> (evens: [Int], odds: [Int]) {
    var evens = [Int]()
    var odds = [Int]()
    for number in numbers {
        if number % 2 == 0 {
            evens.append(number)
        } else {
            odds.append(number)
        }
    }
    return (evens, odds)
}
//The function returns a named tuple, so called because its constituent parts are named: evens will be an array
//of integers, and odds will also be an array of integers.

// MARK: Optional Return Types
func grabMiddleName(fromFullName name: (String, String?, String)) -> String? {
    return name.1
}
let middleName = grabMiddleName(fromFullName: ("Alice", nil, "Ward"))
if let theName = middleName {
    print(theName)
}

// MARK: Exiting Early from a Function
//A guard statement is used to exit early from a function if some condition is not met
func greetByMiddleName(fromFullName name: (first: String,
                                           middle: String?,
                                           last: String)) {
    guard let middleName = name.middle else {
        print("Hey there!")
        return
    }
    print("Hey, \(middleName)")
}
greetByMiddleName(fromFullName: ("Alice", "Richards", "Ward"))

// MARK: Function Types
//Function types are made up of the function’s parameter and return types, e.g. ([Int]) -> ([Int], [Int]).
let evenOddFunction: (([Int]) -> ([Int], [Int]))?

//Bronze Challenge
//Like if/else conditions, guard statements support the use of multiple clauses to perform additional checks. Using additional clauses with a guard statement gives you further control over the statement’s condition. Refactor the greetByMiddleName(fromFullName:) function to have an additional clause in its guard statement. This clause should check whether the middle name is longer than 10 characters. If it is, then greet the person with their first name, their middle initial (the first letter of the middle name followed by a period), and their last name instead.
//For example, if the name is Alois Rumpelstiltskin Chaz, the function should print Hey, Alois R. Chaz.

func greetByMiddleName1(fromFullName name: (first: String,
                                           middle: String?,
                                           last: String)) {
    guard let middleName = name.middle, middleName.count > 10 else {
        print("Hey there!")
        return
    }
    print("Hey, \(name.first) \(middleName.first!). \(name.last)")
}
greetByMiddleName1(fromFullName: ("Alice", "Richards Middleton", "Ward"))

//Silver Challenge
//Write a function called siftBeans(fromGroceryList:) that takes a grocery list (as an array of strings) and “sifts out” the beans from the other groceries. The function should take one argument that has
//a parameter name called list, and it should return a named tuple of the type (beans: [String], otherGroceries: [String]).
//Here is an example of how you should be able to call your function and what the result should be:
//    let result = siftBeans(fromGroceryList: ["green beans",
//                                             "milk",
//                                             "black beans",
//                                             "pinto beans",
//                                             "apples"])
//    result.beans == ["green beans", "black beans", "pinto beans"] // true
//    result.otherGroceries == ["milk", "apples"] // true
//Hint: You may need to use a function on the String type called hasSuffix(_:).
func siftBeans(fromGrocery list: [String]) -> (beans: [String], otherGroceries: [String]){
    let beansValues = list.filter { $0.contains("beans") }
    let filtered: [String] = list.filter { !$0.contains("beans") }
    return (beans: beansValues, otherGroceries: filtered)
}
print(siftBeans(fromGrocery: ["green beans",
                              "milk",
                              "black beans",
                              "pinto beans",
                              "apples"]))

// MARK: Void functions
//Actually, functions that do not explicitly return something do have a return.
//They return something called Void. This return is inserted into the code for you by the compiler.
func printGreeting() -> Void {
    print("Hello, playground.")
}
//For example, the function type for printGreeting() is () -> Void. This is simply the type for a
//function that takes no arguments and returns an empty tuple, which is the implicit return type for all
//functions that do not explicitly have a return value.

// MARK: For the More Curious: Variadic Parameters
// A variadic parameter takes zero or more input values for its argument. Here are the rules:
// A function can have only one variadic parameter, it cannot be marked with inout, and it should typically be
// the final parameter in the list. The values provided to the argument are made available within the
// function’s body as an array.
func printPersonalGreetings(to names: String...) {
    for name in names {
        print("Hello, \(name). Welcome to your playground.")
    }
}
printPersonalGreetings(to: "Tessa", "Selah", "Aria", "Elijah")
//variadic parameters are a convenient and expressive way to define a function for callers that will have
//in mind a discrete list of arguments they wish to provide.
