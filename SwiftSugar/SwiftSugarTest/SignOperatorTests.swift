import XCTest

class SignOperatorTests: XCTestCase {

    func testNumber <T: Numeric> (example: T) {
        let x: T = 100
        let y: T = 0
        let z: T = -100

        XCTAssertEqual(±x, 1)
        XCTAssertEqual(±y, 0)
        XCTAssertEqual(±z, -1)
    }

    func testNumbers() {
        testNumber(Double(1))
        testNumber(Float(1))
        testNumber(Int(1))
    }
}
