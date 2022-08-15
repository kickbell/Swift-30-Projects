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
        
        oneMonthButton.rx.tap
            .map { _ in Month.one }
            .bind(to: monthSubject)
            .disposed(by: disposeBag)
        
        threeMonthButton.rx.tap
            .map { _ in Month.three }
            .bind(to: monthSubject)
            .disposed(by: disposeBag)
        
        sixMonthButton.rx.tap
            .map { _ in Month.six }
            .bind(to: monthSubject)
            .disposed(by: disposeBag)
        
        monthSubject.map { $0 == .one }
            .bind(to: oneMonthButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        monthSubject.map { $0 == .three }
            .bind(to: threeMonthButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        monthSubject.map { $0 == .six }
            .bind(to: sixMonthButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        
        
        //period
        
        latestPeriodButton.rx.tap
            .map { _ in Period.latest }
            .bind(to: periodSubject)
            .disposed(by: disposeBag)
        
        oldestPeriodButton.rx.tap
            .map { _ in Period.oldest }
            .bind(to: periodSubject)
            .disposed(by: disposeBag)
        
        periodSubject.map { $0 == .latest }
            .bind(to: latestPeriodButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        periodSubject.map { $0 == .oldest }
            .bind(to: oldestPeriodButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        
        
        
        Observable.combineLatest (
            monthSubject.map { $0 != .none },
            periodSubject.map { $0 != .none }
        ) { $0 && $1 }
        .bind(to: confirmButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        
        
    }
    
    
}


