//
//  DetailsLocalSourceProtocol.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol DetailsLocalSourceProtocol {

  func savePostAuthor(authorName: String)
  func savePostComment(comment: String)
  func savePostBody(postBody: String)

  func getDetails()

}

class DetailsLocalSource: DetailsLocalSourceProtocol {

    private let database: Database
    private let mapper: RealmPostDetailMapper

    init(
        database: Database = RealmDatabase.shared,
        mapper: RealmPostDetailMapper = RealmPostDetailMapper()
    ) {
        self.database = database
        self.mapper = mapper
    }
    
    func savePostAuthor(authorName: String) {

    }

    func savePostComment(comment: String) {

    }

    func savePostBody(postBody: String) {

    }

    func getDetails() {

    }


}
