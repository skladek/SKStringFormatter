//
//  FormatStringSpec.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import SKStringFormatter

class FormatStringSpec: QuickSpec {
    var unitUnderTest: FormatString!

    override func spec() {
        describe("FormatString") {
            context("init(string:startIndex:displaysAt:)") {

                beforeEach {
                    self.unitUnderTest = FormatString(string: "TestString", startIndex: 3, displaysAt: 5)
                }

                it("Should set the string value") {
                    expect(self.unitUnderTest.string).to(equal("TestString"))
                }

                it("Should set the start index") {
                    expect(self.unitUnderTest.startIndex).to(equal(3))
                }

                it("Should set the displays at value") {
                    expect(self.unitUnderTest.displaysAt).to(equal(5))
                }

                it("Should set the displays at value to 1 greater than the startIndex if none is provided") {
                    self.unitUnderTest = FormatString(string: "TestString", startIndex: 7)
                    expect(self.unitUnderTest.displaysAt).to(equal(8))
                }
            }

            context("<(lhs:rhs:)") {
                it("Should return true if the lhs start index is less than the rhs start index") {
                    let lhs = FormatString(string: "", startIndex: 0)
                    let rhs = FormatString(string: "", startIndex: 1)
                    expect(lhs < rhs).to(beTrue())
                }

                it("Should return false if the lhs start index is greater than the rhs start index") {
                    let lhs = FormatString(string: "", startIndex: 1)
                    let rhs = FormatString(string: "", startIndex: 0)
                    expect(lhs < rhs).to(beFalse())
                }
            }

            context("==(lhs:rhs:)") {
                it("Should return false if the string values do not match") {
                    let lhs = FormatString(string: "A", startIndex: 1, displaysAt: 1)
                    let rhs = FormatString(string: "B", startIndex: 1, displaysAt: 1)
                    expect(lhs == rhs).to(beFalse())
                }

                it("Should return false if the start index values do not match") {
                    let lhs = FormatString(string: "A", startIndex: 0, displaysAt: 1)
                    let rhs = FormatString(string: "A", startIndex: 1, displaysAt: 1)
                    expect(lhs == rhs).to(beFalse())
                }

                it("Should return false if the displays at values do not match") {
                    let lhs = FormatString(string: "A", startIndex: 1, displaysAt: 0)
                    let rhs = FormatString(string: "A", startIndex: 1, displaysAt: 1)
                    expect(lhs == rhs).to(beFalse())
                }

                it("Should return true if all the parameters match") {
                    let lhs = FormatString(string: "A", startIndex: 1, displaysAt: 1)
                    let rhs = FormatString(string: "A", startIndex: 1, displaysAt: 1)
                    expect(lhs == rhs).to(beTrue())
                }
            }
        }
    }
}
