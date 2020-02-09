//
//  AppDelegate.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-10-23.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let authVC = storyboard.instantiateViewController(withIdentifier: "AuthVC")
            window?.makeKeyAndVisible()
            window?.rootViewController?.present(authVC, animated: true, completion: nil)
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let googleSignIn = GIDSignIn.sharedInstance().handle(url)
        return ApplicationDelegate.shared.application(app, open: url, options: options) || googleSignIn
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to log user into Google", error)
            return
        }
        
        print("Successfully logged in user", user)
        guard let uid = user.userID else { return }
        guard let email = user.profile.email else { return }
        DataService.instance.createDBUser(uid: uid, userData: ["email": email])
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let error = error {
                print("Failed to authenticate google user: ", error)
                return
            }
            
            print("Successfully logged google user into Firebase", user)
        }
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

