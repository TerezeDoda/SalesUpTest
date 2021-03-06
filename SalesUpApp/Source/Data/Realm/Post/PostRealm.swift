//
//  Post.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import RealmSwift

class RealmPost: Object {

   @objc dynamic var userId: Int = 0
   @objc dynamic var id: Int = 0
   @objc dynamic var title: String = ""
   @objc dynamic var body: String = ""


    struct Keys {
      static let id = "id"
    }

    override class func primaryKey() -> String? {
        return Keys.id
    }
}
 

extension RealmPost {
    static var allPostsQuery: NSPredicate {
        return NSPredicate(format: "%K > 0", Keys.id)
    }
}
