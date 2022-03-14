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
      static let userId = "userId"
    }

    override class func primaryKey() -> String? {
        return Keys.userId
    }
}
 

extension RealmPost {

    static var allPostsQuery: NSPredicate {
        return NSPredicate(format: "%K != ''", Keys.userId)
    }
}
