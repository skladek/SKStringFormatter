//
//  HomeViewController.swift
//  SampleProject
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import SKStringFormatter
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!

    let stringFormatter: StringFormatter

    init() {
        let stringFormat = StringFormat(maxLength: 5)
        stringFormatter = StringFormatter(stringFormat: stringFormat)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func dismissKeyboard() {
        textField.resignFirstResponder()
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        label.text = stringFormatter.string(for: textField.text)
    }
}
