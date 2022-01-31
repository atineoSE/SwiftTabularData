
/*:
 ## Loading tabular data
 
 Let's start by loading some tabular data.
 
 This is parking meter policy information shared as open data by the city of San Francisco [here](https://data.sfgov.org/Transportation/Meter-Policies/qq7v-hds4).
 
 For convenience, data is included in this example, as taken on Jan 31st 2022.
 
 */

import Foundation
import TabularData

let policies = try DataFrame(contentsOfCSVFile: policiesURL)

print(policies)
