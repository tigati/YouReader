import XCTest
@testable import App

class Resources: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let sklads = getAllSklads(phrases: words)
        let missed = sklads.compactMap { sklad -> String? in
            let resource = Bundle.main.path(forResource: sklad, ofType: "caf")
            if resource == nil {
                return sklad
            }
            return nil
        }
        
        missed.forEach { miss in
            print(miss)
        }
        
        XCTAssertTrue(missed.isEmpty, "Found missed sound files for \(missed.count) sklads: \(missed)")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
