//
//  AppDelegate.swift
//  FirebasePhone
//
//  Created by Ranjith Kumar on 8/28/17.
//  Copyright © 2017 Ranjith Kumar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder {
    
    lazy var window: UIWindow? = {
        let w = UIWindow(frame: UIScreen.main.bounds)
        w.makeKeyAndVisible()
        return w
    }()
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        registerNotification(application)
        setupRootScene()
        return true
    }
    
    private func registerNotification(_ application: UIApplication) {
        //Firebase
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
    }
    
    private func setupRootScene() {
        let nc = UINavigationController(rootViewController: PhoneEntryController())
        self.window?.rootViewController = nc
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to auth.
        let auth = Auth.auth()
        
        //At development time we use .sandbox
        auth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
        
        //At time of production it will be set to .prod
        //        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let auth = Auth.auth()
        
        if (auth.canHandleNotification(userInfo)){
            print(userInfo)
        }
    }
}

