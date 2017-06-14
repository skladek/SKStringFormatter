//
//  FormatString.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

public struct FormatString {
    public let startIndex: UInt
    public let string: String

    public init(string: String, startIndex: UInt) {
        self.string = string
        self.startIndex = startIndex
    }
}
