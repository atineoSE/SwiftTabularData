import Foundation
import TabularData

public let policiesURL = Bundle.main.url(forResource: "Meter_Policies", withExtension: "csv")!
public let metersURL = Bundle.main.url(forResource: "Parking_Meters", withExtension: "csv")!

public func filterPolicies() throws -> DataFrame {
    var options = CSVReadingOptions()
    options.addDateParseStrategy(
        Date.ParseStrategy(
            format: "\(year: .defaultDigits)/\(month: .twoDigits)/\(day: .twoDigits)",
            locale: Locale(identifier: "en_US"),
            timeZone: TimeZone(abbreviation: "PST")!
        )
    )

    let columns = ["HourlyRate", "DayOfWeek", "StartTime", "EndTime", "StartDate", "PostID"]

    let policies = try DataFrame(contentsOfCSVFile: policiesURL, columns: columns, rows: 0..<100, options: options)
    let current = Date()
    var filteredPolicies = DataFrame(policies.filter(on: "StartDate", Date.self) { date in
        guard let date = date else {
            return false
        }
        return date <= current
    })
    filteredPolicies.removeColumn("StartDate")
    return filteredPolicies
}

public let formattingOptions = FormattingOptions(
    maximumLineWidth: 250,
    maximumCellWidth: 15,
    maximumRowCount: 5
)
