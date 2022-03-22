//
//  PostsCoordinator.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import UIKit

class PostsCoordinator: NSObject, Coordinator {

    let navigationController: UINavigationController
    private let injector: Injector
    private let postRepository: PostRepositoryProtocol
    private let usersRepository: UsersRepositoryProtocol
    private let commentsRepository: CommentsRepositoryProtocol
    private let networkStatusMonitor: NetworkStatusMonitorProtocol = NetworkStatusMonitor.shared
    private weak var postListViewModel: PostListViewModel?
    private weak var postDetailsViewModel: PostDetailViewModel?

    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)

    init(navigationController: UINavigationController, injector: Injector) {
        self.navigationController = navigationController
        self.injector = injector
        self.postRepository = injector.postRepository
        self.usersRepository = injector.usersRepository
        self.commentsRepository = injector.commentsRepository

        networkStatusMonitor.startMonitoring()
    }

    func start() {
        print("PostsCoordinator Start")
        showPostsViewController()
    }

    private func showPostsViewController() {
        let postListViewModel = PostListViewModel(repository: self.postRepository)
        self.postListViewModel = postListViewModel
        postListViewModel.onCoordinatorCallback = { post in
            self.showPostsDetailsViewController(post: post)
        }

        let postListController = storyboard.instantiateViewController(withIdentifier: "PostListController") as! PostListController

        postListController.viewModel = postListViewModel
        navigationController.pushViewController(postListController, animated: true)

    }

    private func showPostsDetailsViewController(post: Post) {
        let postDetailsViewModel = PostDetailViewModel(usersRepository: self.usersRepository, commentsRepository: commentsRepository, post: post)
        self.postDetailsViewModel = postDetailsViewModel

        let postDetailsController = storyboard.instantiateViewController(withIdentifier: "PostDetailsController") as! PostDetailsController
        postDetailsController.viewModel = postDetailsViewModel

        navigationController.pushViewController(postDetailsController, animated: true)

    }

}


