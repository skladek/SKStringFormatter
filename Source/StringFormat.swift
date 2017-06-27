import Foundation

/// A protocol defining the available rules for a string format.
public protocol StringFormat {

    /// A set of characters allowed for the formatted string. Characters outside of this set are discarded. If this is nil, all characters are allowed.
    var allowedCharacterSet: CharacterSet? { get }

    /// An array of FormatStrings defining special characters in a string format. For instance, the hyphens in 123-45-6789 can be defined with format strings.
    var formatStrings: [FormatString]? { get }

    /// The maximum length of the string. Strings beyond the maximum length will have the tail trimmed until it meets the limit.
    var maxLength: Int { get }
}
