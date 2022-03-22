//
//  CommentsRepository.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol CommentsRepositoryProtocol {
    func getComments(completion: @escaping CommentsNetworkCallback)
    func saveDetail(detail: Detail)
    func getDetail(completion: @escaping (Result<Detail, SalesUpError>) -> Void)
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

    func saveDetail(detail: Detail) {
        localSource.saveDetails(detail, completion: { res in
            print(res)
        })
    }

    func getDetail(completion: @escaping (Result<Detail, SalesUpError>) -> Void) {
        localSource.getDetails(completion: { result in
           completion(result)
        })
    }

}
