//
//  StringFormatter.swift
//  SKStringFormatter
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

/// Provides an formatter to convert strings for display.
public class StringFormatter: Formatter {

    // MARK: Public Variables

    /// The non formatted version of the string.
    public internal(set) var editingString: String = ""

    // MARK: Internal Variables

    let decoder: Decoding
    let encoder: Encoding
    let format: StringFormat

    // MARK: Init Methods

    /// Initializes a string formatter with the provided stringFormat rules.
    ///
    /// - Parameter stringFormat: An object providing the formatting rules to the formatter.
    public init(stringFormat: StringFormat) {
        self.format = stringFormat
        self.decoder = Decoder(stringFormat: stringFormat)
        self.encoder = Encoder(stringFormat: stringFormat)

        super.init()
    }

    /// Do not use. Intentionally always returns nil. This class does not conform to NSCoding.
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    init(decoder: Decoding, encoder: Encoding, format: StringFormat) {
        self.decoder = decoder
        self.encoder = encoder
        self.format = format

        super.init()
    }

    // MARK: Public Methods

    /// Returns the formatted string.
    ///
    /// - Parameter inputString: The string to apply the string format rules to.
    /// - Returns: The formatted string.
    public func formattedString(for inputString: String?) -> String {
        guard let string = inputString else {
            return ""
        }

        editingString = string

        var formattedString = string
        formattedString = encoder.trimDisallowedCharacters(formattedString)
        formattedString = encoder.trimToMaxLength(formattedString)
        formattedString = encoder.insertFormatStrings(formattedString)

        return formattedString
    }

    /// Returns the formatted string.
    ///
    /// - Parameter inputString: The string to apply the string format rules to.
    /// - Returns: The formatted string.
    public override func string(for obj: Any?) -> String? {
        guard let string = obj as? String else {
            return nil
        }

        return formattedString(for: string)
    }

    public func unformattedString(for inputString: String?) -> String {
        guard let string = inputString else {
            return ""
        }

        var outputString = string
        outputString = decoder.removeFormatStrings(outputString)

        return outputString
    }
}

extension StringFormatter: UITextFieldDelegate {
    /// Changes the text field string to the formatted string.
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.rangeOfCharacter(from: NSCharacterSet.newlines) == nil else {
            return true
        }

        var outputString = self.editingString

        if outputString.characters.count + string.characters.count <= format.maxLength {
            if string.characters.count == 0 && outputString.characters.count > 0 {
                // Deletions
                let endIndex = outputString.endIndex
                let rangeStartIndex = outputString.index(endIndex, offsetBy: -1)
                let range = rangeStartIndex..<endIndex
                outputString = outputString.replacingCharacters(in: range, with: "")
            } else if string.rangeOfCharacter(from: format.allowedCharacterSet ?? CharacterSet().inverted) != nil {
                outputString.append(string)
            }
        }

        textField.text = self.formattedString(for: outputString)

        return false
    }
}
