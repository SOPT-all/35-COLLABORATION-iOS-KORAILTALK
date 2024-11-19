//
//  AppDelegate.swift
//  KORAILTALK-iOS
//
//  Created by 조혜린 on 11/18/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let font = UIFont.korailTitle(.title1sb18)
        let titleColor = UIColor.korailBasic(.white)
        let backgroundColor = UIColor.korailBlue(.blue01)
        
        configureNavigationBarAppearance(
            font: font,
            titleColor: titleColor,
            backgroundColor: backgroundColor
        )
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension AppDelegate {
    
    private func configureNavigationBarAppearance(
        font: UIFont,
        titleColor: UIColor,
        backgroundColor: UIColor
    ) {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: font,
            .foregroundColor: titleColor
        ]
        
        appearance.backgroundColor = backgroundColor
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
}

