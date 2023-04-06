//
//  ImageCache.swift
//  GithubSearch
//
//  Created by jc.kim on 4/6/23.
//

import UIKit
import RxSwift
import RxCocoa

public class ImageCache {
  
  public static let publicCache = ImageCache()
  
  private var placeholderImage = UIImage(systemName: "rectangle")!
  
  private let cachedImages = NSCache<NSURL, UIImage>()
  
  public final func image(url: NSURL) -> UIImage? {
    return cachedImages.object(forKey: url)
  }
  
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  final func load(url: NSURL) -> Observable<UIImage?> {
    if let cachedImage = image(url: url) {
      return Observable.just(cachedImage)
    }
    
    let request = URLRequest(url: url as URL)
    
    return session.rx.data(request: request)
      .map { UIImage(data: $0) }
      .do(onNext: { image in
        guard let image = image else { return }
        self.cachedImages.setObject(image, forKey: url)
      })
      .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
      .catchAndReturn(placeholderImage)
  }
  
}
