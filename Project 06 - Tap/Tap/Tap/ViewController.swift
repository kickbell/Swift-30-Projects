//
//  ViewController.swift
//  Tap
//
//  Created by jc.kim on 4/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        nextButton.rx.tap
//            .flatMapLatest(Service.requestRx)
            .flatMapLatest(Service.requestRxImage)
            .debug()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { value in
//                print(value.map { $0.id }.reduce(0, +))
//                guard value != [] else { return }
//                if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
//                    self.present(detailVC, animated: true)
//                }
            })
            .disposed(by: disposeBag)
    }
}


extension RxSwift.Reactive where Base: UIViewController {
    public var viewWillAppear: Observable<Bool> {
    return methodInvoked(#selector(UIViewController.viewWillAppear))
       .map { $0.first as? Bool ?? false }
  }
}
