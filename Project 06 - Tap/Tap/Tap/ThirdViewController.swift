//
//  ThirdViewController.swift
//  Tap
//
//  Created by jc.kim on 4/22/22.
//

import UIKit

class ThirdViewController: UIViewController {
    let popupView = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        
        popupView.setTitle("popupView", for: .normal)
        popupView.setTitleColor(.white, for: .normal)
        popupView.backgroundColor = .blue
        popupView.addTarget(self, action: #selector(pop), for: .touchUpInside)
        popupView.frame = CGRect(x: 0, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2)
        popupView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        popupView.layer.cornerRadius = 20
        self.view.addSubview(popupView)
    }
    
    @objc func pop() {
        self.navigationController?.popViewControllerFromTop(view: popupView)
    }
    
}
