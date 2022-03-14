//
//  UITableViewCell+Identifier.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
