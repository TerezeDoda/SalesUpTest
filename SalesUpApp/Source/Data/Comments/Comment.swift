//
//  Comments.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

struct Comment: Codable {
    var postId: Int
    var id: Int
    var email: String
    var body:  String
}
