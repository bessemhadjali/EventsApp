//
//  UIViewController+Extentions.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 13/10/2020.
//

import UIKit

extension UIViewController {
    
    static func instanctiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let ctrl = storyboard.instantiateViewController(withIdentifier: "\(T.self)") as! T
        return ctrl
    }
}
