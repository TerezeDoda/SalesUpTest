//
//  UsersService.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol UsersServiceProtocol {
    func getUsers(completion: @escaping UsersNetworkCallback)
}

struct UsersService: UsersServiceProtocol {

    func getUsers(completion: @escaping UsersNetworkCallback) {
       APIClient.performRequest(route: .users, completion: completion)
    }
}
