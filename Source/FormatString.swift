//
//  FormatString.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

// swiftlint:disable operator_whitespace

import Foundation

/// An object defining special characters within a formatted string. For instance, the hyphens in 123-45-6789
public struct FormatString {

    // MARK: Internal Variables

    let displaysAt: UInt
    let startIndex: UInt
    let string: String

    /// Initializes a format string.
    ///
    /// - Parameters:
    ///   - string: The string to be inserted at the start index.
    ///   - startIndex: The index to insert the string at.
    ///   - displaysAt: The number of characters the string must reach before the format string will be displayed.
    ///      If a value is not provided, this value will default to startIndex + 1. Note, this means this must be
    ///      explicitly set for trailing characters or else they will not appear.
    public init(string: String, startIndex: UInt, displaysAt: UInt? = nil) {
        self.displaysAt = displaysAt ?? startIndex + 1
        self.startIndex = startIndex
        self.string = string
    }
}

extension FormatString: Comparable {
    public static func <(lhs: FormatString, rhs: FormatString) -> Bool {
        return lhs.startIndex < rhs.startIndex
    }

    public static func ==(lhs: FormatString, rhs: FormatString) -> Bool {
        return (lhs.displaysAt == rhs.displaysAt) &&
                (lhs.startIndex == rhs.startIndex) &&
                (lhs.string == rhs.string)
    }
}
