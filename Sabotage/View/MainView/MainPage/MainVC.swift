//Main

//MainVC.swift - 메인 페이지

import UIKit
import SwiftUI
import SnapKit
import Then

protocol LimitItemDelegate: AnyObject {
    func addNewLimitItem(_ itemName: String)
}

class MainVC: UIViewController{
    var segmentedControl = UISegmentedControl()
    
    // MARK: - ".custom"으로 설정해야 이미지를 가진 버튼 만들기 가능
    var actionButton = UIButton(type: .custom)
    var limitButton = UIButton(type: .custom)
    
    var addButton = UIButton(type: .system)
    var pieChartViewController: PieChart!
    
    var limitTableView: UITableView!
    var actionTableView: UITableView!
    
    let logoImageView = UIImageView(image: UIImage(named: "main_logo.png"))
    let logoText = UIImageView(image: UIImage(named: "main_logoText.png"))
    let pieChartBG = UIImageView(image: UIImage(named: "main_pieChartBG.png"))
    let today = UILabel()
    let forMoreAnalysis = UIImageView(image: UIImage(named: "main_forMoreAnalysis.png"))
    
    
    let actionTogglebuttonTapped = UIImageView(image: UIImage(named: "main_actionToggleButtonTapped.png"))
    let limitTogglebuttonTapped = UIImageView(image: UIImage(named: "main_limitToggleButtonTapped.png"))
    
    var limitButtonVisible = false // limitbuttonTapped 이미지의 보이기 여부를 추적하는 변수
    
