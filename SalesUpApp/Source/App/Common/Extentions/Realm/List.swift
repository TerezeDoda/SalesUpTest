//
//  List.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import RealmSwift

extension List {
    convenience init(with elements: [Element]) {
        self.init()
        self.append(objectsIn: elements)
    }
}
