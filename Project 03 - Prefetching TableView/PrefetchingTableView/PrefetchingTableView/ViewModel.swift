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
  
  private var cachedImage: UIImage?
  
  func downloadImage(completion: @escaping (UIImage?) -> Void) {
    if let image = cachedImage {
      completion(image)
      return
    }
    
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
        print(image.debugDescription)
        self?.cachedImage = image
        completion(image)
      }
    }
    task.resume()
  }
  
  
}
