import XCTest

class MemoizePerformanceTests: XCTestCase {

    let testsCount = 19

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

    func performTasksForBaseline() {
        for i in 0...testsCount {
            self.fibonacciFunction(i + 1)
            self.factorialFunction(i)
        }
    }

    func testClosureHashMemoizedSequencePerformance() {
        measureMetrics(self.dynamicType.defaultPerformanceMetrics(),
            automaticallyStartMeasuring: false) { () -> Void in
                var fibonacci = HashMemoizedSequence(first: 1,
                    incrementer: self.incrementer,
                    closure: self.fibonacciClosure)
                var factorial = HashMemoizedSequence(first: 1,
                    incrementer: self.incrementer,
                    closure: self.factorialClosure)

                self.startMeasuring()
                for _ in 1...self.testsCount {
                    fibonacci.next()
                    factorial.next()
                }
                self.stopMeasuring()
        }
    }

    func testClosureMemoizedIncrementableSequencePerformance() {
        measureMetrics(self.dynamicType.defaultPerformanceMetrics(),
            automaticallyStartMeasuring: false) { () -> Void in
                var fibonacci = HashMemoizedSequence(first: 1,
                    closure: self.fibonacciClosure)
                var factorial = HashMemoizedSequence(first: 1,
                    closure: self.factorialClosure)

                self.startMeasuring()
                for _ in 1...self.testsCount {
                    fibonacci.next()
                    factorial.next()
                }
                self.stopMeasuring()
        }
    }

    func testClosureMemoizedNumericSequencePerformance() {
        measureMetrics(self.dynamicType.defaultPerformanceMetrics(),
            automaticallyStartMeasuring: false) { () -> Void in
                var fibonacci = HashMemoizedSequence(self.fibonacciClosure)
                var factorial = HashMemoizedSequence(self.factorialClosure)

                self.startMeasuring()
                for _ in 1...self.testsCount {
                    fibonacci.next()
                    factorial.next()
                }
                self.stopMeasuring()
        }
    }

    func testFunctionHashMemoizedSequencePerformance() {
        measureMetrics(self.dynamicType.defaultPerformanceMetrics(),
            automaticallyStartMeasuring: false) { () -> Void in
                var fibonacci = HashMemoizedSequence(first: 1,
                    incrementer: self.incrementer,
                    function: self.fibonacciFunction)
                var factorial = HashMemoizedSequence(first: 1,
                    incrementer: self.incrementer,
                    function: self.factorialFunction)

                self.startMeasuring()
                for _ in 1...self.testsCount {
                    fibonacci.next()
                    factorial.next()
                }
                self.stopMeasuring()
        }
    }

    func testFunctionMemoizedIncrementableSequencePerformance() {
        measureMetrics(self.dynamicType.defaultPerformanceMetrics(),
            automaticallyStartMeasuring: false) { () -> Void in
                var fibonacci = HashMemoizedSequence(first: 1,
                    function: self.fibonacciFunction)
                var factorial = HashMemoizedSequence(first: 1,
                    function: self.factorialFunction)

                self.startMeasuring()
                for _ in 1...self.testsCount {
                    fibonacci.next()
                    factorial.next()
                }
                self.stopMeasuring()
        }
    }

    func testFunctionMemoizedNumericSequencePerformance() {
        measureMetrics(self.dynamicType.defaultPerformanceMetrics(),
            automaticallyStartMeasuring: false) { () -> Void in
                var fibonacci = HashMemoizedSequence(self.fibonacciFunction)
                var factorial = HashMemoizedSequence(self.factorialFunction)

                self.startMeasuring()
                for _ in 1...self.testsCount {
                    fibonacci.next()
                    factorial.next()
                }
                self.stopMeasuring()
        }
    }

    func testMemoizedClosurePerformance() {
        let fibonacci = memoize(fibonacciClosure)
        let factorial = memoize(factorialClosure)

        measureBlock {
            for i in 0...self.testsCount {
                fibonacci(i + 1)
                factorial(i)
            }
        }
    }

    func testMemoizedFunctionPerformance() {
        let fibonacci = memoize(fibonacciFunction)
        let factorial = memoize(factorialFunction)

        measureBlock {
            for i in 0...self.testsCount {
                fibonacci(i + 1)
                factorial(i)
            }
        }
    }
}
