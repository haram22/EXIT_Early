//
//  SabotageApp.swift
//  Sabotage
//
//  Created by 김하람 on 12/27/23.
//

import SwiftUI
import FamilyControls

let deviceID = UIDevice.current.identifierForVendor!.uuidString

@main
struct ScreenTime_SabotageApp: App {
    @StateObject var familyControlsManager = FamilyControlsManager.shared
    @StateObject var scheduleVM = ScheduleVM()
    init() {
        handleRequestAuthorization()
        requestNotificationPermission()
//        initUUID()
    }
    var body: some Scene {
        WindowGroup {
            VStack {
                // MARK: - ram 권한에 대한 조건 설정
                if !familyControlsManager.hasScreenTimePermission {
                    ContentView()
                } else {
                  ContentView()
                }
            }
            .onReceive(familyControlsManager.authorizationCenter.$authorizationStatus) { newValue in
                // here
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    familyControlsManager.updateAuthorizationStatus(authStatus: newValue)
                }
            }
            .environmentObject(familyControlsManager)
            .environmentObject(scheduleVM)
        }
    }
}

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            print("Notification Permission Granted.\(deviceID)")
            
        } else {
            print("Notification Permission Denied.\(deviceID)")
        }
    }
}
@MainActor
func handleRequestAuthorization() {
    FamilyControlsManager.shared.requestAuthorization()
}

struct ActionItemData : Codable {
    // 이 부분의 변수명들은 불러온 부분과 일치해야 함.
    let data : [DataList]
}

struct DataList : Codable {
    let id : Int
    let category : String
    let content : String
}


struct LimitItemData : Codable {
    // 이 부분의 변수명들은 불러온 부분과 일치해야 함.
    let data : [LimitDataList]
}

struct LimitDataList : Codable {
    let id : Int
    let title: String
    let timeBudget: Int
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("🎡 \(bannetText)")
        // 알림 델리게이트 설정
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.content.title == "탈출 1분 전!" {
            NotificationCenter.default.post(name: Notification.Name("하람테스트"), object: nil, userInfo: ["index": 3])
        }
        completionHandler()
    }
}
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
//struct BeforeAnalysisVCWrapper: UIViewControllerRepresentable {
//    typealias UIViewControllerType = BeforeAnalysisVC
//
//    func makeUIViewController(context: Context) -> BeforeAnalysisVC {
//        // 여기서 BeforeAnalysisVC 인스턴스를 생성
//        return BeforeAnalysisVC()
//    }
//
//    func updateUIViewController(_ uiViewController: BeforeAnalysisVC, context: Context) {
//        // 필요한 경우 업데이트 로직을 여기에 구현
//    }
//}
