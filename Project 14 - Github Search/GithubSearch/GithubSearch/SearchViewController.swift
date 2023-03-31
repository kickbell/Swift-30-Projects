//
//  ViewController.swift
//  GithubSearch
//
//  Created by jc.kim on 3/30/23.
//

import UIKit
import ReactorKit
import RxSwift


//액션시트 만들기


//레포지토리셀 이미지넣기, 이미지 캐싱
//네트워크 연결하기
//코디네이터패턴 추가하기
//리액터킷으로 변경하기
//테스트 넣기


class SearchViewController: UITableViewController {
  
  private lazy var searchController: UISearchController = {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = "Search Repositories"
    return searchController
  }()
  
  private let recentSearchHeaderView = RecentSearchHeaderView()
  
  var data: [String] = []
  
  private func setupViews() {
    title = "Github"
    navigationItem.searchController = searchController
    
    view.backgroundColor = .systemBackground
    tableView.register(cellType: RecentSearchCell.self)
    
    
    recentSearchHeaderView.clearButtonDidTap = {
      print("celr...")
    }
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchCell.reuseIdentifier, for: indexPath) as? RecentSearchCell else {
      return UITableViewCell()
    }
    cell.configure(with: data[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    print(tableView.tableHeaderView, "??")
    if data.isEmpty {
      tableView.tableHeaderView?.isHidden = true
    }
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    print(#function, "???")
    return data.isEmpty == true ? nil : recentSearchHeaderView
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detail = DetailViewController()
    self.navigationController?.pushViewController(detail, animated: true)
  }
  
  
}

extension SearchViewController: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    print(#function, searchBar.text)
    data = ["포도", "딸기", "메론", "수박", "바나나", "방울토마토", "참외"]
    tableView.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print(#function, searchBar.text)
  }
  
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    //내부 유저디폴트에서 조회할때 데이터있으면 써치바 텍스트에 맞는걸로만 보이게
    print(#function, searchController.searchBar.text)
  }
}


