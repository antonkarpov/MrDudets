//
//  AppDelegate.swift
//  MrDudets
//
//  Created by Anton on 05/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit

import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self])
        
        return true
    }

}

