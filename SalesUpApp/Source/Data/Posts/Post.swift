//
//  Post.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body:  String
}
