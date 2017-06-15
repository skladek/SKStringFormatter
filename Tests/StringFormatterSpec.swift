//
//  StringFormatterSpec.swift
//  SKStringFormatter
//
//  Created by Sean on 6/15/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import SKStringFormatter

class StringFormatterSpec: QuickSpec {

    override func spec() {
        describe("StringFormatter") {
            var mockEncoder: MockEncoder!
            var mockStringFormat: MockStringFormat!
            var unitUnderTest: StringFormatter!

            beforeEach {
                mockEncoder = MockEncoder()
                mockStringFormat = MockStringFormat()
                unitUnderTest = StringFormatter(encoder: mockEncoder, format: mockStringFormat)
            }

            context("init(stringFormat:)") {
                beforeEach {
                    mockStringFormat = MockStringFormat()
                    unitUnderTest = StringFormatter(stringFormat: mockStringFormat)
                }

                it("Should set the string format") {
                    expect(unitUnderTest.stringFormat).to(be(mockStringFormat))
                }
            }

            context("init?(coder:)") {
                it("Should return nil") {
                    unitUnderTest = StringFormatter(coder: NSCoder())
                    expect(unitUnderTest).to(beNil())
                }
            }

            context("editingString(for:)") {
                it("Should return the editing string property") {
                    unitUnderTest.editingString = "TestString"
                    expect(unitUnderTest.editingString(for: "")).to(equal("TestString"))
                }
            }

            context("string(for: Any?)") {
                it("Should return nil if the input object is not a string") {
                    expect(unitUnderTest.string(for: NSObject())).to(beNil())
                }

                it("Should call trimDisallowedCharacters on the encoder") {
                    let _ = unitUnderTest.string(for: "TestString")
                    expect(mockEncoder.trimDisallowedCharactersCalled).to(beTrue())
                }

                it("Should call trim to max length on the encoder") {
                    let _ = unitUnderTest.string(for: "TestString")
                    expect(mockEncoder.trimToMaxLengthCalled).to(beTrue())
                }

                it("Should call insertFormatStrings on the encoder") {
                    let _ = unitUnderTest.string(for: "TestString")
                    expect(mockEncoder.insertFormatStringsCalled).to(beTrue())
                }
            }

            context("textField(_:shouldChangeCharactersInRange:replacementString:)") {
                var textField: UITextField!

                beforeEach {
                    textField = UITextField(frame: .zero)
                    unitUnderTest = StringFormatter(stringFormat: mockStringFormat)
                    textField.delegate = unitUnderTest
                    textField.text = unitUnderTest.string(for: "1234")
                }

                it("Should return true if the input string is a new line character") {
                    let result = textField.delegate?.textField!(textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "\n")
                    expect(result).to(beTrue())
                }

                it("Should delete the last character if the replacement string length is 0") {
                    let _ = textField.delegate?.textField!(textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
                    expect(textField.text).to(equal("123"))
                }

                it("Should not modify the text if the replacement string does not match the allowed characters") {
                    mockStringFormat.allowedCharacterSet = CharacterSet.decimalDigits
                    let _ = textField.delegate?.textField!(textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "A")
                    expect(textField.text).to(equal("1234"))
                }

                it("Should append the character to the end of the string if the replacement string does match the allowed characters") {
                    mockStringFormat.allowedCharacterSet = CharacterSet.decimalDigits
                    let _ = textField.delegate?.textField!(textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "5")
                    expect(textField.text).to(equal("12345"))
                }

                it("Should allow any characters if the allowedCharacterSet is nil") {
                    let _ = textField.delegate?.textField!(textField, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "A5%∂✅")
                    expect(textField.text).to(equal("1234A5%∂✅"))
                }
            }
        }
    }
}
