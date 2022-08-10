//
//  PlayerMainViewController.swift
//  UIExample
//
//  Created by jc.kim on 8/9/22.
//

import UIKit

class PlayerView: UIView {
    
    @IBOutlet weak var topStackView: UIStackView!
    
    
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    
    @IBOutlet weak var bottomStackView: UIStackView!
    
    var callBack: (()->())?
    
    var callBackDescrition: (()->())?
    
    @IBAction func push(_ sender: Any) {
        callBack?()
    }
    
    @IBAction func presentDescrition(_ sender: Any) {
        callBackDescrition?()
    }
}

// FIXME: - 대충 어찌저찌된거같긴한데..
//액션 이벤트 따로.
//스와이프따로.
//히든처리 따로 해서 구분을 해놓아야겠다.

class PlayerMainViewController: UIViewController {
    
    @IBOutlet weak var miniPlayerVarView: PlayerView!
    
    @IBOutlet weak var heightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var safeToTopLayoutConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeLeft.direction = .left
        swipeRight.direction = .right
        swipeUp.direction = .up
        swipeDown.direction = .down
        self.miniPlayerVarView.gestureRecognizers = [swipeUp, swipeDown, swipeLeft, swipeRight]
        
        
        
        
        
        
        miniPlayerVarView.callBack = {
            
            let detailVC = DetailViewController()
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        miniPlayerVarView.callBackDescrition = {
            let detailVC = DescritionViewController()
            self.present(detailVC, animated: true)
        }
    }
    
    var isExpand = false
    
    @objc func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        print("swipeLeft...", sender.direction)
    }
    
    @objc func swipeRight() {
        print("swipeRight...")
    }
    
    @objc func swipeUp() {
        print("swipeUp...")
        tap()
    }
    
    @objc func swipeDown() {
        print("swipeDown...")
        tap()
    }
    
    @objc func tap() {

        if !isExpand {
            self.heightLayoutConstraint.priority = .defaultLow
            self.safeToTopLayoutConstraint.priority = .defaultHigh
        } else {
            self.heightLayoutConstraint.priority = .defaultHigh
            self.safeToTopLayoutConstraint.priority = .defaultLow
        }
        
        
        isExpand = !isExpand
        
        let tabbar = self.tabBarController?.tabBar
        let offset = self.isExpand ? tabbar!.frame.size.height : -tabbar!.frame.size.height

        
        UIView.animate(withDuration: 0.3) {
            self.miniPlayerVarView.topStackView.isHidden = !self.isExpand
            self.miniPlayerVarView.titleStackView.isHidden = self.isExpand
            self.miniPlayerVarView.button1.isHidden = self.isExpand
            self.miniPlayerVarView.button2.isHidden = self.isExpand
            self.miniPlayerVarView.bottomStackView.isHidden = !self.isExpand

            tabbar?.frame = tabbar?.frame.offsetBy(dx: 0, dy: offset) ?? CGRect.zero
            tabbar?.isHidden = self.isExpand

            self.miniPlayerVarView.topStackView.alpha = !self.isExpand ? 0.0 : 1.0
            self.miniPlayerVarView.bottomStackView.alpha = !self.isExpand ? 0.0 : 1.0

            
            
            self.view.layoutIfNeeded()
            
        } completion: { b in
            
            
        }
        
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
