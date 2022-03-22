//
//  ApiRouter.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {

    case posts
    case users
    case comments


    private var method: HTTPMethod {
        switch self {
        case .posts, .users, .comments:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .comments:
            return "/comments"
        }
    }

    private var parameters: Parameters? {
        switch self {
         case .posts, .users, .comments:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {

        let base = URL(string: K.Server.baseURL)!
        let baseAppend = base.appendingPathComponent(path).absoluteString.removingPercentEncoding
        let url = URL(string: baseAppend!)

        var urlRequest =  URLRequest(url: url!)

        urlRequest.httpMethod = method.rawValue

        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}
