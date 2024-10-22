import UIKit

class ActionItemController: UIViewController {
    
    // MARK: 변수
    var selectedCard = UILabel()
    var selectedCardTag: Int?
    
    let closeButton = UIImageView(image: UIImage(named: "closeButton.png"))
    let Title = UIImageView(image: UIImage(named: "action_title.png"))
    let tracker1 = UIImageView(image: UIImage(named: "action_tracker1.png"))
    let subtitle = UIImageView(image: UIImage(named: "action_subtitle.png"))
    
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
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        Title.contentMode = .center
        Title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(Title)
        
        tracker1.contentMode = .scaleAspectFit
        tracker1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tracker1)
        
        subtitle.contentMode = .scaleAspectFit
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitle)
        
        for image in actionCardImages {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            actionCardImageViews.append(imageView)
            view.addSubview(imageView)
        }
        
        backButton.contentMode = .scaleAspectFit
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        nextButton.contentMode = .scaleAspectFit
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
        
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
        NSLayoutConstraint.activate([
            
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            Title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            Title.widthAnchor.constraint(equalToConstant: 80),
            Title.heightAnchor.constraint(equalToConstant: 25),
            
            tracker1.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            tracker1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tracker1.widthAnchor.constraint(equalToConstant: 415),
            tracker1.heightAnchor.constraint(equalToConstant: 50),
            
            subtitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            subtitle.widthAnchor.constraint(equalToConstant: 280),
            subtitle.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        var previousCardImageView: UIImageView?
        for imageView in actionCardImageViews {
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 370),
                imageView.heightAnchor.constraint(equalToConstant: 70),
            ])
            
            // Set aspect ratio constraint
            let aspectConstraint = NSLayoutConstraint(item: imageView,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: imageView,
                                                      attribute: .width,
                                                      multiplier: imageView.image!.size.height / imageView.image!.size.width,
                                                      constant: 0)
            aspectConstraint.isActive = true
            
            if let previous = previousCardImageView {
                imageView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 20).isActive = true
            } else {
                imageView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 25).isActive = true
            }
            
            previousCardImageView = imageView
        }
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backButton.widthAnchor.constraint(equalToConstant: 180),
            backButton.heightAnchor.constraint(equalToConstant: 80),
            
            // Next button constraints
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: 180),
            nextButton.heightAnchor.constraint(equalToConstant: 80),
        ])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextButtonTapped))
        nextButton.isUserInteractionEnabled = true
        nextButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func nextButtonTapped() {
        let addActionItemController = AddActionItemController()
        
        // Pass selectedCard value to AddActionItemController
        if let selectedCardValue = selectedCardTag {
            addActionItemController.selectedCard = selectedCardValue
        }
        
        navigationController?.pushViewController(addActionItemController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setConstraint()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        closeButton.addGestureRecognizer(tapGesture)
        closeButton.isUserInteractionEnabled = true
    }
    
    
    // MARK: -  카드 뒤집기
    @objc func closeButtonTapped() {
//        if let mainVC = navigationController?.viewControllers.first(where: { $0 is MainVC }) {
//            UIView.transition(with: navigationController!.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
//                self.navigationController?.popToViewController(mainVC, animated: false)
//            }, completion: nil)
//        } else {
//            let mainVC = MainVC() // Instantiate your MainVC if not in the navigation stack
//            navigationController?.pushViewController(mainVC, animated: true)
//        }
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
