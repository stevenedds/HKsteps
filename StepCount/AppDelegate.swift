//
//  AppDelegate.swift
//  StepCount
//
//  Created by ultraflex on 1/29/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
    let APP_ID = "2E0F1BF8-11E6-EDEE-FFE0-7C4E5A001600"
    let SECRET_KEY = "CFC5798B-DB26-848C-FFB4-05957BBF7E00"
    let VERSION_NUM = "v1"
    var backendless = Backendless.sharedInstance()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
     backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
   backendless.userService.setStayLoggedIn(true)
    if backendless.userService.currentUser != nil {
        print("Current User")
    }
    return true
  }

    func checkIfUserIsSignIn() {        
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

