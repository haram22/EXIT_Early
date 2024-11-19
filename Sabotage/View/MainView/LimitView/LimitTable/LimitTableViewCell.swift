import UIKit

class LimitTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let timeBudget = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .base50
        print("limit view called")
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        // titleLabel 설정
        titleLabel.font = .Callout()
        titleLabel.textColor = .base700
        titleLabel.text = "그룹 이름"
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
  
        ])
    }
}
