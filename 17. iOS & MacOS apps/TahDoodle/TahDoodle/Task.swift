//
//  Task.swift
//  TahDoodle
//
//  Created by Azizbek Asadov on 15/11/22.
//

import Foundation

struct Task: Equatable, Identifiable, Codable {
    let id: UUID
    let title: String
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
}

//You declare conformance to the Identifiable protocol and implement its only requirement: a property called id of a Hashable type. The id property must be unique for any instance in your program.
//UUID, which stands for universally unique identifier. A UUID is like a long random string, and it is generated such that its uniqueness is guaranteed.
//As with Equatable and Hashable, the compiler is willing to synthesize the Codable protocol requirements for most value types, as long as all non-lazy stored properties are also Codable. The compiler will also synthesize Codable conformance for classes that meet the same requirement. Nearly all the basic types in the Swift standard library, from Int to URL and Data, conform to Codable. And collection types like Array are Codable as long as their element types are.
