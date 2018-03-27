//
//  AppDelegate.swift
//  20180324-SergeDossongui-NYCSchools
//
//  Created by serge kone Dossongui on 3/24/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        /**
         *Format Navigation controller color and font
         * @param: none
         */
        UINavigationBar.appearance().barTintColor = UIColor(red: 156/255.0, green:
            6/255.0, blue: 6/255.0, alpha: 0.85)
        UINavigationBar.appearance().tintColor = UIColor.black
        if let barFont = UIFont(name: "Noteworthy", size: 18.0 ) {            UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedStringKey.foregroundColor:UIColor.white,
             NSAttributedStringKey.font:barFont]
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
