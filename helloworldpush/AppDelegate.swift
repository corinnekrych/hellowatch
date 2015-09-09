//
//  AppDelegate.swift
//  helloworldpush
//
//  Created by Corinne Krych on 09/09/15.
//  Copyright © 2015 AeroGear. All rights reserved.
//

import UIKit
import AeroGearPush
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Add some categories
        let textAction = UIMutableUserNotificationAction()
        textAction.identifier = "TEXT_ACTION"
        textAction.title = "Reply"
        textAction.authenticationRequired = false
        textAction.destructive = false
                if #available(iOS 9.0, *) {
                    textAction.behavior = .TextInput
                }
        let declineAction = UIMutableUserNotificationAction()
        declineAction.identifier = "DECLINE_ACTION"
        declineAction.title = "Decline"
        declineAction.authenticationRequired = false
        declineAction.destructive = true
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = "CATEGORY_ID"
        category.setActions([textAction, declineAction], forContext: .Default)
        category.setActions([textAction, declineAction], forContext: .Minimal)
        
        let categories = NSSet(object: category) as! Set<UIUserNotificationCategory>
        
        // bootstrap the registration process by asking the user to 'Accept' and then register with APNS thereafter
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: categories)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        // Send metrics when app is launched due to push notification
        //AGPushAnalytics.sendMetricsWhenAppLaunched(launchOptions)
        
        // Display all push messages (even the message used to open the app)
        if let options = launchOptions {
            if let option : NSDictionary = options[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
                let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults();
                // Send a message received signal to display the notification in the table.
                if let aps : NSDictionary = option["aps"] as? NSDictionary {
                    if let alert : String = aps["alert"] as? String {
                        defaults.setObject(alert, forKey: "message_received")
                        defaults.synchronize()
                    } else {
                        let msg = aps["alert"]!["body"] as! String
                        defaults.setObject(msg, forKey: "message_received")
                        defaults.synchronize()
                    }
                }
            }
        }
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // time to register user with the "AeroGear UnifiedPush Server"
        let device = AGDeviceRegistration()
        // perform registration of this device
        device.registerWithClientInfo({ (clientInfo: AGClientDeviceInformation!) in
            
            // set the deviceToken
            clientInfo.deviceToken = deviceToken
            
            // --optional config--
            // set some 'useful' hardware information params
            let currentDevice = UIDevice()
            
            clientInfo.operatingSystem = currentDevice.systemName
            clientInfo.osVersion = currentDevice.systemVersion
            clientInfo.deviceType = currentDevice.model
            },
            
            success: {
                // successfully registered!
                print("successfully registered with UPS!")
                
                // send NSNotification for success_registered, will be handle by registered AGViewController
                let notification = NSNotification(name:"success_registered", object: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
            },
            
            failure: {(error: NSError!) in
                print("Error Registering with UPS: \(error.localizedDescription)")
                
                let notification = NSNotification(name:"error_register", object: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
        })
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

