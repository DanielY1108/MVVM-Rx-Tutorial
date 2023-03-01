//
//  UINavigationController.swift
//  MVVM-Rx-Tutorial
//
//  Created by JINSEOK on 2023/03/01.
//

import UIKit

extension UINavigationController {
    
    func setupNavigationBarAppearance() {
        let appearnce = UINavigationBarAppearance()
        appearnce.configureWithDefaultBackground()
        
        navigationBar.standardAppearance = appearnce
        navigationBar .compactAppearance = appearnce
        navigationBar.scrollEdgeAppearance = appearnce
    }
    
}
