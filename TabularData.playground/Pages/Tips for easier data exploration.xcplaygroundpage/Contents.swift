
/*:
 ## Tips for easier data exploration
 
Since we are just exploring the data set for now, we can limit the number of rows to load for a faster operation.
 
We can also select some formatting options to customize the printed output.
 */

import Foundation
import TabularData

let formattingOptions = FormattingOptions(
    maximumLineWidth: 250,
    maximumCellWidth: 15,
    maximumRowCount: 5
)

let policies = try DataFrame(contentsOfCSVFile: policiesURL, rows: 0..<100)

print(policies.description(options: formattingOptions))

/*:

 This was faster to load and we can see now all columns. Let's see how to focus on specific columns next.
 
  [< Previous](@previous)                            [Next >](@next)
 */
