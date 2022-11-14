import Foundation

public protocol PercentageClampingExtension: Comparable {
    func clamped(to range: ClosedRange<Double>) -> Double
}

extension Double: PercentageClampingExtension {
    public func clamped(to range: ClosedRange<Double>) -> Double {
        if self > range.upperBound {
            return range.upperBound
        } else if self < range.lowerBound {
            return range.lowerBound
        } else {
            return self
        }
    }
}
