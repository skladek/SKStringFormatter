//
//  RootViewController.swift
//  SampleProject
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import SKStringFormatter
import SKTableViewDataSource
import UIKit

class RootViewController: UIViewController {

    struct Row {
        let stringFormat: StringFormat
        let title: String
    }

    @IBOutlet weak var tableView: UITableView!

    var dataSource: TableViewDataSource<Row>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let array = [
            Row(stringFormat: CreditCardNumberFormat(), title: "Credit Card Number XXXX XXXX XXXX XXXX"),
            Row(stringFormat: SocialSecurityNumberFormat(), title: "Social Security Number XXX-XX-XXXX"),
            Row(stringFormat: USPhoneNumberFormat(), title: "US Phone Number (XXX) XXX-XXXX"),
        ]

        dataSource = TableViewDataSource(objects: array, cell: UITableViewCell.self, cellPresenter: { (cell, row) in
            cell.textLabel?.text = row.title
        })

        tableView.dataSource = dataSource
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = dataSource?.object(indexPath) {
            let viewController = TextViewController(stringFormat: row.stringFormat)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
