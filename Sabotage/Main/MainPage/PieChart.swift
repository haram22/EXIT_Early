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
            let singleItem = RKPieChartItem(ratio: 23, color: UIColor.primary500, title: "")
            
            chartView = RKPieChartView(items: [singleItem], centerTitle: "")
            chartView.circleColor = .base400
            chartView.arcWidth = 10
            chartView.isIntensityActivated = false
            chartView.style = .butt
            chartView.isTitleViewHidden = true
            chartView.isAnimationActivated = true

            // 배경 이미지 설정을 위한 UIView 추가
            let backgroundView = UIImageView(image: UIImage(named: "chartBackground"))
            backgroundView.contentMode = .scaleAspectFill // 이미지가 화면에 꽉 차도록 설정
            chartView.insertSubview(backgroundView, at: 0) // chartView에 배경 이미지 추가
            
            // 배경 이미지가 chartView와 같은 크기가 되도록 제약 추가
            backgroundView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }

            self.view.addSubview(chartView)
            
            // Create a label and add it to the chartView
            let label = UILabel()
            label.text = "23%"
            label.textAlignment = .center
            label.textColor = .white
            chartView.addSubview(label)
            
            // Adding constraints to center the label within the chartView
            label.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                // Add constraints for label size as needed
            }
            
            // chartView에 대한 다른 제약 설정...
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
