/*:
 ## Joining dataframes
 
We can join dataframes to combine information from different data sets.
 
 */

import CoreLocation
import TabularData

var filteredPolicies = try filterPolicies()

var meters = try DataFrame(
    contentsOfCSVFile: metersURL,
    columns: ["POST_ID", "STREET_NAME", "STREET_NUM", "LATITUDE", "LONGITUDE"]
)
meters.combineColumns("LATITUDE", "LONGITUDE", into: "location") { (latitude: Double?, longitude: Double?) -> CLLocation? in
    guard let latitude = latitude, let longitude = longitude else {
        return nil
    }

    return CLLocation(latitude: latitude, longitude: longitude)
}
filteredPolicies.renameColumn("PostID", to: "POST_ID")  // Rename to match column name
let activeMeters = filteredPolicies.joined(meters, on: ("POST_ID"))

func closestParking(to location: CLLocation, in meters: DataFrame, limit: Int) -> DataFrame.Slice {
    var closesMeters = meters
    closesMeters.transformColumn("location") { (meterLocation: CLLocation) in
        meterLocation.distance(from: location)
    }
    closesMeters.renameColumn("location", to: "distance")
    return closesMeters.sorted(on: "distance", order: .ascending)[..<limit]
}

let appleStoreLocation = CLLocation(latitude: 37.788675, longitude: -122.407129)
let myAppleStoreParking = closestParking(to: appleStoreLocation, in: activeMeters, limit: 5)

print(myAppleStoreParking)

/*:

 
  [< Previous](@previous)                            [Next >](@next)
 */
