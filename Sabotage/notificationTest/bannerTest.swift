////
////  bannerTest.swift
////  Sabotage
////
////  Created by 김하람 on 1/6/24.
////
//
//import SwiftUI
//import UserNotifications
//
//let userNotificationCenter = UNUserNotificationCenter.current()
//
//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//       userNotificationCenter.delegate = self
//       application.registerForRemoteNotifications()
//       return true
//   }
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        
//        let application = UIApplication.shared
//        
//        //앱이 켜져있는 상태에서 푸쉬 알림을 눌렀을 때
//        if application.applicationState == .active {
//            print("푸쉬알림 탭(앱 켜져있음)")
//        }
//        
//        //앱이 꺼져있는 상태에서 푸쉬 알림을 눌렀을 때
//        if application.applicationState == .inactive {
//            print("푸쉬알림 탭(앱 꺼져있음)")
//        }
//    }
//}
