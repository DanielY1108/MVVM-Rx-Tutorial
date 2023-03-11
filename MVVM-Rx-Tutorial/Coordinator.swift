//
//  Coordinator.swift
//  MVVM-Rx-Tutorial
//
//  Created by JINSEOK on 2023/03/01.
//

import UIKit

class Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainViewController = MainViewController(viewModel: MainViewModel(ariticleServise: ArticleService()))
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.setupNavigationBarAppearance()
    
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
