import Foundation

public func getSwiftVersion() -> String {
    #if swift(>=5.0)
    return "5 or higher"
    #elseif swift(>=4.0)
    return "4.x"
    #elseif swift(>=3.0)
    return "3.x"
    #else
    return "lower than 3.0"
    #endif
}

public let policiesURL = Bundle.main.url(forResource: "Meter_Policies", withExtension: "csv")!
