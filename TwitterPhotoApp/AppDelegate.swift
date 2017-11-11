//
//  AppDelegate.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/11.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Twitter.sharedInstance().start(withConsumerKey: "cKokA4yd6RLtr4y4FjxQ0Andp", consumerSecret: "MkrqZA8ImacCUHXYGvTVFzmmlcfjLENEYVISs0QvmCAmqXLpBO")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = Twitter.sharedInstance().sessionStore.hasLoggedInUsers()
            ? storyboard.instantiateViewController(withIdentifier: "Navi") as! UINavigationController
            : storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        window?.rootViewController = viewcontroller
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if Twitter.sharedInstance().application(app, open: url, options: options) {
            return true
        }
        return true
    }
    
}

