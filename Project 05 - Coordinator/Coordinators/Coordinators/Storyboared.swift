//
//  Storyboared.swift
//  Coordinators
//
//  Created by ios on 2022/04/06.
//

import Foundation
import UIKit

protocol Storyboared {
    static func instantiate() -> Self
}

extension Storyboared where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}


