/*:
 ## Grouping results by column value
 
We can now create the next feature, which is locating the street with the most parking slots, by grouping results by street.
 
 */

import CoreLocation
import TabularData

var meters = try DataFrame(
    contentsOfCSVFile: metersURL,
    columns: ["POST_ID", "STREET_NAME", "STREET_NUM", "LATITUDE", "LONGITUDE"]
)

let streetGroups = meters.grouped(by: "STREET_NAME")
let streetMeterCounts = streetGroups.counts(order: .descending)

print(streetMeterCounts.description(options: formattingOptions))

/*:
Thus, we obtained the streets with the most parking slots.
 
But we have just realized that the first feature, which returned the closest parking meters, has a bug since it does not take into account if the meters have active policies. We will fix that next.
 
  [< Previous](@previous)                            [Next >](@next)
 */
