import XCTest

class CollectionsTests: XCTestCase {

    func testDoubleIteration() {
        let tuple: (Double, Double, Double) = (1, 2, 0.1)
        let array: [Double] = [1, 2, 0.1]
        var i = 0
        iterate(tuple) { (_, any) -> Void in
            if let value = any as? Double {
                XCTAssert(value == array[i])
            }
            i++
        }
    }

    func testStringIteration() {
        let tuple: (String, String, String) = ("1", "2", "0.1")
        let array: [String] = ["1", "2", "0.1"]
        var i = 0
        iterate(tuple) { (_, any) -> Void in
            if let value = any as? String {
                XCTAssert(value == array[i])
            }
            i++
        }
    }
}
