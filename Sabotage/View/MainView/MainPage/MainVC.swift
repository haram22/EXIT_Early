import UIKit
import SwiftUI
import SnapKit
import Then
import RealmSwift

protocol LimitItemDelegate: AnyObject {
    func addNewLimitItem(_ itemName: String)
}

class MainVC: UIViewController {
    var segmentedControl = UISegmentedControl()
    var actionButton = UIButton(type: .custom)
    var limitButton = UIButton(type: .custom)
    var addButton = UIButton(type: .system)
    var pieChartViewController: PieChart!
    var limitTableView: UITableView!
    var actionTableView: UITableView!
    var actionItems: Results<CategoryItem>! // Realm의 데이터 저장
    var realm: Realm!
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
    var limitItems: [String] = ["Limit Item 1"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .base50
        
        // Realm 초기화
        do {
            realm = try Realm()
        } catch {
            print("Realm 초기화 실패: \(error)")
            return
        }
        
        // UI 설정
        pieChartViewUI()
        pieChartConstraintUI()
        piechartUI()
        toggleUI()
        toggleConstraintUI()
        
        // 테이블뷰 설정
        setupTableViews()
        
        // 이전 화면으로 돌아가는 "< Back" 버튼 숨기기
        navigationItem.hidesBackButton = true
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // actionButton 설정
        actionButton.setImage(UIImage(named: "main_actionButton.png"), for: .normal)
        actionButton.contentMode = .scaleAspectFit
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.isHidden = false
        
        // 데이터 로드
        loadData()
    }
    
