//
//  ExpandViewController.swift
//  UIExample
//
//  Created by jc.kim on 8/7/22.
//

import UIKit

struct BlockManager {
    let blockUser: [User]
    let nonBlolckUser: [User]
}

struct User: Identifiable {
    let id: String
    let profileImageUrl: String?
    let chanelName: String
    let isBlocked: Bool
}

class BlockHeaderView: UIView {
    var title: UILabel = {
        let label = UILabel()
        label.text = "차단된 사용자"
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var expandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.setImage(UIImage(systemName: "chevron.up"), for: .selected)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)
        button.isSelected = false
        return button
    }()
    
    lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(expandButton)
        return stack
    }()
    
    @objc func didTapExpand() {
        callBack?()
        expandButton.isSelected = !expandButton.isSelected
    }
    
    var callBack: (() -> ())?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: self.topAnchor),
            hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
}

class ExpandViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let data = BlockManager(
        blockUser: [
            User(id: UUID().uuidString, profileImageUrl: nil, chanelName: "이순신", isBlocked: true),
            User(id: UUID().uuidString, profileImageUrl: nil, chanelName: "나대용", isBlocked: true),
            User(id: UUID().uuidString, profileImageUrl: nil, chanelName: "장이수", isBlocked: true),
            User(id: UUID().uuidString, profileImageUrl: nil, chanelName: "박개똥", isBlocked: true),
            User(id: UUID().uuidString, profileImageUrl: nil, chanelName: "박거지", isBlocked: true),
        ],
        nonBlolckUser: [
            User(id: UUID().uuidString, profileImageUrl: nil, chanelName: "나까무라", isBlocked: false),
            User(id: UUID().uuidString, profileImageUrl: nil, chanelName: "와스히루", isBlocked: false),
            User(id: UUID().uuidString, profileImageUrl: nil, chanelName: "히데요시", isBlocked: false)
        ]
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        title = "Expand TableView"
    }
    

}

extension ExpandViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0 :
            let v = BlockHeaderView()
            v.title.text = "차단된 사용자 \(data.blockUser.count)"
            v.callBack = {
                print("차단..")
            }
            return v
        case 1:
            let v = BlockHeaderView()
            v.title.text = "차단되지 않은 사용자 \(data.nonBlolckUser.count)"
            v.callBack = {
                print("노노차단..")
            }
            return v
        default: break
        }

        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? data.blockUser.count : data.nonBlolckUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = data.blockUser[indexPath.row].chanelName
        case 1:
            cell.textLabel?.text = data.nonBlolckUser[indexPath.row].chanelName
        default:
            break
        }
        return cell
    }
    
}
