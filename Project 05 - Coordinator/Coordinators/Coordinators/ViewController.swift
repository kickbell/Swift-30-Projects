//
//  ViewController.swift
//  Coordinators
//
//  Created by ios on 2022/04/06.
//

import UIKit

class ViewController: UIViewController, Storyboared {
    
    weak var coordinator: MainCoordinator?
    
    @IBAction func BuyTapped(_ sender: UIButton) {
        coordinator?.buySubscription()
    }
    
    @IBAction func CreateAccountTapped(_ sender: UIButton) {
        coordinator?.createAccount()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

