/*:
 ## Grouping results by column value
 
We can create the next feature, which is locating the street with the most parking slots, by grouping results by street.
 
 */


import CoreLocation
import TabularData

let filteredPolicies = try filterPolicies()

var meters = try DataFrame(
    contentsOfCSVFile: metersURL,
    columns: ["POST_ID", "STREET_NAME", "STREET_NUM", "LATITUDE", "LONGITUDE"]
)

let streetGroups = meters.grouped(by: "STREET_NAME")
let streetMeterCounts = streetGroups.counts(order: .descending)

print(streetMeterCounts.description(options: formattingOptions))

/*:
 
We realized that the first feature has a bug, which returned the closest parking meters, since it does not take into account if they have active policies. We will fix that next.
 
  [< Previous](@previous)                            [Next >](@next)
 */
