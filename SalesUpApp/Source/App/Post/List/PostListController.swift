//
//  ViewController.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import UIKit

class PostListController: UIViewController {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var postsTableView: UITableView!

    var viewModel: PostListViewModelProtocol?
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        setUpTableView()
        setNavigationTitle()

        viewModel?.setUpView(view: self)
        viewModel?.getPosts()
    }

    private func setNavigationTitle(){
        self.title = "Posts"
    }

    private func registerCell() {
        postsTableView.register(PostCell.self)
    }

    private func setUpTableView() {
        self.postsTableView.delegate = self
        self.postsTableView.dataSource = self

        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 44
    }
}

extension PostListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
        if let post = posts[indexPath.row] as Post? {
            cell.setUp(post: post)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectPost(posts[indexPath.row])
    }
}

extension PostListController: PostListViewProtocol {
    func loadNoData() {
        dispatchToMain {
            let noDataView = NoDataView.instanceFromNib(noDataType: .posts)
            self.postsTableView.backgroundView = noDataView
        }
    }

    func loadPosts(posts: [Post]) {
        dispatchToMain {
            self.posts = posts
            self.postsTableView.reloadData()
        }
    }

    func showLoader() {
        dispatchToMain {
            self.loader.isHidden = false
            self.loader.startAnimating()
        }
    }

    func hideLoader() {
        dispatchToMain {
            self.loader.isHidden = true
            self.loader.stopAnimating()
        }
    }

    func showError(error: String) {
        dispatchToMain {
            NotificationBanner.show(error)
        }
    }
}
