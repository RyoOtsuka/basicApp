//
//  AppDelegate.swift
//  basicApp
//
//  Created by 大塚　良 on 2019/06/26.
//  Copyright © 2019 Ryo Otsuka. All rights reserved.
//

import UIKit
import Pages
import Firebase
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController = UITabBarController()
    
    let gcmMessageIDKey = "gnmMessageId"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            
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
        
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if Auth.auth().currentUser != nil{
            
            print("ログイン済み")
            insertTabToViewControllers()
            
        }else{
            startTutorial()
        }
        
        return true
    }
    
    func insertTabToViewControllers() {
        
        var viewControllers: [UIViewController] = []
        
        let viewController = ViewController()
        let tab1 = UINavigationController(rootViewController: viewController)
        tab1.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.bookmarks, tag: 0)
        viewControllers.append(tab1)
        
        let viewController2 = SecondViewController()
        let tab2 = UINavigationController(rootViewController: viewController2)
        tab2.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 1)
        viewControllers.append(tab2)
        
        let viewController3 = ThirdViewController()
        let tab3 = UINavigationController(rootViewController: viewController3)
        tab3.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.favorites, tag: 2)
        viewControllers.append(tab3)
        
        tabBarController.setViewControllers(viewControllers, animated: false)
        self.window?.rootViewController = tabBarController
    }
    
    func startTutorial() {
        
        let tutorail1 = Tutorial1ViewController()
        let tutorial2 = Tutorial2ViewController()
        let tutorial3 = Tutorial3ViewController()
        let tutorial4 = Tutorial4ViewController()
        
        let tutorialArray = [ tutorail1, tutorial2, tutorial3, tutorial4]
        
        let pageViewController = PagesController(tutorialArray)
        pageViewController.view.backgroundColor = UIColor.white
        
        let pageControlAppearance = UIPageControl.appearance()
        pageControlAppearance.backgroundColor = .white
        pageControlAppearance.pageIndicatorTintColor = .lightGray
        pageControlAppearance.currentPageIndicatorTintColor = .black
        self.window?.rootViewController = pageViewController
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        
        //notificationにURLデータが含まれていた場合、アプリ内のwebに遷移
        let isURL = userInfo["URL"] as? String
        
        if Auth.auth().currentUser != nil{
            if isURL == nil{
                tabBarController.selectedIndex = 0
                
            }else{
                SecondViewController.pushURL = isURL
                insertTabToViewControllers()
                tabBarController.selectedIndex = 1
            }
            
        }else{
            startTutorial()
        }
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Message Data", remoteMessage.appData)
    }
}

