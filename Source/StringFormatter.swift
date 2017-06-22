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

    // MARK: Internal Variables

    let transformer: Transforming
    let format: StringFormat

    // MARK: Init Methods

    /// Initializes a string formatter with the provided stringFormat rules.
    ///
    /// - Parameter stringFormat: An object providing the formatting rules to the formatter.
    public init(stringFormat: StringFormat) {
        self.format = stringFormat
        self.transformer = StringTransformer(stringFormat: stringFormat)

        super.init()
    }

    /// Do not use. Intentionally always returns nil. This class does not conform to NSCoding.
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }

    init(transformer: Transforming, format: StringFormat) {
        self.transformer = transformer
        self.format = format

        super.init()
    }

    // MARK: Public Methods

    public override func editingString(for obj: Any) -> String? {
        guard let string = obj as? String else {
            return nil
        }

        return unformattedString(for: string)
    }

    /// Returns the formatted string.
    ///
    /// - Parameter inputString: The string to apply the string format rules to.
    /// - Returns: The formatted string.
    public func formattedString(for inputString: String?) -> String {
        guard let string = inputString else {
            return ""
        }

        var outputString = string
        outputString = transformer.trimDisallowedCharacters(outputString)
        outputString = transformer.trimToMaxLength(outputString)
        outputString = transformer.insertFormatStrings(outputString)

        return outputString
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
        outputString = transformer.removeFormatStrings(outputString)
        outputString = transformer.trimDisallowedCharacters(outputString)
        outputString = transformer.trimToMaxLength(outputString)

        return outputString
    }
}

extension StringFormatter: UITextFieldDelegate {
    /// Changes the text field string to the formatted string.
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.rangeOfCharacter(from: NSCharacterSet.newlines) == nil else {
            return true
        }

        var outputString = unformattedString(for: textField.text)

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
        textField.sendActions(for: .editingChanged)

        return false
    }
}
