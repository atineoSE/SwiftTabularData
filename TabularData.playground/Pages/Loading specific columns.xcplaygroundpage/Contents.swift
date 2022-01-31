
/*:
 ## Loading specific columns
 
We can focus on specific columns, indicating them by name.
 */

import Foundation
import TabularData

let formattingOptions = FormattingOptions(
    maximumLineWidth: 250,
    maximumCellWidth: 15,
    maximumRowCount: 5
)

let columns = ["HourlyRate", "DayOfWeek", "StartTime", "EndTime", "StartDate", "PostID"]

let policies = try DataFrame(contentsOfCSVFile: policiesURL, columns: columns, rows: 0..<100)

print(policies.description(options: formattingOptions))

/*:
We have now loaded specific columns, which makes it easier to explore the data set.
 
The dates are loaded as strings, since they couldn't be automatically converted to `Date` by the default parser. Let's fix that next.
 
  [< Previous](@previous)                            [Next >](@next)
 */
