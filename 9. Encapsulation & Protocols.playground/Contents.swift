import Foundation

// MARK: Encapsulation
// Encapsulation – separating the implementation details of a system from the visible features of the system.

// -> structs & classes;
// -> access control (private, public, open etc);
// -> abstract classes and data -> protocols;

// MARK: Protocol
// -> is a list of properties and methods – an interface – that a type must have to fulfill some role
// -> Multiple types can conform to a protocol. As long as they have the required properties and methods, the protocol does not care what the concrete type is.
// -> Protocols are especially useful when you want to implement a function that only cares about a specific feature of the types that it will work with.
func printTable(_ data: [[String]], withColumnLabels columnLabels: [String]) {
    // Create header row containing column headers
    var headerRow = "|"
    
    // Also keep track of the width of each column
    var columnWidths = [Int]()
    
    for columnLabel in columnLabels {
        let columnHeader = " \(columnLabel) |"
        headerRow += columnHeader
        columnWidths.append(columnLabel.count)
    }
    print(headerRow)
    
    for row in data {
        // Start the output string
        var out = "|"
        // Append each item in this row to the string
        for (j, item) in row.enumerated() {
            let paddingNeeded = columnWidths[j] - item.count
            let padding = repeatElement(" ", count:
                                            paddingNeeded).joined(separator: "")
            out += " \(padding)\(item) |"
        }
        // Done - print it!
        print(out)
    }
}
let data = [
    ["Eva", "30", "6"],
    ["Saleh", "40", "18"],
    ["Amit", "50", "20"],
]
printTable(data, withColumnLabels: ["Employee Name", "Age", "Years of Experience"])
// MARK: repeatElement(_:count:), which creates a collection of individual spaces

// Refactoring
struct Person {
    let name: String
    let age: Int
    let yearsOfExperience: Int
}

struct Department {
    let name: String
    var people = [Person]()
    init(name: String) {
        self.name = name
    }
    mutating func add(_ person: Person) {
        people.append(person)
    }
}

class Person1 {
    let name: String
    let age: Int
    let yearsOfExperience: Int
    
    init(name: String, age: Int, yearsOfExperience: Int) {
        self.name = name
        self.age = age
        self.yearsOfExperience = yearsOfExperience
    }
}


class Employee: Person1, CustomStringConvertible {
    let employeeID: Int
    
    init(employeeID: Int) {
        self.employeeID = employeeID
        super.init(name: "", age: 0, yearsOfExperience: 0)
    }
    
    var description: String {
        return "Name: \(name) ID: \(employeeID)"
    }
}

func printResource(_ resource: Person1 & CustomStringConvertible) {
    print("Resource: \(resource)")
}


var department = Department(name: "Engineering")
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))
department.add(Person(name: "Eva", age: 30, yearsOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearsOfExperience: 20))

// A protocol allows you to define the interface you want a type to satisfy. A type that satisfies a protocol is said to “conform to” the protocol. You can think of a protocol like a contract that every conforming type agrees to. This allows you to code against that contract without concerning yourself with specific types.
protocol TabularDataSource {//: CustomStringConvertible -> Protocol Inheritance {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    func label(forColumn column: Int) -> String
    func itemFor(row: Int, column: Int) -> String
}

extension Department: TabularDataSource {
    var description: String {
        "Department: \(name)"
    }
    
    var numberOfRows: Int {
        people.count
    }
    
    var numberOfColumns: Int {
        3
    }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Employee Name"
        case 1: return "Age"
        case 2: return "Years of Experience"
        default: fatalError("Invalid column!")
        }
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]
        switch column {
        case 0: return person.name
        case 1: return String(person.age)
        case 2: return String(person.yearsOfExperience)
        default: fatalError("Invalid column!")
        }
    }
}

// Protocols do not just define the properties and methods a conforming type must supply. They can also be used as types themselves: You can have variables, function arguments, and return values that have the type of a protocol.
func printTable(_ dataSource: TabularDataSource) {
    // Create header row containing column headers
    var headerRow = "|"
    
    // Also keep track of the width of each column
    var columnWidths = [Int]()
    
    for i in 0 ..< dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: i)
        let columnHeader = " \(columnLabel) |"
        headerRow += columnHeader
        columnWidths.append(columnLabel.count)
    }
    print(headerRow)
    
    for i in 0 ..< dataSource.numberOfRows {
        // Start the output string
        var out = "|"
        // Append each item in this row to the string
        for j in 0 ..< dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: i, column: j)
            let paddingNeeded = columnWidths[j] - item.count
            let padding = repeatElement(" ", count:
                                            paddingNeeded).joined(separator: "")
            out += " \(padding)\(item) |"
        }
        // Done - print it!
        print(out)
    }
}

printTable(department)

// Protocol Compatibility
//extension Department: CustomStringConvertible {
//    var description: String {
//        "Department: \(name)"
//    }
//}
//Note that it is not enough to merely implement a description property. You must both declare conformance to a protocol and implement the required methods and properties to fully conform.

// MARK: Protocols with classes
//Finally, classes can also conform to protocols. If the class does not have a superclass, the syntax is the same as for structs and enums:
//    class ClassName: ProtocolOne, ProtocolTwo {
//// ... }
//If the class does have a superclass, the name of the superclass comes first, followed by the protocol (or protocols).
//    class ClassName: SuperClass, ProtocolOne, ProtocolTwo {
//// ... }

