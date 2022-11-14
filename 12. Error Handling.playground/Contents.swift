import Foundation

// MARK: Classes of Errors
// There are two broad categories of errors that can occur: recoverable errors and nonrecoverable errors.
//Recoverable errors are typically events you must be ready for and handle. Common examples of
//recoverable errors are:
//• trying to open a file that does not exist
//• trying to communicate with a server that is down
//• trying to communicate when a device does not have an internet connection

//Nonrecoverable errors are just a special kind of bug. You have already encountered one: force- unwrapping an optional that contains nil. Another example is trying to access an element past the end of an array. These nonrecoverable errors will cause your program to trap.

// Lexing an Input String
//The first phase of your expression-evaluating compiler is lexing. In computer science, lexing is the process of turning some input into a sequence of tokens. A token is something with meaning, like a number or a plus sign (the two tokens your compiler will recognize). Lexing is sometimes referred to as “tokenizing” because you are turning some input that is meaningless to the compiler (like a string) into a sequence of meaningful tokens.

enum Token: CustomStringConvertible {
    case number(Int)
    case plus
    
    var description: String {
        switch self {
        case let .number(n):
            return "Number: \(n)"
        case .plus:
            return "Symbol: +"
        }
    }
}
//When building something like a lexer, logging your progress can help with debugging later.
//Next, start building your lexer. To lex an input string, you will need to access the individual characters in the input string one by one. You will need to keep track of your current position in String as well. Create the Lexer class and give it two properties to track these pieces of information
class Lexer {
    
    // TODO: Add -, /, *;
    enum Error: Swift.Error {
        case invalidCharacter(Character)
    }
    
    let input: String
    var position: String.Index
    
    init(input: String) {
        self.input = input
        self.position = input.startIndex
    }
    
    func peek() -> Character? {
        guard position < input.endIndex else {
            return nil }
        return input[position]
    }
    
    func advance() {
        assert(position < input.endIndex, "Cannot advance past endIndex!")
        position = input.index(after: position)
    }
    
    func getNumber() -> Int {
        var value = 0
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                // Another digit - add it into value
                let digitValue = Int(String(nextCharacter))!
                value = 10 * value + digitValue
                advance()
            default:
                // Something unexpected - need to send back an error
                return value
            }
        }
        return value
    }
    
    func lex() throws -> [Token] {
        var tokens = [Token]()
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                // Start of a number - need to grab the rest
                let value = getNumber()
                tokens.append(.number(value))
            case "+":
                tokens.append(.plus)
                advance()
            case " ":
                // Just advance to ignore spaces
                advance()
            default:
                // Something unexpected - need to send back an error
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }
        return tokens
    }
}
//Lexer will need two basic operations: a way to peek at the next character from the input and a way to advance the current position. Peeking at the next character requires a way to indicate that the lexer has reached the end of its input, so make it return an optional.
//As you implement the rest of Lexer, you will be calling peek() and advance(). peek() can be called any time, but advance() should only be called if you are not already at the end of the input. Add an assertion to advance() that checks for this condition.
//Calls to assert(_:_:) will only be evaluated if your program is built in debug mode. Debug mode is the default when you are working in a playground or running a project in Xcode. Release mode is what Xcode uses when you build an app for submission to the App Store. Among other things, building in release mode turns on a number of compiler optimizations and removes all calls to assert(_:_:).
//If you want to keep your assertions around even in release mode, you can use precondition(_:_:) instead. It takes the same arguments and has the same effect as assert(_:_:), but it is not removed when your app is built for release.
//Both assert(_:_:) and precondition(_:_:) are used to trap if a condition is not met. If you need to unconditionally halt program execution, you can do so with fatalError(_:), which accepts a string argument that will be printed to the console just before trapping.
//Why did you use assert(_:_:) instead of guard or some other error-handling mechanism? assert(_:_:) and its partner precondition(_:_:) are tools to help you catch nonrecoverable errors. As you are implementing your lexing algorithm, you are advancing an index from the beginning of the input to the end. You should never attempt to advance past the input’s endIndex.
//Adding this assertion will help you catch any mistake you make that introduces a bug of this kind, because the assertion will cause the debugger to stop execution at this point, helping you identify the error.
//Now that the Lexer class has the building blocks you need, it is time to start implementing the lexing algorithm. The output of lexing will be an array of Tokens, but it is also possible for lexing to fail. To indicate that a function or method might emit an error, add the keyword throws after the parentheses containing the arguments.
//In Swift, you use the throws keyword to send, or “throw,” an error back to the caller.
//What can you throw? You must throw an instance of a type that conforms to the Error protocol. Most of the time, errors you want to throw will lend themselves to being defined as enumerations, and this is no exception.
//Like return, throw causes the function to immediately stop executing and go back to its caller.

