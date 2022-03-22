//
//  RealmDetailMapper.swift
//  SalesUpApp
//
//  Created by ritech on 22.3.22.
//

import Foundation
import RealmSwift

struct RealmDetailMapper: DatabaseObjectMapper {

    typealias DomainObject = Detail
    typealias PersistenceObject = DetailRealm

    func fromPersistenceObject(_ persistenceObject: DetailRealm) -> Detail {
       return Detail(id: persistenceObject.id, authorName: persistenceObject.authorName, postDescription: persistenceObject.postDescription, numberOfComments: persistenceObject.numberOfComments)
    }

    func toPersistenceObject(_ domainObject: Detail) -> DetailRealm {
        let persistenceObject = DetailRealm()
        persistenceObject.id = domainObject.id
        persistenceObject.numberOfComments = domainObject.numberOfComments
        persistenceObject.postDescription = domainObject.postDescription
        persistenceObject.authorName = domainObject.authorName

        return persistenceObject
    }
}
