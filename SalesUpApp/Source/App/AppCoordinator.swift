//
//  AppCoordinator.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    private var injector: Injector
    var rootViewController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.prefersLargeTitles = true

        self.injector = Injector()
    }

    func start() {
        window.rootViewController = rootViewController
        let postsCoordinator = PostsCoordinator(navigationController: rootViewController, injector: injector)
        coordinate(to: postsCoordinator)
        window.makeKeyAndVisible()
    }
}
