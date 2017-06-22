//
//  StringTransformerSpec.swift
//  SKStringFormatter
//
//  Created by Sean on 6/15/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import SKStringFormatter

class StringTransformerSpec: QuickSpec {
    override func spec() {
        describe("StringTransformer") {
            var mockStringFormat: MockStringFormat!
            var unitUnderTest: StringTransformer!

            beforeEach {
                mockStringFormat = MockStringFormat()
                unitUnderTest = StringTransformer(stringFormat: mockStringFormat)
            }

            context("init(stringFormat:)") {
                it("Should set the string format") {
                    expect(unitUnderTest.format).to(be(mockStringFormat))
                }
            }

            context("insertFormatStrings(_:)") {
                it("Should return the input string if no format strings are specified") {
                    mockStringFormat.formatStrings = nil
                    let inputString = "TestString"
                    expect(unitUnderTest.insertFormatStrings(inputString)).to(equal(inputString))
                }

                it("Should insert the format string objects at their specified locations") {
                    mockStringFormat.formatStrings = [
                        FormatString(string: "A", startIndex: 1),
                        FormatString(string: "B", startIndex: 2),
                        FormatString(string: "C", startIndex: 3),
                        FormatString(string: "D", startIndex: 4, displaysAt: 4),
                    ]
                    let inputString = "1234"
                    expect(unitUnderTest.insertFormatStrings(inputString)).to(equal("1A2B3C4D"))
                }
            }

            context("trimDisallowedCharacters(_:)") {
                it("Should return the input string if allowedCharacterSet is nil") {
                    mockStringFormat.allowedCharacterSet = nil
                    let inputString = "TestString"
                    expect(unitUnderTest.trimDisallowedCharacters(inputString)).to(equal("TestString"))
                }

                it("Should remove characters that are not in the allowedCharacterSet") {
                    mockStringFormat.allowedCharacterSet = CharacterSet.decimalDigits
                    let inputString = "1A2B3C4D5"
                    expect(unitUnderTest.trimDisallowedCharacters(inputString)).to(equal("12345"))
                }

                it("Should return an empty string if no characters match the allowedCharacterSet") {
                    mockStringFormat.allowedCharacterSet = CharacterSet.decimalDigits
                    let inputString = "TestString"
                    expect(unitUnderTest.trimDisallowedCharacters(inputString)).to(equal(""))
                }
            }

            context("trimToMaxLength(_:)") {
                it("Should return the input string if it is shorter than the max length") {
                    mockStringFormat.maxLength = 5
                    let inputString = "1234"
                    expect(unitUnderTest.trimToMaxLength(inputString)).to(equal("1234"))
                }

                it("Should remove all characters after the max length limit") {
                    mockStringFormat.maxLength = 5
                    let inputString = "1234567890"
                    expect(unitUnderTest.trimToMaxLength(inputString)).to(equal("12345"))
                }
            }
        }
    }
}
