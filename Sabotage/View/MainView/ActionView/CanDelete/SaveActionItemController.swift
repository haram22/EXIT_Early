//////
//////  SaveActionItemController.swift
//////  Sabotage
//////
//////  Created by 오성진 on 12/27/23.
//////
////  AddActionItemController.swift
//
//
// MARK: - 이건 지워도 될듯
///*
// SaveActionItemController은 "if let selectedActionItem = selectedActionItem {
// // 선택된 셀의 정보를 이용한 작업 수행
// print("Selected Action Item: \(selectedActionItem)")
//}"을 통해 외부 파일로부터 selectedActionItem 데이터를 받았다. selectedActionItem 내부에는 category 데이터(selectedActionItem?.category)와 content 데이터(selectedActionItem?.content)가 있다.
// inputField에서 새로운 텍스트를 받으면 그 데이터가 기존의 content 데이터(selectedActionItem?.content)에서 업데이트 되어야 한다.
// 그리고 saveButton을 탭하면 "actionPatchRequest(with: , content: )"가 호출됨으로써 서버로 데이터를 보내야 한다.
// "actionPatchRequest(with: , content: )"를 완성해줘
// 
// inputField에서 텍스트가 변경되고 saveButton을 눌렀을 때 actionPatchRequest(with: , content: )가 호출되어야 한다.
// **/
//
//import UIKit
//import SnapKit
//
//class SaveActionItemController: UIViewController, UITextFieldDelegate {
//    
//    var textField: UITextField = UITextField()
//    var selectedButtonName: String = "" // 선택된 버튼의 이름을 저장하는 변수
//    var selectedCard: Int = 0
//    var text = ""
//    
//    
//    var selectedActionItem: ActionDataType?
//    
//    // MARK: 변수
//    //    let backButton = UIButton(type: .system)
//    let closeButton = UIImageView(image: UIImage(named: "closeButton.png"))
//    let Title = UIImageView(image: UIImage(named: "action_title.png"))
//    let category1 = UIImageView(image: UIImage(named: "addaction_category1.png"))
//    let inputItem = UIImageView(image: UIImage(named: "addaction_inputitem.png"))
//    var content: String = "" // MARK: 외부에서 받을 content
//    
//    static let buttonText = "저장하기" // Declare text as a static property
//    
//    let saveButton: UIButton = {
//        let button = UIButton()
//        button.setTitle(SaveActionItemController.buttonText, for: .normal) // Use the static property here
//        button.setTitleColor(.base50, for: .normal)
//        button.setBackgroundImage(UIImage(named: "saveButton.png"), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    let saveButtonChanged: UIButton = {
//        let button = UIButton()
//        button.setTitle(SaveActionItemController.buttonText, for: .normal) // Use the static property here
//        button.setTitleColor(.base500, for: .normal)
//        button.setBackgroundImage(UIImage(named: "saveButtonChanged.png"), for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    let deleteButton = UIImageView(image: UIImage(named: "deleteButton.png"))
//    
//    let inputField: UITextField = {
//        let textField = UITextField()
//        //        textField.placeholder = "예) 자리에 앉기"
//        textField.backgroundColor = .clear // Set the background color to clear
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    // MARK: UI
//    func setUI() {
//        
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(closeButton)
//        
//        Title.contentMode = .center
//        Title.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(Title)
//        view.addSubview(Title)
//        
//        // MARK: - 외부 데이터 받기 -> selectedActionItem?.category
//        
//        if let category = selectedActionItem?.category {
//            let categoryImageName: String
//            switch category {
//            case "1":
//                categoryImageName = "addaction_category1.png"
//            case "2":
//                categoryImageName = "addaction_category2.png"
//            case "3":
//                categoryImageName = "addaction_category3.png"
//            case "4":
//                categoryImageName = "addaction_category4.png"
//            case "5":
//                categoryImageName = "addaction_category5.png"
//            case "6":
//                categoryImageName = "addaction_category6.png"
//            default:
//                categoryImageName = "default_category.png" // Default image if category is not within 1 to 6
//            }
//            
//            if let categoryImage = UIImage(named: categoryImageName) {
//                category1.image = categoryImage
//            }
//        }
//        category1.contentMode = .scaleAspectFit
//        category1.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(category1)
//        
//        inputItem.contentMode = .scaleAspectFit
//        inputItem.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(inputItem)
//        
//        view.addSubview(inputField)
//        
//        view.addSubview(saveButton)
//        view.addSubview(saveButtonChanged)
//        
//        deleteButton.contentMode = .scaleAspectFit
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(deleteButton)
//        
//    }
//    
//    // MARK: constraint
//    func setConstraint() {
//        NSLayoutConstraint.activate([
//            
//            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            closeButton.widthAnchor.constraint(equalToConstant: 40),
//            closeButton.heightAnchor.constraint(equalToConstant: 40),
//            
//            Title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            Title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
//            Title.widthAnchor.constraint(equalToConstant: 80),
//            
//            category1.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
//            category1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            category1.widthAnchor.constraint(equalToConstant: 370),
//            category1.heightAnchor.constraint(equalToConstant: 90),
//            
//            inputItem.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
//            inputItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            inputItem.widthAnchor.constraint(equalToConstant: 370),
//            inputItem.heightAnchor.constraint(equalToConstant: 120),
//            
//            inputField.topAnchor.constraint(equalTo: inputItem.topAnchor, constant: 10),
//            inputField.leadingAnchor.constraint(equalTo: inputItem.leadingAnchor, constant: 10),
//            inputField.trailingAnchor.constraint(equalTo: inputItem.trailingAnchor, constant: -10),
//            inputField.bottomAnchor.constraint(equalTo: inputItem.bottomAnchor, constant: -10),
//            
//            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
//            saveButton.heightAnchor.constraint(equalToConstant: 70),
//            
//            saveButtonChanged.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            saveButtonChanged.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            saveButtonChanged.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
//            saveButtonChanged.heightAnchor.constraint(equalToConstant: 70),
//            
//            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
//            //            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            deleteButton.widthAnchor.constraint(equalToConstant: 60),
//            deleteButton.heightAnchor.constraint(equalToConstant: 25),
//        ])
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        if let selectedActionItem = selectedActionItem {
//            // 선택된 셀의 정보를 이용한 작업 수행
//            print("Selected Action Item: \(selectedActionItem)")
//        }
//        
//        saveButtonChanged.isHidden = true
//        
//        setUI()
//        setConstraint()
//        
//        // MARK: - 외부 데이터 ->selectedActionItem?.content
//        inputField.text = selectedActionItem?.content
//        
//        print("Selected card: \(selectedCard)")
//        
//        saveButtonChanged.addTarget(self, action: #selector(saveButtonChangedTapped), for: .touchUpInside)
//        view.addSubview(saveButtonChanged)
//        
//        let tapGestureDelete = UITapGestureRecognizer(target: self, action: #selector(deleteButtonTapped))
//        deleteButton.addGestureRecognizer(tapGestureDelete)
//        deleteButton.isUserInteractionEnabled = true
//        
//        
//        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tapGesture1.cancelsTouchesInView = false // Allow touch events to pass through the view hierarchy
//        view.addGestureRecognizer(tapGesture1)
//        
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
//        closeButton.addGestureRecognizer(tapGesture2)
//        closeButton.isUserInteractionEnabled = true
//        
//        inputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        
//    }
//    
//    @objc func closeButtonTapped() {
//        let alert = UIAlertController(title: "정말 나가시겠어요?",
//                                      message: "저장하지 않은 내용을 잃어버릴 수 있어요",
//                                      preferredStyle: .alert)
//        
//        let confirmAction = UIAlertAction(title: "나가기", style: .default) { _ in
//            self.navigationController?.popToRootViewController(animated: true)
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        
//        alert.addAction(confirmAction)
//        alert.addAction(cancelAction)
//        
//        present(alert, animated: true, completion: nil)
//        navigationController?.popToRootViewController(animated: true)
//    }
//    
//    @objc func deleteButtonTapped() {
//        let alert = UIAlertController(title: "정말 삭제하시겠어요?",
//                                      message: "삭제하면 다시 불러올 수 없어요",
//                                      preferredStyle: .alert)
//        
//        let confirmAction = UIAlertAction(title: "삭제", style: .default) { [self] _ in
//            guard let myID = selectedActionItem?.id else {
//                return
//            }
////            deleteRequest(id: myID)
//            print("✋ myID = ", myID)            
//            self.navigationController?.popToRootViewController(animated: true)
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
//        
//        alert.addAction(confirmAction)
//        alert.addAction(cancelAction)
//        
//        present(alert, animated: true, completion: nil)
//        navigationController?.popToRootViewController(animated: true)
//    }
//
//    
//    @objc func dismissKeyboard() {
//        view.endEditing(true) // Dismiss the keyboard
//    }
//    
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    @objc func saveButtonChangedTapped() {
//        guard let newContent = inputField.text,
//              let category = selectedActionItem?.category,
//              let myID = selectedActionItem?.id else {
//            return
//        }
//        print("⚠️ selectedActionItem?.content: ", newContent)
//        print("⚠️ selectedActionItem?.content: ", inputField.text as Any)
//        print("⚠️ selectedActionItem?.category: ", selectedActionItem?.category as Any)
//        print("⚠️ selectedActionItem?.id: ", selectedActionItem?.id as Any)
//        print("🔥 category = ", category, ", content = ", newContent, ", id = ", myID)
////        actionPatchRequest(category: category, content: newContent, id: myID)
//        print("🔥 category = ", category, ", content = ", newContent, ", id = ", myID)
//        navigationController?.popToRootViewController(animated: true)
//    }
//
//
//
//    // 저장하기
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        if let text = textField.text, let originalContent = selectedActionItem?.content, text != originalContent {
//            //            saveButton.setImage(UIImage(named: "saveButtonChanged.png"), for: .normal)
//            saveButton.isHidden = true
//            saveButtonChanged.isHidden = false
//        } else {
//            saveButton.isHidden = false
//            saveButtonChanged.isHidden = true
//            
//            //            saveButton.setImage(UIImage(named: "saveButton.png"), for: .normal)
//            //            saveButtonChanged.isHidden = false
//        }
//    }
//    
//}
