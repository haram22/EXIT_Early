//
//  MainTabBarView.swift
//  Sabotage
//
//  Created by 김하람 on 10/22/24.
//

import Foundation
import UIKit

extension MainVC {
    func toggleUI() {
        view.addSubview(actionTogglebuttonTapped)
        actionTogglebuttonTapped.contentMode = .scaleAspectFit
        actionTogglebuttonTapped.isHidden = false
        
        view.addSubview(limitTogglebuttonTapped)
        limitTogglebuttonTapped.contentMode = .scaleAspectFit
        limitTogglebuttonTapped.isHidden = true
        
        view.addSubview(leftButton)
        leftButton.setTitle("", for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        
        view.addSubview(rightButton)
        rightButton.setTitle("", for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    func toggleConstraintUI() {
        actionTogglebuttonTapped.then {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(view.frame.width)
                $0.height.equalTo(60)
            }
        }
        
        limitTogglebuttonTapped.then {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(view.frame.width)
                $0.height.equalTo(60)
            }
        }
        
        leftButton.then {
            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(pieChartBG.snp.bottom).offset(-10)
                $0.leading.equalTo(actionTogglebuttonTapped.snp.leading)
                $0.width.equalTo(200)
                $0.height.equalTo(60)
            }
        }
        
        rightButton.then {
            view.addSubview($0)
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
            // actionTogglebuttonTapped이 숨겨져 있는 경우에만 작동하도록 설정
            toggleCondition()
        }
    }
    
    // actionTogglebuttonTapped 버튼을 눌렀을 때 실행되는 메서드
    @objc func rightButtonTapped() {
        if limitTogglebuttonTapped.isHidden {
            // limitTogglebuttonTapped이 숨겨져 있는 경우에만 작동하도록 설정
            toggleCondition()
        }
    }
    
    func toggleCondition() {
        if actionTogglebuttonTapped.isHidden {
            // actionTogglebuttonTapped is hidden: show actionButton and hide limitButton
            actionTogglebuttonTapped.isHidden = false
            limitTogglebuttonTapped.isHidden = true
            actionButton.isHidden = false
            limitButton.isHidden = true
            //                actionTableView.isHidden = false
            //                limitTableView.isHidden = true
        } else {
            // actionTogglebuttonTapped is visible: hide actionButton and show limitButton
            actionTogglebuttonTapped.isHidden = true
            limitTogglebuttonTapped.isHidden = false
            actionButton.isHidden = true
            limitButton.isHidden = false
            //                actionTableView.isHidden = true
            //                limitTableView.isHidden = false
        }
    }
    
}
