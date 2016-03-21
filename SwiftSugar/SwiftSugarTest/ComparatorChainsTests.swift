import XCTest

class ComparatorChainsTests: XCTestCase {

    // MARK: Setup
    func testLessThan <T: Numeric> (example _: T) {
            let test: [T] = [1, 2, 3, 4, 5]

            // x < a ≤ ... ≤ n
            XCTAssert(test[0] < test[1] ≤ test[2])
            XCTAssert(test[0] < test[1] ≤ test[2] ≤ test[3])
            XCTAssert(test[0] < test[1] ≤ test[2] ≤ test[3] ≤ test[4])

            // Fail when x > a, doesn't matter if x > n
            XCTAssertFalse(test[1] < test[0] ≤ test[2] ≤ test[3] ≤ test[4])
            XCTAssertFalse(test[2] < test[0] ≤ test[1] ≤ test[3] ≤ test[4])
            XCTAssertFalse(test[4] < test[0] ≤ test[1] ≤ test[2] ≤ test[3])

            // Fail when a > n, doesn't matter if x < n
            XCTAssertFalse(test[0] < test[2] ≤ test[1])
            XCTAssertFalse(test[0] < test[1] ≤ test[2] ≤ test[1])
            XCTAssertFalse(test[0] < test[1] ≤ test[2] ≤ test[0])
            XCTAssertFalse(test[1] < test[2] ≤ test[3] ≤ test[0])

            // Fail when x > some a...n, doesn't matter which
            XCTAssertFalse(test[1] < test[0] ≤ test[2] ≤ test[3])
            XCTAssertFalse(test[1] < test[2] ≤ test[0] ≤ test[3])
            XCTAssertFalse(test[1] < test[2] ≤ test[3] ≤ test[0] ≤ test[3])
    }

    func testLessThanOrEqualTo <T: Numeric> (example example: T) {
            testLessThanOrEqualToStrictly(example: example)
            testLessThanOrEqualToEquality(example: example)
    }

    func testLessThanOrEqualToStrictly <T: Numeric> (example _: T) {
            let test: [T] = [1, 2, 3, 4, 5]

            // x < a ≤ ... ≤ n
            XCTAssert(test[0] <= test[1] ≤= test[2])
            XCTAssert(test[0] <= test[1] ≤= test[2] ≤= test[3])
            XCTAssert(test[0] <= test[1] ≤= test[2] ≤= test[3] ≤= test[4])

            // Fail when x > a, doesn't matter if x > n
            XCTAssertFalse(test[1] <= test[0] ≤= test[2] ≤= test[3] ≤= test[4])
            XCTAssertFalse(test[2] <= test[0] ≤= test[1] ≤= test[3] ≤= test[4])
            XCTAssertFalse(test[4] <= test[0] ≤= test[1] ≤= test[2] ≤= test[3])

            // Fail when a > n, doesn't matter if x <= n
            XCTAssertFalse(test[0] <= test[2] ≤= test[1])
            XCTAssertFalse(test[0] <= test[1] ≤= test[2] ≤= test[1])
            XCTAssertFalse(test[0] <= test[1] ≤= test[2] ≤= test[0])
            XCTAssertFalse(test[1] <= test[2] ≤= test[3] ≤= test[0])

            // Fail when x > some a...n, doesn't matter which
            XCTAssertFalse(test[1] <= test[0] ≤= test[2] ≤= test[3])
            XCTAssertFalse(test[1] <= test[2] ≤= test[0] ≤= test[3])
            XCTAssertFalse(test[1] <= test[2] ≤= test[3] ≤= test[0] ≤= test[3])
    }

    func testLessThanOrEqualToEquality <T: Numeric> (example _: T) {
            let test: [T] = [1, 2, 3, 4, 5]

            XCTAssert(test[0] <= test[1] ≤= test[1])
            XCTAssert(test[0] <= test[0] ≤= test[1])

            XCTAssert(test[0] <= test[1] ≤= test[1] ≤= test[2])
            XCTAssert(test[0] <= test[1] ≤= test[2] ≤= test[2])
            XCTAssert(test[0] <= test[0] ≤= test[1] ≤= test[2])

            XCTAssert(test[0] <= test[1] ≤= test[1] ≤= test[2] ≤= test[3])
            XCTAssert(test[0] <= test[1] ≤= test[2] ≤= test[2] ≤= test[3])
            XCTAssert(test[0] <= test[1] ≤= test[2] ≤= test[3] ≤= test[3])

            XCTAssert(test[0] <= test[0] ≤= test[1] ≤= test[2] ≤= test[3])

            XCTAssert(test[0] <= test[0] ≤= test[0])
            XCTAssert(test[0] <= test[0] ≤= test[0] ≤= test[0])
            XCTAssert(test[0] <= test[0] ≤= test[0] ≤= test[0] ≤= test[0])
    }

