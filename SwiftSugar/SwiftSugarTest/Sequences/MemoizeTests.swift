import XCTest

class MemoizeTests: XCTestCase {

    let testsCount = 15

    var fibonacciResults: [Int] = [1, 1]
    var factorialResults: [Int] = [1, 2]

    let incrementer: (inout index: Int) -> Void  = { (inout index: Int) in
        index = index + 1
    }

    let fibonacciClosure: (Int -> Int, Int) -> Int = {
        (fibonacciLookup, index) -> Int in
        if index <= 2 {
            return 1
        } else {
            return fibonacciLookup(index - 1) + fibonacciLookup(index - 2)
        }
    }

    let factorialClosure: (Int -> Int, Int) -> Int = {
        (factorialLookup, index) -> Int in
        if index <= 1 {
            return 1
        } else {
            return index * factorialLookup(index - 1)
        }
    }

    func fibonacciFunction(index: Int) -> Int {
        return fibonacciClosure(fibonacciFunction, index)
    }

    func factorialFunction(index: Int) -> Int {
        return factorialClosure(factorialFunction, index)
    }

    override func setUp() {
        super.setUp()

        for i in 2...testsCount {
            let fibonacci = fibonacciResults[i - 1] + fibonacciResults[i - 2]
            fibonacciResults.append(fibonacci)

            let factorial = (i + 1) * factorialResults[i - 1]
            factorialResults.append(factorial)
        }
    }

    func testMemoizedClosureResults() {
        let fibonacci = memoize(fibonacciClosure)
        let factorial = memoize(factorialClosure)

        for i in 1...testsCount {
            XCTAssertEqual(fibonacci(i), fibonacciResults[i - 1])
            XCTAssertEqual(factorial(i), factorialResults[i - 1])
        }
    }

    func testMemoizedFunctionResults() {
        let fibonacci = memoize(fibonacciFunction)
        let factorial = memoize(factorialFunction)

        for i in 1...testsCount {
            XCTAssertEqual(fibonacci(i), fibonacciResults[i - 1])
            XCTAssertEqual(factorial(i), factorialResults[i - 1])
        }
    }

    func testHashMemoizedSequenceResults() {
        let sequences = [
            HashMemoizedSequence(first: 1, incrementer: incrementer,
                closure: fibonacciClosure),
            HashMemoizedSequence(first: 1, incrementer: incrementer,
                closure: factorialClosure),
            HashMemoizedSequence(first: 1, closure: fibonacciClosure),
            HashMemoizedSequence(first: 1, closure: factorialClosure),
            HashMemoizedSequence(fibonacciClosure),
            HashMemoizedSequence(factorialClosure),
            HashMemoizedSequence(first: 1, incrementer: incrementer,
                function: fibonacciFunction),
            HashMemoizedSequence(first: 1, incrementer: incrementer,
                function: factorialFunction),
            HashMemoizedSequence(first: 1, function: fibonacciFunction),
            HashMemoizedSequence(first: 1, function: factorialFunction),
            HashMemoizedSequence(fibonacciFunction),
            HashMemoizedSequence(factorialFunction)]

        let names = (0..<sequences.count).map { (index) -> String in
            var string = ""
            string += index % 2 == 1 ? "fibonacci " : "factorial "
            string += "\(index / 2) "
            string += index < 6 ? "(closure)" : "(function)"
            return string
        }

        let results = (0..<sequences.count).map { $0 % 2 == 0 ?
            fibonacciResults : factorialResults }

        let examples = (0..<sequences.count).map { $0 % 2 == 0 ?
            21 : 120 }

        for (((name, sequence), results), example) in
            zip(zip(zip(names, sequences), results), examples) {

            testHashMemoizedSequenceResults(sequence, sequenceName: name,
                testNumbers: results)
            testContains(sequence, sequenceName: name, number: example)
        }
    }

    func testHashMemoizedSequenceResults(sequence: HashMemoizedSequence<Int, Int>,
        sequenceName: String, testNumbers: [Int]) {
        var i = 0
        for result in sequence {
            guard i < testsCount else { break }
            XCTAssert(result == testNumbers[i], "Error in \(sequenceName), " +
                "index \(i): \(result) != \(testNumbers[i])")
            i = i + 1
        }
    }

    func testContains(sequence: HashMemoizedSequence<Int, Int>,
        sequenceName: String, number: Int) {
            XCTAssert(sequence.contains(number),  "Error: \(sequenceName) " +
                "does not contain \(number)")
            XCTAssertFalse(sequence.contains(number + 1),  "Error: " +
                "\(sequenceName) does not contain \(number + 1)")
    }
}
