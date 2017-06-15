//
//  MockEncoder.swift
//  SKStringFormatter
//
//  Created by Sean on 6/15/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

@testable import SKStringFormatter

class MockEncoder: Encoding {
    var insertFormatStringsCalled = false
    var trimDisallowedCharactersCalled = false
    var trimToMaxLengthCalled = false

    func insertFormatStrings(_ inputString: String) -> String {
        insertFormatStringsCalled = true

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
