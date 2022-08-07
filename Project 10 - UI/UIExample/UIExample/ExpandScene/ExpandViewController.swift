//
//  ExpandViewController.swift
//  UIExample
//
//  Created by jc.kim on 8/7/22.
//

import UIKit

class ExpandViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let data = Array(1...30)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    

}

extension ExpandViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(data[indexPath.row])"
        return cell
    }
    
}
