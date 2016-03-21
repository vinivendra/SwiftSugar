import XCTest

class PowerOperatorTests: XCTestCase {

    func testPower<T: DoubleValuable>(example: T) {
        let doubles: [Double] = [1, 1.5, 2, 2.5, 3]

        for combo in doubles.combos(2) {
            let tValues = combo.map { T.fromDouble($0) }
            let operatorResult = tValues[0] ^ tValues[1]
            let functionResult = pow(tValues[0].toDouble, tValues[1].toDouble)
            XCTAssert(operatorResult ==~ functionResult,
                "\(operatorResult) is not approximately \(functionResult)")
        }
    }

    func testDoubleValuables() {
        testPower(Double(0))
        testPower(Float(0))
        testPower(Int(0))
    }

    func testFloat() {
        let floats: [Float] = [1, 1.5, 2, 2.5, 3]

        for combo in floats.combos(2) {
            XCTAssertEqual(combo[0] ^ combo[1], powf(combo[0], combo[1]))
        }
    }

    func testDouble() {
        let doubles: [Double] = [1, 1.5, 2, 2.5, 3]

        for combo in doubles.combos(2) {
            XCTAssertEqual(combo[0] ^ combo[1], pow(combo[0], combo[1]))
        }
    }

}
