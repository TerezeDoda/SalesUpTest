//
//  PostService.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation


protocol PostServiceProtocol {
    func getPosts(completion: @escaping PostsNetworkCallback)
}

struct PostService: PostServiceProtocol {

    func getPosts(completion: @escaping PostsNetworkCallback) {
       APIClient.performRequest(route: .posts, completion: completion)
    }
}
