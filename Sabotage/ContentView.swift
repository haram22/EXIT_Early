////
//  ContentView.swift
//  Sabotage
//
//  Created by 박서윤 on 2024/01/04.
//


import UIKit
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var selectedTab = 0 // 선택된 탭을 저장하는 상태 변수
}

struct ContentView: View {
    @StateObject var navigationManager = NavigationManager()
    @ObservedObject var viewModel = MainViewModel() // MainViewModel 인스턴스 생성
        @State private var shouldNavigate = false

        var body: some View {
            NavigationView {
                VStack {
                    MainVCRepresentable(viewModel: viewModel, selectedTab: $viewModel.selectedTab)
                        .edgesIgnoringSafeArea(.all)
                        .navigationBarHidden(true)
                    if shouldNavigate {
                        NavigationLink("", destination: BeforeAnalysisVCWrapper(), isActive: $shouldNavigate)
                    }
                    NavigationLink(destination: BeforeAnalysisVCWrapper(),
                                                   isActive: $navigationManager.showBeforeAnalysisVC) {
                                        EmptyView()
                                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: Notification.Name("하람테스트"))) { _ in
                    self.shouldNavigate = true
                }
            }.environmentObject(navigationManager)
        }
}
struct BeforeAnalysisVCWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BeforeAnalysisVC {
        return BeforeAnalysisVC()
    }

    func updateUIViewController(_ uiViewController: BeforeAnalysisVC, context: Context) {
        // 필요한 경우 여기서 ViewController를 업데이트합니다.
    }
}

public struct MainVCRepresentable: UIViewControllerRepresentable {
    @ObservedObject var viewModel: MainViewModel
    @Binding var selectedTab: Int // SwiftUI로부터 가져온 selectedTab

    class CustomTabBar: UITabBar {
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 100 // 탭 바의 높이 조절
            return sizeThatFits
        }
    }

    public func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()

        let mainVC = MainVC()
        let analysisVC = AnalysisVC()
        let profileVC = ProfileVC()
        
        let mainTag = 0
        let analysisTag = 1
        let profileTag = 2

        // 이미지 설정 부분 변경
        mainVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: viewModel.selectedTab == 0 ? "0icon" : "0logo")?.withRenderingMode(.alwaysOriginal), tag: mainTag)
        analysisVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: viewModel.selectedTab == 1 ? "1icon" : "1logo")?.withRenderingMode(.alwaysOriginal), tag: analysisTag)
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: viewModel.selectedTab == 2 ? "2icon" : "2logo")?.withRenderingMode(.alwaysOriginal), tag: profileTag)
        print("🚀 tapbar = \(viewModel.selectedTab)")
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .label

        tabBarController.viewControllers = [mainVC, analysisVC, profileVC]

        tabBarController.selectedIndex = viewModel.selectedTab
        
        let customTabBar = CustomTabBar()
        tabBarController.setValue(customTabBar, forKey: "tabBar")
        print("tab -- \(customTabBar.selectedItem)")
        tabBarController.delegate = context.coordinator // 이 줄 추가
            return tabBarController
    }

    public func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        uiViewController.selectedIndex = viewModel.selectedTab
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, UITabBarControllerDelegate {
        var parent: MainVCRepresentable

        init(_ parent: MainVCRepresentable) {
            self.parent = parent
        }

        public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
                parent.selectedTab = index
                updateTabBarItems(tabBarController: tabBarController) // 탭이 선택될 때마다 이미지 업데이트
            }
            // 탭바가 사라지지 않도록 설정
            viewController.hidesBottomBarWhenPushed = false
            return true
        }

        func updateTabBarItems(tabBarController: UITabBarController) {
            if let viewControllers = tabBarController.viewControllers {
                for (index, viewController) in viewControllers.enumerated() {
                    let imageName = index == parent.selectedTab ? "\(index)icon" : "\(index)logo"
                    viewController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
                }
            }
        }
    }
}
