//
//  MockStringFormat.swift
//  SKStringFormatter
//
//  Created by Sean on 6/15/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

@testable import SKStringFormatter

class MockStringFormat: StringFormat {
    var allowedCharacterSet: CharacterSet?
    var formatStrings: [FormatString]?
    var maxLength: Int

    init() {
        allowedCharacterSet = nil
        formatStrings = nil
        maxLength = NSIntegerMax
    }
}
