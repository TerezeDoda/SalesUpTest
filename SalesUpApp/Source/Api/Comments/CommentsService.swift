//
//  CommentsService.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol CommentsServiceProtocol {
    func getComments(completion: @escaping CommentsNetworkCallback)
}

struct CommentsService: CommentsServiceProtocol {

    func getComments(completion: @escaping CommentsNetworkCallback) {
       APIClient.performRequest(route: .comments, completion: completion)
    }
}
