//
//  AppDelegate.swift
//  ios
//
//  Created by Matthew on 7/25/19.
//  Copyright © 2019 bahlsenwitz. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Init", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Init") as! Init
        
        let navigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        self.window?.tintColor = .white
        
        self.configureGlobalUI()
        return true
    }
    
    public var id: String?
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("000")
        
        print("id: \(id!)")
        
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let note_key: String? = tokenParts.joined()
        
        print("note_key: \(note_key!)")
        
        let payload: [String: String] = ["id": id!, "note_key": note_key!]
        
        UpdatePush().execute(requestPayload: payload) { (response) in
            
            print("response: \(response)")
            
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("111")
        print("Failed to register: \(error)")
    }
    
    /*
     
     {"aps":{"alert":"new update available","badge":"1","content-available":1}}
     
     */
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("notification recieved")
        //let state = application.applicationState
        //switch state {
        //case .inactive:
            //print(".inactive")
            //UIApplication.shared.applicationIconBadgeNumber = 1
            //completionHandler(UIBackgroundFetchResult.newData)
        //case .background:
            //print(".background")
            //let notification = userInfo["aps"] as? NSDictionary
            //guard let string: String = notification?["badge"] as? String else {
                //return
            //}
            //let badge: Int = 1
            //UIApplication.shared.applicationIconBadgeNumber = 1
            //completionHandler(UIBackgroundFetchResult.newData)
        //case .active:
            //print(".active")
        //default:
            //print("default")
            //UIApplication.shared.applicationIconBadgeNumber = 1
            //completionHandler(UIBackgroundFetchResult.newData)
        //}
        application.applicationIconBadgeNumber = 1
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0 //reset badge count
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //application.applicationIconBadgeNumber = 0 //reset badge count
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func configureGlobalUI() {
        UINavigationBar.appearance().tintColor = UIColor.white
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
}
