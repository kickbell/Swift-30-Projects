//
//  ViewController.swift
//  Chatlist
//
//  Created by jc.kim on 11/10/21.
//

import UIKit


class KakaoChatLandingViewController: UIViewController {
    // TODO: TableView를 만들어서 outlet으로 추가해주세요.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }

    func setupTableView() {
        // TODO: TableView를 datasource을 설정해주세요.
    }

    private let list = Message.dummyList
}

extension KakaoChatLandingViewController: UITableViewDataSource {
    // TODO: UITableViewDataSource를 설정해주세요.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: list의 갯수만큼 나오게 해주세요.
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: KakaoChatTableViewCell을 생성해주세요. 생성하고 configure을 불러주세요.
        return UITableViewCell()
    }
}

