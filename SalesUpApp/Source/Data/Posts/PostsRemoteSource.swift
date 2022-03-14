//
//  PostsRemoteSourceProtocol.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol PostsRemoteSourceProtocol {
  func getPosts(completion: @escaping PostsNetworkCallback)
}

class PostsRemoteSource: PostsRemoteSourceProtocol {

    let postService: PostServiceProtocol

    init(postService: PostServiceProtocol = PostService()) {
        self.postService = postService
    }

    func getPosts(completion: @escaping PostsNetworkCallback) {
       postService.getPosts() { result in
          switch result {
            case .success(let response):
               completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
       }
    }
 }
