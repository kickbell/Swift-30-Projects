//
//  ViewController.swift
//  RxComponent
//
//  Created by jc.kim on 8/15/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        rightBarButtonItem.rx.tap
            .subscribe(onNext: {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController {
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
    
}


