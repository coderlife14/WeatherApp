//
//  WeatherViewControllerPresenterTests.swift
//  WeatherAppTests
//
//  Created by Chirag on 4/17/23.
//

import XCTest
@testable import WeatherApp

class WeatherAppServicesTests: XCTestCase {

    let serviceBuilder = ServiceBuilder()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIKey() throws {
        XCTAssertEqual(WeatherConstants.API_KEY, "94139418d7a222cfb00136fcee6afd55")
    }
    
    /// Test for get Weather for coordinates
    func testGetWeather() throws {
        let exp = expectation(description: "Loading weather")
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=37.78&lon=-122.42&units=imperial&appid=94139418d7a222cfb00136fcee6afd55"
        serviceBuilder.makeServiceCall(url: urlString) { data, response, error in
            
            if let error = error {
                  XCTFail("Get Weather Error: \(error.localizedDescription)")
                  return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                  if statusCode == 200 {
                    // 2
                      exp.fulfill()
                  } else {
                    XCTFail("Status code: \(statusCode)")
                  }
                }

        }
        
        waitForExpectations(timeout: 3)

    }
    
    /// Test for get locations service call
    func testGetLocations() throws {
        let exp = expectation(description: "Loading weather")
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=Dublin&limit=5&appid=94139418d7a222cfb00136fcee6afd55"
        serviceBuilder.makeServiceCall(url: urlString) { data, response, error in
            
            if let error = error {
                  XCTFail("Get Locations Error: \(error.localizedDescription)")
                  return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                  if statusCode == 200 {
                    // 2
                      exp.fulfill()
                  } else {
                    XCTFail("Status code: \(statusCode)")
                  }
                }

        }
        
        waitForExpectations(timeout: 3)

    }
    
    /// Testing Image Service call
    func testImageService() throws {
        let exp = expectation(description: "Loading weather")
        let urlString = "https://openweathermap.org/img/wn/04d@2x.png"
        serviceBuilder.makeServiceCall(url: urlString) { data, response, error in
            
            if let error = error {
                  XCTFail("Image Download Error: \(error.localizedDescription)")
                  return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                  if statusCode == 200 {
                    // 2
                      exp.fulfill()
                  } else {
                    XCTFail("Status code: \(statusCode)")
                  }
                }

        }
        
        waitForExpectations(timeout: 3)

    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
