//
//  Database.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import RealmSwift

protocol Database {
    func loadObjects<Model: Object, Query: NSPredicate>(
        ofType type: Model.Type,
        matchingQuery query: Query,
        completion: @escaping (Result<[Model], SalesUpError>) -> Void
    )

    func saveObjects<Model: Object>(
        _ objects: [Model],
        completion: @escaping (SalesUpError?) -> Void
    )

    func deleteObjects<Model: Object>(
        _ objects: [Model],
        completion: @escaping (SalesUpError?) -> Void
    )

    func deleteAllObjects<Model: Object>(
        ofType type: Model.Type,
        completion: @escaping (SalesUpError?) -> Void
    )
}
