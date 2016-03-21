import XCTest

class StringTests: XCTestCase {

    func testDoubleValuable() {
        let random = Random(example: Double(0))

        10.times { () -> () in
            let double = random.randomNumber()
            let string = String.fromDouble(double)

            XCTAssert(double ==~ string.toDouble)
        }
    }
}
