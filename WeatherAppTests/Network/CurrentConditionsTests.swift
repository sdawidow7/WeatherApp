import Foundation

import XCTest
@testable import WeatherApp // TODO: Network - after modularization...

final class CurrentConditionsMappingTests: XCTestCase {
    func testCurrentConditionsMapping() throws {
        // Given

        let testJSON =
        """
[
  {
    "LocalObservationDateTime": "2023-08-07T10:32:00+02:00",
    "EpochTime": 1691397120,
    "WeatherText": "Przeważnie słonecznie",
    "WeatherIcon": 2,
    "HasPrecipitation": false,
    "PrecipitationType": null,
    "IsDayTime": true,
    "Temperature": {
      "Metric": {
        "Value": 24.5,
        "Unit": "C",
        "UnitType": 17
      },
      "Imperial": {
        "Value": 76,
        "Unit": "F",
        "UnitType": 18
      }
    },
    "MobileLink": "http://www.accuweather.com/pl/it/naples/212466/current-weather/212466",
    "Link": "http://www.accuweather.com/pl/it/naples/212466/current-weather/212466"
  }
]
"""
        let expectedCurrentConditions = CurrentConditions(weatherIcon: 2,
                                                          weatherText: "Przeważnie słonecznie",
                                                          temperature: .init(metric: .init(value: 24.5, unit: "C"),
                                                                             imperial: .init(value: 76, unit: "F")))

        let jsonData = testJSON.data(using: .utf8)!

        // When
        let result = try JSONDecoder().decode([CurrentConditions].self, from: jsonData)

        // Then
        XCTAssertNotNil(result, "Result should not be nil")
        XCTAssertEqual(result.count, 1, "Result should contain one current conditions")
        XCTAssertEqual(result.first, expectedCurrentConditions, "Result should contain one current conditions")
    }
}
