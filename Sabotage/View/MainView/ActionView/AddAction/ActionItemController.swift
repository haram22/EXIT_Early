import UIKit

// MARK: - action item 추가하기 버튼 클릭 시 이동하는 페이지 (step1)
class ActionItemController: UIViewController {
    
    // MARK: 변수
    var selectedCard = UILabel()
    var selectedCardTag: Int?
    
    let closeButton = UIImageView(image: UIImage(named: "closeButton.png"))
    let titleLabel = UILabel()
    let tracker1 = UIImageView(image: UIImage(named: "action_tracker1.png"))
    let subtitle = UILabel()
    
    let actionCardImages: [UIImage] = [
        UIImage(named: "action_card1.png")!,
        UIImage(named: "action_card2.png")!,
        UIImage(named: "action_card3.png")!,
        UIImage(named: "action_card4.png")!,
        UIImage(named: "action_card5.png")!,
        UIImage(named: "action_card6.png")!
    ]
    var actionCardImageViews: [UIImageView] = []
    
    let backButton = UIImageView(image: UIImage(named: "action_backbutton.png"))
    let nextButton = UIImageView(image: UIImage(named: "action_nextbutton.png"))
    
    // MARK: UI
    func setUI() {
        for image in actionCardImages {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            actionCardImageViews.append(imageView)
            view.addSubview(imageView)
        }
        
        for (index, imageView) in actionCardImageViews.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionCardTapped(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGesture)
            imageView.tag = index + 1
        }
    }
    
    @objc func actionCardTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            let tappedTag = imageView.tag
            
            // 탭된 이미지가 이미 선택된거면 되돌리기.
            if selectedCardTag == tappedTag {
                imageView.image = UIImage(named: "action_card\(tappedTag).png")
                selectedCardTag = nil
            } else {
                // 이전에 선택된 카드를 되돌림.
                if let prevSelectedTag = selectedCardTag,
                   let prevSelectedImageView = actionCardImageViews.first(where: { $0.tag == prevSelectedTag }) {
                    prevSelectedImageView.image = UIImage(named: "action_card\(prevSelectedTag).png")
                }
                // 탭된 이미지 선택.
                imageView.image = UIImage(named: "action_card\(tappedTag)selected.png")
                selectedCardTag = tappedTag
            }
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
        
        titleLabel.then {
            view.addSubview($0)
            $0.text = "목표 습관"
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.contentMode = .center
            $0.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
                make.width.equalTo(80)
                make.height.equalTo(25)
            }
        }
        
        tracker1.then {
            $0.contentMode = .scaleAspectFit
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top).offset(110)
                make.leading.equalTo(0)
                make.trailing.equalTo(-3)
                make.width.equalTo(305)
                make.height.equalTo(50)
            }
        }
        subtitle.then {
            $0.text = "제한 서비스 외에\n어떤 활동을 추천 해 드릴까요?"
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 22, weight: .medium)
            $0.contentMode = .scaleAspectFit
            view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top).offset(150)
                make.leading.equalToSuperview().offset(30)
                make.width.equalTo(280)
                make.height.equalTo(80)
            }
        }
        
        var previousCardImageView: UIImageView?
        for imageView in actionCardImageViews {
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 350),
                imageView.heightAnchor.constraint(equalToConstant: 80),
            ])
            
            let aspectConstraint = NSLayoutConstraint(item: imageView,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: imageView,
                                                      attribute: .width,
                                                      multiplier: imageView.image!.size.height / imageView.image!.size.width,
                                                      constant: 0)
            aspectConstraint.isActive = true
            
            if let previous = previousCardImageView {
                imageView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                imageView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 25).isActive = true
            }
            previousCardImageView = imageView
        }
        backButton.then {
            view.addSubview($0)
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
                make.width.equalTo(160)
                make.height.equalTo(80)
            }
        }
        nextButton.then {
            view.addSubview($0)
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-20)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
                make.width.equalTo(160)
                make.height.equalTo(80)
            }
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextButtonTapped))
        nextButton.isUserInteractionEnabled = true
        nextButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func nextButtonTapped() {
        let addActionItemController = AddActionItemController()
        if let selectedCardValue = selectedCardTag {
            addActionItemController.selectedCard = selectedCardValue
        }
        
        navigationController?.pushViewController(addActionItemController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("anctionItem controller")
        setUI()
        setConstraint()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        closeButton.addGestureRecognizer(tapGesture)
        closeButton.isUserInteractionEnabled = true
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
}