    let leftButton = UIButton(type: .system)
    let rightButton = UIButton(type: .system)
    
    
    func piechartUI() {
        pieChartViewController = PieChart()
        addChild(pieChartViewController)
        view.addSubview(pieChartViewController.view)
        pieChartViewController.didMove(toParent: self)
        
        pieChartViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pieChartViewController.view.topAnchor.constraint(equalTo: today.bottomAnchor, constant: 15),
            pieChartViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
        ])
    }
    
    func top3Apps() {
        let scheduleVM = ScheduleVM() // Set up your ScheduleVM instance with necessary configurations
        
        let monitoringView = MonitoringView().environmentObject(scheduleVM)
        let hostingController = UIHostingController(rootView: monitoringView)
        addChild(hostingController)
        pieChartBG.addSubview(hostingController.view)
        
        hostingController.view.backgroundColor = .base100
        // Set constraints for the HostingController's view using Auto Layout or other layout methods
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            //            hostingController.view.leadingAnchor.constraint(equalTo: pieChartBG.centerXAnchor, constant: 10),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 220),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            hostingController.view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 280),
            //            hostingController.view.widthAnchor.constraint(equalToConstant: 150),
            //            hostingController.view.heightAnchor.constraint(equalToConstant: 200),
        ])
        hostingController.didMove(toParent: self)
    }
    
    
    
    func pieChartViewUI() {
        let scheduleVM = ScheduleVM()
        logoImageView.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(logoImageView)
        
        logoText.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(logoText)
        
        pieChartBG.contentMode = .scaleAspectFit // 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(pieChartBG)
        
        today.text = "오늘 사용량"
        today.textAlignment = .center
        today.font = UIFont.Callout()
        today.textColor = .base200
        today.numberOfLines = 0 // 필요에 따라 텍스트가 여러 줄로 표시되도록 설정
        pieChartBG.addSubview(today)
        forMoreAnalysis.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(forMoreAnalysis)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forMoreAnalysisTapped))
        forMoreAnalysis.isUserInteractionEnabled = true
        forMoreAnalysis.addGestureRecognizer(tapGesture)
        
        top3Apps()
        
    }
    
    func pieChartConstraintUI() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoText.translatesAutoresizingMaskIntoConstraints = false
        pieChartBG.translatesAutoresizingMaskIntoConstraints = false
        today.translatesAutoresizingMaskIntoConstraints = false

        forMoreAnalysis.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.95), // 상단에 여백을 줄 수 있도록 조정
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.15), // 좌측에 여백을 줄 수 있도록 조정
            logoImageView.widthAnchor.constraint(equalToConstant: 39.304), // 이미지의 가로 크기 조정
            logoImageView.heightAnchor.constraint(equalToConstant: 39.6), // 이미지의 세로 크기 조정
            
            logoText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 31), // 상단에 여백을 줄 수 있도록 조정
            logoText.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 45), // 좌측에 여백을 줄 수 있도록 조정
            logoText.widthAnchor.constraint(equalToConstant: 63), // 이미지의 가로 크기 조정
            logoText.heightAnchor.constraint(equalToConstant: 20), // 이미지의 세로 크기 조정
            
            pieChartBG.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            pieChartBG.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pieChartBG.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            pieChartBG.widthAnchor.constraint(equalToConstant: 400), // 우측에 여백을 줄 수 있도록 조정
            pieChartBG.heightAnchor.constraint(equalToConstant: 300), // 이미지의 세로 크기 조정
            
            today.topAnchor.constraint(equalTo: pieChartBG.topAnchor, constant: 34),
            today.trailingAnchor.constraint(equalTo: pieChartBG.leadingAnchor, constant: 140),
            today.widthAnchor.constraint(equalToConstant: 74),
            today.heightAnchor.constraint(equalToConstant: 22),
            
            forMoreAnalysis.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290), // 상단에 여백을 줄 수 있도록 조정
            forMoreAnalysis.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            forMoreAnalysis.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 45),
            forMoreAnalysis.widthAnchor.constraint(equalToConstant: 80),
            forMoreAnalysis.heightAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    @objc func forMoreAnalysisTapped() {
        // Navigate to AnalysisVC
        let analysisVC = ActionTableView_RAM() // Assuming AnalysisVC is your destination view controller
        navigationController?.pushViewController(analysisVC, animated: true)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .base50
        
        pieChartViewUI()
        pieChartConstraintUI()
        piechartUI()
     
        
        // 이전 화면으로 돌아가는 "< Back" 버튼 숨기기
        navigationItem.hidesBackButton = true
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        actionButton.setImage(UIImage(named: "main_actionButton.png"), for: .normal)
        actionButton.contentMode = .scaleAspectFit
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        //        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.isHidden = false
        
        // actionTableView의 푸터 뷰로 actionButton을 설정
        
    }
    @objc func showPage(_ notification:Notification) {
            if let userInfo = notification.userInfo {
                if let index = userInfo["index"] as? Int {
                
                    // 네번째 탭의 VC는 NavigationBar를 가지고 있어서 UINavigationController로 다운 캐스팅을 해주기
                    let navigationController = self.children[index] as? UINavigationController
                    
                    
                    // navigationController에 연결되어 있는 secondVC를 push 형식으로 전환
                    guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? BeforeAnalysisVC else { return }
                    navigationController?.pushViewController(secondVC, animated: true)
                    
                    // Modal로 띄우고 싶으면 NavigationController를 연결하는 선행 과정 없이 present 메서드를 사용하면 됨.
                }
                
            }
        }
    
    private func configureTableView(_ tableView: UITableView, cellClass: UITableViewCell.Type, identifier: String) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 450), // cell이 시작되는 tableview
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        if tableView == actionTableView {
            tableView.backgroundColor = .base50
            
        } else if tableView == limitTableView {
            tableView.backgroundColor = .base50
        }
        
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    @objc func actionButtonTapped() {
        if actionTableView.visibleCells.count >= 5 {
            // If there are already 5 cells visible in the actionTableView, show an alert
            let alertController = UIAlertController(title: "Limit Reached", message: "You already have 5 items.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            // Handle the navigation or any other action if the limit is not reached
            let actionItemController =  ActionItemController() // Replace this line with your desired action
            navigationController?.pushViewController(actionItemController, animated: true)
       
            
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

