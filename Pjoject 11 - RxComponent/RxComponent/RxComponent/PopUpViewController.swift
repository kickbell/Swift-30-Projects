//
//  PopUpViewController.swift
//  RxComponent
//
//  Created by jc.kim on 8/15/22.
//

import UIKit
import RxSwift
import RxCocoa

class PopUpViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    enum Month {
        case one
        case three
        case six
        case none
    }
    
    enum Period {
        case latest
        case oldest
        case none
    }
    
    @IBOutlet weak var oneMonthButton: UIButton!
    @IBOutlet weak var threeMonthButton: UIButton!
    @IBOutlet weak var sixMonthButton: UIButton!
    
    @IBOutlet weak var latestPeriodButton: UIButton!
    @IBOutlet weak var oldestPeriodButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    let monthSubject = BehaviorSubject<Month>.init(value: .none)
    let periodSubject = BehaviorSubject<Period>.init(value: .none)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //month
        
        Observable.merge(
            oneMonthButton.rx.tap.map { _ in Month.one },
            threeMonthButton.rx.tap.map { _ in Month.three },
            sixMonthButton.rx.tap.map { _ in Month.six }
        )
        .bind(to: monthSubject)
        .disposed(by: disposeBag)
        
        
        //위에타입은 같은데 아래가 다르다. 튜플
        //두가지방법. 1. 머지 방법 또는
        
        Observable.merge(
            monthSubject.map { ($0 == .one, self.oneMonthButton) },
            monthSubject.map { ($0 == .three, self.threeMonthButton) },
            monthSubject.map { ($0 == .six, self.sixMonthButton) }
        )
        .subscribe(onNext: { bool, button in
            button.isSelected = bool
        })
        .disposed(by: disposeBag)
        
        //period
        
        Observable.merge(
            latestPeriodButton.rx.tap.map { _ in Period.latest },
            oldestPeriodButton.rx.tap.map { _ in Period.oldest }
        )
        .bind(to: periodSubject)
        .disposed(by: disposeBag)
        
        //두가지방법. 2. 플랫맵 방법
        periodSubject.flatMap {
            Observable.from([
                (bool: $0 == .latest, button: self.latestPeriodButton),
                (bool: $0 == .oldest, button: self.oldestPeriodButton)
            ])
        }
        .subscribe(onNext: { pair in
            pair.button.isSelected = pair.bool
        })
        .disposed(by: disposeBag)
        
//        periodSubject.map { $0 == .latest }
//            .bind(to: latestPeriodButton.rx.isSelected)
//            .disposed(by: disposeBag)
//
//        periodSubject.map { $0 == .oldest }
//            .bind(to: oldestPeriodButton.rx.isSelected)
//            .disposed(by: disposeBag)
        
        Observable.combineLatest (
            monthSubject.map { $0 != .none },
            periodSubject.map { $0 != .none }
        ) { $0 && $1 }
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    
}


