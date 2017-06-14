//
//  StringFormat.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

public struct StringFormat {
    let maxLength: Int

    public init(maxLength: Int = NSIntegerMax) {
        self.maxLength = maxLength
    }
}
