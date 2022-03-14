//
//  UsersRemoteSource.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation


protocol UsersRemoteSourceProtocol {
  func getUsers(completion: @escaping UsersNetworkCallback)
}

class UsersRemoteSource: UsersRemoteSourceProtocol {

    let service: UsersServiceProtocol

    init(service: UsersServiceProtocol = UsersService()) {
        self.service = service
    }

    func getUsers(completion: @escaping UsersNetworkCallback) {
       service.getUsers { result in
          switch result {
            case .success(let response):
               print(response)
               completion(.success(response))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
       }
    }

    func savePostAuthor(post: Post) {

    }

 }
