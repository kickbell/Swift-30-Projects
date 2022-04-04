//
//  DatailViewController.swift
//  DITutorial
//
//  Created by ios on 2022/04/04.
//

import UIKit
import APIKit

struct Course {
    let name: String
}

class DatailViewController: UIViewController {
    
    let dataFetchable: FetchServiceType
    var courses: [Course] = []
    
    lazy var  tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    init(dataFetchable: FetchServiceType) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        dataFetchable.fetchCourNames { [weak self] name in
            self?.courses = name.map { Course(name: $0)}
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension DatailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }
}
