//
//  ViewController.swift
//  Chatlist
//
//  Created by jc.kim on 11/10/21.
//

import UIKit


class KakaoChatLandingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        tableView.dataSource = self
    }

    private let list = Message.dummyList
}

extension KakaoChatLandingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KakaoChatTableViewCell", for: indexPath) as? KakaoChatTableViewCell else { return UITableViewCell()
        }
        cell.configure(message: list[indexPath.row])
        return cell
    }
}

