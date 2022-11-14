//
//  WordFinder.swift
//  WordFinderTool
//
//  Created by Azizbek Asadov on 15/11/22.
//

import Foundation

struct WordFinder {
    static let wildcard: Character = "."
    let wordList: [String]
    let ignoreCase: Bool
    
    init(wordListPath: String, ignoreCase: Bool) throws {
        let wordListContent = try String(contentsOfFile: wordListPath)
        wordList = wordListContent.components(separatedBy: .newlines)
        self.ignoreCase = ignoreCase
    }
    
    //    The String(contentsOfFile:) initializer is a failable initializer that synchronously loads a file from disk into an instance of String. It will fail if the file does not exist, if the program does not have permission to access the file, or if the file cannot be successfully decoded into text.
    
    private func caseCorrected(_ value: String) -> String {
        ignoreCase ? value.lowercased() : value
    }
    
    private func isMatch(template: String, with word: String) -> Bool {
        guard template.count == word.count else { return false }
        return template.indices.allSatisfy { index in
            (template[index] == WordFinder.wildcard) || (template[index] == word[index])
        }
    }
    
    func findMatches(for template: String) -> [String] {
        return wordList.filter { candidate in
            isMatch(template: caseCorrected(template),
                    with: caseCorrected(template))
        }
    }
}

//use the allSatisfy(_:) higher-order function to iterate over every index in the template string and figure out whether the character at that index in the template matches either the wildcard character or the character at the same index in the candidate word.
