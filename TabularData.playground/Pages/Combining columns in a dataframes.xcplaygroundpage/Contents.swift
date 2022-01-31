
/*:
 ## Combining columns in a data frame
 
 We can now load a different data set, with data about location of parking meters.
 
 The data is again provided by the city of San Francisco and can be found [here](https://data.sfgov.org/Transportation/Parking-Meters/8vzz-qzz9).
 
 Data is provided, as obtained on Jan 31st 2022.
 
 This data set provides latitude and longitude of the parking meters, which allows us to combine both columns into a new column of type 1 `CLLocation`.
 
 */


import CoreLocation
import TabularData

let filteredPolicies = try filterPolicies()

var meters = try DataFrame(
    contentsOfCSVFile: metersURL,
    columns: ["POST_ID", "STREET_NAME", "STREET_NUM", "LATITUDE", "LONGITUDE"]
)

print(meters.description(options: formattingOptions))

meters.combineColumns("LATITUDE", "LONGITUDE", into: "location") { (latitude: Double?, longitude: Double?) -> CLLocation? in
    guard let latitude = latitude, let longitude = longitude else {
        return nil
    }

    return CLLocation(latitude: latitude, longitude: longitude)
}

print(meters.description(options: formattingOptions))

/*:

Next, we can get the closest parking meters to a given location.
 
  [< Previous](@previous)                            [Next >](@next)
 */
