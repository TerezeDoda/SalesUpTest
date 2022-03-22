//
//  PostRepository.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import Connectivity

protocol PostRepositoryProtocol {
    func getPosts(completion: @escaping (Result<[Post], SalesUpError>) -> Void)
}

class PostRepository: PostRepositoryProtocol {

    private let remoteSource: PostsRemoteSourceProtocol
    private let localSource: PostsLocalSourceProtocol

    init(remoteSource: PostsRemoteSourceProtocol =  PostsRemoteSource(), localSource: PostsLocalSourceProtocol = PostsLocalSource()) {
        self.localSource = localSource
        self.remoteSource = remoteSource
    }

    func getPosts(completion: @escaping (Result<[Post], SalesUpError>) -> Void) {
        if NetworkStatusMonitor.shared.currentStatus == .connected {
            remoteSource.getPosts(){ res in
                switch res {
                case .success(let response):
                    completion(.success(response))
                    self.localSource.savePosts(response, completion: { _ in
                        print("Posts updated successfully")
                    })
                case .failure(let error):
                   print(error)
                   completion(.failure(SalesUpError.general))
                }
            }
        }
        else {
            print("Get local posts")
            localSource.getPosts(){ res in
                print(res)
                completion(res)
            }
        }
    }
}
