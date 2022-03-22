//
//  PostDetailViewModel.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import Connectivity

protocol PostDetailViewModelProtocol {
    func setUpView(view: PostDetailViewProtocol)
    func getDetails()
}

protocol PostDetailViewProtocol {
    func showLoader()
    func hideLoader()
    func loadResult(details: PostDetaiViewAdapter)
}

class PostDetailViewModel: PostDetailViewModelProtocol {

    let usersRepository: UsersRepositoryProtocol
    let commentsRepository: CommentsRepositoryProtocol
    let post: Post
    var postDetailsView: PostDetailViewProtocol?
    let dispatchGroup = DispatchGroup()
    var postAuthor: User? = nil
    var comments: Int = 0

    init (usersRepository: UsersRepositoryProtocol, commentsRepository: CommentsRepositoryProtocol, post: Post){
        self.usersRepository = usersRepository
        self.commentsRepository = commentsRepository
        self.post = post
    }

    func setUpView(view: PostDetailViewProtocol) {
        self.postDetailsView = view

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusDidChange(_:)),
            name: K.Notifications.networkStatusChanged,
            object: nil
        )
    }

    func getDetails() {
        /// TODO:
        // 1. Create a details repository with UsersRepository and CommentsRepository and put the methods get details and saveDetails
        // 2. Use that repository to persist details and get details
        // 3. Remove methods from commentsRepository

        if NetworkStatusMonitor.shared.currentStatus == .connected {
            postDetailsView?.showLoader()
            dispatchGroup.enter()
            getComments()

            dispatchGroup.enter()
            getUsers()

            dispatchGroup.notify(queue: .main, execute: {
                self.postDetailsView?.hideLoader()
                let details = PostDetaiViewAdapter(post: self.post, numberOfComments: self.comments, author: self.postAuthor)
                if let user = self.postAuthor {
                    self.commentsRepository.saveDetail(detail: Detail(id: self.post.id,
                                                                      authorName: user.name,
                                                                      postDescription: self.post.body,
                                                                      numberOfComments: self.comments))
                }
                self.postDetailsView?.loadResult(details: details)
            })
        }
        else {

            commentsRepository.getDetail(completion: { [weak self] res in
                guard let self = self else { return }

                self.postDetailsView?.hideLoader()

                switch res {
                case .success(let detail):
                    let details = PostDetaiViewAdapter(post: self.post, numberOfComments: detail.numberOfComments, author: self.postAuthor)
                    self.postDetailsView?.loadResult(details: details)
                case .failure(let error):
                    print(error)
                }
            })

        }
        
    }

    private func getUsers() {
        usersRepository.getUsers() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.postAuthor = response.first(where: { $0.id == self.post.userId })
            case .failure(let error):
                print(error)
            }
            self.dispatchGroup.leave()
        }
    }

    private func getComments() {
        commentsRepository.getComments() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.comments = response.filter({ $0.postId == self.post.id }).count
            case .failure(let error):
                print(error)
            }
            self.dispatchGroup.leave()
        }
    }

    @objc private func networkStatusDidChange(_ notification: Notification) {
        getDetails()
    }

}
