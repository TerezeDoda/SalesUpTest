//
//  PostRepository.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import Reachability

protocol PostRepositoryProtocol {
    func getPosts(completion: @escaping PostsNetworkCallback) // not ideal
}

class PostRepository: PostRepositoryProtocol {

    private let remoteSource: PostsRemoteSourceProtocol
    private let localSource: PostsLocalSourceProtocol

    init(remoteSource: PostsRemoteSourceProtocol =  PostsRemoteSource(), localSource: PostsLocalSourceProtocol = PostsLocalSource()) {
        self.localSource = localSource
        self.remoteSource = remoteSource
    }

    func getPosts(completion: @escaping PostsNetworkCallback) {

       self.remoteSource.getPosts(completion: completion)

      // TODO
       let reachability = try! Reachability()
        reachability.whenReachable = { reachability in
           // call remote source
           // update posts in local storage
        }
        reachability.whenUnreachable = { _ in
           // get posts from local storage
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
}
