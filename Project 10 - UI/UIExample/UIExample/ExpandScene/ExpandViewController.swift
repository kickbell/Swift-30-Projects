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
    }
    

}

extension ExpandViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "차단된 사용자" : "차단되지 않은 사용자"
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
