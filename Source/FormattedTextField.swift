//
//  FormattedTextField.swift
//  SKStringFormatter
//
//  Created by Sean on 6/15/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import UIKit

/// A text field designed to be used with formatted strings. This prevents the cursor from
/// being moved and from other actions like copy/paste from being performed.
public class FormattedTextField: UITextField {

    /// Overrides the default behavior to disallow gestures when the field is the first responder.
    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !isFirstResponder
    }
}
