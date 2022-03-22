//
//  DetailsLocalSourceProtocol.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol DetailsLocalSourceProtocol {

    func getDetails(completion: @escaping (Result<Detail, SalesUpError>) -> Void)
    func saveDetails(_ detail: Detail, completion: @escaping (Result<Void, SalesUpError>) -> Void)
    func deleteDetails(completion: @escaping (Result<Void, SalesUpError>) -> Void)

}

class DetailsLocalSource: DetailsLocalSourceProtocol {

    private let database: Database
    private let mapper: RealmDetailMapper

    init(
        database: Database = RealmDatabase.shared,
        mapper: RealmDetailMapper = RealmDetailMapper()
    ) {
        self.database = database
        self.mapper = mapper
    }

    func getDetails(completion: @escaping (Result<Detail, SalesUpError>) -> Void) {
     let query = DetailRealm.detailPredicate
     database.loadObjects(ofType: DetailRealm.self, matchingQuery: query) { result in
            switch result {
            case .success(let details):
                if details.isNotEmpty {
                     completion(.success(self.mapper.fromPersistenceObject(details.first!)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func saveDetails(_ detail: Detail, completion: @escaping (Result<Void, SalesUpError>) -> Void) {
      let detailRealmResponse = mapper.toPersistenceObject(detail)
        database.saveObjects([detailRealmResponse]) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
        }
    }

    func deleteDetails(completion: @escaping (Result<Void, SalesUpError>) -> Void) {

    }

}
