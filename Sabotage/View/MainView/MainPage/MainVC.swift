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
    
    // MARK: - ".custom"으로 설정해야 이미지를 가진 버튼 만들기 가능
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
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil) // title 부분 수정
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
        actionTableView.backgroundColor = .white // 명확한 배경색 설정
        actionTableView.dataSource = self
        actionTableView.delegate = self
        view.addSubview(actionTableView)
        
        actionTableView.snp.makeConstraints {
            $0.top.equalTo(leftButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        // limitTableView 설정
        limitTableView = UITableView(frame: .zero, style: .plain)
        limitTableView.register(UITableViewCell.self, forCellReuseIdentifier: "LimitCustomCell")
        limitTableView.backgroundColor = .white // 명확한 배경색 설정
        limitTableView.dataSource = self
        limitTableView.delegate = self
        view.addSubview(limitTableView)
        
        limitTableView.snp.makeConstraints {
            $0.top.equalTo(leftButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
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
        logoImageView.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(logoImageView)
        
        logoText.contentMode = .scaleAspectFit // 로고 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(logoText)
        
        pieChartBG.contentMode = .scaleAspectFit // 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(pieChartBG)
        
        today.text = "오늘 사용량"
        today.textAlignment = .center
//        today.font = UIFon
        today.textColor = .base200
        today.numberOfLines = 0 // 필요에 따라 텍스트가 여러 줄로 표시되도록 설정
        pieChartBG.addSubview(today)
        
        forMoreAnalysis.contentMode = .scaleAspectFit // 이미지의 크기를 유지하면서 비율을 맞춤
        view.addSubview(forMoreAnalysis)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forMoreAnalysisTapped))
        forMoreAnalysis.isUserInteractionEnabled = true
        forMoreAnalysis.addGestureRecognizer(tapGesture)
        
        top3Apps()
    }
    
    func pieChartConstraintUI() {
        logoImageView.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(20.95) // 상단 여백
                $0.leading.equalToSuperview().offset(25.15) // 좌측 여백
                $0.width.equalTo(39.304) // 가로 크기
                $0.height.equalTo(39.6) // 세로 크기
            }
        }
        
        logoText.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(31) // 상단 여백
                $0.leading.equalTo(logoImageView.snp.trailing).offset(45) // 좌측 여백
                $0.width.equalTo(63) // 가로 크기
                $0.height.equalTo(20) // 세로 크기
            }
        }
        
        pieChartBG.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(logoImageView.snp.bottom).offset(16) // 상단 여백
                $0.leading.equalToSuperview().offset(10) // 좌측 여백
                $0.trailing.equalToSuperview().offset(-10) // 우측 여백
                $0.width.equalTo(400) // 가로 크기
                $0.height.equalTo(300) // 세로 크기
            }
        }
        
        today.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.top).offset(34) // 상단 여백
                $0.trailing.equalTo(pieChartBG.snp.leading).offset(140) // 우측 여백
                $0.width.equalTo(74) // 가로 크기
                $0.height.equalTo(22) // 세로 크기
            }
        }
        
        forMoreAnalysis.then {
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(290) // 상단 여백
                $0.centerX.equalToSuperview() // 중앙 정렬
                $0.width.equalTo(80) // 가로 크기
                $0.height.equalTo(30) // 세로 크기
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
    
    private func configureTableView(_ tableView: UITableView, cellClass: UITableViewCell.Type, identifier: String) {
        // 이 함수는 중복된 설정을 피하기 위해 제거합니다.
        // setupTableViews()에서 모든 설정을 완료했기 때문에 이 함수는 필요 없습니다.
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
            // 5개 이하일 경우, 새로운 아이템을 추가합니다.
            let actionItemController = ActionItemController() // 원하는 ActionItemController로 이동
            navigationController?.pushViewController(actionItemController, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    // 섹션 내 행의 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == actionTableView {
            return actionItems.count + 1 // 마지막 셀에 "추가" 버튼을 위한 셀 하나 추가
        } else if tableView == limitTableView {
            return 0 // limitTableView용 별도 데이터 배열이 있다면 반환
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
                addButton.setTitle("Add New Item", for: .normal)
                addButton.addTarget(self, action: #selector(addNewItem), for: .touchUpInside)
                addButton.frame = cell.contentView.bounds
                addButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                cell.contentView.addSubview(addButton)
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
        } else if tableView == limitTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LimitCustomCell", for: indexPath)
            cell.textLabel?.text = "Limit Item \(indexPath.row + 1)"
            return cell
        }

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
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    // 셀 높이 조절 (필요 시)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // 셀의 높이를 100으로 설정
    }
    
    // "Add New Item" 셀의 편집 스타일 비허용
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
    
    // "Add New Item" 버튼 동작
    @objc func addNewItem() {
        let alertController = UIAlertController(title: "새 항목 추가", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "카테고리 타입 입력"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "내용 입력"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "이미지 이름 입력"
        }
        
        let addAction = UIAlertAction(title: "추가", style: .default) { _ in
            guard
                let categoryType = alertController.textFields?[0].text, !categoryType.isEmpty,
                let content = alertController.textFields?[1].text, !content.isEmpty,
                let categoryImageName = alertController.textFields?[2].text, !categoryImageName.isEmpty
            else {
                self.presentAlert(title: "입력 오류", message: "모든 필드를 입력해야 합니다.")
                return
            }
            
            // Realm에 새로운 항목 추가
            let newItem = CategoryItem()
            newItem.categoryType = categoryType
            newItem.content = content
            newItem.categoryImageName = categoryImageName
            
            do {
                try self.realm.write {
                    self.realm.add(newItem)
                }
                self.loadData()
            } catch {
                self.presentAlert(title: "추가 실패", message: "새 항목을 추가하는데 실패했습니다.")
                print("Realm 추가 실패: \(error)")
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // 간단한 알림창 함수
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
