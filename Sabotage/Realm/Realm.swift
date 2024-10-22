//
//  Realm.swift
//  Sabotage
//
//  Created by 김하람 on 10/22/24.
//

import UIKit
import RealmSwift

// Realm 데이터베이스에 접근하고, 원하는 작업을 하기 위해 local default Realm 객체를 열어 사용
let realm = try! Realm()

class ViewController: UIViewController {
    var member: [Data] = []
    var isSelected: IndexPath?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    let homeTitle: UILabel = {
        let label = UILabel()
        label.text = "🏄‍♀️ PARD 타는 사람들 🏄🏻‍♂️"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.systemCyan, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(editButton)
        view.addSubview(homeTitle)
        addConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editData), for: .touchUpInside)
        loadMemberList()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: homeTitle.topAnchor, constant: 100),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            homeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            homeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    @objc func add() {
        print("buttonPRessed")
        let alert = UIAlertController(title: "데이터를 추가하시겠습니까?", message: nil, preferredStyle: .alert)
        alert.addTextField{ text in
            text.placeholder = "이름을 입력하세요."
        }
        alert.addTextField { text in
            text.placeholder = "나이를 입력하세요."
        }
        alert.addTextField { text in
            text.placeholder = "파트를 입력하세요."
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            guard
                let name = alert.textFields?[0].text, !name.isEmpty,
                let ageString = alert.textFields?[1].text, let age = Int(ageString),
                let part = alert.textFields?[2].text, !part.isEmpty
                    
            else {
                print("텍스트 입력에 오류가 발생했습니다.")
                return
            }

            let newMember = Data()
            newMember.name = name
            newMember.age = age
            newMember.part = part
            
            do {
                try realm.write {
                    realm.add(newMember)
                    self.loadMemberList()
                }
            } catch let error {
                print("Error saving to Realm: \(error)")
            }
        })
        self.present(alert, animated: true)
    }
    
    @objc func editData() {
        guard let indexPath = isSelected else {
            print("셀을 하나 선택하세요.")
            return
        }
        let memberToEdit = member[indexPath.row]
        let alert = UIAlertController(title: "데이터를 수정하시겠습니까?", message: nil, preferredStyle: .alert)
        alert.addTextField { abc in
            abc.placeholder = "이름을 입력하세요."
            abc.text = self.member[indexPath.row].name
        }
        alert.addTextField { (textField) in
            textField.placeholder = "나이를 입력하세요."
            textField.text = "\(memberToEdit.age)"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "파트를 입력하세요."
            textField.text = memberToEdit.part
        }
        
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            guard
                let name = alert.textFields?[0].text, !name.isEmpty,
                let ageString = alert.textFields?[1].text, let age = Int(ageString),
                let part = alert.textFields?[2].text, !part.isEmpty
            else {
                print("텍스트 입력에 오류가 발생했습니다.")
                return
            }
            do {
                try realm.write {
                    memberToEdit.name = name
                    memberToEdit.age = age
                    memberToEdit.part = part
                }
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            } catch let error {
                print("Error updating in Realm: \(error)")
            }
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(alert, animated: true)
    }
    
    // MARK: - list에 있는 Data 읽어오기 (Read)
    private func loadMemberList(){
        let member = realm.objects(Data.self)
        self.member = Array(member)
        print("🌲 = \(member)")
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let members = member[indexPath.row]
        cell.textLabel?.text = "[ \(members.part) ] \(members.name)"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        print("🥳  \(members.name)")
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return member.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           let memberToDelete = member[indexPath.row]
           do {
               try realm.write {
                   realm.delete(memberToDelete)
               }
               // 로컬에서 해당 데이터 삭제
               member.remove(at: indexPath.row)
               // 테이블 뷰에서 해당 row 삭제
               tableView.deleteRows(at: [indexPath], with: .middle)
           } catch let error {
               print("Error deleting from Realm: \(error)")
           }
       }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelected = indexPath
    }
}
