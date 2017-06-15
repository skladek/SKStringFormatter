//
//  StringFormat.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

public protocol StringFormat {
    var allowedCharacterSet: CharacterSet? { get }
    var formatStrings: [FormatString]? { get }
    var maxLength: Int { get }
}
