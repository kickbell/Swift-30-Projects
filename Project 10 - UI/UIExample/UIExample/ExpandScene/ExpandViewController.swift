//
//  ExpandViewController.swift
//  UIExample
//
//  Created by jc.kim on 8/7/22.
//

import UIKit

class ExpandViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hiddenSections = Set<Int>()
    
    // MARK: - 핵심은 얘를 let으로 놓고 수정하지 않는 것
    private let data = BlockManager(
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
    private func hideSection(_ section: Int) {
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            if section == 0 {
                let indexs = data.blockUser.enumerated().map { index, _ in IndexPath(row: index, section: 0) }
                indexPaths.append(contentsOf: indexs)
            } else {
                let indexs = data.nonBlolckUser.enumerated().map { index, _ in IndexPath(row: index, section: 1) }
                indexPaths.append(contentsOf: indexs)
            }
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.tableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.tableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = BlockHeaderView()
        v.title.text = section == 0 ? "차단된 사용자 \(data.blockUser.count)" : "차단되지 않은 사용자 \(data.nonBlolckUser.count)"
        v.callBack = { [weak self] in self?.hideSection(section)}
        return v
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !self.hiddenSections.contains(section) else { return 0 }
        return section == 0 ? data.blockUser.count : data.nonBlolckUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =
        indexPath.section == 0 ? data.blockUser[indexPath.row].chanelName : data.nonBlolckUser[indexPath.row].chanelName
        return cell
    }
    
}
