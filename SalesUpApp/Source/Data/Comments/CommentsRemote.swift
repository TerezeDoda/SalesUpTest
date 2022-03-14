//
//  CommentsRemoteRepository.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol CommentsRemoteSourceProtocol {
  func getComments(completion: @escaping CommentsNetworkCallback) 
}

class CommentRemoteSource: CommentsRemoteSourceProtocol {

    let service: CommentsServiceProtocol

    init(service: CommentsServiceProtocol = CommentsService()) {
        self.service = service
    }

    func getComments(completion: @escaping CommentsNetworkCallback) {
       service.getComments { result in
          switch result {
            case .success(let response):
               completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
       }
    }
 }
