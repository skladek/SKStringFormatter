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
        }
    }
}
