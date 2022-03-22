//
//  Detail.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import RealmSwift

class DetailRealm: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var authorName: String = ""
    @objc dynamic var postDescription: String = ""
    @objc dynamic var numberOfComments: Int = 0

    struct Keys {
      static let id = "id"
    }

    override class func primaryKey() -> String? {
        return Keys.id
    }
}

extension DetailRealm {
    static var detailPredicate: NSPredicate {
        return NSPredicate(format: "%K > 0", Keys.id)
    }
}
