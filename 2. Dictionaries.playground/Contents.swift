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

typealias Team = [TeamTypes: [String]]

enum TeamTypes: String, CaseIterable, CustomStringConvertible {
    case skyBlue = "Sky Blue FC"
    case orlando = "Orlando Pride"
    case houston = "Houston Dash"
    
    func getPlayersByTeams() -> [String] {
        switch self {
        case .skyBlue: return ["Kailen", "McKenzie", "Thaisa", "Shea", "Jen"]
        case .houston: return ["Jane", "Michaela", "Rachel", "Allysha", "Janine"]
        case .orlando: return ["Jane", "Michaela", "Rachel", "Allysha", "Janine"]
        }
    }
    
    var description: String {
        self.rawValue
    }
}

func sortPlayersByTeams(_ input: [String]) -> Team {
    var result: Team = [:]
    
    func updateResults(
        with item: String,
        ofKey key: TeamTypes,
        ofResult result: inout Team
    ) {
        let key = key
        if result.keys.contains(key) {
            var values = (result[key] ?? [])
            values.append(item)
            result.updateValue(values, forKey: key)
        } else {
            result.updateValue([item], forKey: key)
        }
    }
    
    let skyBlues = TeamTypes.skyBlue.getPlayersByTeams()
    let houston = TeamTypes.houston.getPlayersByTeams()
    let orlando = TeamTypes.orlando.getPlayersByTeams()
    
    input.forEach { item in
        switch item {
        case _ where skyBlues.contains(item):
            updateResults(with: item, ofKey: TeamTypes.skyBlue, ofResult: &result)
        case _ where orlando.contains(item):
            updateResults(with: item, ofKey: .orlando, ofResult: &result)
        case _ where houston.contains(item):
            updateResults(with: item, ofKey: .orlando, ofResult: &result)
        default: break
        }
    }
    
    return result
}

print(sortPlayersByTeams(input))
