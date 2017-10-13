import Foundation

protocol Transforming {
    func insertFormatStrings(_ inputString: String) -> String
    func removeFormatStrings(_ inputString: String) -> String
    func trimDisallowedCharacters(_ inputString: String) -> String
    func trimToMaxLength(_ inputString: String) -> String
}

class StringTransformer: Transforming {
    let format: StringFormat

    init(stringFormat: StringFormat) {
        self.format = stringFormat
    }

    func insertFormatStrings(_ inputString: String) -> String {
        guard let formatStrings = format.formatStrings else {
            return inputString
        }

        var outputString = inputString
        var addedCharactersCount: UInt = 0
        for formatString in formatStrings {
            let offset = Int(formatString.startIndex + addedCharactersCount)
            if let insertionIndex = outputString.index(outputString.startIndex, offsetBy: offset, limitedBy: outputString.endIndex),
                inputString.characters.count >= Int(formatString.displaysAt) {
                for character in formatString.string.characters.reversed() {
                    outputString.insert(character, at: insertionIndex)
                    addedCharactersCount += 1
                }
            }
        }

        return outputString
    }

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
                    let substring = String(outputString[formatRange])
                    if substring == formatString.string {
                        outputString = outputString.replacingCharacters(in: formatRange, with: "")
                    }
                }
            }
        }

        return outputString
    }

    func trimDisallowedCharacters(_ inputString: String) -> String {
        guard let characterSet = format.allowedCharacterSet else {
            return inputString
        }

        let invertedCharacterSet = characterSet.inverted
        let stringComponents = inputString.components(separatedBy: invertedCharacterSet)
        let outputString = stringComponents.joined(separator: "")

        return outputString
    }

    func trimToMaxLength(_ inputString: String) -> String {
        if inputString.characters.count <= format.maxLength {
            return inputString
        }

        let stringStartIndex = inputString.startIndex
        let endIndex = inputString.index(stringStartIndex, offsetBy: format.maxLength)
        let outputString = String(inputString[..<endIndex])

        return outputString
    }
}
