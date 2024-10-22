import UIKit

class RankingTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let cellIdentifier = "CustomCell"
    let cellCount = 11
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        addSubview(tableView)
        
        // Remove cell separator
        tableView.separatorStyle = .none
        tableView.backgroundColor = .base400
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.widthAnchor.constraint(equalToConstant: 324),
            tableView.heightAnchor.constraint(equalToConstant: 433),
        ])
    }

    // MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .base100
        
        let number = UILabel()
        number.translatesAutoresizingMaskIntoConstraints = false
        number.font = .Headline()
        cell.contentView.addSubview(number)
        
        let leftText = UILabel()
        leftText.translatesAutoresizingMaskIntoConstraints = false
        leftText.text = "Left Text"
        leftText.font = .Headline()
        cell.contentView.addSubview(leftText)
        
        let rightText = UILabel()
        rightText.translatesAutoresizingMaskIntoConstraints = false
        rightText.text = "Right Text"
        rightText.font = .Headline()
        rightText.textAlignment = .right
        cell.contentView.addSubview(rightText)
        
        NSLayoutConstraint.activate([
            number.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            number.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 30),
            
            leftText.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            leftText.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 90),
            
            rightText.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            rightText.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20)
        ])
        
        // 상위 랭킹 3위 안
        if indexPath.row < 3 {
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setBackgroundImage(UIImage(named: "rankingTop3BG"), for: .normal)
            button.contentMode = .scaleAspectFit
            cell.contentView.addSubview(button)
            
            // 초록색 동그라미
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 22), // 버튼의 크기 조정
                button.heightAnchor.constraint(equalToConstant: 22), // 버튼의 크기 조정
                button.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                button.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 24)
            ])
        
            cell.contentView.bringSubviewToFront(number) // 이거 해야 이미지 위에 number 올릴 수 있음.
            number.text = "\(indexPath.row + 1)"
            number.textColor = .base500
            
        }
        // 내 랭킹
        else if indexPath.row == 10 {
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setBackgroundImage(UIImage(named: "myRankingBG"), for: .normal)
            button.contentMode = .scaleAspectFit
            cell.contentView.addSubview(button)
                
            // 내 랭킹 위치
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 310), // 버튼의 크기 조정
                button.heightAnchor.constraint(equalToConstant: 36), // 버튼의 크기 조정
                button.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
//                button.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10)
            ])
        
            cell.contentView.bringSubviewToFront(number) // 이거 해야 이미지 위에 number 올릴 수 있음.
            cell.contentView.bringSubviewToFront(leftText)
            cell.contentView.bringSubviewToFront(rightText)
            number.text = "\(indexPath.row + 14)"
            number.textColor = .base500
        }
        else {
            number.text = "\(indexPath.row + 1)"
            number.textColor = indexPath.row == 10 ? .base500 : .base300
        }
        
        switch indexPath.row {

        case 0:
            leftText.text = "활기찬무지개9865"
            rightText.text = "180회"
            leftText.textColor = .base500
            rightText.textColor = .base500
        case 1:
            leftText.text = "활기찬고양이6798"
            rightText.text = "153회"
            leftText.textColor = .base500
            rightText.textColor = .base500
        case 2:
            leftText.text = "창의적인호랑이7980"
            rightText.text = "130회"
            leftText.textColor = .base500
            rightText.textColor = .base500
        case 3:
            leftText.text = "신비로운별1242"
            rightText.text = "121회"
            leftText.textColor = .base300
            rightText.textColor = .base300
        case 4:
            leftText.text = "우아한강아지3564"
            rightText.text = "99회"
            leftText.textColor = .base300
            rightText.textColor = .base300
        case 5:
            leftText.text = "귀여운토끼1010"
            rightText.text = "87회"
            leftText.textColor = .base300
            rightText.textColor = .base300
        case 6:
            leftText.text = "매혹적인해파리2087"
            rightText.text = "73회"
            leftText.textColor = .base300
            rightText.textColor = .base300
        case 7:
            leftText.text = "신비한바다사자5748"
            rightText.text = "70회"
            leftText.textColor = .base300
            rightText.textColor = .base300
        case 8:
            leftText.text = "창의적인코알라2580"
            rightText.text = "62회"
            leftText.textColor = .base300
            rightText.textColor = .base300
        case 9:
            leftText.text = "신비로운갈매기8192"
            rightText.text = "59회"
            leftText.textColor = .base300
            rightText.textColor = .base300
        case 10:
            leftText.text = "test"
            rightText.text = "13회"
            leftText.textColor = .base500
            rightText.textColor = .base500
            
        default:
            break
        }
        
        return cell
    }
    
    // TableView의 Cell 높이 설정
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 39.0 // 원하는 height 값으로 변경
        }
}
