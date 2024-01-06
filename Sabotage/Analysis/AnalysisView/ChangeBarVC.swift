//
//  ChangeBarVC.swift
//  Sabotage
//
//  Created by 박서윤 on 2024/01/03.
//

import UIKit
import DGCharts

class ChangeBarVC: UIViewController {
    
    var barGraphView: BarChartView!
    var dataPoints: [String] = ["어제", "오늘"]
    var dataEntries : [BarChartDataEntry] = []
    var dataArray:[Int] = [5,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        barGraphView = BarChartView()
        barGraphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barGraphView)
        
        NSLayoutConstraint.activate([
            barGraphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            barGraphView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            barGraphView.widthAnchor.constraint(equalToConstant: 121),
            barGraphView.heightAnchor.constraint(equalToConstant: 172)
        ])
        
        // 확대하지 못하게 고정
        barGraphView.scaleXEnabled = false
        barGraphView.scaleYEnabled = false
        
        for i in 0..<dataPoints.count {
            var xValue = Double(i) * 1.7 // 간격을 늘리기 위해 x 값에 2를 곱합니다
            if i > 0 {
                xValue -= 0.5 // 각 막대 그래프가 중앙에 위치하도록 x 값을 조정합니다
            }
            let dataEntry = BarChartDataEntry(x: xValue, y: Double(dataArray[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "그래프 값 명칭")
        chartDataSet.colors = [.base300, .primary500] // 각 데이터 엔트리에 대한 색상 배열
        chartDataSet.valueTextColor = .black // 데이터 레이블(데이터 값) 텍스트 색상 지정
        chartDataSet.valueFont = UIFont.systemFont(ofSize: 12) // 데이터 레이블(데이터 값) 폰트 크기 지정

        let chartData = BarChartData(dataSet: chartDataSet)

        // 그래프 데이터 포인트 값 설정
        chartData.setValueFormatter(CustomValueFormatter())
        
        barGraphView.data = chartData
        
        // X, Y 축 설정 등 그래프 추가 설정
        // X 축 설정
        let xAxis = barGraphView.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        xAxis.labelPosition = .bottom // X 축 레이블을 아래에 표시
        xAxis.labelTextColor = .white // X 축 레이블의 글씨색을 흰색으로 설정
        xAxis.drawAxisLineEnabled = false // X 축 라인 숨기기
        xAxis.drawLabelsEnabled = false // X 축 레이블 숨기기

        // Y 축 숨기기
        barGraphView.rightAxis.enabled = false
        barGraphView.leftAxis.enabled = false
            
        // X 축 그리드 라인 숨기기
        barGraphView.xAxis.drawGridLinesEnabled = false
            
        barGraphView.layer.borderWidth = 0 // 테두리의 너비를 0으로 설정하여 투명하게 만듭니다.

        // 그래프 테두리를 투명하게 설정
        barGraphView.layer.borderWidth = 0 // 테두리의 너비를 0으로 설정하여 투명하게 만듭니다.

        // X 축 시작점 투명하게 만들기
        xAxis.axisLineColor = .clear // X 축의 선 색상을 투명으로 설정합니다.
        xAxis.axisMinimum = -0.5 // X 축 시작점을 조정하여 그래프를 가운데에 위치시킵니다.

        // Y 축 단위 설정
        xAxis.valueFormatter = Hours()
            
        // 범례(네모칸) 제거
        barGraphView.legend.enabled = false
    }
    
    // Hours 클래스에서 stringForValue 함수 내부를 아래와 같이 수정하여 'h'의 글씨색을 흰색으로 변경합니다.
    class Hours: AxisValueFormatter {
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            let formattedValue = "\(Int(value))"
            let attributedString = NSMutableAttributedString(string: "\(formattedValue)h")
            
            // 'h'의 글씨색을 흰색으로 변경
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: formattedValue.count, length: 1))
            
            return formattedValue
        }
    }
    
    class CustomValueFormatter: ValueFormatter {
        func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            return "\(Int(value))"
        }
    }

}

