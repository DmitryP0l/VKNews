//
//  AuthViewController.swift
//  VKNews
//
//  Created by lion on 28.04.22.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
        view.backgroundColor = .systemBlue
    }

    @IBAction private func signInTap(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

