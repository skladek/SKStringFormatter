//
//  Decoder.swift
//  SKStringFormatter
//
//  Created by Sean on 6/22/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

protocol Decoding {
    func removeFormatStrings(_ inputString: String) -> String
    func trimDisallowedCharacters(_ inputString: String) -> String
    func trimToMaxLength(_ inputString: String) -> String
}

class Decoder: Decoding {
    let format: StringFormat

    init(stringFormat: StringFormat) {
        self.format = stringFormat
    }

    // MARK: Instance Methods

    func removeFormatStrings(_ inputString: String) -> String {
        guard var formatStrings = format.formatStrings else {
            return inputString
        }

        formatStrings = formatStrings.sorted()

        var outputString = inputString
        for formatString in formatStrings {
            let startIndex = outputString.startIndex
            let endIndex = outputString.endIndex
            if let lowerBound = outputString.index(startIndex, offsetBy: Int(formatString.startIndex), limitedBy: endIndex) {
                if let upperBound = outputString.index(lowerBound, offsetBy: formatString.string.characters.count, limitedBy: endIndex) {
                    let formatRange = lowerBound..<upperBound
                    let substring = outputString.substring(with: formatRange)
                    if substring == formatString.string {
                        outputString = outputString.replacingCharacters(in: formatRange, with: "")
                    }
                }
            }
        }

        return outputString
    }

    func trimDisallowedCharacters(_ inputString: String) -> String {
        return inputString
    }

    func trimToMaxLength(_ inputString: String) -> String {
        return inputString
    }
}
