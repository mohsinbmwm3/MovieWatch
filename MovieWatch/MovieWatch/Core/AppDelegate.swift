//
//  AppDelegate.swift
//  MovieWatch
//
//  Created by Khan, Mohsin on 01/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: MovieSearchCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        
        mainCoordinator = MovieSearchCoordinator(navigationController: window?.rootViewController as! UINavigationController, data: nil)
        mainCoordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

