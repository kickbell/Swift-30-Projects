//
//  ViewController.swift
//  DynamicChangeAppIcon
//
//  Created by jc.kim on 6/24/22.
//

import UIKit

enum Icon: String, CaseIterable {
    case primary    = "AppIcon"
    case blue       = "AppIcon-Blue"
    case green      = "AppIcon-Green"
    case orange     = "AppIcon-Orange"
    case purple     = "AppIcon-Purple"
    case pink       = "AppIcon-Pink"
    case teal       = "AppIcon-Teal"
    case yellow     = "AppIcon-Yellow"
}

class ViewController: UIViewController {
    
    @IBAction func tap(_ sender: UIButton) {
        guard let icon = Icon.allCases.randomElement() else { return }
        changeIcon(to: icon)
    }
    
    func changeIcon(to icon: Icon) {
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        
        let iconName: String? = (icon != .primary) ? icon.rawValue : nil
        
        UIApplication.shared.setAlternateIconName(iconName, completionHandler: { (error) in
            if let error = error {
                print("App icon failed to change due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully")
            }
        })
    }
    
}


