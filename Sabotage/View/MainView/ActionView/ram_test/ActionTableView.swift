//
//  ActionTableView.swift
//  Sabotage
//
//  Created by 김하람 on 10/22/24.
//

import UIKit
import RealmSwift
import SnapKit

//class ActionTableView_RAM: UIViewController {
//    
//    let tableView = UITableView()
//    var actionDataList: Results<ActionData>!
//    let realm = try! Realm()
//    var notificationToken: NotificationToken?
//    
//    override func viewDidLoad() {
//        printRealmFilePath()
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        // UI 설정
//        setupTableView()
//        setupNavigationBar()
//        
//        // Realm 데이터 가져오기
//        fetchDataFromRealm()
//        
//        // Realm 데이터 변경 감지
//        observeRealmChanges()
//    }
//    
//    deinit {
//        notificationToken?.invalidate()
//    }
//    
//    func setupTableView() {
//        view.addSubview(tableView)
//        
//        // SnapKit을 사용한 테이블 뷰 오토레이아웃 설정
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
//        }
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//    
//    func printRealmFilePath() {
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//    }
//    
//    func setupNavigationBar() {
//        self.title = "Action Data"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addActionData))
//    }
//    
//    func fetchDataFromRealm() {
//        actionDataList = realm.objects(ActionData.self).sorted(byKeyPath: "id", ascending: true)
//    }
//    
//    func observeRealmChanges() {
//        notificationToken = actionDataList.observe { [weak self] (changes) in
//            guard let tableView = self?.tableView else { return }
//            switch changes {
//            case .initial:
//                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                tableView.beginUpdates()
//                tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
//                tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
//                tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
//                tableView.endUpdates()
//            case .error(let error):
//                print("Realm 오류 발생: \(error)")
//            }
//        }
//    }
//
//    // ActionData 추가하기
//    @objc func addActionData() {
//        let alert = UIAlertController(title: "새 데이터 추가", message: nil, preferredStyle: .alert)
//        alert.addTextField { (textField) in
//            textField.placeholder = "Category"
//        }
//        alert.addTextField { (textField) in
//            textField.placeholder = "Content"
//        }
//        
//        let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
//            guard let self = self,
//                  let category = alert.textFields?[0].text, !category.isEmpty,
//                  let content = alert.textFields?[1].text, !content.isEmpty else {
//                return
//            }
//            
//            // 새 데이터 추가
//            let newActionData = ActionData()
//            newActionData.id = (self.actionDataList.max(ofProperty: "id") as Int? ?? 0) + 1 // 고유한 ID 할당
//            newActionData.category = category
//            newActionData.content = content
//            
//            // Realm에 데이터 저장
//            try! self.realm.write {
//                self.realm.add(newActionData)
//            }
//            
//            // 테이블뷰는 Realm의 변경 감지 덕분에 자동으로 업데이트됩니다.
//        }
//        
//        alert.addAction(addAction)
//        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
//    
//    // ActionData 삭제하기
//    func deleteActionData(at indexPath: IndexPath) {
//        let actionDataToDelete = actionDataList[indexPath.row]
//        
//        try! realm.write {
//            realm.delete(actionDataToDelete)
//        }
//    }
//}
//
//extension ActionTableView_RAM: UITableViewDelegate, UITableViewDataSource {
//    
//    // 섹션당 행의 개수
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return actionDataList?.count ?? 0
//    }
//    
//    // 각 셀에 데이터 설정
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let actionData = actionDataList[indexPath.row]
//        cell.textLabel?.text = "\(actionData.category): \(actionData.content)"
//        return cell
//    }
//    
//    // 스와이프하여 삭제 기능 구현
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            deleteActionData(at: indexPath)
//        }
//    }
//}
//
