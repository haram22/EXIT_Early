//
//  PieChart.swift
//  Sabotage
//
//  Created by 오성진 on 12/29/23.
//

import UIKit
import SnapKit
import Then
import RKPieChart

class PieChart: UIViewController {
    
    let titleLabel = UILabel()
    var chartView: RKPieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalTimeUI()
        setConstraints()
        
    }
    
    // MARK: - 다른 부분을 탭하면 "총 사용 시간"으로 넘어가는 로직은 나중에 디자인 다 나와서 파이차트 백그라운드 이미지 받으면 (파이차트, 버튼 3개 제외) 그 이미지 클릭하면 넘어가게끔 나중에 구현.
    
    func totalTimeUI() {
        let singleItem = RKPieChartItem(ratio: 50, color: UIColor.primary500, title: "")
        
        chartView = RKPieChartView(items: [singleItem], centerTitle: "Title")
        chartView.circleColor = .base400
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.arcWidth = 10
        chartView.isIntensityActivated = false
        chartView.style = .butt
        chartView.isTitleViewHidden = true
        chartView.isAnimationActivated = true
        
//        chartView.centerTitle.UICol = .red // 텍스트 색상 변경
//        chartView.centerTitleFont = UIFont.boldSystemFont(ofSize: 18) // 폰트 변경

        self.view.addSubview(chartView)
    }
    
//    func firstAppUI() {
//        
//        chartView.removeFromSuperview() // 기존의 파이 차트 지우기
//        
//        let singleItem = RKPieChartItem(ratio: 80, color: UIColor.green, title: "1th Item")
//        
//        chartView = RKPieChartView(items: [singleItem], centerTitle: "First App")
//        chartView.circleColor = .systemGreen
//        chartView.translatesAutoresizingMaskIntoConstraints = false
//        chartView.arcWidth = 40
//        chartView.isIntensityActivated = false
//        chartView.style = .round
//        chartView.isTitleViewHidden = false
//        chartView.isAnimationActivated = true
//        
//        self.view.addSubview(chartView) // 새로운 파이 차트 올리기
//        
//        // 새로운 chartView의 제약 조건을 설정
//        chartView.snp.makeConstraints { make in
//            make.width.height.equalTo(250)
//            make.centerX.centerY.equalToSuperview()
//            make.top.equalToSuperview().offset(100)
//        }
//    }
//    
//    func secondAppUI() {
//        chartView.removeFromSuperview()
//        
//        let singleItem = RKPieChartItem(ratio: 30, color: UIColor.orange, title: "2th Item")
//        
//        // 새로운 chartView를 생성하고 설정합니다.
//        chartView = RKPieChartView(items: [singleItem], centerTitle: "Second App")
//        chartView.circleColor = .systemOrange
//        chartView.translatesAutoresizingMaskIntoConstraints = false
//        chartView.arcWidth = 40
//        chartView.isIntensityActivated = false
//        chartView.style = .round
//        chartView.isTitleViewHidden = false
//        chartView.isAnimationActivated = true
//        
//        self.view.addSubview(chartView)
//        
//        // 새로운 chartView의 제약 조건을 설정
//        chartView.snp.makeConstraints { make in
//            make.width.height.equalTo(250)
//            make.centerX.centerY.equalToSuperview()
//            make.top.equalToSuperview().offset(100)
//        }
//    }
//
//    
//    func thirdAppUI() {
//        
//        chartView.removeFromSuperview()
//        
//        let singleItem = RKPieChartItem(ratio: 70, color: UIColor.brown, title: "3th Item")
//        
//        chartView = RKPieChartView(items: [singleItem], centerTitle: "Third App")
//        chartView.circleColor = .systemBrown
//        chartView.translatesAutoresizingMaskIntoConstraints = false
//        chartView.arcWidth = 40
//        chartView.isIntensityActivated = false
//        chartView.style = .round
//        chartView.isTitleViewHidden = false
//        chartView.isAnimationActivated = true
//        self.view.addSubview(chartView)
//        
//        // 새로운 chartView의 제약 조건을 설정
//        chartView.snp.makeConstraints { make in
//            make.width.height.equalTo(250)
//            make.centerX.centerY.equalToSuperview()
//            make.top.equalToSuperview().offset(100)
//        }
//    }

    func setConstraints() {
        chartView.snp.makeConstraints { make in
            make.width.height.equalTo(115)
//            make.centerX.centerY.equalToSuperview()
//            make.top.equalToSuperview().offset(100)
        }
    }
    
}
