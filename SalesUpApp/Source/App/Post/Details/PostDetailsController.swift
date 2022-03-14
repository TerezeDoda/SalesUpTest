//
//  PostDetailsController.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import UIKit

class PostDetailsController: UIViewController {

    var viewModel: PostDetailViewModel?

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var numberOfCommnetsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.setUpView(view: self)
        viewModel?.getDetails()
    }
}

extension PostDetailsController: PostDetailViewProtocol {

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

    func loadResult(details: PostDetaiViewAdapter) {
        dispatchToMain {
            self.title = details.postTitle
            self.authorLabel.text = details.authorName
            self.postBodyLabel.text = details.postDescription
            self.numberOfCommnetsLabel.text =  String(details.numberOfComments)
        }
    }
}
