//
//  UsersRepository.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol UsersRepositoryProtocol {
    func getUsers(completion: @escaping UsersNetworkCallback)
    func savePostAuthor(user: User, post: Post)
}

class UsersRepository: UsersRepositoryProtocol {

    private let remoteSource: UsersRemoteSourceProtocol
    private let localSource: DetailsLocalSourceProtocol

    init(remoteSource: UsersRemoteSourceProtocol = UsersRemoteSource(), localSource: DetailsLocalSourceProtocol = DetailsLocalSource()) {
        self.remoteSource = remoteSource
        self.localSource = localSource
    }

    func getUsers(completion: @escaping UsersNetworkCallback) {
         remoteSource.getUsers(completion: completion)
    }

   func savePostAuthor(user: User, post: Post){
        // TODO
    }

}
