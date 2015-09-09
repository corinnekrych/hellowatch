//
//  ExtensionDelegate.swift
//  helloworldpush WatchKit Extension
//
//  Created by Corinne Krych on 09/09/15.
//  Copyright © 2015 AeroGear. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        print("applicationDidFinishLaunching")
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
        print("applicationWillResignActive")
    }
    func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
    {
        print("TEXT1 \(identifier)!!!")
    }
    func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification) // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
    {
        print("TEXT2!!!")
    }
    func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject], withResponseInfo responseInfo: [NSObject : AnyObject]) // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
    {
        print("TEXT3!!!")
    }
    func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject]) // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
    {
        print("TEXT4!!!")
    }
    func handleUserActivity(userInfo: [NSObject : AnyObject]?)
    {
        print("TEXT5!!!")
    }
    func didReceiveRemoteNotification(userInfo: [NSObject : AnyObject])
    {
        print("TEXT6!!!")
    }
    func didReceiveLocalNotification(notification: UILocalNotification)
    {
        print("TEXT7!!!")
    }
}
