//
//  AppDelegate.swift
//  MyPersonalMovieTheater
//
//  Created by Tony Jung on 2020/11/27.
//

import UIKit

/// # Review 9 [Resources 디렉토리 분류]
/// AppDelegate와 SceneDelegate가 Resources 디렉토리에 분류되어 있는데
/// 이 둘은 Appliation이라는 디렉토리로 분류하는 편이 더 맞는 것 같습니다.
///
/// # Review 10 [.gitignore 위치]
/// 그리고 .gitignore파일이 현재 Supportings에 들어가있어서 gitignore가 정상적으로 동작을 안하고 있네요.
/// 이거는 프로젝트 최상단(xcworkspace가 있는 위치)에 위치해야합니다.
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

