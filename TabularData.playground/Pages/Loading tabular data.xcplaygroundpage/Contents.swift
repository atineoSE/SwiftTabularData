
/*:
 ## Loading tabular data
 
 Let's start by loading some tabular data.
 
 This is parking meter policy information shared as open data by the city of San Francisco, as taken on Jan 31st 2022. An up-to-date version of the dataset can be obtained [here](https://data.sfgov.org/Transportation/Meter-Policies/qq7v-hds4).
 
 */

import Foundation
import TabularData

let policies = try DataFrame(contentsOfCSVFile: policiesURL)

print(policies)

/*:
This takes a few seconds to load and some columns are not displayed, since they don't fit in the space provided. Let's improve that next.
 
  [< Previous](@previous)                            [Next >](@next)
 */
