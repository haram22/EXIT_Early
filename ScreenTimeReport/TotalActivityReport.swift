//
//  TotalActivityReport.swift
//  ScreenTimeReport
//
//  Created by 김하람 on 12/28/23.
//

import DeviceActivity
import SwiftUI
import UserNotifications


var bannetText: Int = 0

//protocol DeviceActivityReportScene {
//    // 프로토콜 정의
//    // ...
//}
// MARK: - 각각의 Device Activity Report들에 대응하는 컨텍스트 정의
extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    /// 해당 리포트의 내용 렌더링에 사용할 DeviceActivityReportScene에 대응하는 익스텐션이 필요합니다.  ex) TotalActivityReport
    static let totalActivity = Self("Total Activity")
}
// MARK: - ram : dictionary for triger check
var notificationSentForApps: [String: Bool] = [:]
let userNotificationCenter = UNUserNotificationCenter.current()
// MARK: - Device Activity Report의 내용을 어떻게 구성할 지 설정
struct TotalActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    /// 보여줄 리포트에 대한 컨텍스트를 정의해줍니다.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    /// 어떤 데이터를 사용해서 어떤 뷰를 보여줄 지 정의해줍니다. (SwiftUI View)
    let content: (ActivityReport) -> TotalActivityView
    var activityStartTime: Date?
    /// DeviceActivityResults 데이터를 받아서 필터링
