# SKStringFormatter

![Travis Status](https://travis-ci.org/skladek/SKStringFormatter.svg?branch=master)
![Codecov Status](https://img.shields.io/codecov/c/github/skladek/SKStringFormatter.svg)
![Pod Version](https://img.shields.io/cocoapods/v/SKStringFormatter.svg)
![Platform Status](https://img.shields.io/cocoapods/p/SKStringFormatter.svg)
![License Status](https://img.shields.io/github/license/skladek/SKStringFormatter.svg)

SKStringFormatter is a formatter to visually style strings to a known structure while maintaining the raw value of a string without the style additions. This can be used to add formatting for a phone number for example. Check out the SampleProject in the workspace to see some usage examples.

- [Installation](#installation)
- [Initialization](#initialization)
- [StringFormat](#stringformat)
- [FormatString](#formatstring)
- [UITextFieldDelegate](#uitextfielddelegate)
- [FormattedTextField](#formattedtextfield)

---

## Installation

### Cocoapods

Instalation is supported through Cocoapods. Add the following to your pod file for the target where you would like to use SKStringFormatter:

```
pod 'SKStringFormatter'
```

---

## Initialization

To use the string formatter, it must be initialized with an object conforming to the `StringFormat` protocol. This protocol defines attributes about how the format should be applied.


```
import SKStringFormatter
```

```
let stringFormatter = StringFormatter(stringFormat: stringFormat)
```

---

## StringFormat
This protocol defines attributes about how a format should be applied.

### allowedCharacterSet
If this is set, only characters in the allowedCharacterSet will be allowed. Any characters not in the set will be discarded. If this is nil, all characters are allowed.

### formatStrings
An array of FormatString objects which define the position and other attributes of static characters. For instance, the dashes in a Social Security Number format (`XXX-XX-XXXX`) would be defined with format strings.

### maxLength
The maximum length of the format. Any characters beyond the max length will be discarded.

---

## FormatString
FormatString objects define the static decoration strings within a string format. The parenthesis and dash in a US phone number format (`(XXX) XXX-XXXX`) would be defined with FormatString objects.

### Initialization
A FormatString is initialized by providing the string to display (string), position for the string (startIndex), and optionally, the number of characters that the string must reach before displaying the display string (displaysAt).

```
FormatString(string: "(", startIndex: 0, displaysAt: 4)
```

In the above example, the "(" character will be inserted at character index 0 when the string to be formatted reaches 4 characters in length. Note, both the startIndex and displaysAt values do not count any FormatStrings displayed. The indexes only count characters entered by the user.

---

## UITextFieldDelegate
The `StringFormatter` object implements UITextFieldDelegate methods to handle live updating of the format as the user inputs text. Simply set the StringFormatter as the UITextFieldDelegate to adopt this behavior.

```
textfield.delegate = stringFormatter
```

---

## FormattedTextField
A UITextField subclass is provided that can be used in conjunction with the `StringFormatter`. The FormattedTextField prevents user interaction with the field. The user cannot select, paste, or move the cursor. All text entry is appended to the end of the current entry. This subclass does not need to be used, but it is recommended.