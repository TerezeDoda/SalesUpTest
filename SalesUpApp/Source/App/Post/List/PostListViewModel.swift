//
//   PostViewModel.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

protocol PostListViewModelProtocol {
    func setUpView(view: PostListViewProtocol)
    func getPosts()
    func didSelectPost(_ post: Post)
    var onCoordinatorCallback: ((Post) -> Void)? { get set }
}

protocol PostListViewProtocol {
    func showLoader()
    func hideLoader()
    func showError(error: String)
    func loadPosts(posts: [Post])
    func loadNoData()
}

class PostListViewModel: PostListViewModelProtocol {

    let repository: PostRepositoryProtocol
    var postView: PostListViewProtocol?
    var onCoordinatorCallback: ((Post) -> Void)?

    init(repository: PostRepositoryProtocol){
        self.repository = repository
    }

    func setUpView(view: PostListViewProtocol){
        self.postView = view
    }

    func getPosts() {
        postView?.showLoader()
        repository.getPosts() { [weak self] result in
           guard let self = self else { return }

           self.postView?.hideLoader()

            switch result {
            case .success(let response):
              response.count == 0
              ? self.postView?.loadNoData()
              : self.postView?.loadPosts(posts: response)
            case .failure(let error):
                print(error)
                self.postView?.showError(error: "Something went wrong")
            }
        }
    }

    func didSelectPost(_ post: Post){
      onCoordinatorCallback?(post)
    }

}
