import XCTest

class NumericTests: XCTestCase {

    func testTimes() {
        let random = Random(example: Int(0))

        for _ in 1...10 {
            var i = 0

            var iterations = random.positiveRandomNumber()

            while iterations > 10 ^ 5 {
                iterations /= 10
            }

            iterations.times { i++ }

            XCTAssertEqual(iterations, i)
        }
    }
}
