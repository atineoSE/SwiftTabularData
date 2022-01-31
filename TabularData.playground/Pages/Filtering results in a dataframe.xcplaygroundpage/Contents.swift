
/*:
 ## Filtering results in a dataframe
 
Now that we imported date data as `Date`, we can easily filter for current policies, i.e. policies whose start date is earlier than the current date.
 */

import Foundation
import TabularData

let formattingOptions = FormattingOptions(
    maximumLineWidth: 250,
    maximumCellWidth: 15,
    maximumRowCount: 5
)
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
let filteredPolicies = policies.filter(on: "StartDate", Date.self) { date in
    guard let date = date else {
        return false
    }
    return date <= current
}
print(filteredPolicies.description(options: formattingOptions))

/*:

Now that we have filtered for the slice we want, we can remove unneeded columns next.
 
  [< Previous](@previous)                            [Next >](@next)
 */
