//
//  StringFormatter.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

public class StringFormatter: Formatter {
    var editingString: String = ""

    let encoder: Encoding

    let stringFormat: StringFormat

    public init(stringFormat: StringFormat) {
        self.stringFormat = stringFormat
        self.encoder = StringEncoder(stringFormat: stringFormat)

        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    init(encoder: Encoding, format: StringFormat) {
        self.encoder = encoder
        self.stringFormat = format

        super.init()
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
        formattedString = encoder.trimDisallowedCharacters(formattedString)
        formattedString = encoder.trimToMaxLength(formattedString)
        formattedString = encoder.insertFormatStrings(formattedString)

        return formattedString
    }
}

extension StringFormatter: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.rangeOfCharacter(from: NSCharacterSet.newlines) == nil else {
            return true
        }

        var outputString = self.editingString

        if outputString.characters.count + string.characters.count <= stringFormat.maxLength {
            if string.characters.count == 0 && outputString.characters.count > 0 {
                // Deletions
                let endIndex = outputString.endIndex
                let rangeStartIndex = outputString.index(endIndex, offsetBy: -1)
                let range = rangeStartIndex..<endIndex
                outputString = outputString.replacingCharacters(in: range, with: "")
            } else if string.rangeOfCharacter(from: stringFormat.allowedCharacterSet ?? CharacterSet().inverted) != nil {
                outputString.append(string)
            }
        }

        textField.text = self.string(for: outputString)

        return false
    }
}
