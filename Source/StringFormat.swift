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
    public var maxLength: Int

    public init() {
        self.allowedCharacterSet = nil
        self.maxLength = NSIntegerMax
    }
}
