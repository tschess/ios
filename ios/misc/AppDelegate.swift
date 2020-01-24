//
//  AppDelegate.swift
//  ios
//
//  Created by Matthew on 7/25/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit
import UserNotifications // <-- is this actually necessary?
//import PushNotifications // NEED TO REVISIIT THESE PUSH NOTIFICATIONS!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //let pushNotifications = PushNotifications.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //self.pushNotifications.start(instanceId: "33e7c056-ccd1-4bd1-ad69-0e2f0af28a69")
        //self.pushNotifications.registerForRemoteNotifications()
        self.configureGlobalUI()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //self.pushNotifications.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //self.pushNotifications.handleNotification(userInfo: userInfo)
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
    
    /* * */
    func configureGlobalUI() {
        UINavigationBar.appearance().tintColor = Colour().getRed()
    }

}

//Development server: api.sandbox.push.apple.com:443
//Production server: api.push.apple.com:443
//
//{
//    “alg” : “ES256”,
//    “kid” : “9FNJ959UW8”
//}
//{
//    “iss”: “JZK98QUAAY”,
//    “iat”: 1568134782
//}

//{
//“aps” : {
//“alert” : {
//“title” : “Game Request”,
//“subtitle” : “Five Card Draw”
//“body” : “Bob wants to play poker”,
//},
//“category” : “GAME_INVITATION”
//},
//“gameID” : “12345678”
//}
