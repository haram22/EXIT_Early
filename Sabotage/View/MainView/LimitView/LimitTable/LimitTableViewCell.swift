import UIKit

class LimitTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let timeBudget = UILabel()

    
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        
        contentView.backgroundColor = .base50
        contentView.addSubview(cellBackgroundView)
        
        // titleLabel 설정
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
  
        ])
    }
}
