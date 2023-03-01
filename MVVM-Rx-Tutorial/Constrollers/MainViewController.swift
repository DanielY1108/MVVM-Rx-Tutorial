//
//  MainViewController.swift
//  MVVM-Rx-Tutorial
//
//  Created by JINSEOK on 2023/03/01.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    // MARK: - Configure
    private func configUI() {
        self.view.backgroundColor = .systemBackground
    }

}
