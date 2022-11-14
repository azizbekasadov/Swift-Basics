//
//  main.swift
//  WordFinderTool
//
//  Created by Azizbek Asadov on 15/11/22.
//

import Foundation
import ArgumentParser

struct Wordlasso: ParsableCommand {
    @Argument(help: """
            The word template to match, with \(WordFinder.wildcard) as \
            placeholders. Leaving this blank will enter interactive mode.
            """)
    var template: String?
//    The @Argument property wrapper is used to declare a property that will store the primary argument to the program. In a moment you will use other property wrappers to declare properties that ArgumentParser will store your program’s options into. All ArgumentParser property wrappers take a help argument to their initializer that is used to autogenerate your tool’s documentation.
    @Flag(name: .shortAndLong, help: "Perform case-insensitive matches.")
        var ignoreCase: Bool = false
//    ArgumentParser has those also. An option that does not need an argument of its own, like -l for the ls command, is also called a flag. Declare a flag to let the user enable case- insensitive matching.
    
    @Option(name: .customLong("wordfile"),
                help: "Path to a newline-delimited word list.")
    var wordListPath: String = "/usr/share/dict/words"
//    Unlike a flag, an @Option property is parsed with an accompanying value.
    
    func run() throws {
//        let wordList = ["Wolf", "wolf", "word", "works", "woo"]
//        let wordFinder = WordFinder(wordList: wordList, ignoreCase: true)
        
        // MARK: Loading the words from disk
        let wordFinder = try WordFinder(wordListPath: wordListPath, ignoreCase: ignoreCase)
        
        // MARK: Retrieving Command-Line Arguments
        let args = CommandLine.arguments
        print("Command-line arguments: \(args)")
        
//        The CommandLine enum from the Swift standard library has no cases. It serves as a memorable namespace for static properties, including arguments, that would otherwise be global variables. If you need to declare several related global variables, declaring them as static properties of a caseless enum is a solid strategy for collecting them under an umbrella type with a name that is meaningful to your program.

//        The arguments static property of CommandLine stores an array of strings, each of which is one of the arguments to your program. The zeroth argument is the full path to your program’s executable (which can be quite long.) The remaining arguments are ones that were passed in when the program was executed.
        
//        How can you supply additional arguments? By configuring how Xcode will run your program in the scheme editor.
//        Find the scheme editor control in the Xcode toolbar and click on its lefthand component, pictured in Figure 27.5. Select Edit Scheme... from the drop-down menu that appears.

        
//        let template = "wo.."
//        if args.count > 1 {
//            let template = args[1]
//            findAndPrintMatches(for: template, using: wordFinder)
        if let template = template {
            findAndPrintMatches(for: template, using: wordFinder)
        } else {
//            template = ""
//            #warning("Ask the user for input interactively")
            while true {
                print("Enter word template: ", terminator: "")
                let template = readLine() ?? ""
                if template.isEmpty { return }
                findAndPrintMatches(for: template, using: wordFinder)
            }
        }
//        Recall that args[0] is the path to the program itself. Here, you access args[1] to retrieve the first passed argument if you know there is one. Otherwise, you provide an error message
        
    }
    
    private func findAndPrintMatches(for template: String,
                                     using wordFinder: WordFinder) {
        let matches = wordFinder.findMatches(for: template)
        print("Found \(matches.count) \(matches.count == 1 ? "match" : "matches"):")
        for match in matches {
            print(match)
        }
    }
}

//do {
//    try Wordlasso().run()
//} catch {
//    fatalError("Program exited unexpectedly. \(error)")
//}

Wordlasso.main()

// MARK: Receiving Input Interactively
//you will change the program to have two modes, depending on whether the user provides a template argument when they run the tool:
//• If the user passes a template as a command-line argument, wordlasso will find and print matches for it, then exit.
//• If the user does not provide a template as a command-line argument, wordlasso will ask for one. Then, if the user enters a template, the program will find and print matches for it and ask for another template. This will continue until the user tells the program to stop.

// MARK: Parsing Command-Line Arguments with ArgumentParser
//The ArgumentParser framework defines a ParsableCommand protocol, which requires a throwing method called run(). The body of your program is – or is called by – code in this method. ArgumentParser defines a robust suite of types and property wrappers (which you learned about in Chapter 26) to automatically parse command-line arguments for you and store them into properties of your ParsableCommand-conforming type.

//ParsableCommand has a protocol extension that adds a free static main() method to parse your command-line arguments and call your run() function for you. Replace the manual execution of your run() function with a call to main() instead.
//ArgumentParser uses property wrappers to implement its parsing behaviors on your behalf. When you want to identify an argument or option for ArgumentParser to look for at the command line, you select and configure the appropriate property wrapper and use it to declare a property of your ParsableCommand-conforming type.
//While the primary argument of your program comes at the end of the command and is unnamed, options and flags have names. Sometimes the names are short, like -h, and sometimes they are long, like --help. Passing the value .shortAndLong indicates that you want both and that ArgumentParser should infer their names from the property name. ArgumentParser’s inferred names default to the first letter for the short form and a hyphen-separated lowercase spelling for the long form.

//Silver Challenge
//Sometimes wordlasso returns a lot of matches, but sometimes it returns only a few. Add an option to wordlasso to let the user specify a maximum number of results.
//Its usage should look like this:
//    % ./wordlasso -i -c 4 ne..
//    Found 31 matches; listing the first 4:
//    Neal
//    neal
//    neap
//    neat
//    Program ended with exit code: 0
//Gold Challenge
//In this exercise, you used the ArgumentParser library to parse command-line options and arguments. And, when you learned about error handling in Chapter 23, you wrote code to lex and parse a string containing an arithmetic formula.
//Now, write a command-line tool called calc based on your Chapter 23 solution to allow the user to execute basic arithmetic operations in a Terminal session. Copy over as much code as you want from ErrorHandling.playground.
//The user should be able to enter a command like this:
//    % ./calc 11+11+7+13
//And get the correct numerical output printed to the console.
