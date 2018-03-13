//
//  AppDelegate.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/13.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orange
        return true
    }
}

