//
//  ApiClient.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import Alamofire

class APIClient {

    @discardableResult
    static func performRequest<T:Decodable>(route: ApiRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>) -> Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                completion(response.result)
        }
    }
}

typealias PostsNetworkCallback = (AFResult<[Post]>) -> Void
typealias CommentsNetworkCallback = (AFResult<[Comment]>) -> Void
typealias UsersNetworkCallback = (AFResult<[User]>) -> Void



