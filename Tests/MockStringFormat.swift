import Foundation

@testable import SKStringFormatter

class MockStringFormat: StringFormat {
    var allowedCharacterSet: CharacterSet?
    var formatStrings: [FormatString]?
    var maxLength: Int

    init() {
        allowedCharacterSet = nil
        formatStrings = nil
        maxLength = NSIntegerMax
    }
}
