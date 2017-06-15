//
//  FormatString.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

public struct FormatString {
    public let displaysAt: UInt
    public let startIndex: UInt
    public let string: String

    public init(string: String, startIndex: UInt, displaysAt: UInt? = nil) {
        self.displaysAt = displaysAt ?? startIndex + 1
        self.startIndex = startIndex
        self.string = string
    }
}
