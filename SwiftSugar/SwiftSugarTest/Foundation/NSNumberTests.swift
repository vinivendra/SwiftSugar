import XCTest

class NSNumberTests: XCTestCase {

    func testDoubleValuable() {
        let random = Random(example: Double(0))

        10.times { () -> () in
            let double = random.randomNumber()
            let number = NSNumber.fromDouble(double)

            XCTAssertEqual(double, number.toDouble)
        }
    }
}
