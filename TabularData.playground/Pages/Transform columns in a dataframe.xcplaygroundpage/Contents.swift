
/*:
 ## Transform columns in a dataframe
 
 We can now transform location into distance to build the first feature of the app: locate the nearest parking meters to a given location.
 
 We compute those meters with the `closestParking(to:in:limit:)` function.
 
 */


import CoreLocation
import TabularData

let filteredPolicies = try filterPolicies()

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

func closetParking(to location: CLLocation, in meters: DataFrame, limit: Int) -> DataFrame.Slice {
    var closesMeters = meters
    closesMeters.transformColumn("location") { (meterLocation: CLLocation) in
        meterLocation.distance(from: location)
    }
    closesMeters.renameColumn("location", to: "distance")
    return closesMeters.sorted(on: "distance", order: .ascending)[..<limit]
}

let appleStoreLocation = CLLocation(latitude: 37.788675, longitude: -122.407129)
let myAppleStoreParking = closetParking(to: appleStoreLocation, in: meters, limit: 5)

print(myAppleStoreParking)

/*:

This allows us to find the 5 closest parking meters to a given location. Sometimes though, we would like to know what are the streets with the most parking slots. We will make that feature next.
 
  [< Previous](@previous)                            [Next >](@next)
 */
