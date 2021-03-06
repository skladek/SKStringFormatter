import SKStringFormatter

class CreditCardNumberFormat: StringFormat {
    let allowedCharacterSet: CharacterSet?
    let formatStrings: [FormatString]?
    let maxLength: Int

    init() {
        allowedCharacterSet = CharacterSet.decimalDigits
        maxLength = 16
        formatStrings = [
            FormatString(string: " ", startIndex: 4),
            FormatString(string: " ", startIndex: 8),
            FormatString(string: " ", startIndex: 12),
        ]
    }
}

class SocialSecurityNumberFormat: StringFormat {
    let allowedCharacterSet: CharacterSet?
    let formatStrings: [FormatString]?
    let maxLength: Int

    init() {
        allowedCharacterSet = CharacterSet.decimalDigits
        maxLength = 9
        formatStrings = [
            FormatString(string: "-", startIndex: 3),
            FormatString(string: "-", startIndex: 5),
        ]
    }
}

class USPhoneNumberFormat: StringFormat {
    let allowedCharacterSet: CharacterSet?
    let formatStrings: [FormatString]?
    let maxLength: Int

    init() {
        allowedCharacterSet = CharacterSet.decimalDigits
        maxLength = 10
        formatStrings = [
            FormatString(string: "+1 ", startIndex: 0, displaysAt: 0),
            FormatString(string: "(", startIndex: 0, displaysAt: 4),
            FormatString(string: ") ", startIndex: 3, displaysAt: 4),
            FormatString(string: "-", startIndex: 6, displaysAt: 7),
        ]
    }
}
