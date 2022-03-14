//
//  PostDetailViewModel.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

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
    }

    func getDetails() {

       postDetailsView?.showLoader()
       dispatchGroup.enter()
       getComments()

       dispatchGroup.enter()
       getUsers()

        dispatchGroup.notify(queue: .main, execute: {
            self.postDetailsView?.hideLoader()
            let details = PostDetaiViewAdapter(post: self.post, numberOfComments: self.comments, author: self.postAuthor)
            self.postDetailsView?.loadResult(details: details)
        })

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

}
