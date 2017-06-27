import SKStringFormatter
import UIKit

class TextViewController: UIViewController {
    @IBOutlet weak var formattingTextField: UITextField!
    @IBOutlet weak var formattingResultLabel: UILabel!
    @IBOutlet weak var unformattingTextField: UITextField!
    @IBOutlet weak var unformattingResultLabel: UILabel!

    let stringFormatter: StringFormatter

    init(stringFormat: StringFormat) {
        stringFormatter = StringFormatter(stringFormat: stringFormat)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func dismissKeyboard() {
        formattingTextField.resignFirstResponder()
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        let unformattedText = stringFormatter.unformattedString(for: sender.text)

        if sender == formattingTextField {
            formattingResultLabel.text = unformattedText
        } else {
            unformattingResultLabel.text = unformattedText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        formattingTextField.delegate = stringFormatter
        formattingTextField.text = stringFormatter.formattedString(for: "")
    }
}
