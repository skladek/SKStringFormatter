//
//  FormattedTextFieldSpec.swift
//  SKStringFormatter
//
//  Created by Sean on 6/15/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import SKStringFormatter

class FormattedTextFieldSpec: QuickSpec {
    override func spec() {
        var unitUnderTest: FormattedTextField!

        describe("FormattedTextField") {
            beforeEach {
                unitUnderTest = FormattedTextField()
                let window = UIWindow()
                window.addSubview(unitUnderTest)
                RunLoop.current.run(until: Date())
            }

            context("gestureRecognizerShouldBegin(_:)") {
                it("Should return true if the field is not the first responder") {
                    expect(unitUnderTest.gestureRecognizerShouldBegin(UIGestureRecognizer())).to(beTrue())
                }

                it("Should return false if the field is the first responder") {
                    unitUnderTest.becomeFirstResponder()
                    expect(unitUnderTest.gestureRecognizerShouldBegin(UIGestureRecognizer())).to(beFalse())
                }
            }
        }
    }
}
