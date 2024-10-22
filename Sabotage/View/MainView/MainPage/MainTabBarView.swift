////
////  MainTabBarView.swift
////  Sabotage
////
////  Created by 김하람 on 10/22/24.
////
//
//import Foundation
//import UIKit
//
//import Foundation
//import UIKit
//
//extension MainVC {
//    func toggleUI() {
//        // actionTogglebuttonTapped 설정
//        view.addSubview(actionTogglebuttonTapped)
//        actionTogglebuttonTapped.contentMode = .scaleAspectFit
//        actionTogglebuttonTapped.isHidden = false
//        
//        // limitTogglebuttonTapped 설정
//        view.addSubview(limitTogglebuttonTapped)
//        limitTogglebuttonTapped.contentMode = .scaleAspectFit
//        limitTogglebuttonTapped.isHidden = true
//        
//        // leftButton 설정
//        view.addSubview(leftButton)
//        leftButton.setTitle("", for: .normal)
//        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
//        
//        // rightButton 설정
//        view.addSubview(rightButton)
//        rightButton.setTitle("", for: .normal)
//        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
//    }
//    
//    func toggleConstraintUI() {
//        // actionTogglebuttonTapped 제약 조건
//        actionTogglebuttonTapped.then {
//            view.addSubview($0)
//            $0.snp.makeConstraints {
//                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
//                $0.centerX.equalToSuperview()
//                $0.width.equalTo(view.frame.width)
//                $0.height.equalTo(60)
//            }
//        }
//        
//        // limitTogglebuttonTapped 제약 조건
//        limitTogglebuttonTapped.then {
//            view.addSubview($0)
//            $0.snp.makeConstraints {
//                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
//                $0.centerX.equalToSuperview()
//                $0.width.equalTo(view.frame.width)
//                $0.height.equalTo(60)
//            }
//        }
//        
//        // leftButton 제약 조건
//        leftButton.then {
//            view.addSubview($0)
//            $0.snp.makeConstraints {
//                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
//                $0.leading.equalTo(actionTogglebuttonTapped.snp.leading)
//                $0.width.equalTo(200)
//                $0.height.equalTo(60)
//            }
//        }
//        
//        // rightButton 제약 조건
//        rightButton.then {
//            view.addSubview($0)
//            $0.snp.makeConstraints {
//                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
//                $0.trailing.equalTo(actionTogglebuttonTapped.snp.trailing)
//                $0.width.equalTo(200)
//                $0.height.equalTo(60)
//            }
//        }
//        
//        // actionTableView 설정 및 제약 조건
//        actionTableView = UITableView(frame: .zero, style: .plain)
//        actionTableView.register(ActionTableViewCell.self, forCellReuseIdentifier: "ActionCustomCell")
//        actionTableView.backgroundColor = .base200
//        view.addSubview(actionTableView)
//        
//        actionTableView.snp.makeConstraints {
//            $0.top.equalTo(leftButton.snp.bottom).offset(10)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalTo(view.snp.bottomMargin)
//        }
//        
//        // actionTableView 설정 및 제약 조건
//        limitTableView = UITableView(frame: .zero, style: .plain)
//        limitTableView.register(ActionTableViewCell.self, forCellReuseIdentifier: "ActionCustomCell")
//        limitTableView.backgroundColor = .base200
//        view.addSubview(limitTableView)
//        
//        actionTableView.snp.makeConstraints {
//            $0.top.equalTo(leftButton.snp.bottom).offset(10)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalTo(view.snp.bottomMargin)
//        }
//    }
//    
//    @objc func leftButtonTapped() {
//        if actionTogglebuttonTapped.isHidden {
//            // actionTogglebuttonTapped이 숨겨져 있는 경우에만 toggleCondition 실행
//            toggleCondition()
//        }
//    }
//    
//    // rightButtonTapped 메서드
//    @objc func rightButtonTapped() {
//        if limitTogglebuttonTapped.isHidden {
//            // limitTogglebuttonTapped이 숨겨져 있는 경우에만 toggleCondition 실행
//            toggleCondition()
//        }
//    }
//    
//    // toggleCondition 메서드
//    func toggleCondition() {
//        let isActionHidden = actionTogglebuttonTapped.isHidden
//        
//        // Toggle 상태 변경
//        actionTogglebuttonTapped.isHidden = !isActionHidden
//        limitTogglebuttonTapped.isHidden = isActionHidden
//        actionButton.isHidden = !isActionHidden
//        limitButton.isHidden = isActionHidden
//        actionTableView.isHidden = !isActionHidden
//        // limitTableView.isHidden = isActionHidden // limitTableView 구현 예정 시 추가
//    }
//}
//
//extension MainVC: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return actionItems.count + 1 // 마지막 셀에 "추가" 버튼을 위한 셀 하나 추가
//        }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            if indexPath.row == actionItems.count {
//                // 마지막 셀에 "추가" 버튼 표시
//                let cell = UITableViewCell(style: .default, reuseIdentifier: "AddCell")
//                let addButton = UIButton(type: .system)
//                addButton.setTitle("Add New Item", for: .normal)
//                addButton.addTarget(self, action: #selector(addNewItem), for: .touchUpInside)
//                addButton.frame = cell.contentView.bounds
//                cell.contentView.addSubview(addButton)
//                return cell
//            } else {
//                // 일반 셀
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCustomCell", for: indexPath) as! ActionTableViewCell
//                let categoryItem = actionItems[indexPath.row]
//                cell.configure(with: categoryItem)
//                return cell
//            }
//        }
//    @objc func addNewItem() {
//            // 새로운 항목 추가를 위한 Alert 생성
//            let alertController = UIAlertController(title: "새 항목 추가", message: nil, preferredStyle: .alert)
//
//            alertController.addTextField { textField in
//                textField.placeholder = "카테고리 타입 입력"
//            }
//            
//            alertController.addTextField { textField in
//                textField.placeholder = "내용 입력"
//            }
//            
//            alertController.addTextField { textField in
//                textField.placeholder = "이미지 이름 입력"
//            }
//
//            let addAction = UIAlertAction(title: "추가", style: .default) { _ in
//                guard
//                    let categoryType = alertController.textFields?[0].text, !categoryType.isEmpty,
//                    let content = alertController.textFields?[1].text, !content.isEmpty,
//                    let categoryImageName = alertController.textFields?[2].text, !categoryImageName.isEmpty
//                else {
//                    print("모든 필드를 입력해야 합니다.")
//                    return
//                }
//
//                // Realm에 새로운 항목 추가
//                let newItem = CategoryItem()
//                newItem.categoryType = categoryType
//                newItem.content = content
//                newItem.categoryImageName = categoryImageName
//
//                try! self.realm.write {
//                    self.realm.add(newItem)
//                }
//
//                // 테이블 뷰 다시 로드
//                self.loadData()
//            }
//
//            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//
//            alertController.addAction(addAction)
//            alertController.addAction(cancelAction)
//
//            present(alertController, animated: true, completion: nil)
//        }
//}
