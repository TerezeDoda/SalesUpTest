//
//  Collection.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

extension Collection {

    var nilIfEmpty: Self? {
        return self.isEmpty ? nil : self
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }

}
