//
//  PostDetailDisplayable.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

struct PostDetaiViewAdapter {

    var authorName: String?
    var postDescription: String?
    var numberOfComments: Int = 0
    var postTitle: String?

    init(post: Post, numberOfComments: Int, author: User?) {
        self.authorName = author?.name
        self.postDescription = post.body
        self.postTitle = post.title
        self.numberOfComments = numberOfComments
        self.postTitle = post.title
    }
}
