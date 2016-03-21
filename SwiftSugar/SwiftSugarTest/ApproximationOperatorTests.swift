import XCTest

class ApproximationOperatorTests: XCTestCase {

    func testApproximation <T: Numeric> (example example: T) {

        let random = Random(example: example)

        let bigNumber: T = 10 ^ 5

        10.times { () -> () in
            let number = random.randomNumber()

            let epsilon = number/bigNumber
            let approximation = random.uniformRandomNumber(center: number,
                maxDeviation: epsilon)

            let badApproximation = 2 * (number + 10)

            XCTAssert(number ==~ approximation, "\(number) is not" +
                "approximately \(approximation)")
            XCTAssertFalse(number ==~ badApproximation, "\(number) is" +
                "approximately \(approximation)")
        }
    }

    func testAllApproximations() {
        testApproximation(example: Double(0))
        testApproximation(example: Float(0))
        testApproximation(example: Int(0))
    }
}
