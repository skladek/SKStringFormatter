//
//  SampleFormats.swift
//  SampleProject
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import SKStringFormatter

class USPhoneNumberFormat: StringFormat {
    let allowedCharacterSet: CharacterSet?
    let formatStrings: [FormatString]?
    let maxLength: Int

    init() {
        allowedCharacterSet = CharacterSet.decimalDigits
        maxLength = 10
        formatStrings = [
            FormatString(string: "(", startIndex: 0),
            FormatString(string: ") ", startIndex: 3),
            FormatString(string: "-", startIndex: 6),
        ]
    }
}