// MARK: Catching Errors
func evaluate(_ input: String) {
    print("Evaluating: \(input)")
    let lexer = Lexer(input: input)
//    let tokens = try! lexer.lex()
    //    guard let tokens = try? lexer.lex() else {
    //            print("Lexing failed, but I don't know why")
    //    return
    //    }
    do {
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")
        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser output: \(result)")
    } catch Lexer.Error.invalidCharacter(let character) {
        print("Input contained an invalid character: \(character)")
    } catch Parser.Error.unexpectedEndOfInput {
        print("Unexpected end of input during parsing")
    } catch Parser.Error.invalidToken(let token) {
        print("Invalid token during parsing: \(token)")
    } catch {
        print("An error occurred: \(error)")
    }
}
evaluate("10 + 3 + 5")
evaluate("1 + 2 + three")
//To handle errors, Swift uses a control construct you have not yet seen: do/catch, with at least one try statement inside the do.
//What do these new keywords mean? do introduces a new scope, much like an if statement. Inside the do scope, you can write code as normal, like calling print(). In addition, you can call functions or methods that are marked as throws. Each such call must be indicated with the try keyword.
//After the do block, you write a catch block. If any of the try calls inside the do block throw an error, the catch block will run, with the thrown error value bound to the constant error.
//You add a catch block that is specifically looking for the Lexer.Error.invalidCharacter error. catch blocks support pattern matching, just like switch statements, so you can bind the invalid character to a constant for use within the catch block. You should see a more specific error message now:
//    Evaluating: 10 + 3 + 5
//    Lexer output: [Number: 10, Symbol: +, Number: 3, Symbol: +, Number: 5]
//    Evaluating: 1 + 2 + three
//    Input contained an invalid character: t
//Congratulations, the lexing phase of your compiler is complete! Before moving on to parsing, delete the call to evaluate(_:) that is causing an error.

// MARK: Parsing the Token Array
//The algorithm to parse this sequence of tokens is more restrictive than the algorithm you used for lexing, because the order the tokens appear in is very important. The rules are:
//• The first token must be a number.
//• After parsing a number, either the parser must be at the end of input, or the next token must be
//.plus.
//• After parsing a .plus, the next token must be a number.
class Parser {
    
    // TODO: Add -, /, *;
    enum Error: Swift.Error {
        case unexpectedEndOfInput
        case invalidToken(Token)
    }
    
    let tokens: [Token]
    var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil }
        let token = tokens[position]
        position += 1
        return token
    }
    
    func getNumber() throws -> Int {
        guard let token = getNextToken() else {
            throw Parser.Error.unexpectedEndOfInput
        }
        switch token {
        case .number(let value):
            return value
        case .plus:
            throw Parser.Error.invalidToken(token)
        }
    }
    
    func parse() throws -> Int {
        // Require a number first
        var value = try getNumber()
        while let token = getNextToken() {
            switch token {
                // Getting a plus after a number is legal
            case .plus:
                // After a plus, we must get another number
                let nextNumber = try getNumber()
                value += nextNumber
                // Getting a number after a number is not legal
            case .number:
                throw Parser.Error.invalidToken(token)
            }
        }
        return value
    }
}
//A Parser is initialized with an array of tokens and begins with a position of 0. The getNextToken() method uses guard to check that there are more tokens remaining and, if there are, returns the next one, advancing position past the token it returns.


// MARK: Handling Errors by Sticking Your Head in the Sand
//The real power of do/catch error handling is that a throws function can communicate to its caller the exact reason for the failure. This allows the caller to decide what to do next, such as present an alert to the user or try something else. If you do not care why the error occurred, only that it occurred at all, you can convert a throws function into an optional-returning function by calling it with try?.

