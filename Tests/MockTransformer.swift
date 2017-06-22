//
//  MockTransformer.swift
//  SKStringFormatter
//
//  Created by Sean on 6/15/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

@testable import SKStringFormatter

class MockTransformer: Transforming {
    var insertFormatStringsCalled = false
    var removeFormatStringsCalled = false
    var trimDisallowedCharactersCalled = false
    var trimToMaxLengthCalled = false

    func insertFormatStrings(_ inputString: String) -> String {
        insertFormatStringsCalled = true

        return inputString
    }

    func removeFormatStrings(_ inputString: String) -> String {
        removeFormatStringsCalled = true

        return inputString
    }

    func trimDisallowedCharacters(_ inputString: String) -> String {
        trimDisallowedCharactersCalled = true

        return inputString
    }

    func trimToMaxLength(_ inputString: String) -> String {
        trimToMaxLengthCalled = true

        return inputString
    }
}
