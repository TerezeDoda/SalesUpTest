//
//  LocalSource.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol PostsLocalSourceProtocol {
    func getPosts(completion: @escaping (Result<[Post], SalesUpError>) -> Void)
    func savePosts(_ posts: [Post], completion: @escaping (Result<[Post], SalesUpError>) -> Void)
    func deleteAllPosts(completion: @escaping (Result<Void, SalesUpError>) -> Void)

}

class PostsLocalSource: PostsLocalSourceProtocol {

    private let database: Database
    private let mapper: RealmPostMapper

    init(
        database: Database = RealmDatabase.shared,
        mapper: RealmPostMapper = RealmPostMapper()
    ) {
        self.database = database
        self.mapper = mapper
    }

    func getPosts(completion: @escaping (Result<[Post], SalesUpError>) -> Void) {
        let query = RealmPost.allPostsQuery
        database.loadObjects(ofType: RealmPost.self, matchingQuery: query) { result in
            switch result {
            case .success(let posts):
                if posts.isNotEmpty {
                    let p = posts.map {
                        self.mapper.fromPersistenceObject($0)
                    }
                    completion(.success(p))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func savePosts(_ posts: [Post], completion: @escaping (Result<[Post], SalesUpError>) -> Void) {
      let realmPostResponses = posts.map { mapper.toPersistenceObject($0) }
        database.saveObjects(realmPostResponses) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            self.getPosts(completion: completion)
        }
    }

    func deleteAllPosts(completion: @escaping (Result<Void, SalesUpError>) -> Void) {
        database.deleteAllObjects(ofType: RealmPost.self) { error in
            if let error = error {
                completion(.failure(error))
            } else {
               // completion(.success())
            }
        }
    }

}
