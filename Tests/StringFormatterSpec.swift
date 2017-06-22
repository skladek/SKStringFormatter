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
            var mockTransformer: MockTransformer!
            var mockStringFormat: MockStringFormat!
            var unitUnderTest: StringFormatter!

            beforeEach {
                mockTransformer = MockTransformer()
                mockStringFormat = MockStringFormat()
                unitUnderTest = StringFormatter(transformer: mockTransformer, format: mockStringFormat)
            }

            context("init(stringFormat:)") {
                beforeEach {
                    mockStringFormat = MockStringFormat()
                    unitUnderTest = StringFormatter(stringFormat: mockStringFormat)
                }

                it("Should create an transformer with the string format") {
                    expect((unitUnderTest.transformer as? StringTransformer)?.format).to(be(mockStringFormat))
                }

                it("Should set the string format") {
                    expect(unitUnderTest.format).to(be(mockStringFormat))
                }
            }

            context("init?(coder:)") {
                it("Should return nil") {
                    unitUnderTest = StringFormatter(coder: NSCoder())
                    expect(unitUnderTest).to(beNil())
                }
            }

            context("editingString(for:)") {
                it("Should return nil if the input object is not a string") {
                    expect(unitUnderTest.editingString(for: NSObject())).to(beNil())
                }

                it("Should return a string if the input object is a string") {
                    expect(unitUnderTest.editingString(for: "test")).to(beAnInstanceOf(String.self))
                }
            }

            context("formattedString(for:)") {
                it("Should return an empty string if nil is passed in") {
                    expect(unitUnderTest.formattedString(for: nil)).to(equal(""))
                }

                it("Should call trimDisallowedCharacters on the transformer") {
                    let _ = unitUnderTest.formattedString(for: "TestString")
                    expect(mockTransformer.trimDisallowedCharactersCalled).to(beTrue())
                }

                it("Should call trim to max length on the transformer") {
                    let _ = unitUnderTest.formattedString(for: "TestString")
                    expect(mockTransformer.trimToMaxLengthCalled).to(beTrue())
                }

                it("Should call insertFormatStrings on the transformer") {
                    let _ = unitUnderTest.formattedString(for: "TestString")
                    expect(mockTransformer.insertFormatStringsCalled).to(beTrue())
                }
            }

            context("string(for:)") {
                it("Should return nil if the input object is not a string") {
                    expect(unitUnderTest.string(for: NSObject())).to(beNil())
                }

                it("Should return a string if the input object is a string") {
                    expect(unitUnderTest.string(for: "test")).to(beAnInstanceOf(String.self))
                }
            }

            context("unformattedString(for:)") {
                it("Should return an empty string if nil is passed in") {
                    expect(unitUnderTest.unformattedString(for: nil)).to(equal(""))
                }

                it("Should call removeFormatStrings on the transformer") {
                    let _ = unitUnderTest.unformattedString(for: "TestString")
                    expect(mockTransformer.removeFormatStringsCalled).to(beTrue())
                }

                it("Should call trim to max length on the transformer") {
                    let _ = unitUnderTest.formattedString(for: "TestString")
                    expect(mockTransformer.trimToMaxLengthCalled).to(beTrue())
                }

                it("Should call trimDisallowedCharacters on the transformer") {
                    let _ = unitUnderTest.formattedString(for: "TestString")
                    expect(mockTransformer.trimDisallowedCharactersCalled).to(beTrue())
                }
            }

            context("textField(_:shouldChangeCharactersInRange:replacementString:)") {
                var textField: UITextField!

                beforeEach {
                    textField = UITextField(frame: .zero)
                    unitUnderTest = StringFormatter(stringFormat: mockStringFormat)
                    textField.delegate = unitUnderTest
                    textField.text = unitUnderTest.formattedString(for: "1234")
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
