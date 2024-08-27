import XCTest
import OSLog
import Foundation
@testable import SkipMapbox

let logger: Logger = Logger(subsystem: "SkipMapbox", category: "Tests")

@available(macOS 13, *)
final class SkipMapboxTests: XCTestCase {
    func testSkipMapbox() throws {
        logger.log("running testSkipMapbox")
        XCTAssertEqual(1 + 2, 3, "basic test")
        
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try XCTUnwrap(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        XCTAssertEqual("SkipMapbox", testData.testModuleName)
    }
}

struct TestData : Codable, Hashable {
    var testModuleName: String
}