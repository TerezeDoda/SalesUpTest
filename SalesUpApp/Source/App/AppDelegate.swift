//
//  AppDelegate.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    private var injector: Injector?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let mainWindow = UIWindow(frame: UIScreen.main.bounds)
        window = mainWindow

        appCoordinator = AppCoordinator(window: mainWindow)
        appCoordinator?.start()

        RealmMigrator.performMigrations()

        return true
    }

}

