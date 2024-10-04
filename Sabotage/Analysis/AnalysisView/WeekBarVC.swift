////
////  WeekBarVC.swift
////  Sabotage
////
////  Created by 박서윤 on 2024/01/03.
////
//
//import UIKit
////import DGCharts
//
//class WeekBarVC: UIViewController {
//    
//    var barGraphView: BarChartView!
//    var dataPoints: [String] = ["일","월","화","수","목","금","토"]
//    var dataEntries : [BarChartDataEntry] = []
//    var dataArray:[Int] = [10,5,6,13,15,7,2]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.view.backgroundColor = .clear
//        
//        barGraphView = BarChartView()
//        barGraphView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(barGraphView)
//        
//        NSLayoutConstraint.activate([
//            barGraphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            barGraphView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            barGraphView.widthAnchor.constraint(equalToConstant: 307),
//            barGraphView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//        
//
//        // 데이터가 토요일에 해당하는 위치를 식별하여 해당 막대 그래프만 초록색으로 설정
//            dataArray[6] = 9 // '토' 요일에 해당하는 데이터를 20으로 변경
//        
//        for i in 0..<dataPoints.count {
//                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataArray[i]))
//                dataEntries.append(dataEntry)
//            }
//            
//            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "그래프 값 명칭")
//            
//            // '토' 요일에 해당하는 막대 그래프만 초록색으로 설정
//            let colors = dataPoints.enumerated().map { (index, day) in
//                index == 6 ? UIColor.primary500 : UIColor.base300
//            }
//            chartDataSet.colors = colors
//
//        
//        
//        let chartData = BarChartData(dataSet: chartDataSet)
//        chartData.barWidth = 0.3
//        
//        barGraphView.data = chartData
//        
//        // X, Y 축 설정 등 그래프 추가 설정
//        // X 축 설정
//        let xAxis = barGraphView.xAxis
//        xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
//        xAxis.labelPosition = .bottom // X 축 레이블을 아래에 표시
//        xAxis.labelTextColor = .white // X 축 레이블의 글씨색을 흰색으로 설정
//        
//        // Y 축 레이블 표시
//        let yAxisRight = barGraphView.rightAxis
//        yAxisRight.axisMinimum = -2 // 음수 값으로 설정하여 그래프가 0 아래에서 시작하도록 조정
//        yAxisRight.axisMaximum = 24
//        yAxisRight.granularity = 4
//        yAxisRight.drawLabelsEnabled = true // Y 축 레이블 표시 활성화
//        yAxisRight.labelTextColor = .white // Y 축 레이블의 글씨색을 흰색으로 설정
//        
//        // 그래프 확대/축소 비활성화
//        barGraphView.scaleXEnabled = false
//        barGraphView.scaleYEnabled = false
//        
//        // 왼쪽 Y 축 숨기기
//        barGraphView.leftAxis.enabled = false
//        
//        // X 축 그리드 라인 숨기기
//        barGraphView.xAxis.drawGridLinesEnabled = false
//        
//        barGraphView.layer.borderWidth = 0 // 테두리의 너비를 0으로 설정하여 투명하게 만듭니다.
//
//        // 그래프 테두리를 투명하게 설정
//        barGraphView.layer.borderWidth = 0 // 테두리의 너비를 0으로 설정하여 투명하게 만듭니다.
//
//        // X 축 시작점 투명하게 만들기
//        xAxis.axisLineColor = .clear // X 축의 선 색상을 투명으로 설정합니다.
//        xAxis.axisMinimum = -0.5 // X 축 시작점을 조정하여 그래프를 가운데에 위치시킵니다.
//
//        // Y 축 시작점 투명하게 만들기
//        yAxisRight.axisLineColor = .clear // Y 축의 선 색상을 투명으로 설정합니다.
//        yAxisRight.axisMinimum = 0 // Y 축 시작점을 조정하여 그래프를 가운데에 위치시킵니다.
//        
//        // Y 축 단위 설정
//        yAxisRight.valueFormatter = Hours()
//        
//        // 범례(네모칸) 제거
//        barGraphView.legend.enabled = false
//    }
//    
//    // Hours 클래스에서 stringForValue 함수 내부를 아래와 같이 수정하여 'h'의 글씨색을 흰색으로 변경합니다.
//    class Hours: AxisValueFormatter {
//        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//            let formattedValue = "\(Int(value))"
//            let attributedString = NSMutableAttributedString(string: "\(formattedValue)h")
//            
//            // 'h'의 글씨색을 흰색으로 변경
//            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: formattedValue.count, length: 1))
//            
//            return formattedValue
//        }
//    }
//}
