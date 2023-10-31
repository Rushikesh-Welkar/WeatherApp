//
//  Weather_AppTests.swift
//  Weather AppTests
//
//  Created by Rushikesh on 30/10/23.
//

import XCTest
@testable import Weather_App

class Weather_AppTests: XCTestCase {

    
    let weatherObj = Weather(response: APIResponse(name: "Yerandwane",
                                                   main: APIMain(temp: 22.51),
                                                   weather: [APIWeather(description: "clear sky", iconName: "01name.png")]))
    func testGetWeatherData() {
        let name = weatherObj.name
        let temp = weatherObj.temperature
        let description = weatherObj.description
        XCTAssertNotNil(weatherObj)
        XCTAssertNotNil(name)
        XCTAssertNotNil(temp)
        XCTAssertNotNil(description)
    }

}

