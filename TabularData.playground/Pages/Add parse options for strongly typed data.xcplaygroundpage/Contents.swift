
/*:
 ## Add parse options for strongly typed data
 
We can load date data into the `Date` type by providing the appropriate parsing options.
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

print(policies.description(options: formattingOptions))

/*:

Now dates are imported directly into the `Date` foundation type.
 
This allows us to filter results by date next.
 
  [< Previous](@previous)                            [Next >](@next)
 */
