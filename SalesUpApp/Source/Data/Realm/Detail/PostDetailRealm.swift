//
//  DetailRealm.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import RealmSwift

class PostDetailRealm: Object {

   @objc dynamic var postId: Int = 0
   @objc dynamic var authorName: String = ""
   @objc dynamic var postDescription: String = ""
   @objc dynamic var numberOfComments: Int = 0

}

