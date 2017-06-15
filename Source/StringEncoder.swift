//
//  StringEncoder.swift
//  SKStringFormatter
//
//  Created by Sean on 6/15/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation

protocol Encoding {
    func insertFormatStrings(_ inputString: String) -> String
    func trimDisallowedCharacters(_ inputString: String) -> String
    func trimToMaxLength(_ inputString: String) -> String
}

class StringEncoder: Encoding {
    let stringFormat: StringFormat

    init(stringFormat: StringFormat) {
        self.stringFormat = stringFormat
    }

    func insertFormatStrings(_ inputString: String) -> String {
        guard let formatStrings = stringFormat.formatStrings else {
            return inputString
        }

        var outputString = inputString
        var addedCharactersCount: UInt = 0
        for formatString in formatStrings {
            let stringStartIndex = outputString.startIndex
            let stringEndIndex = outputString.endIndex
            let offset = Int(formatString.startIndex + addedCharactersCount)
            if let insertionIndex = outputString.index(stringStartIndex, offsetBy: offset, limitedBy: stringEndIndex),
                inputString.characters.count >= Int(formatString.displaysAt) {
                for character in formatString.string.characters.reversed() {
                    outputString.insert(character, at: insertionIndex)
                    addedCharactersCount += 1
                }
            }
        }

        return outputString
    }

    func trimDisallowedCharacters(_ inputString: String) -> String {
        guard let characterSet = stringFormat.allowedCharacterSet else {
            return inputString
        }

        let invertedCharacterSet = characterSet.inverted
        let stringComponents = inputString.components(separatedBy: invertedCharacterSet)
        let outputString = stringComponents.joined(separator: "")

        return outputString
    }

    func trimToMaxLength(_ inputString: String) -> String {
        if inputString.characters.count <= stringFormat.maxLength {
            return inputString
        }

        let stringStartIndex = inputString.startIndex
        let endIndex = inputString.index(stringStartIndex, offsetBy: stringFormat.maxLength)
        let outputString = inputString.substring(to: endIndex)

        return outputString
    }
}
