////
////  MainCopy.swift
////  Sabotage
////
////  Created by 김하람 on 10/22/24.
////
//
//import Foundation
//
////Main
//
////MainVC.swift - 메인 페이지
//
//import UIKit
//import SwiftUI
//import SnapKit
//import Then
//
//protocol LimitItemDelegate: AnyObject {
//    func addNewLimitItem(_ itemName: String)
//}
//
//class MainVC: UIViewController, LimitItemDelegate{
//    var segmentedControl = UISegmentedControl()
//    
//    // MARK: - ".custom"으로 설정해야 이미지를 가진 버튼 만들기 가능
//    var actionButton = UIButton(type: .custom)
//    var limitButton = UIButton(type: .custom)
//    
//    var addButton = UIButton(type: .system)
//    var pieChartViewController: PieChart!
//    
//    var limitTableView: UITableView!
//    var actionTableView: UITableView!
//    
//    let logoImageView = UIImageView(image: UIImage(named: "main_logo.png"))
//    let logoText = UIImageView(image: UIImage(named: "main_logoText.png"))
//    let pieChartBG = UIImageView(image: UIImage(named: "main_pieChartBG.png"))
//    let today = UILabel()
//    let ranking1App = UIImageView(image: UIImage(named: "main_ranking1App.png"))
//    let ranking2App = UIImageView(image: UIImage(named: "main_ranking2App.png"))
//    let ranking3App = UIImageView(image: UIImage(named: "main_ranking3App.png"))
//    let forMoreAnalysis = UIImageView(image: UIImage(named: "main_forMoreAnalysis.png"))
//    
//    
//    let actionTogglebuttonTapped = UIImageView(image: UIImage(named: "main_actionToggleButtonTapped.png"))
//    let limitTogglebuttonTapped = UIImageView(image: UIImage(named: "main_limitToggleButtonTapped.png"))
//    
//    var limitButtonVisible = false // limitbuttonTapped 이미지의 보이기 여부를 추적하는 변수
//    
//    let leftButton = UIButton(type: .system)
//    let rightButton = UIButton(type: .system)
//    
//    
//    func toggleUI() {
//        
//        actionTogglebuttonTapped.contentMode = .scaleAspectFit
//        view.addSubview(actionTogglebuttonTapped)
//        actionTogglebuttonTapped.isHidden = false
//        
//        limitTogglebuttonTapped.contentMode = .scaleAspectFit
//        view.addSubview(limitTogglebuttonTapped)
//        limitTogglebuttonTapped.isHidden = true
//        
//        actionTogglebuttonTapped.translatesAutoresizingMaskIntoConstraints = false
//        limitTogglebuttonTapped.translatesAutoresizingMaskIntoConstraints = false
//        
//        leftButton.setTitle("", for: .normal)
//        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
//        leftButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(leftButton)
//        
//        rightButton.setTitle("", for: .normal)
//        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
//        rightButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(rightButton)
//        
//        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
//        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
//        
//    }
//    
//    func toggleConstraintUI() {
//        
//        NSLayoutConstraint.activate([ // 이거 위치 옮길 때 아래 버튼 위치도 같이 옮기기
//            actionTogglebuttonTapped.topAnchor.constraint(equalTo: pieChartBG.bottomAnchor, constant: -10),
//            actionTogglebuttonTapped.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
//            
//            actionTogglebuttonTapped.widthAnchor.constraint(equalToConstant: view.frame.width + 0),
//            actionTogglebuttonTapped.heightAnchor.constraint(equalToConstant: 60),
//            
//            limitTogglebuttonTapped.topAnchor.constraint(equalTo: pieChartBG.bottomAnchor, constant: -10),
//            limitTogglebuttonTapped.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
//            
//            limitTogglebuttonTapped.widthAnchor.constraint(equalToConstant: view.frame.width + 0),
//            limitTogglebuttonTapped.heightAnchor.constraint(equalToConstant: 60),
//                                    ])
//        
//        NSLayoutConstraint.activate([
//            leftButton.topAnchor.constraint(equalTo: pieChartBG.bottomAnchor, constant: -10),
//            leftButton.leadingAnchor.constraint(equalTo: actionTogglebuttonTapped.leadingAnchor, constant: 0),
//            leftButton.widthAnchor.constraint(equalToConstant: 200),
//            leftButton.heightAnchor.constraint(equalToConstant: 60),
//            
//            rightButton.topAnchor.constraint(equalTo: pieChartBG.bottomAnchor, constant: -10),
//            rightButton.trailingAnchor.constraint(equalTo: actionTogglebuttonTapped.trailingAnchor, constant: 0),
//            rightButton.widthAnchor.constraint(equalToConstant: 200),
//            rightButton.heightAnchor.constraint(equalToConstant: 60),
//        ])
//    }
//    
//    func toggleCondition() {
//        if actionTogglebuttonTapped.isHidden {
//            // actionTogglebuttonTapped is hidden: show actionButton and hide limitButton
//            actionTogglebuttonTapped.isHidden = false
//            limitTogglebuttonTapped.isHidden = true
//            actionButton.isHidden = false
//            limitButton.isHidden = true
//            actionTableView.isHidden = false
//            limitTableView.isHidden = true
//        } else {
//            // actionTogglebuttonTapped is visible: hide actionButton and show limitButton
//            actionTogglebuttonTapped.isHidden = true
//            limitTogglebuttonTapped.isHidden = false
//            actionButton.isHidden = true
//            limitButton.isHidden = false
//            actionTableView.isHidden = true
//            limitTableView.isHidden = false
//        }
//    }
//    
//    // limitTogglebuttonTapped 버튼을 눌렀을 때 실행되는 메서드
//    @objc func leftButtonTapped() {
//        if actionTogglebuttonTapped.isHidden {
//            // actionTogglebuttonTapped이 숨겨져 있는 경우에만 작동하도록 설정
//            toggleCondition()
//        }
//    }
//    
//    // actionTogglebuttonTapped 버튼을 눌렀을 때 실행되는 메서드
//    @objc func rightButtonTapped() {
//        if limitTogglebuttonTapped.isHidden {
//            // limitTogglebuttonTapped이 숨겨져 있는 경우에만 작동하도록 설정
//            toggleCondition()
//        }
//    }
//    
//    func piechartUI() {
//        pieChartViewController = PieChart()
//        addChild(pieChartViewController)
//        view.addSubview(pieChartViewController.view)
//        pieChartViewController.didMove(toParent: self)
//        
//        // Set constraints for the PieChart view and buttons using SnapKit
//        
//        pieChartViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            pieChartViewController.view.topAnchor.constraint(equalTo: today.bottomAnchor, constant: 15),
//            pieChartViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
//        ])
//    }
//    
//    func top3Apps() {
//        let scheduleVM = ScheduleVM() // Set up your ScheduleVM instance with necessary configurations
//        
//        let monitoringView = MonitoringView().environmentObject(scheduleVM)
//        let hostingController = UIHostingController(rootView: monitoringView)
//        addChild(hostingController)
//        pieChartBG.addSubview(hostingController.view)
//        
//        hostingController.view.backgroundColor = .base100
//        // Set constraints for the HostingController's view using Auto Layout or other layout methods
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
//            //            hostingController.view.leadingAnchor.constraint(equalTo: pieChartBG.centerXAnchor, constant: 10),
//            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 220),
//            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//            hostingController.view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 280),
//            //            hostingController.view.widthAnchor.constraint(equalToConstant: 150),
//            //            hostingController.view.heightAnchor.constraint(equalToConstant: 200),
//        ])
//        hostingController.didMove(toParent: self)
//    }
//    
//    
//    
//    func pieChartViewUI() {
//        let scheduleVM = ScheduleVM()
//        logoImageView.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
//        view.addSubview(logoImageView)
//        
//        logoText.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
//        view.addSubview(logoText)
//        
//        pieChartBG.contentMode = .scaleAspectFit // 이미지의 크기를 유지하면서 비율을 맞춤
//        view.addSubview(pieChartBG)
//        
//        today.text = "오늘 사용량"
//        today.textAlignment = .center
//        today.font = UIFont.Callout()
//        today.textColor = .base200
//        today.numberOfLines = 0 // 필요에 따라 텍스트가 여러 줄로 표시되도록 설정
//        pieChartBG.addSubview(today)
//        
//        ranking1App.contentMode = .scaleAspectFit
//        ranking1App.layer.cornerRadius = 10
//        ranking1App.layer.masksToBounds = true
//        pieChartBG.addSubview(ranking1App)
//        
//        ranking2App.contentMode = .scaleAspectFit
//        ranking2App.layer.cornerRadius = 10
//        ranking2App.layer.masksToBounds = true
//        pieChartBG.addSubview(ranking2App)
//        
//        ranking3App.contentMode = .scaleAspectFit
//        ranking3App.layer.cornerRadius = 10
//        ranking3App.layer.masksToBounds = true
//        pieChartBG.addSubview(ranking3App)
//        
//        forMoreAnalysis.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
//        view.addSubview(forMoreAnalysis)
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forMoreAnalysisTapped))
//        forMoreAnalysis.isUserInteractionEnabled = true
//        forMoreAnalysis.addGestureRecognizer(tapGesture)
//        
//        top3Apps()
//        
//    }
//    
//    func pieChartConstraintUI() {
//        
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        logoText.translatesAutoresizingMaskIntoConstraints = false
//        pieChartBG.translatesAutoresizingMaskIntoConstraints = false
//        today.translatesAutoresizingMaskIntoConstraints = false
//        ranking1App.translatesAutoresizingMaskIntoConstraints = false
//        ranking2App.translatesAutoresizingMaskIntoConstraints = false
//        ranking3App.translatesAutoresizingMaskIntoConstraints = false
//        forMoreAnalysis.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.95), // 상단에 여백을 줄 수 있도록 조정
//            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.15), // 좌측에 여백을 줄 수 있도록 조정
//            logoImageView.widthAnchor.constraint(equalToConstant: 39.304), // 이미지의 가로 크기 조정
//            logoImageView.heightAnchor.constraint(equalToConstant: 39.6), // 이미지의 세로 크기 조정
//            
//            logoText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31), // 상단에 여백을 줄 수 있도록 조정
//            logoText.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 45), // 좌측에 여백을 줄 수 있도록 조정
//            logoText.widthAnchor.constraint(equalToConstant: 63), // 이미지의 가로 크기 조정
//            logoText.heightAnchor.constraint(equalToConstant: 20), // 이미지의 세로 크기 조정
//            
//            pieChartBG.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
//            pieChartBG.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            pieChartBG.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            pieChartBG.widthAnchor.constraint(equalToConstant: 400), // 우측에 여백을 줄 수 있도록 조정
//            pieChartBG.heightAnchor.constraint(equalToConstant: 300), // 이미지의 세로 크기 조정
//            
//            today.topAnchor.constraint(equalTo: pieChartBG.topAnchor, constant: 34),
//            today.trailingAnchor.constraint(equalTo: pieChartBG.leadingAnchor, constant: 140),
//            today.widthAnchor.constraint(equalToConstant: 74),
//            today.heightAnchor.constraint(equalToConstant: 22),
//            
//            ranking1App.topAnchor.constraint(equalTo: pieChartBG.topAnchor, constant: 34),
//            ranking1App.trailingAnchor.constraint(equalTo: pieChartBG.trailingAnchor, constant: -135),
//            ranking1App.widthAnchor.constraint(equalToConstant: 35), // 이미지의 가로 크기 조정
//            ranking1App.heightAnchor.constraint(equalToConstant: 35), // 이미지의 세로 크기 조정
//            
//            ranking2App.topAnchor.constraint(equalTo: ranking1App.bottomAnchor, constant: 20),
//            ranking2App.trailingAnchor.constraint(equalTo: pieChartBG.trailingAnchor, constant: -135),
//            ranking2App.widthAnchor.constraint(equalToConstant: 35), // 이미지의 가로 크기 조정
//            ranking2App.heightAnchor.constraint(equalToConstant: 35), // 이미지의 세로 크기 조정
//            
//            ranking3App.topAnchor.constraint(equalTo: ranking2App.bottomAnchor, constant: 20),
//            ranking3App.trailingAnchor.constraint(equalTo: pieChartBG.trailingAnchor, constant: -135),
//            ranking3App.widthAnchor.constraint(equalToConstant: 35),
//            ranking3App.heightAnchor.constraint(equalToConstant: 35),
//            
//            forMoreAnalysis.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290), // 상단에 여백을 줄 수 있도록 조정
//            forMoreAnalysis.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            //            forMoreAnalysis.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 45),
//            forMoreAnalysis.widthAnchor.constraint(equalToConstant: 80),
//            forMoreAnalysis.heightAnchor.constraint(equalToConstant: 30),
//        ])
//        
//    }
//    
//    @objc func forMoreAnalysisTapped() {
//        // Navigate to AnalysisVC
//        let analysisVC = ActionTableView_RAM() // Assuming AnalysisVC is your destination view controller
//        navigationController?.pushViewController(analysisVC, animated: true)
//    }
//    
//    // MARK: tableView 관련 코드
//    
//    var actionItems: [ActionDataType] = [
//        ActionDataType(id: 0, category: "액션 1", content: "액션 1에 대한 설명입니다."),
//        ActionDataType(id: 1, category: "액션 2", content: "액션 1에 대한 설명입니다.")
//    ]
//    var limitItems: [LimitDummyDataType] = [
//        LimitDummyDataType(id: 0, title: "제한그룹 1", timeBudget: 1),
//        LimitDummyDataType(id: 0, title: "제한그룹 2", timeBudget: 1)
//    ]
//    
//    // tableview data
//    // LimitItemDelegate 메서드 구현
//    func addNewLimitItem(_ itemName: String) {
//        // LimitItemDelegate 메서드 구현
//        let newLimitItem = LimitDummyDataType(id: 0, title: itemName, timeBudget: 3)
//        limitItems.append(newLimitItem)
//        
//        // TableView 업데이트
//        limitTableView.reloadData()
//        
//        // Calculate total height of all cells in the limitTableView
//        let totalTableViewHeight = limitTableView.contentSize.height
//        
//        // Set the content inset to accommodate the limitButton
//        let bottomInset = view.bounds.height - totalTableViewHeight
//        limitTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .base50
//        
//        pieChartViewUI()
//        pieChartConstraintUI()
//        toggleUI()
//        toggleConstraintUI()
//        piechartUI()
//        // MARK: - getBannerActionData
//        //        getBannerActionData()
//        // MARK: - getActionData
////        getActionData()
////        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: .addNotification, object: nil)
//        
//        // MARK: - getLimitData
////        getLimitData()
////        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: .addLimitNotification, object: nil)
//        
//        // MARK: - EjectionPostRequest
////        EjectionPostRequest()
//        
//        // MARK: tableView 관련 코드
//        actionTableView = UITableView(frame: .zero, style: .plain)
//        limitTableView = UITableView(frame: .zero, style: .plain)
//        
//        actionTableView.backgroundColor = UIColor.green // 색을 원하는 대로 변경해주세요.
//        limitTableView.backgroundColor = UIColor.blue
//        
//        // MARK: tableView 관련 코드
//        actionTableView.register(ActionTableViewCell.self, forCellReuseIdentifier: "ActionCustomCell")
//        limitTableView.register(LimitTableViewCell.self, forCellReuseIdentifier: "LimitCustomCell")
//        
//        // MARK: tableView 관련 코드
//        // 뷰에 테이블뷰 추가
//        view.addSubview(actionTableView)
//        view.addSubview(limitTableView)
//        
//        actionTableView.separatorStyle = .none
//        limitTableView.separatorStyle = .none
//        
//        // Auto Layout을 위한 설정
//        actionTableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            actionTableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -400), // UITableview 영역
//            actionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            actionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            actionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//        
//        // Auto Layout을 위한 설정
//        limitTableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            limitTableView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -400), // UITableview 영역 (가장 최신으로 반영)
//            limitTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            limitTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            limitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//        configureTableView(actionTableView, cellClass: ActionTableViewCell.self, identifier: "ActionCustomCell")
//        configureTableView(limitTableView, cellClass: LimitTableViewCell.self, identifier: "LimitCustomCell")
//        
//        // 초기에는 actionTableView만 보이도록 설정
//        actionTableView.isHidden = false
//        limitTableView.isHidden = true
//        
//        // 이전 화면으로 돌아가는 "< Back" 버튼 숨기기
//        navigationItem.hidesBackButton = true
//        
//        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
//        backBarButtonItem.tintColor = .black
//        self.navigationItem.backBarButtonItem = backBarButtonItem
//        
//        actionButton.setImage(UIImage(named: "main_actionButton.png"), for: .normal)
//        actionButton.contentMode = .scaleAspectFit
//        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
//        //        view.addSubview(actionButton)
//        actionButton.translatesAutoresizingMaskIntoConstraints = false
//        actionButton.isHidden = false
//        
//        // actionTableView의 푸터 뷰로 actionButton을 설정
//        
//        // MARK: - 이거 안 되면 푸터 뷰 대신에 UITableViewCell 안에 버튼을 추가하는 방식 사용 -> UITableViewCell을 커스텀하여 버튼을 셀 안에 추가해야 함.
//        
//        //        actionTableView.tableFooterView = actionButton
//        
//        // 버튼을 마지막 셀 아래에 위치하도록 Auto Layout을 사용하여 조정
//        //        NSLayoutConstraint.activate([
//        ////            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//        //            actionButton.topAnchor.constraint(equalTo: actionTableView.bottomAnchor, constant: 0),
//        //            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//        //            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//        //            actionButton.widthAnchor.constraint(equalToConstant: 370), // 버튼의 너비 조정
//        //            actionButton.heightAnchor.constraint(equalToConstant: 80) // 버튼의 높이 조정
//        //
//        //        ])
//        
//        let actiontotalTableViewHeight = actionTableView.contentSize.height + actionButton.bounds.height
//        actionTableView.contentInset = UIEdgeInsets(top: 00, left: 0, bottom: actiontotalTableViewHeight, right: 0)
//        
//        limitButton.setImage(UIImage(named: "main_limitButton.png"), for: .normal)
//        limitButton.contentMode = .scaleAspectFit
//        limitButton.addTarget(self, action: #selector(limitButtonTapped), for: .touchUpInside)
//        view.addSubview(limitButton)
//        limitButton.translatesAutoresizingMaskIntoConstraints = false
//        limitButton.isHidden = true
//        NSLayoutConstraint.activate([
//            
//            limitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            limitButton.topAnchor.constraint(equalTo: limitTableView.bottomAnchor, constant: 150),
//            limitButton.widthAnchor.constraint(equalToConstant: 350), // Adjust the width and height based on your image size
//            limitButton.heightAnchor.constraint(equalToConstant: 100) // Adjust the width and height based on your image size
//            
//            
//        ])
//        
//        limitTableView.tableFooterView = limitButton
//        
//        let totalTableViewHeight = limitTableView.contentSize.height + limitButton.bounds.height
//        limitTableView.contentInset = UIEdgeInsets(top: 00, left: 0, bottom: totalTableViewHeight, right: 0)
//    }
//    @objc func showPage(_ notification:Notification) {
//            if let userInfo = notification.userInfo {
//                if let index = userInfo["index"] as? Int {
//                
//                    // 네번째 탭의 VC는 NavigationBar를 가지고 있어서 UINavigationController로 다운 캐스팅을 해주기
//                    let navigationController = self.children[index] as? UINavigationController
//                    
//                    
//                    // navigationController에 연결되어 있는 secondVC를 push 형식으로 전환
//                    guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? BeforeAnalysisVC else { return }
//                    navigationController?.pushViewController(secondVC, animated: true)
//                    
//                    // Modal로 띄우고 싶으면 NavigationController를 연결하는 선행 과정 없이 present 메서드를 사용하면 됨.
//                }
//                
//            }
//        }
//    
//    private func configureTableView(_ tableView: UITableView, cellClass: UITableViewCell.Type, identifier: String) {
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 450), // cell이 시작되는 tableview
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        
//        //        actionTableView.dataSource = self
//        //        actionTableView.delegate = self
//        //
//        //        limitTableView.dataSource = self
//        //        limitTableView.delegate = self
//        
//        
//        if tableView == actionTableView {
//            tableView.backgroundColor = .base50
//            
//        } else if tableView == limitTableView {
//            tableView.backgroundColor = .base50
//        }
//        
//        tableView.register(cellClass, forCellReuseIdentifier: identifier)
//    }
//    
//    @objc func actionButtonTapped() {
//        if actionTableView.visibleCells.count >= 5 {
//            // If there are already 5 cells visible in the actionTableView, show an alert
//            let alertController = UIAlertController(title: "Limit Reached", message: "You already have 5 items.", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(okAction)
//            present(alertController, animated: true, completion: nil)
//        } else {
//            // Handle the navigation or any other action if the limit is not reached
//            let actionItemController =  ActionItemController() // Replace this line with your desired action
//            navigationController?.pushViewController(actionItemController, animated: true)
//       
//            
//            // MARK: ram - test code
//            //        let monitoringView = MonitoringView()
//            //        let hostingController = UIHostingController(rootView: monitoringView)
//            //        navigationController?.pushViewController(hostingController, animated: true)
//            
//            
//        }
//    }
//    
//    
//    @objc func limitButtonTapped() {
//        // MARK: ram - test code
//        print("addButtonTapped")
//        let scheduleView = ScheduleView()
//        let hostingController = UIHostingController(rootView: scheduleView)
//        navigationController?.pushViewController(hostingController, animated: true)
//    }
//    @objc func reloadCollectionView() {
//        DispatchQueue.main.async {
////            self.getActionData()
////            self.getLimitData()
//            self.actionTableView.reloadData()
//            self.limitTableView.reloadData()
//        }
//    }
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//}
//
