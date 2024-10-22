//
//  ProfileVC.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit


class ProfileVC: UIViewController {
    private let tableView = UITableView()
    private let header = UIView()
    
    // 토글 상태를 저장하는 변수
    var isToggleOn = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .base50
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setTableview() // Header를 추가하기 전에 테이블뷰 먼저 설정
        setHeader() // Header 추가
        
        setupToggleSwitch() // 알림 설정 토글의 상태 변화를 감지하여 처리하는 함수를 호출

    }
    
    func setHeader() {
        header.backgroundColor = .white
        
        // 이제 header를 테이블 뷰에 직접 추가합니다.
        tableView.tableHeaderView = header
        header.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 268)
        
        // header 오토레이아웃
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.widthAnchor.constraint(equalTo: view.widthAnchor),
            header.heightAnchor.constraint(equalToConstant: 268)
        ])
        
        // 프로필 사진 백그라운드
        let ProfileBGView = UIImageView(image: UIImage(named: "ProfileBackground"))
        ProfileBGView.translatesAutoresizingMaskIntoConstraints = false
        ProfileBGView.contentMode = .scaleAspectFill
        // 프로필 사진 백그라운드 추가
        header.addSubview(ProfileBGView)

        // 프로필 사진 백그라운드 오토레이아웃
        NSLayoutConstraint.activate([
            ProfileBGView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            ProfileBGView.centerYAnchor.constraint(equalTo: header.centerYAnchor), // 헤더의 가운데에 위치하도록 설정
            ProfileBGView.widthAnchor.constraint(equalToConstant: 100),
            ProfileBGView.heightAnchor.constraint(equalToConstant: 100)
        ])

        // 프로필 사진
        let ProfileView = UIImageView(image: UIImage(named: "Profile"))
        ProfileView.translatesAutoresizingMaskIntoConstraints = false
        ProfileView.contentMode = .scaleAspectFill
        
        // 프로필 사진 추가
        header.addSubview(ProfileView)
        
        // 프로필 사진 오토레이아웃
        NSLayoutConstraint.activate([
            ProfileView.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            ProfileView.centerYAnchor.constraint(equalTo: header.centerYAnchor), // 헤더의 가운데에 위치하도록 설정
            ProfileView.widthAnchor.constraint(equalToConstant: 74),
            ProfileView.heightAnchor.constraint(equalToConstant: 74)
        ])
        
        let headerlabel = UILabel()
//        headerlabel.text = "즐거운스누피1441"
        headerlabel.text = "test"
        headerlabel.textColor = .black
        headerlabel.textAlignment = .center
        headerlabel.font = UIFont.Headline()
        header.addSubview(headerlabel)
        
        // headerLabel 오토레이아웃
        headerlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        headerlabel.centerXAnchor.constraint(equalTo: header.centerXAnchor),
        headerlabel.centerYAnchor.constraint(equalTo: header.topAnchor, constant: 222) // 풀스크린 기준으로 위치 조정
        ])
    }
    
         
    func setTableview() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none // 구분하는 선 없애기
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupToggleSwitch() {
        // 테이블 뷰에서 토글 스위치 셀을 찾습니다.
        guard let toggleCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) else {
            return
        }

        // 셀의 액세서리 뷰가 UISwitch인지 확인합니다.
        if let toggleSwitch = toggleCell.accessoryView as? UISwitch {
            toggleSwitch.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        }
    }
}


extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        
        titleLabel.font = UIFont.Subhead()
        titleLabel.textColor = .base400
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30) // 타이틀의 높이를 50포인트로 설정
        ])

        // 두 번째 섹션의 타이틀을 변경
        if section == 1 {
            titleLabel.text = "이용 안내"
        } else {
            titleLabel.text = "내 정보"
        }
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // 각 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // 섹션의 footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil // nil을 반환하여 footer 제거
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude // 가장 작은 높이로 설정하여 footer를 숨김
    }

    // 섹션의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return Model.medeling.count
    }
    
    // 각 섹션의 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.medeling[section].count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            print("fail to dequeue cell")
            return UITableViewCell()
        }
        let data = Model.medeling[indexPath.section][indexPath.row]
        cell.textLabel?.text = data.title
        cell.textLabel?.font = UIFont.Headline()
        cell.textLabel?.frame.origin.x = 24 // 타이틀을 왼쪽으로 24만큼 이동
        cell.layer.cornerRadius = 10

        let arrowIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowIcon.tintColor = .gray
        cell.accessoryView = arrowIcon

        // ">"를 오른쪽에서 24만큼 떨어지게 위치 조정
        if let accessoryView = cell.accessoryView {
            accessoryView.frame.origin.x = cell.contentView.frame.width - accessoryView.frame.width - 24
        }

        // 알림 설정 섹션의 첫 번째 행에 토글 아이콘 적용
        if tableView == self.tableView && indexPath.section == 0 && indexPath.row == 0 {
            let toggleSwitch = UISwitch() // 토글 아이콘 생성
            toggleSwitch.isOn = true // 토글을 기본으로 켜진 상태로 설정
            
            // 토글의 크기를 작게 조절
            toggleSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            
            cell.accessoryView = toggleSwitch // 토글 아이콘으로 변경

            if let accessoryView = cell.accessoryView {
                accessoryView.frame.origin.x = cell.contentView.frame.width - accessoryView.frame.width - 24
            }
            
            // 토글의 valueChanged 이벤트에 대한 처리를 설정
            toggleSwitch.addTarget(self, action: #selector(toggleChanged(_:)), for: .valueChanged)
        }
        
        return cell
    }
    
    @objc func toggleChanged(_ sender: UISwitch) {
        // 스위치가 꺼진 경우(alert를 표시해야 하는 경우)
        if !sender.isOn {
                showAlert()
            } else {
                // 토글의 상태 업데이트
                isToggleOn = sender.isOn
            }
    }

    func showAlert() {
        let alert = UIAlertController(title: "알림을 해제하시겠어요?", message: "알림을 해제하면 제한 서비스에 대한\n알림을 받을 수 없어요", preferredStyle: .alert)

        // '취소' 버튼
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in
            // '취소' 버튼을 눌렀을 때 토글을 다시 켭니다.
            if let toggleSwitch = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.accessoryView as? UISwitch {
                toggleSwitch.isOn = true
                // 토글 상태를 업데이트
                self.isToggleOn = true
            }
        }))
        
        // '해제' 버튼
        alert.addAction(UIAlertAction(title: "해제", style: .destructive, handler: nil))

        // 현재 뷰 컨트롤러가 표시되어 있는지 확인한 후, 알림창을 띄웁니다.
        if let presentedVC = UIApplication.shared.keyWindow?.rootViewController {
            presentedVC.present(alert, animated: true, completion: nil)
        }
    }


//    // 토글 상태가 변경될 때 실행될 함수
//        @objc func toggleChanged(_ sender: UISwitch) {
//            if !sender.isOn {
//                // 토글이 off로 변경되었을 때 알림창을 띄웁니다.
//                showAlert()
//            }
//        }
//    
//    // 알림창을 띄우는 함수
//    func showAlert() {
//        let alert = UIAlertController(title: "알림", message: "토글이 꺼졌습니다!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // "개인정보 처리방침" 셀을 눌렀을 때만 처리
        if indexPath.section == 1 && indexPath.row == 0 {
            if let url = URL(string: "https://www.kisa.or.kr") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        // "서비스 이용약관" 셀을 눌렀을 때만 처리
        if indexPath.section == 1 && indexPath.row == 1 {
            if let url = URL(string: "https://www.kisa.or.kr") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        // "고객센터" 셀을 눌렀을 때만 처리
        if indexPath.section == 1 && indexPath.row == 2 {
            if let url = URL(string: "https://www.notion.so/young-design-archive/92730e674636406b98dbd9d474b12df9") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