    // 테이블뷰 설정 함수
    private func setupTableViews() {
        // actionTableView 설정
        actionTableView = UITableView(frame: .zero, style: .plain)
        actionTableView.register(ActionTableViewCell.self, forCellReuseIdentifier: "ActionCustomCell")
        actionTableView.backgroundColor = .base50
        actionTableView.dataSource = self
        actionTableView.delegate = self
        actionTableView.separatorStyle = .none
        view.addSubview(actionTableView)
        
        actionTableView.snp.makeConstraints {
            $0.top.equalTo(leftButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // limitTableView 설정
        limitTableView = UITableView(frame: .zero, style: .plain)
        limitTableView.register(LimitTableViewCell.self, forCellReuseIdentifier: "LimitCustomCell")
        limitTableView.backgroundColor = .base50
        limitTableView.dataSource = self
        limitTableView.delegate = self
        limitTableView.separatorStyle = .none
        view.addSubview(limitTableView)
        
        // limitTableView 위치
        limitTableView.snp.makeConstraints {
            $0.top.equalTo(rightButton.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // 초기 상태 설정
        actionTableView.isHidden = false
        limitTableView.isHidden = true
    }
    
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
        let scheduleVM = ScheduleVM()
        let monitoringView = MonitoringView().environmentObject(scheduleVM)
        let hostingController = UIHostingController(rootView: monitoringView)
        addChild(hostingController)
        pieChartBG.addSubview(hostingController.view)
        
        hostingController.view.backgroundColor = .base100
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 220),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            hostingController.view.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 280),
        ])
        hostingController.didMove(toParent: self)
    }
    
    func pieChartViewUI() {
        let scheduleVM = ScheduleVM()
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        
        logoText.contentMode = .scaleAspectFit
        view.addSubview(logoText)
        // 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(pieChartBG)
        
        today.text = "오늘 사용량"
        today.textAlignment = .center
        //        today.font = UIFon
        today.textColor = .base200
        today.numberOfLines = 0
        pieChartBG.addSubview(today)
        
        forMoreAnalysis.contentMode = .scaleAspectFit
        view.addSubview(forMoreAnalysis)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forMoreAnalysisTapped))
        forMoreAnalysis.isUserInteractionEnabled = true
        forMoreAnalysis.addGestureRecognizer(tapGesture)
        
        top3Apps()
    }
    
    func pieChartConstraintUI() {
        logoImageView.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.95)
                $0.leading.equalToSuperview().offset(25.15)
                $0.width.equalTo(39.304)
                $0.height.equalTo(39.6)
            }
        }
        
        logoText.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(31)
                $0.leading.equalTo(logoImageView.snp.trailing).offset(45)
                $0.width.equalTo(63)
                $0.height.equalTo(20)
            }
        }
        
        pieChartBG.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(logoImageView.snp.bottom).offset(16)
                $0.leading.equalToSuperview().offset(10)
                $0.trailing.equalToSuperview().offset(-10)
                $0.width.equalTo(400)
                $0.height.equalTo(300)
            }
        }
        
        today.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.top).offset(34)
                $0.trailing.equalTo(pieChartBG.snp.leading).offset(140)
                $0.width.equalTo(74)
                $0.height.equalTo(22)
            }
        }
        
        forMoreAnalysis.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(290)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(80)
                $0.height.equalTo(30)
            }
        }
        
    }
    
    func toggleUI() {
        // actionTogglebuttonTapped 설정
        view.addSubview(actionTogglebuttonTapped)
        actionTogglebuttonTapped.contentMode = .scaleAspectFit
        actionTogglebuttonTapped.isHidden = false
        
        // limitTogglebuttonTapped 설정
        view.addSubview(limitTogglebuttonTapped)
        limitTogglebuttonTapped.contentMode = .scaleAspectFit
        limitTogglebuttonTapped.isHidden = true
        
        // leftButton 설정
        view.addSubview(leftButton)
        leftButton.setTitle("", for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        
        // rightButton 설정
        view.addSubview(rightButton)
        rightButton.setTitle("", for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    func toggleConstraintUI() {
        // actionTogglebuttonTapped 제약 조건
        actionTogglebuttonTapped.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(60)
            }
        }
        
        // limitTogglebuttonTapped 제약 조건
        limitTogglebuttonTapped.then {
            print("toggle tapped")
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(60)
            }
        }
        
        // leftButton 제약 조건
        leftButton.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
                $0.leading.equalTo(actionTogglebuttonTapped.snp.leading)
                $0.width.equalTo(200)
                $0.height.equalTo(60)
            }
        }
        
        // rightButton 제약 조건
        rightButton.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
                $0.trailing.equalTo(actionTogglebuttonTapped.snp.trailing)
                $0.width.equalTo(200)
                $0.height.equalTo(60)
            }
        }
    }
    
    @objc func leftButtonTapped() {
        if actionTogglebuttonTapped.isHidden {
            // actionTogglebuttonTapped이 숨겨져 있는 경우에만 toggleCondition 실행
            toggleCondition()
        }
    }
    
    // rightButtonTapped 메서드
    @objc func rightButtonTapped() {
        if limitTogglebuttonTapped.isHidden {
            // limitTogglebuttonTapped이 숨겨져 있는 경우에만 toggleCondition 실행
            toggleCondition()
        }
    }
    
    // toggleCondition 메서드
    func toggleCondition() {
        let isActionHidden = actionTogglebuttonTapped.isHidden
        
        // Toggle 상태 변경
        actionTogglebuttonTapped.isHidden = !isActionHidden
        limitTogglebuttonTapped.isHidden = isActionHidden
        actionButton.isHidden = !isActionHidden
        limitButton.isHidden = isActionHidden
        actionTableView.isHidden = !isActionHidden
        limitTableView.isHidden = isActionHidden
    }
    
    @objc func forMoreAnalysisTapped() {
        let analysisVC = AnalysisVC()
        navigationController?.pushViewController(analysisVC, animated: true)
    }
    
    func loadData() {
        actionItems = realm.objects(CategoryItem.self)
        actionTableView.reloadData()
    }
    
    @objc func showPage(_ notification: Notification) {
        if let userInfo = notification.userInfo, let index = userInfo["index"] as? Int {
            // 네번째 탭의 VC는 NavigationBar를 가지고 있어서 UINavigationController로 다운 캐스팅을 해주기
            let navigationController = self.children[index] as? UINavigationController
            
            // navigationController에 연결되어 있는 secondVC를 push 형식으로 전환
            guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? BeforeAnalysisVC else { return }
            navigationController?.pushViewController(secondVC, animated: true)
            
            // Modal로 띄우고 싶으면 NavigationController를 연결하는 선행 과정 없이 present 메서드를 사용하면 됨.
        }
    }
    
    @objc func actionButtonTapped() {
        if actionItems.count >= 5 {
            // 5개의 셀이 이미 추가되어 있을 경우, 알림 표시
            let alertController = UIAlertController(title: "Limit Reached", message: "You already have 5 items.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            let actionItemController = ActionItemController() // 원하는 ActionItemController로 이동
            navigationController?.pushViewController(actionItemController, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}



// MARK: - extension

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    // 섹션 내 행의 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == actionTableView {
            return actionItems.count + 1 // "추가" 버튼을 위한 셀 포함
        } else if tableView == limitTableView {
            return limitItems.count + 1 // limitItems 배열 크기 반환
        }
        return 0
    }
    
    
    // 각 행에 대한 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == actionTableView {
            if indexPath.row == actionItems.count {
                // 마지막 셀에 "추가" 버튼 표시
                let cell = UITableViewCell(style: .default, reuseIdentifier: "AddCell")
                let addButton = UIButton(type: .system)
                cell.backgroundColor = .base50
                cell.contentView.backgroundColor = .base50
                addButton.setTitle("새로운 목표 만들기", for: .normal)
                addButton.setTitleColor(.primary700
                                        , for: .normal)
                addButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                addButton.addTarget(self, action: #selector(addNewItem), for: .touchUpInside)
                if let plusImage = UIImage(named: "plus_icon") {
                    addButton.setImage(plusImage, for: .normal)
                    addButton.tintColor = .primary700
                    
                }
                
                addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
                addButton.layer.cornerRadius = 16 // 반경 설정
                addButton.clipsToBounds = true
                addButton.contentHorizontalAlignment = .center
                addButton.backgroundColor = .white
                addButton.frame = cell.contentView.bounds
                addButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                cell.contentView.addSubview(addButton)
                addButton.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(75)
                }
                return cell
            } else {
                // 일반 셀
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCustomCell", for: indexPath) as? ActionTableViewCell else {
                    return UITableViewCell()
                }
                let categoryItem = actionItems[indexPath.row]
                cell.configure(with: categoryItem)
                
                return cell
            }
        };
        
        if tableView == limitTableView {
            if indexPath.row == limitItems.count {
                // 마지막 셀에 "추가" 버튼 표시
                let cell = UITableViewCell(style: .default, reuseIdentifier: "AddActionCell")
                let addButton = UIButton(type: .system)
                cell.backgroundColor = .base50
                cell.contentView.backgroundColor = .base50
                addButton.setTitle("그룹 생성하기", for: .normal)
                addButton.setTitleColor(.primary700
                                        , for: .normal)
                addButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
                addButton.addTarget(self, action: #selector(addNewAcion), for: .touchUpInside)
                if let plusImage = UIImage(named: "plus_icon") {
                    addButton.setImage(plusImage, for: .normal)
                    addButton.tintColor = .primary700
                }
                
                addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
                addButton.layer.cornerRadius = 16 // 반경 설정
                addButton.clipsToBounds = true
                addButton.contentHorizontalAlignment = .center
                addButton.backgroundColor = .white
                addButton.frame = cell.contentView.bounds
                addButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                cell.contentView.addSubview(addButton)
                addButton.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                    make.width.equalToSuperview()
                    make.height.equalTo(75)
                }
                return cell
            } else {
                // 일반 셀
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "LimitCustomCell", for: indexPath) as? ActionTableViewCell else {
                    return UITableViewCell()
                }
                let categoryItem = actionItems[indexPath.row]
                cell.configure(with: categoryItem)
                
                return cell
            }
        };
        return UITableViewCell()
    }
    
    // 행 선택 시 동작 설정 (필요 시)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == actionTableView {
            if indexPath.row < actionItems.count {
                
                print("Selected Action Item: \(actionItems[indexPath.row].content)")
            }
        } else if tableView == limitTableView {
            
            print("Selected Limit Item: \(indexPath.row + 1)")
        }
        tableView.deselectRow(at: indexPath, animated: true);
        
        if tableView == limitTableView {
                if indexPath.row == limitItems.count {
                    // 마지막 셀: 새로운 항목 추가
                    let newItem = "Limit Item \(limitItems.count + 1)"
                    limitItems.append(newItem)
                    tableView.reloadData() // 테이블뷰 갱신
                } else {
                    // 일반 셀 선택 동작
                    print("Selected: \(limitItems[indexPath.row])")
                }
                tableView.deselectRow(at: indexPath, animated: true)
            }
    }
    
    // 편집 스타일 설정 (삭제 가능하도록)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == actionTableView && editingStyle == .delete {
            // Realm에서 삭제
            let itemToDelete = actionItems[indexPath.row]
            do {
                try realm.write {
                    realm.delete(itemToDelete)
                }
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("삭제 실패: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == actionTableView  {
            return 87
        }
        return 100
    }
    
    // 목표 추가 셀의 편집 스타일 비허용
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == actionTableView && indexPath.row < actionItems.count {
            return true
        }
        return false
    }
    
    // 셀 편집 스타일 설정
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView == actionTableView && indexPath.row < actionItems.count {
            return .delete
        }
        return .none
    }
    
    // 셀 선택 스타일 비허용
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if tableView == actionTableView && indexPath.row < actionItems.count {
            return true
        }
        return false
    }
    
    // "내용 추가하기" 버튼 동작
    @objc func addNewItem() {
        let addItemVC = ActionItemController()
        addItemVC.hidesBottomBarWhenPushed = false
        navigationController?.pushViewController(addItemVC, animated: true)
    }
    
    @objc func addNewAcion() {
        let addNewActionVC = LimitItemController()
        addNewActionVC.hidesBottomBarWhenPushed = false
        navigationController?.pushViewController(addNewActionVC, animated: true)
    }
    
}
