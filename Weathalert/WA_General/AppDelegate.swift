//
//  AppDelegate.swift
//  Weathalert
//
//  Created by Scott Browne on 20/12/2017.
//  Copyright © 2017 Smiles Dev. All rights reserved.
//

import UIKit

/// CREDITS TO BE MADE TO:
///     DarkSky
///     Icons made by Those Icons from www.flaticon.com
///

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var profile: WAProfile!
    var currLocNum: Int!
    var currAlertNum: Int!
    
    var filePath: String {
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first;
        return url!.appendingPathComponent("Profile").path
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        loadProfile()
        
        return true
    }
    
    func loadProfile(){
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? Data else {
            self.profile = WAProfile(profileName: "Profile", profileLocations: [WALocation]())
            return
        }
        
        do {
            let profile = try PropertyListDecoder().decode(WAProfile.self, from: data)
            self.profile = profile
            print("Profile loaded successfully.")
        } catch {
            self.profile = WAProfile(profileName: "Profile", profileLocations: [WALocation]())
            print("Error loading Profile.")
        }
    
    }
    
    func saveProfile(){
        
        do {
            let data = try PropertyListEncoder().encode(profile)
            let success = NSKeyedArchiver.archiveRootObject(data, toFile: filePath)
            print(success ? "Successful save." : "Save failed.")
        } catch {
            print ("Save failed.")
        }
        
    }
    
    func getWeekday(timestamp: Double) -> String {
        
        let dayNum = Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: timestamp))
        let daysArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let weekday = daysArray[dayNum-1]
        return weekday
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("App Closing")
        saveProfile()
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        loadProfile()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }


}

