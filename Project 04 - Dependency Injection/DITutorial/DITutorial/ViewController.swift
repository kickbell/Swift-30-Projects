//
//  ViewController.swift
//  DITutorial
//
//  Created by ios on 2022/04/04.
//

import UIKit
import APIKit


class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 250, height: 50)
        button.center = view.center
        button.setTitle("Tap Me", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
    }

    @objc func didTapButton() {
        let vc = DatailViewController(dataFetchable: FetchService())
        self.present(vc, animated: true)
    }

}

