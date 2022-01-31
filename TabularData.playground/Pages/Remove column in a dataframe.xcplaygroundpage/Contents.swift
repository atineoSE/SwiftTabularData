
/*:
 ## Remove column in a dataframe
 
Now that we have filtered by date, we no longer need the start date column.
 
To remove it, we must do it over a dataframe, not a dataframe slice. Thus, we need to convert the filtered slice to a full dataframe.
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
var filteredPolicies = DataFrame(policies.filter(on: "StartDate", Date.self) { date in
    guard let date = date else {
        return false
    }
    return date <= current
})
filteredPolicies.removeColumn("StartDate")
print(filteredPolicies.description(options: formattingOptions))

/*:

 We have finished the exploration of the parking meter policies data set.
 
  [< Previous](@previous)                            [Next >](@next)
 */
