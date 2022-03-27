//
//  ViewModel.swift
//  PrefetchingTableView
//
//  Created by jc.kim on 3/27/22.
//

import Foundation
import UIKit

class ViewModel {
  
  init() {}
  
  private var isDownloading = false
  private var cachedImage: UIImage?
  private var callback: ((UIImage?) -> Void)?
  
  func downloadImage(completion: ((UIImage?) -> Void)?) {
    if let image = cachedImage {
      completion?(image)
      return
    }
    
    guard !isDownloading else {
      self.callback = completion
      return
    }
    
    isDownloading = true
    
    let size = Int.random(in: 100...350)
    
    guard let url = URL(string: "https://source.unsplash.com/random/\(size)x\(size)") else {
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
      guard let data = data else {
        return
      }
      DispatchQueue.main.async {
        let image = UIImage(data: data)
        self?.cachedImage = image
        self?.callback?(image)
        self?.callback = nil
        completion?(image)
      }
    }
    task.resume()
  }
  
  
}


//https://youbidan-project.tistory.com/148
