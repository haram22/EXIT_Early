//import UIKit
//
//class ActionTableViewCell: UITableViewCell {
//    var categoryType: UILabel!
//    var categoryLabel: UILabel!
//
//    var contentLabel: UILabel!
//    var categoryImage: UIImageView! // Include the UIImageView for category images
//    
//    let cellBackgroundView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 20
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
////    func configure(with category: Int, content: String) {
////        contentLabel.text = content
////        
////        switch category {
////        case 1:
////            categoryType.text = "운동"
////            categoryImage.image = UIImage(named: "category1.png")
////        case 2:
////            categoryType.text = "셀프케어"
////            categoryImage.image = UIImage(named: "category2.png")
////        case 3:
////            categoryType.text = "생활"
////            categoryImage.image = UIImage(named: "category3.png")
////        case 4:
////            categoryType.text = "생산성"
////            categoryImage.image = UIImage(named: "category4.png")
////        case 5:
////            categoryType.text = "성장"
////            categoryImage.image = UIImage(named: "category5.png")
////        case 6:
////            categoryType.text = "수면"
////            categoryImage.image = UIImage(named: "category6.png")
////        default:
////            categoryType.text = "기타"
////            categoryImage.image = nil // No image for default or unknown category
////        }
////    }
//    
//    func setupCell() {
//        contentView.backgroundColor = .base50
//        contentView.addSubview(cellBackgroundView)
//        
//        categoryType = UILabel()
//        categoryType.font = UIFont.Caption1()
//        categoryType.textColor = .base700
//        contentView.addSubview(categoryType)
//        categoryType.translatesAutoresizingMaskIntoConstraints = false
//        
//        contentLabel = UILabel()
//        contentLabel.font = UIFont.Body()
//        contentLabel.textColor = .base700
//        contentView.addSubview(contentLabel)
//        contentLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        categoryImage = UIImageView() // Initialize the UIImageView
//        contentView.addSubview(categoryImage)
//        categoryImage.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//
//            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            cellBackgroundView.heightAnchor.constraint(equalToConstant: 100),
//            
//            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
//            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
//            
//            categoryType.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 55),
//            categoryType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120),
//            
//            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23),
//            categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
//            categoryImage.widthAnchor.constraint(equalToConstant: 50), // Adjust the image size as needed
//            categoryImage.heightAnchor.constraint(equalToConstant: 50) // Adjust the image size as needed
//        ])
//
////        func configure(with category: String, content: String) {
////            // Configure cell with data
////            categoryLabel.text = category
////            contentLabel.text = content
////        }
//    }
//}

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
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(68)
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
            make.leading.equalToSuperview().offset(120)
        }
        
        contentView.addSubview(categoryType)
        categoryType.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(120)
        }
        
        // 카테고리 이미지 설정
        categoryImage = UIImageView().then {
            $0.contentMode = .scaleAspectFit
        }
        contentView.addSubview(categoryImage)
        categoryImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalToSuperview().offset(50)
            make.width.height.equalTo(50) // 너비 및 높이 50 설정
        }
    }
}