// MARK: Swift Error-Handling Philosophy
//Any function that could fail must be marked with throws. This makes it obvious from the type of a function whether you need to handle potential errors.
//Swift also requires you to mark all calls to functions that might fail with try. This gives a great benefit to anyone reading Swift code. If a function call is annotated with try, you know it is a potential source of errors that must be handled. If a function call is not annotated with try, you know it will never emit errors that you need to handle.
//Even though Swift uses some of the same terminology, particularly try, catch, and throw, Swift does not implement error handling using exceptions. When you mark a function with throws, that effectively changes its return type from whatever type it normally returns to “either whatever type it normally returns or an instance of the Error protocol.”
//A function that throws does not state what kinds of errors it might throw. This has two practical impacts. First, you are always free to add more potential Errors that a function might throw without changing the API of the function. Second, when you are handling errors with catch, you must always be prepared to handle an error of some unknown type.

//MARK: Bronze Challenge
//Your expression evaluator currently only supports addition. That is not very useful! Add support for subtraction. You should be able to call evaluate("10 + 5 - 3 - 1") and see it output 11.

//MARK: Silver Challenge
//The error messages printed out by evaluate(_:) are useful, but not as useful as they could be. Here are a couple of erroneous inputs and the error messages they produce:
//    evaluate("1 + 3 + 7a + 8")
//    > Input contained an invalid character: a
//    evaluate("10 + 3 3 + 7")
//    > Invalid token during parsing: .number(3)
//Make these messages more helpful by including the character position where the error occurred. After completing this challenge, you should see error messages like this:
//    evaluate("1 + 3 + 7a + 8")
//    > Input contained an invalid character at index 9: a
//    evaluate("10 + 3 3 + 7")
//    > Invalid token during parsing at index 7: 3
//Hint: You will need to associate error positions with your existing error cases. To convert a String.Index into an integral position, you can use the distance(from:to:) method on the string. For example, if input is a String and position is a String.Index, the following will compute how many characters separate the beginning of the string and position.
//    let distanceToPosition = input.distance(from: input.startIndex, to: position)

//MARK: Gold Challenge
//Time to step it up a notch. Add support for multiplication and division to your calculator. If you think this will be as easy as adding subtraction, think again! Your evaluator should give higher precedence to multiplication and division than it does to addition and subtraction. Here are some sample inputs and their expected output.
//    evaluate("10 * 3 + 5 * 3") // Should print 45
//    evaluate("10 + 3 * 5 + 3") // Should print 28
//    evaluate("10 + 3 * 5 * 3") // Should print 55
//If you get stuck, try researching “recursive descent parsers.” That is the kind of parser you have been implementing. Here is a hint to get you started: Instead of parsing a single number and then expecting a .plus or .minus, try parsing a term computed from numbers and multiplication/division operators, and then expecting a .plus or .minus.

// MARK: Storing Failable Results for Later
//• Trap with assert(_:_:), precondition(_:_:), or fatalError(_:) if you want to indicate a nonrecoverable error state.
//• Return an Optional, which is nil on failure, when the caller does not need to know why the failure occurred.
//• Throw an Error in case the caller might want to react differently to different reasons for failure.
//One downside to error-throwing functions is that they force you to handle the success or failure immediately, using a catch block. If you are not ready to process the result of the function call, your only option is to convert the result to an optional with try? (or trap on failures with try!, but that is an exceptional case). Converting a throwing function’s output to an optional is a convenient way to capture your desired data on success, but it loses error information on failure.
//Swift provides a data type that you can use to store the entire result of a throwing function for future use, whether the function succeeded and returned a value or failed and threw an error. That type is Result.
let lexer1 = Lexer(input: "1 + 3 + 3 + 7")
let tokensResult = Result { try lexer1.lex() }

//enum Result<Success, Failure> where Failure : Error {
//       case .success(Success)
//       case .failure(Failure)
//}
switch tokensResult {
case let .success(tokens):
    print("Found \(tokens.count) tokens: \(tokens)")
case let .failure(error):
    print("Couldn't lex '\(lexer1.input)': \(error)")
}
//Result has several features for working with its cases. You could use its map(_:) method to transform the success value if there is one:
let numbersResult: Result<[Int],Error> = tokensResult.map { tokens in
    tokens.compactMap { token in
        switch token {
        case let .number(digit): return digit
        default: return nil
        }
    }
}

func extractNumbers(from result: Result<[Int],Error>) throws -> [Int] {
    return try result.get()
}
if let numbers = try? extractNumbers(from: numbersResult) {
    print(numbers)
}
//The Result type is a flexible way to store success/failure states that you need to cache or are not ready to process yet. As you grow as a Swift developer and explore asynchronous programming, you will encounter many frameworks that use Result for passing around the results of background work. For now, it is enough that you will recognize it when you see it in the wild.
