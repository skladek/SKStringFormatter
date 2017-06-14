//
//  StringFormatter.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

public class StringFormatter: Formatter {
    fileprivate var editingString: String?

    fileprivate let stringFormat: StringFormat

    public init(stringFormat: StringFormat) {
        self.stringFormat = stringFormat

        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func editingString(for obj: Any) -> String? {
        return editingString
    }

    public override func string(for obj: Any?) -> String? {
        guard let string = obj as? String else {
            return nil
        }

        editingString = string

        var formattedString = string
        formattedString = trimDisallowedCharacters(formattedString)
        formattedString = trimToMaxLength(formattedString)

        return formattedString
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
