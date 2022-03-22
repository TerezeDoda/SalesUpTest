//
//  Contants.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import UIKit

struct K {
    static let networkStatusPollingInterval: TimeInterval = 120.0 // In seconds
    struct Notifications {
        static let networkStatusKey = "kNetworkStatusChangedKey"
        static let connectivityNetworkStatusKey = "kConnectivityNetworkStatusChangedKey"
        static let networkStatusChanged: Notification.Name = Notification.Name("kNetworkStatusChanged")
    }
    struct Server {
        static let baseURL = "https://jsonplaceholder.typicode.com"
    }

}
