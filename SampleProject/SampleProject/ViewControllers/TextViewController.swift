//
//  TextViewController.swift
//  SampleProject
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import SKStringFormatter
import UIKit

class TextViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var unformattedLabel: UILabel!

    let stringFormatter: StringFormatter

    init(stringFormat: StringFormat) {
        stringFormatter = StringFormatter(stringFormat: stringFormat)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        textField.removeObserver(self, forKeyPath: #keyPath(UITextField.text))
    }

    @IBAction func dismissKeyboard() {
        textField.resignFirstResponder()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let unformattedText = stringFormatter.unformattedString(for: textField.text)
        unformattedLabel.text = unformattedText
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = stringFormatter
        textField.text = stringFormatter.formattedString(for: "")

        textField.addObserver(self, forKeyPath: #keyPath(UITextField.text), options: [.new], context: nil)
    }
}
