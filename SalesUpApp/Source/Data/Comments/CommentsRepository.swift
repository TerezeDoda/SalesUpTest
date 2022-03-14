//
//  CommentsRepository.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol CommentsRepositoryProtocol {
    func getComments(completion: @escaping CommentsNetworkCallback)
    func savePostComment(post: Post, user: User)
}

class CommentsRepository: CommentsRepositoryProtocol {

    private let remoteSource: CommentsRemoteSourceProtocol
    private let localSource: DetailsLocalSourceProtocol

    init(remoteSource: CommentsRemoteSourceProtocol = CommentRemoteSource(),  localSource: DetailsLocalSourceProtocol = DetailsLocalSource()) {
        self.remoteSource = remoteSource
        self.localSource = localSource
    }

    func getComments(completion: @escaping CommentsNetworkCallback) {
         remoteSource.getComments(completion: completion)
    }

    func savePostComment(post: Post, user: User){
        // TODO
     }

}
