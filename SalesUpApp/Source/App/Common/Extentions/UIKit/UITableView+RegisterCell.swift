//
//  UITableView+RegisterCell.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import UIKit

extension UITableView {

    func register(_ cellClass: UITableViewCell.Type) {
        register(UINib(nibName: cellClass.identifier, bundle: nil), forCellReuseIdentifier: cellClass.identifier)
    }

    func register(_ cellClass: UITableViewHeaderFooterView.Type) {
        register(UINib(nibName: cellClass.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: cellClass.identifier)
    }
}

 
