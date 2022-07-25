//
//  ViewController.swift
//  Ratelimit
//
//  Created by jc.kim on 7/10/22.
//

import UIKit

class ViewController: UIViewController {

    private var repositories: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func presentAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true)
    }
    
    private func exampleError(_ json: [String : Any]) {
        guard let errorMessage = json["message"] as? String else { return }
        DispatchQueue.main.async {
            self.presentAlert("Error", errorMessage)
        }
    }
    
    private func searchRepositories(_ q: String, completion: @escaping ([Repository]) -> ()) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(q)") else {
            return print("invalid url...")
        }
        
        var request = URLRequest(url: url)
        request.setValue("token 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", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let httpResponse = response as? HTTPURLResponse,
                  let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            
            guard let items = json["items"] as? [[String:Any]] else {
                self.exampleError(json)
                return
            }

            print(httpResponse.allHeaderFields.forEach { print($0) })
            
            let result = items.map {
                Repository(fullName: $0["full_name"] as? String ?? "",
                           htmlUrl: $0["html_url"] as? String ?? "")
            }
            
            completion(result)
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repositories[indexPath.row].fullName
        cell.detailTextLabel?.text = repositories[indexPath.row].htmlUrl
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRepositories(searchBar.text ?? "") {
            self.repositories = $0
        }
    }
}

struct Repository {
    let fullName: String
    let htmlUrl: String
}





