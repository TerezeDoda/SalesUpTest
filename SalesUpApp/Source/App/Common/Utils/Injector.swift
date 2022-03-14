//
//  Injector.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import UIKit

class Injector {

    let postRepository: PostRepositoryProtocol
    let usersRepository: UsersRepositoryProtocol
    let commentsRepository: CommentsRepositoryProtocol

    init() {
       postRepository = PostRepository()
       usersRepository =  UsersRepository()
       commentsRepository = CommentsRepository()
    }
}
