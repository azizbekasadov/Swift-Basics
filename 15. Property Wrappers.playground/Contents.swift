import Foundation

struct Car {
    private var fuelLevelStorage: Double = 1.0
    var fuelLevel: Double {
        set {
            fuelLevelStorage = max(min(newValue, 1), 0)
        }
        get {
            return fuelLevelStorage
        }
    }
}
