import UIKit

class AnalysisVC: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let TitleLabel = UILabel()
    let ThisWeek = UILabel()
    let Change = UILabel()
    let ExitRank = UILabel()
    let updateTime = UILabel()
    let weekBarVC = WeekBarVC()
    let changeBarVC = ChangeBarVC()
    let rankingTableView = RankingTableView()
    let rankingBG = UIButton(type: .custom)


override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
        
    scrollViewUI()
    contentViewUI()
    
    titleUI()
    addWeekBarView()
    addChangeBarView()
    rankingUI()

    
}
    func scrollViewUI() {
        // MARK: - UIScrollView 생성
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        
        // MARK: ScrollView autolayout 설정
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    
    func contentViewUI() {
        // MARK: - 스크롤뷰 content 추가
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
    
        // MARK: - contentView의 오토레이아웃 설정 -> 이거 해야 스크롤 됨.
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
    }
    

    func titleUI() {
        // MARK: - contentView에 추가할 content 생성 및 설정
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.text = "사용량 분석"
        TitleLabel.font = UIFont.Title2()
        TitleLabel.textColor = .black
        TitleLabel.numberOfLines = 0
        contentView.addSubview(TitleLabel)

        // thisweekimage 이미지 위치 설정
        let thisweekimage = UIButton(type: .custom)
        thisweekimage.translatesAutoresizingMaskIntoConstraints = false
        thisweekimage.contentMode = .scaleAspectFit
        thisweekimage.backgroundColor = .clear
        thisweekimage.setImage(UIImage(named: "weeklyBG"), for: .normal)
        contentView.addSubview(thisweekimage)

        ThisWeek.translatesAutoresizingMaskIntoConstraints = false
        ThisWeek.text = "이번 주"
        ThisWeek.font = UIFont.Headline()
        ThisWeek.textColor = .base50
        ThisWeek.numberOfLines = 0
        contentView.addSubview(ThisWeek) // label3를 contentView에 추가

        NSLayoutConstraint.activate([
            TitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            TitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            ThisWeek.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ThisWeek.bottomAnchor.constraint(equalTo: thisweekimage.topAnchor, constant: 45), // ThisWeek를 thisweekimage 위에 배치

            thisweekimage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            thisweekimage.widthAnchor.constraint(equalToConstant: 343),
            thisweekimage.heightAnchor.constraint(equalToConstant: 320), // 이미지 크기에 맞게 조정
            thisweekimage.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 30), // TitleLabel 아래에 배치
        ])
        
        // changeimage 이미지를 Change 밑에 추가
        let changeimage = UIButton(type: .custom)
        changeimage.translatesAutoresizingMaskIntoConstraints = false
        changeimage.contentMode = .scaleAspectFit
        changeimage.backgroundColor = .clear
        changeimage.setImage(UIImage(named: "changeBG"), for: .normal)
        contentView.addSubview(changeimage)
        
        // Change Label을 contentView에 추가
        let changeLabel = UILabel()
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.text = "어제보다\n84%\n감소했어요"
        changeLabel.font = UIFont.Headline()
        changeLabel.textColor = .base50
        changeLabel.numberOfLines = 3
        contentView.addSubview(changeLabel)
        
        // '40%' 텍스트의 색상을 변경하기 위한 NSAttributedString 설정
        let attributedString = NSMutableAttributedString(string: "어제보다\n84%\n감소했어요")
        let range = (changeLabel.text! as NSString).range(of: "84%")
        attributedString.addAttribute(.foregroundColor, value: UIColor.green, range: range)
        changeLabel.attributedText = attributedString
        
        Change.translatesAutoresizingMaskIntoConstraints = false
        Change.text = "사용 변화량"
        Change.font = UIFont.Headline()
        Change.textColor = .base50
        Change.numberOfLines = 0
        contentView.addSubview(Change)
        
        NSLayoutConstraint.activate([
            Change.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            Change.bottomAnchor.constraint(equalTo: changeimage.topAnchor, constant: 45),
            
            changeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 60),
            changeLabel.centerYAnchor.constraint(equalTo: changeimage.centerYAnchor, constant: -10),
            
            changeimage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            changeimage.widthAnchor.constraint(equalToConstant: 343),
            changeimage.heightAnchor.constraint(equalToConstant: 255), // 이미지 크기에 맞게 조정
            changeimage.topAnchor.constraint(equalTo: thisweekimage.bottomAnchor, constant: 1),
        ])


        // MARK: - contentView에 추가할 content 생성 및 설정
        ExitRank.translatesAutoresizingMaskIntoConstraints = false
        ExitRank.text = "EXIT 랭킹"
        ExitRank.font = UIFont.Headline()
        ExitRank.textColor = .black
        ExitRank.numberOfLines = 0
        contentView.addSubview(ExitRank)


        NSLayoutConstraint.activate([
            // ExitRank 위치 설정
            ExitRank.topAnchor.constraint(equalTo: changeimage.bottomAnchor, constant: 20),
            ExitRank.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

        ])
    }
    
    // WeekBarVC의 뷰를 AnalysisVC에 추가하는 메서드
    func addWeekBarView() {
        // WeekBarVC의 뷰를 AnalysisVC의 contentView에 추가
        weekBarVC.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weekBarVC.view)
            
        // Autolayout constraints 설정
        NSLayoutConstraint.activate([
            weekBarVC.view.topAnchor.constraint(equalTo: ThisWeek.bottomAnchor, constant: -90),
            weekBarVC.view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weekBarVC.view.widthAnchor.constraint(equalToConstant: 343),
            weekBarVC.view.heightAnchor.constraint(equalToConstant: 320) // 적절한 크기로 조정
        ])
            
        // 부모-자식 뷰컨트롤러 관계 설정
        addChild(weekBarVC)
        weekBarVC.didMove(toParent: self)
    }
    
    
    // WeekBarVC의 뷰를 AnalysisVC에 추가하는 메서드
    func addChangeBarView() {
        // WeekBarVC의 뷰를 AnalysisVC의 contentView에 추가
        changeBarVC.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(changeBarVC.view)
            
        // Autolayout constraints 설정
        NSLayoutConstraint.activate([
            changeBarVC.view.topAnchor.constraint(equalTo: Change.topAnchor, constant: -100),
            changeBarVC.view.trailingAnchor.constraint(equalTo: Change.centerXAnchor, constant: 110),
            changeBarVC.view.widthAnchor.constraint(equalToConstant: 343),
            changeBarVC.view.heightAnchor.constraint(equalToConstant: 320) // 적절한 크기로 조정
        ])
            
        // 부모-자식 뷰컨트롤러 관계 설정
        addChild(weekBarVC)
        weekBarVC.didMove(toParent: self)
    }

    
    func rankingUI() {
        // 테이블 뷰를 먼저 contentView에 추가합니다.
        rankingTableView.translatesAutoresizingMaskIntoConstraints = false
        rankingTableView.backgroundColor = .blue
        contentView.addSubview(rankingTableView)
        
        NSLayoutConstraint.activate([
            // 테이블 뷰 위치 설정
            rankingTableView.topAnchor.constraint(equalTo: ExitRank.bottomAnchor, constant: 20),
            rankingTableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rankingTableView.widthAnchor.constraint(equalToConstant: 320),
            rankingTableView.heightAnchor.constraint(equalToConstant: 429)
        ])
        
        rankingTableView.layer.masksToBounds = true // 뷰의 내용이 모서리를 벗어나지 않도록 설정합니다.
        
        // rankingBG를 contentView에 추가합니다.
            rankingBG.translatesAutoresizingMaskIntoConstraints = false
            rankingBG.contentMode = .scaleAspectFit
            rankingBG.backgroundColor = .clear
            rankingBG.setImage(UIImage(named: "RankingBG"), for: .normal)
            contentView.addSubview(rankingBG)
        
        // rankingBG를 rankingTableView 위에 올리기 위해 순서를 조정합니다.
        contentView.bringSubviewToFront(ExitRank)
        contentView.bringSubviewToFront(rankingTableView)
        
        NSLayoutConstraint.activate([
            // 배경 이미지 버튼 위치 설정
            rankingBG.topAnchor.constraint(equalTo: ExitRank.topAnchor, constant: -20),
            rankingBG.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rankingBG.widthAnchor.constraint(equalToConstant: 343),
            rankingBG.heightAnchor.constraint(equalToConstant: 530)
        ])
        
        // 스크롤뷰 길이 확인을 위한 label
        let extraLabel = UILabel()
        extraLabel.translatesAutoresizingMaskIntoConstraints = false
        extraLabel.contentMode = .scaleAspectFit
        extraLabel.text = ""
        contentView.addSubview(extraLabel)
        
        NSLayoutConstraint.activate([
            extraLabel.topAnchor.constraint(equalTo: rankingBG.bottomAnchor, constant: 30),
            extraLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            extraLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            extraLabel.heightAnchor.constraint(equalToConstant: 1), // 이미지 높이 조정
            extraLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20), // contentView 하단과 이미지 간격 조정
        ])
    }

}
