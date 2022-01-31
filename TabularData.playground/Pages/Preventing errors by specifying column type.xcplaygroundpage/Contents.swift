/*:
 ## Preventing errors by specifying column type
 
Some values in a dataframe may not be what we expect. It's safer to specify an expected type and handle conversion errors as exceptions.
 
The following is a production-ready version of the presented example, including checking for expected column types.
 
 */

import CoreLocation
import TabularData

enum ParkingError: Error {
    case incompatibleColumnNames
}

struct Parking {
    
    let parking: DataFrame
    
    static let locationID = ColumnID("location", CLLocation.self)
    
    init(policiesURL: URL, metersURL: URL) throws {
        let policies = try Self.loadPolicies(url: policiesURL)
        let meters = try Self.loadMeters(url: metersURL)
        
        parking = policies.joined(meters, on: ("POST_ID"))
    }
    
    static func loadPolicies(url: URL) throws -> DataFrame {
        let postID = ColumnID("PostID", String.self)
        let startDate = ColumnID("StartDate", Date.self)
        let columnNames = [postID.name, startDate.name]
        
        var options = CSVReadingOptions()
        options.addDateParseStrategy(
            Date.ParseStrategy(
                format: "\(year: .defaultDigits)/\(month: .twoDigits)/\(day: .twoDigits)",
                locale: Locale(identifier: "en_US"),
                timeZone: TimeZone(abbreviation: "PST")!
            )
        )

        let policies = try DataFrame(contentsOfCSVFile: url, columns: columnNames, options: options)

        let current = Date()
        var filteredPolicies = DataFrame(policies.filter(on: startDate) { date in
            guard let date = date else {
                return false
            }
            return date <= current
        })
        filteredPolicies.removeColumn("StartDate")
        filteredPolicies.renameColumn("PostID", to: "POST_ID")
        return filteredPolicies
    }
    
    static func loadMeters(url: URL) throws -> DataFrame {
        // Column IDs for loading
        let postID = ColumnID("POST_ID", String.self)
        let streetNameID = ColumnID("STREET_NAME", String.self)
        let streetNumberID = ColumnID("STREET_NUM", Int.self)
        let latitudeID = ColumnID("LATITUDE", Double.self)
        let longitudeID = ColumnID("LONGITUDE", Double.self)
        
        // Load meters CSV
        let columnNames = [postID.name, streetNameID.name, streetNumberID.name, latitudeID.name, longitudeID.name]
        var meters = try DataFrame(
            contentsOfCSVFile: url,
            columns: columnNames,
            types: [
                postID.name: .string,
                streetNameID.name: .string,
                streetNumberID.name: .integer,
                latitudeID.name: .double,
                longitudeID.name: .double
            ]
        )
        
        // Verify loaded columns
        let resolvedColumnNames = Set(meters.columns.map(\.name))
        guard resolvedColumnNames.intersection(columnNames) == resolvedColumnNames else {
            throw ParkingError.incompatibleColumnNames
        }
        
        // Then I make use of latitude, longitude and location column ids in the combine columns operation
        meters.combineColumns(latitudeID, longitudeID, into: locationID.name) { (latitude: Double?, longitude: Double?) -> CLLocation? in
            guard let latitude = latitude, let longitude = longitude else {
                return nil
            }

            return CLLocation(latitude: latitude, longitude: longitude)
        }
        return meters
    }
    
    func closestParking(to location: CLLocation, limit: Int) -> DataFrame.Slice {
        var closesMeters = parking
        closesMeters.transformColumn(Self.locationID) { (meterLocation: CLLocation) in
            meterLocation.distance(from: location)
        }
        closesMeters.renameColumn(Self.locationID.name, to: "distance")
        return closesMeters.sorted(on: "distance", order: .ascending)[..<limit]
    }
}

let parking = try Parking(policiesURL: policiesURL, metersURL: metersURL)
let appleStoreLocation = CLLocation(latitude: 37.788675, longitude: -122.407129)
let myAppleStoreParking = parking.closestParking(to: appleStoreLocation, limit: 5)

print(myAppleStoreParking)

/*:

 This concludes the example of the `TabularData` framework.
 
  [< Previous](@previous)
 */
