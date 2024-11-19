//  AddActionItemController.swift
//  Sabotage
//
//  Created by 오성진 on 12/27/23.
//

import UIKit
import SnapKit
import RealmSwift

// MARK: - action item 추가하기 버튼 클릭 시 이동하는 페이지 (step2)
class AddActionItemController: UIViewController, UITextFieldDelegate {
    var selectedCard: Int = 0
    var realm: Realm!
    var actionItems: Results<CategoryItem>!
    
    // MARK: 변수
    let closeButton = UIImageView(image: UIImage(named: "closeButton.png"))
    let Title = UIImageView(image: UIImage(named: "action_title.png"))
    let tracker2 = UIImageView(image: UIImage(named: "action_tracker2.png"))
    let subtitle = UILabel()
    let category1 = UIImageView(image: UIImage(named: "addaction_category1.png"))
    let inputItem = UIImageView(image: UIImage(named: "addaction_inputitem.png"))
    
    let inputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예) 자리에 앉기"
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let backButton: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "addaction_backbutton.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let completeButton = UIImageView(image: UIImage(named: "addaction_completebuttonUntapped.png"))
    
    // MARK: UI
    func setUI() {
        Title.contentMode = .center
        tracker2.contentMode = .scaleAspectFit
        subtitle.contentMode = .scaleAspectFit
        
        subtitle.text = "이 활동을 위해서\n가장 작게 시작할 수 있는 일을\n자세하게 작성해 주세요"
        subtitle.font = .systemFont(ofSize: 22, weight: .medium)
        subtitle.numberOfLines = 0
        
        // category 이미지 설정
        let categoryImageName = "addaction_category\(selectedCard).png"
        if let categoryImage = UIImage(named: categoryImageName) {
            category1.image = categoryImage
        } else {
            // 선택된 카드에 맞는 이미지가 없을 경우에 대한 처리
            print("해당하는 이미지가 없습니다.")
        }
    }
    
    // MARK: constraint
    func setConstraint() {
        closeButton.then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
                make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
                make.width.equalTo(40)
                make.height.equalTo(40)
            }
        }
        
        Title.then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
                make.width.equalTo(80)
                make.height.equalTo(25)
            }
        }
        
        tracker2.then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top).offset(110)
                make.leading.equalToSuperview().offset(0)
                make.trailing.equalTo(-3)
                make.width.equalTo(415)
                make.height.equalTo(50)
            }
        }
        
        subtitle.then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top).offset(150)
                make.leading.equalToSuperview().offset(30)
                make.width.equalTo(280)
                make.height.equalTo(120)
            }
        }
        
        category1.then {
            view.addSubview($0)
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top).offset(288)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalTo(-20)
                make.height.equalTo(90)
            }
        }
        
        inputItem.then {
            view.addSubview($0)
            $0.backgroundColor = .clear
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top).offset(400)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalTo(-10)
                make.width.equalTo(370)
                make.height.equalTo(120)
            }
            $0.isUserInteractionEnabled = true
        }
        
        inputField.then {
            inputItem.addSubview($0)
            $0.backgroundColor = .clear
            $0.snp.makeConstraints { make in
                make.top.equalTo(inputItem.snp.top).offset(10)
                make.leading.equalTo(inputItem.snp.leading).offset(10)
                make.trailing.equalTo(inputItem.snp.trailing).offset(-10)
                make.bottom.equalTo(inputItem.snp.bottom).offset(-10)
            }
            $0.isUserInteractionEnabled = true
            $0.delegate = self
        }
        
        backButton.then {
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-215)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
                make.height.equalTo(70)
            }
        }
        
        completeButton.then {
            view.addSubview($0)
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(215)
                make.trailing.equalToSuperview().offset(-20)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
                make.height.equalTo(70)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("add actionitem controller")
        view.backgroundColor = .white
        
        do {
            realm = try Realm()
            loadData()
        } catch {
            print("Realm 초기화 실패: \(error)")
        }
        
        setUI()
        setConstraint()
        
        print("Selected card: \(selectedCard)")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backButton.addGestureRecognizer(tapGesture)
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture1.cancelsTouchesInView = false // Allow touch events to pass through the view hierarchy
        view.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        closeButton.addGestureRecognizer(tapGesture2)
        closeButton.isUserInteractionEnabled = true
        
        let completeTapGesture = UITapGestureRecognizer(target: self, action: #selector(completeButtonTapped))
        completeButton.isUserInteractionEnabled = true
        completeButton.addGestureRecognizer(completeTapGesture)
        
        inputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func closeButtonTapped() {
        let alert = UIAlertController(title: "정말 나가시겠어요?",
                                      message: "저장하지 않은 내용을 잃어버릴 수 있어요",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "나가기", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completeButtonTapped() {
        guard let text = inputField.text, !text.isEmpty else {
            print("Text is missing")
            return
        }
        let mainVC = MainVC()
        // Realm에 새로운 항목 추가
        let newItem = CategoryItem()
        var type : String = ""
        type = getCategoryType(for: selectedCard)
        newItem.categoryType = "\(type)"
        newItem.content = text
        newItem.categoryImageName = "category\(selectedCard).png"
        do {
            try self.realm.write {
                self.realm.add(newItem)
            }
            self.loadData()
        } catch {
            print("Realm 추가 실패: \(error)")
        }
        
        navigationController?.pushViewController(mainVC, animated: true)
    }
    func loadData() {
        actionItems = realm.objects(CategoryItem.self)
    }
    
    func getCategoryType(for selectedCard: Int) -> String {
        switch selectedCard {
        case 1:
            return "운동"
        case 2:
            return "셀프케어"
        case 3:
            return "생활"
        case 4:
            return "생산성"
        case 5:
            return "성장"
        case 6:
            return "수면"
        default:
            return "Unknown Category" // 선택된 카드가 정의된 범위에 없을 경우
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("textfield tapped")
        if let text = textField.text, !text.isEmpty {
            completeButton.image = UIImage(named: "addaction_completebutton.png")
        } else {
            completeButton.image = UIImage(named: "addaction_completebuttonUntapped.png")
        }
    }
}