    func testGreaterThan <T: Numeric> (example _: T) {
            let test: [T] = [1, 2, 3, 4, 5]

            // x > a ≥ ... ≥ n
            XCTAssert(test[4] > test[3] ≥ test[2])
            XCTAssert(test[4] > test[3] ≥ test[2] ≥ test[1])
            XCTAssert(test[4] > test[3] ≥ test[2] ≥ test[1] ≥ test[0])

            // Fail when x < a, doesn't matter if x > n
            XCTAssertFalse(test[3] > test[4] ≥ test[2] ≥ test[1] ≥ test[0])
            XCTAssertFalse(test[2] > test[4] ≥ test[3] ≥ test[1] ≥ test[0])
            XCTAssertFalse(test[0] > test[4] ≥ test[3] ≥ test[2] ≥ test[1])

            // Fail when a < n, doesn't matter if x > n
            XCTAssertFalse(test[4] > test[2] ≥ test[3])
            XCTAssertFalse(test[4] > test[3] ≥ test[2] ≥ test[3])
            XCTAssertFalse(test[4] > test[3] ≥ test[2] ≥ test[4])
            XCTAssertFalse(test[3] > test[2] ≥ test[1] ≥ test[4])

            // Fail when x < some a...n, doesn't matter which
            XCTAssertFalse(test[3] > test[4] ≥ test[2] ≥ test[1])
            XCTAssertFalse(test[3] > test[2] ≥ test[4] ≥ test[1])
            XCTAssertFalse(test[3] > test[2] ≥ test[1] ≥ test[4] ≥ test[1])
    }

    func testGreaterThanOrEqualTo <T: Numeric> (example example: T) {
            testGreaterThanOrEqualToStrictly(example: example)
            testGreaterThanOrEqualToEquality(example: example)
    }

    func testGreaterThanOrEqualToStrictly <T: Numeric> (example _: T) {
            let test: [T] = [1, 2, 3, 4, 5]

            // x ≥ a ≥ ... ≥ n
            XCTAssert(test[4] >= test[3] ≥= test[2])
            XCTAssert(test[4] >= test[3] ≥= test[2] ≥= test[1])
            XCTAssert(test[4] >= test[3] ≥= test[2] ≥= test[1] ≥= test[0])

            // Fail when x < a, doesn't matter if x > n
            XCTAssertFalse(test[3] >= test[4] ≥= test[2] ≥= test[1] ≥= test[0])
            XCTAssertFalse(test[2] >= test[4] ≥= test[3] ≥= test[1] ≥= test[0])
            XCTAssertFalse(test[0] >= test[4] ≥= test[3] ≥= test[2] ≥= test[1])

            // Fail when a < n, doesn't matter if x >= n
            XCTAssertFalse(test[4] >= test[2] ≥= test[3])
            XCTAssertFalse(test[4] >= test[3] ≥= test[2] ≥= test[3])
            XCTAssertFalse(test[4] >= test[3] ≥= test[2] ≥= test[4])
            XCTAssertFalse(test[3] >= test[2] ≥= test[1] ≥= test[4])

            // Fail when x < some a...n, doesn't matter which
            XCTAssertFalse(test[3] >= test[4] ≥= test[2] ≥= test[1])
            XCTAssertFalse(test[3] >= test[2] ≥= test[4] ≥= test[1])
            XCTAssertFalse(test[3] >= test[2] ≥= test[1] ≥= test[4] ≥= test[1])
    }

    func testGreaterThanOrEqualToEquality <T: Numeric> (example _: T) {
            let test: [T] = [1, 2, 3, 4, 5]

            XCTAssert(test[4] >= test[3] ≥= test[3])
            XCTAssert(test[4] >= test[4] ≥= test[3])

            XCTAssert(test[4] >= test[3] ≥= test[3] ≥= test[2])
            XCTAssert(test[4] >= test[3] ≥= test[2] ≥= test[2])
            XCTAssert(test[4] >= test[4] ≥= test[3] ≥= test[2])

            XCTAssert(test[4] >= test[3] ≥= test[3] ≥= test[2] ≥= test[1])
            XCTAssert(test[4] >= test[3] ≥= test[2] ≥= test[2] ≥= test[1])
            XCTAssert(test[4] >= test[3] ≥= test[2] ≥= test[1] ≥= test[1])

            XCTAssert(test[4] >= test[4] ≥= test[3] ≥= test[2] ≥= test[1])

            XCTAssert(test[4] >= test[4] ≥= test[4])
            XCTAssert(test[4] >= test[4] ≥= test[4] ≥= test[4])
            XCTAssert(test[4] >= test[4] ≥= test[4] ≥= test[4] ≥= test[4])
    }

    // MARK: Tests
    func testLessThan() {
        testLessThan(example: Double(0))
        testLessThan(example: Int(0))
        testLessThan(example: Float(0))
    }

    func testGreaterThan() {
        testGreaterThan(example: Double(0))
        testGreaterThan(example: Int(0))
        testGreaterThan(example: Float(0))
    }

    func testLessThanOrEqualTo() {
        testLessThanOrEqualTo(example: Double(0))
        testLessThanOrEqualTo(example: Int(0))
        testLessThanOrEqualTo(example: Float(0))
    }

    func testGreaterThanOrEqualTo() {
        testGreaterThanOrEqualTo(example: Double(0))
        testGreaterThanOrEqualTo(example: Int(0))
        testGreaterThanOrEqualTo(example: Float(0))
    }
}
