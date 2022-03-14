//
//  DatabaseObjectMapper.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol DatabaseObjectMapper {
    associatedtype DomainObject
    associatedtype PersistenceObject

    func fromPersistenceObject(_ persistenceObject: PersistenceObject) -> DomainObject
    func toPersistenceObject(_ domainObject: DomainObject) -> PersistenceObject
}
