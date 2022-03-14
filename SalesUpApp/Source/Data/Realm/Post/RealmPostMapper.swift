//
//  RealmPostMapper.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import RealmSwift

struct RealmPostMapper: DatabaseObjectMapper {

    typealias DomainObject = Post
    typealias PersistenceObject = RealmPost

    func fromPersistenceObject(_ persistenceObject: RealmPost) -> Post {
      return Post(userId: persistenceObject.userId, id: persistenceObject.id, title: persistenceObject.title, body: persistenceObject.body)
    }

    func toPersistenceObject(_ domainObject: Post) -> RealmPost {
       let persistenceObject = RealmPost()
       persistenceObject.id = domainObject.id
       persistenceObject.userId = domainObject.userId
       persistenceObject.title = domainObject.title
       persistenceObject.body = domainObject.body

      return persistenceObject
    }
}
