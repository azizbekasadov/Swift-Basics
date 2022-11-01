import Foundation

//Each team’s members should appear one per line, with no other punctuation. There should be an additional new line between teams. For added difficulty, make your solution work using only one print() statement (inside a loop is fine). Writing extremely concise code in this way often harms your ability to read the code later, but it can be fun and satisfying to flex your understanding in a playground environment like this.

//Sky Blue FC members:
//    Kailen
//    McKenzie
//    Thaisa
//Shea Jen
//    Orlando Pride members:
//    Sydney
//    Toni
//    Shelina
//Emily Chioma
//    Houston Dash members:
//    Jane
//    Michaela
//    Rachel
//    Allysha
//    Janine

let input = ["Jane", "Michaela", "Rachel", "Allysha",
             "Janine", "Sydney", "Toni", "Shelina", "Emily", "Chioma", "Kailen",
             "McKenzie", "Thaisa", "Shea", "Jen"]

typealias Team = [String: [String]]

enum TeamTypes: String, CaseIterable {
    case skyBlue = "Sky Blue FC"
    case orlando = "Orlando Pride"
    case houston = "Houston Dash"
}

func sortPlayersByTeams(_ input: [String]) -> Team {
    let skyBlue = ["Kailen", "McKenzie", "Thaisa", "Shea", "Jen"]
    let orlando = ["Sydney", "Toni", "Shelina", "Emily", "Chioma"]
    let houston = ["Jane", "Michaela", "Rachel", "Allysha", "Janine"]
    
    var result: Team = [:]
    
    input.forEach { item in
        switch item {
        case _ where skyBlue.contains(item):
            let key = TeamTypes.skyBlue.rawValue
            if result.keys.contains(key) {
                var values = (result[key] ?? [])
                values.append(item)
                result.updateValue(values, forKey: key)
            } else {
                result.updateValue([item], forKey: key)
            }
        case _ where orlando.contains(item):
            let key = TeamTypes.orlando.rawValue
            if result.keys.contains(key) {
                var values = (result[key] ?? [])
                values.append(item)
                result.updateValue(values, forKey: key)
            } else {
                result.updateValue([item], forKey: key)
            }
        case _ where houston.contains(item):
            let key = TeamTypes.houston.rawValue
            if result.keys.contains(key) {
                var values = (result[key] ?? [])
                values.append(item)
                result.updateValue(values, forKey: key)
            } else {
                result.updateValue([item], forKey: key)
            }
        default:
            break
        }
    }
    
    return result
}

print(sortPlayersByTeams(input))
