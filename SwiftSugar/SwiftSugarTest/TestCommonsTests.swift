import XCTest

class TestCommonsTests: XCTestCase {

    let doubleRandom = Random(example: Double(0))
    let floatRandom = Random(example: Float(0))
    let intRandom = Random(example: Int(0))

    var start: Double!
    var center: Double!
    var interval: Double!

    func testRandomNumber<T: Numeric>(generator generator: () -> T,
        assertion assertCorrection: (T) -> Bool) {
            var numbers = [T]()

            100.times { () -> () in
                var number: T

                repeat {
                    number = generator()
                } while number == 0

                numbers.append(number)

                XCTAssert(assertCorrection(number), "Assertion " +
                    "\(assertCorrection) failed for random number \(number).")
            }

            let firstNumber = numbers.first
            for number in numbers {
                if number != firstNumber {
                    return
                }
            }

            XCTFail("All numbers are equal!")
    }

    func testRandomNumbers() {
        testRandomNumber(generator: doubleRandom.randomNumber,
            assertion: { (Double) in return true })

        testRandomNumber(generator: floatRandom.randomNumber,
            assertion: { (Float) in return true })

        testRandomNumber(generator: intRandom.randomNumber,
            assertion: { (Int) in return true })
    }

    func testPositiveRandomNumbers() {
        testRandomNumber(generator: doubleRandom.positiveRandomNumber,
            assertion: { (number: Double) in return number > 0 })

        testRandomNumber(generator: floatRandom.positiveRandomNumber,
            assertion: { (number: Float) in return number > 0 })

        testRandomNumber(generator: intRandom.positiveRandomNumber,
            assertion: { (number: Int) in return number > 0 })
    }

    func testNonnegativeRandomNumbers() {
        testRandomNumber(generator: doubleRandom.nonnegativeRandomNumber,
            assertion: { (number: Double) in return number >= 0 })

        testRandomNumber(generator: floatRandom.nonnegativeRandomNumber,
            assertion: { (number: Float) in return number >= 0 })

        testRandomNumber(generator: intRandom.nonnegativeRandomNumber,
            assertion: { (number: Int) in return number >= 0 })
    }

    func testUniformFromToRandomNumbers() {
        let a = doubleRandom.randomNumber()
        let b = doubleRandom.randomNumber()
        var lowerLimit = min(a, b)
        var upperLimit = max(a, b)

        testRandomNumber(generator: {
                self.doubleRandom.uniformRandomNumber(
                    from: lowerLimit, to: upperLimit)
            },
            assertion: { $0 > lowerLimit && $0 < upperLimit })

        testRandomNumber(generator: {
                self.floatRandom.uniformRandomNumber(
                    from: Float(lowerLimit), to: Float(upperLimit))
            },
            assertion: { $0 > Float(lowerLimit) && $0 < Float(upperLimit) })

        repeat {
            let a = doubleRandom.randomNumber()
            let b = doubleRandom.randomNumber()
            lowerLimit = min(a, b)
            upperLimit = max(a, b)
        } while abs(Int(lowerLimit)) < 1 && abs(Int(upperLimit)) < 1 &&
            Int(upperLimit) - Int(lowerLimit) < 3

        testRandomNumber(generator: {
                self.intRandom.uniformRandomNumber(
                    from: Int(lowerLimit), to: Int(upperLimit))
            },
            assertion: { $0 > Int(lowerLimit) && $0 < Int(upperLimit) })
    }

    func numberInInterval <T: Numeric> (number: T) -> Bool {
        let tStart = T.fromDouble(start)
        let tInterval = T.fromDouble(interval)

        if interval > 0 {
            return number >= tStart && number <= tStart + tInterval
        } else {
            return number <= tStart && number >= tStart + tInterval
        }
    }

    func testUniformStartIntervalRandomNumbers() {
        start = doubleRandom.randomNumber()
        interval = doubleRandom.randomNumber()

        testRandomNumber(generator: {
                self.doubleRandom.uniformRandomNumber(
                    start: self.start, interval: self.interval)
            },
            assertion: numberInInterval)

        while abs(Float(interval)) <= 10 ^ -5 {
            interval = doubleRandom.randomNumber()
        }

        testRandomNumber(generator: {
                self.floatRandom.uniformRandomNumber(
                    start: Float(self.start), interval: Float(self.interval))
            },
            assertion: numberInInterval)

        while abs(Int(interval)) < 1 {
            interval = doubleRandom.randomNumber()
        }

        testRandomNumber(generator: {
                self.intRandom.uniformRandomNumber(
                    start: Int(self.start), interval: Int(self.interval))
            },
            assertion: numberInInterval)
    }

    func numberWithinDeviation <T: Numeric> (number: T) -> Bool {
        let tInterval = T.fromDouble(interval)
        let tCenter = T.fromDouble(center)

        if tInterval > 0 {
            return number >= tCenter - tInterval &&
                number <= tCenter + tInterval
        } else {
            return number <= tCenter - tInterval &&
                number >= tCenter + tInterval
        }
    }

    func testUniformCenterMaxDeviationRandomNumbers() {
        center = doubleRandom.randomNumber()
        interval = doubleRandom.randomNumber()

        testRandomNumber(generator: {
            self.doubleRandom.uniformRandomNumber(
                center: self.center, maxDeviation: self.interval)
            },
            assertion: numberWithinDeviation)

        while abs(Float(interval)) <= 10 ^ -5 {
            interval = doubleRandom.randomNumber()
        }

        testRandomNumber(generator: {
            self.floatRandom.uniformRandomNumber(
                center: Float(self.center), maxDeviation: Float(self.interval))
            },
            assertion: numberWithinDeviation)

        while abs(Int(interval)) <= 1 {
            interval = doubleRandom.randomNumber()
        }

        testRandomNumber(generator: {
            self.intRandom.uniformRandomNumber(
                center: Int(self.center), maxDeviation: Int(self.interval))
            },
            assertion: numberWithinDeviation)
    }

    func testRandomSign() {
        testRandomNumber(generator: doubleRandom.randomSign,
            assertion: { return $0 == 1 || $0 == -1 })

        testRandomNumber(generator: floatRandom.randomSign,
            assertion: { return $0 == 1 || $0 == -1 })

        testRandomNumber(generator: intRandom.randomSign,
            assertion: { return $0 == 1 || $0 == -1 })
    }
}
