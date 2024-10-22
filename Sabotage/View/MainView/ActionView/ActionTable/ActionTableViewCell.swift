import UIKit
import RealmSwift

class ActionTableViewCell: UITableViewCell {
    var categoryType: UILabel!
    var contentLabel: UILabel!
    var categoryImage: UIImageView!

    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with categoryItem: CategoryItem) {
        contentLabel.text = categoryItem.content
        categoryType.text = categoryItem.categoryType
        if let image = UIImage(named: categoryItem.categoryImageName) {
            categoryImage.image = image
        } else {
            categoryImage.image = nil
        }
    }
    
    func setupCell() {
        // 셀 배경 색상 설정
        contentView.backgroundColor = .base50

        // 배경 뷰 설정
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(75)
        }

        // 카테고리 타입 레이블 설정
        categoryType = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            $0.textColor = .base700
        }
        
        // 내용 레이블 설정
        contentLabel = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            $0.textColor = .base600
        }
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(90)
        }
        
        contentView.addSubview(categoryType)
        categoryType.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(90)
        }
        
        // 카테고리 이미지 설정
        categoryImage = UIImageView().then {
            $0.contentMode = .scaleAspectFit
        }
        contentView.addSubview(categoryImage)
        categoryImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(50) // 너비 및 높이 50 설정
        }
    }
}