//    let finalActionData = getBannerActionData()
    let finalActionData = ""

    
    func makeConfiguration(
        representing data: DeviceActivityResults<DeviceActivityData>) async -> ActivityReport {
            // Reformat the data into a configuration that can be used to create
            // the report's view.
            var totalActivityDuration: Double = 0 /// 총 스크린 타임 시간
            var list: [AppDeviceActivity] = [] /// 사용 앱 리스트
            let limitTime: Double = 6
//            getLimitData()
            let specificLimitTime: Double = 240
            
            /// DeviceActivityResults 데이터에서 화면에 보여주기 위해 필요한 내용을 추출해줍니다.
            for await eachData in data {
                /// 특정 시간 간격 동안 사용자의 활동
                for await activitySegment in eachData.activitySegments {
                    
                    /// 활동 세그먼트 동안 사용자의 카테고리 별 Device Activity
                    for await categoryActivity in activitySegment.categories {
                        /// 이 카테고리의 totalActivityDuration에 기여한 사용자의 application Activity
                        for await applicationActivity in categoryActivity.applications {
                            let appName = (applicationActivity.application.localizedDisplayName ?? "nil") /// 앱 이름
                            let bundle = (applicationActivity.application.bundleIdentifier ?? "nil") /// 앱 번들id
                            let duration = applicationActivity.totalActivityDuration /// 앱의 total activity 기간
                            // MARK: - ram: 각 앱에 대한 시간처리 조건문
                            if duration >= specificLimitTime - 60 && duration <= specificLimitTime  { // 10 minutes
                                bannetText = 1
                                scheduleNotification_each0(appName: applicationActivity.application.localizedDisplayName!)
                            }
                            if duration >= specificLimitTime && duration <= specificLimitTime + 60  { // 10 minutes
                                
                                bannetText = 2
                                let alert = await UIAlertController(title: "알림", message: "시간이 거의 다 되었습니다!", preferredStyle: .alert)

                                    // 경고에 추가할 버튼(액션) 설정
                                await alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                                scheduleNotification_each1(appName: applicationActivity.application.localizedDisplayName!)
                                
                                    
                            }
//                            if duration >= specificLimitTime {
//                                showAlert(title: "경고", message: "제한 시간을 초과했습니다!")
//                            }
                            if duration >= specificLimitTime + 60 && duration <= specificLimitTime + 120  { // 10 minutes
                                bannetText = 3
                                
                                scheduleNotification_each2(appName: applicationActivity.application.localizedDisplayName!)
                            }
                            totalActivityDuration += duration
                            let numberOfPickups = applicationActivity.numberOfPickups /// 앱에 대해 직접적인 pickup 횟수
                            let token = applicationActivity.application.token /// 앱의 토큰
                            let appActivity = AppDeviceActivity(
                                id: bundle,
                                displayName: appName,
                                duration: duration,
                                numberOfPickups: numberOfPickups,
                                token: token
                            )
                            list.append(appActivity)
                        }
                    }
                    // MARK: - ram : 전체 시간에 대한 처리
//                    if totalActivityDuration >= limitTime - 60 && totalActivityDuration <= limitTime  { // 10 minutes
//                        scheduleNotification0()
//                    }
//                    if totalActivityDuration >= limitTime && totalActivityDuration <= limitTime + 60 { // 10 minutes
//                        scheduleNotification1()
//                    }
//                    else if totalActivityDuration >= limitTime + 60 && totalActivityDuration <= limitTime + 120 { // 10 minutes
//                        scheduleNotification2()
//                    }
                    func getBannerActionItem(userID: String) -> String{
                        return "책 한 페이지 읽기"
                    }
                    func scheduleNotification_each0(appName: String) {
                        if notificationSentForApps["\(appName)1"] != true {
                            EjectionPostRequest()
                            let content = UNMutableNotificationContent()
                            content.title = "탈출 1분 전!"
                            //                        content.body = "You have used \(appName) for 10 minutes."
                            content.body = "지금 보는 것까지만 보고 미리 약속했던 '영어 단어 5개 암기', 해보는건 어떨까요?"
                            content.summaryArgumentCount = 60
                            content.sound = .default
                            print("💪🏻💻 : \(finalActionData)")
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)1"] = true
                        }
                    }
                    
                    func scheduleNotification_each1(appName: String) {
                        if notificationSentForApps["\(appName)2"] != true {
                            EjectionPostRequest()
                            let content = UNMutableNotificationContent()
                            DispatchQueue.main.async {
                                        // Main thread에서 UI 업데이트
//                                        navigationManager.showBeforeAnalysisVC = true
                                    }
                            content.title = "Time Over !!!"
                            content.body = "지금 보는 것까지만 보고 미리\n약속했던 '스쿼트 10회', 해보는건 어떨까요?"
                            
                            content.summaryArgumentCount = 60
                            content.sound = .default
                            
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)2"] = true
                        }
                    }
                    func scheduleNotification_each2(appName: String) {
                        if notificationSentForApps["\(appName)3"] != true {
                            EjectionPostRequest()
                            let content = UNMutableNotificationContent()
                            content.title = "이미 1분이 지났네요.."
                            content.body = "비록 약속을 지키지 못했지만, 아직 늦지 않았어요. 지금 바로 ‘1시 전에 취침', 시작하면 어떨까요?"
                            content.summaryArgumentCount = 60
                            content.sound = .default
                            
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                            notificationSentForApps["\(appName)3"] = true
                        }
                    }
                }
            }
            
            /// 필터링된 ActivityReport 데이터들을 반환
            return ActivityReport(totalDuration: totalActivityDuration, apps: list)
        }
}





func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // 해당 Notification의 content로 메시지 별 분기 가능
        
        if response.notification.request.content.title == "탈출 1분 전!" {
        
            NotificationCenter.default.post(name: Notification.Name("하람테스트"), object: nil, userInfo: ["index":3])
        }
}

class NavigationManager: ObservableObject {
    @Published var showBeforeAnalysisVC: Bool = false
}

//func showAlert(title: String, message: String) {
//    if let topViewController = getTopViewController() {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//        DispatchQueue.main.async {
//            topViewController.present(alert, animated: true, completion: nil)
//        }
//    }
//}

//func getTopViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//    if let nav = base as? UINavigationController {
//        return getTopViewController(nav.visibleViewController)
//    } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
//        return getTopViewController(selected)
//    } else if let presented = base?.presentedViewController {
//        return getTopViewController(presented)
//    }
//    return base
//}
