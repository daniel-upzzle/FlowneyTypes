import XCTest
@testable import FlowneyData

class FlowneyDataTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FlowneyData().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
