//
//  StringFormat.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

public struct StringFormat {
    public var allowedCharacterSet: CharacterSet?
    public var formatStrings: [FormatString]?
    public var maxLength: Int

    public init() {
        self.allowedCharacterSet = nil
        self.formatStrings = nil
        self.maxLength = NSIntegerMax
    }
}