// MARK: Protocol Inheritance
// A protocol that inherits from another protocol requires conforming types to provide implementations for all the properties and methods required by both itself and the protocol it inherits from.
// Protocol inheritance merely adds any requirements from the parent protocol to the child protocol.

// MARK: Protocols as Types
let operationsDataSource: TabularDataSource = Department(name: "Operations")
//The as keyword (and its forcible and conditional variants) are also available for casting between protocol types and the concrete types that conform to them.
let engineeringDataSource = department as TabularDataSource
// The is keyword can be used to check for protocol conformance

let mikey = Person(name: "Mikey", age: 37, yearsOfExperience: 10)
mikey is TabularDataSource

// MARK: Protocol Composition
// Protocol inheritance is a powerful tool that lets you easily create a new protocol to add requirements
// to an existing protocol or set of protocols. Nevertheless, using protocol inheritance can potentially
// lead you to make poor decisions in creating your types.

//Protocol composition to the rescue: This syntax allows you to state that a type must conform to multiple protocols
//func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
//    print("Table: \(dataSource)")
//... }
func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    // Create header row containing column headers
    var headerRow = "|"
    
    // Also keep track of the width of each column
    var columnWidths = [Int]()
    
    for i in 0 ..< dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: i)
        let columnHeader = " \(columnLabel) |"
        headerRow += columnHeader
        columnWidths.append(columnLabel.count)
    }
    print(headerRow)
    
    for i in 0 ..< dataSource.numberOfRows {
        // Start the output string
        var out = "|"
        // Append each item in this row to the string
        for j in 0 ..< dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: i, column: j)
            let paddingNeeded = columnWidths[j] - item.count
            let padding = repeatElement(" ", count:
                                            paddingNeeded).joined(separator: "")
            out += " \(padding)\(item) |"
        }
        // Done - print it!
        print(out)
    }
}
// The syntax for protocol composition uses the & infix operator to signal to the compiler that you are combining multiple protocols into a single requirement

// Consider another possibility. You could create a new protocol that inherits from both TabularDataSource
// and CustomStringConvertible, like so:
 
// protocol PrintableTabularDataSource: TabularDataSource, CustomStringConvertible {
//
// }
// In short, you have a few options for ensuring that a function like printTable(_:) correctly constrains
// its arguments:
//• Make TabularDataSource inherit from CustomStringConvertible. A solution like this could be appropriate if the two protocols are naturally related. But in this case, they are pretty different from one another.
//• Define a new protocol like PrintableTabularDataSource that inherits from both TabularDataSource and CustomStringConvertible. There is nothing wrong with this approach, but its real utility would be if you had additional requirements to add to the new protocol or needed many functions to use it as a parameter type. Here, it would be empty and would likely be the argument type of only one function, so it would not add much meaning to your program.
//• Compose the two protocols at the call site, as you have done. This signifies to developers that the requirement is particular to this function, is unlikely to be used elsewhere, and requires very little code elsewhere.

// MARK: Mutating methods in Protocols
// Methods in protocols default to nonmutating.
protocol Toggleable {
    mutating func toggle()
}
//Protocol names tend to follow one of two conventions, set by the Swift standard library:
//• The name is a noun, such as TabularDataSource, when the protocol describes the baseline behavior or meaning of a conforming type.
//• The name is an adjective with one of the suffixes “-able,” “-ible,” or “-ing,” such as Equatable or CustomStringConvertible, when the protocol describes a subset of a conforming type’s capabilities.

//Bronze Challenge
//The printTable(_:) function has a bug: It crashes if any of the data items are longer than the label of their column. Try changing Eva’s age to 1,000 to see this happen. Fix the bug. Your solution will likely result in incorrect table formatting; that is fine for now. You will fix the formatting in the gold challenge, below.

//Silver Challenge
//Create a new type, BookCollection, that conforms to TabularDataSource. Calling printTable(_:) on a book collection should show a table of books with columns for titles, authors, and average reviews on Amazon. (Unless all the books you use have very short titles and author names, you will need to have completed the previous challenge!)

//Electrum Challenge
//This challenge will exercise your understanding of multiple topics that you have studied so far.
//Sometimes protocols are used to add behavior to existing types, as you will explore in Chapter 22 on protocol extensions. One such protocol can be used to let you loop over the cases of any enum that does not have associated values: CaseIterable.
//Open your Enumerations.playground file and declare your ProgrammingLanguage enum to conform to the CaseIterable protocol. Using a loop, print all the enum’s cases. Your output should look like this:
//    swift
//    objective-c
//    c
//    c++
//    java
//You will need to explore the CaseIterable protocol reference in the developer documentation.
//To turn this into a gold challenge, do not use a loop. Instead, use what you learned about map(_:) in
//Chapter 13 to make your output look like this:
//    ["swift", "objective-c", "c", "c++", "java"]

//Gold Challenge
//After you fixed the crashing bug in the bronze challenge above, the table rows and columns were likely misaligned. Fix your solution to correctly align the table rows and columns. Verify that your solution does not crash with values longer than their column labels.
