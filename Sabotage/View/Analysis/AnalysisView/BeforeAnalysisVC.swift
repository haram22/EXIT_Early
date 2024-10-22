//
//  BeforeAnalysisVC.swift
//  Sabotage
//
//  Created by 박서윤 on 2024/01/03.
//

import UIKit
import SwiftUI

class BeforeAnalysisVC: UIViewController {
    
    let backButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("X", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(showPage(_:)), name: NSNotification.Name("하람테스트"), object: nil)
        // "X" 버튼 추가
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // 타이틀 레이블 생성
        let icon = UILabel()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.text = "🧘"
        icon.textColor = .black
        icon.textAlignment = .center
        icon.font = UIFont.systemFont(ofSize: 100, weight: .semibold)
        view.addSubview(icon)
        
        // 타이틀 레이블 생성
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "'스쿼트 10회'를 시작해봐요"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        view.addSubview(titleLabel)
        
        // 설명 레이블 생성
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "작은 시도를 통해서 목표를 쉽게 하는 것이\n습관을 개선하는 데 도움을 준대요"
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        descriptionLabel.numberOfLines = 2
        view.addSubview(descriptionLabel)
        
        // 버튼 생성
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("스크린타임 분석 보러가기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 16 // 버튼을 둥글게 만들기 위한 코드
        button.layer.borderWidth = 1 // 버튼 테두리 두께 설정
        button.layer.borderColor = UIColor.green.cgColor // 버튼 테두리 색상 설정
        button.contentHorizontalAlignment = .left // 왼쪽 정렬
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0) // 타이틀의 왼쪽 여백 조절

        button.backgroundColor = .green
        view.addSubview(button)
        
        // 검은색 화살표 버튼 생성
        let arrowButton = UIButton(type: .system)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        arrowButton.tintColor = .black
        arrowButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        arrowButton.semanticContentAttribute = .forceRightToLeft
        arrowButton.contentHorizontalAlignment = .right // 화살표 버튼을 오른쪽 정렬
        view.addSubview(arrowButton)
                
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            // 이미지 뷰 제약조건
            icon.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20),
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // 타이틀 레이블 제약조건
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // 설명 레이블 제약조건
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // 버튼 제약조건
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button.heightAnchor.constraint(equalToConstant: 54),
            
            // 화살표 버튼 제약조건
            arrowButton.topAnchor.constraint(equalTo: button.topAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -30), // 오른쪽 정렬
            arrowButton.widthAnchor.constraint(equalToConstant: 40), // 적절한 크기 조정
            arrowButton.heightAnchor.constraint(equalTo: button.heightAnchor)
        ])
    }
    
    @objc func backButtonTapped() {
            let mainVC = MainVC()
            navigationController?.pushViewController(mainVC, animated: true)
        }

    @objc func buttonTapped() {
        let analysisVC = AnalysisVC() // 생성자 호출
        navigationController?.pushViewController(analysisVC, animated: true)
    }

    @objc func showPage(_ notification: Notification) {
        if let userInfo = notification.userInfo, let index = userInfo["index"] as? Int {
            // 이곳에서 필요한 화면으로 이동하는 로직을 구현하세요.
            // 예를 들어, UINavigationController에 래핑된 ViewController로 이동하려면:
            let secondVC = BeforeAnalysisVC()
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}

struct BeforeAnalysisVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BeforeAnalysisVC {
        return BeforeAnalysisVC()
    }

    func updateUIViewController(_ uiViewController: BeforeAnalysisVC, context: Context) {
        // 필요한 경우 업데이트 로직
    }
}
