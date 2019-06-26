//
//  Tutorial4ViewController.swift
//  basicApp
//
//  Created by 大塚　良 on 2019/06/26.
//  Copyright © 2019 Ryo Otsuka. All rights reserved.
//

import UIKit


class Tutorial4ViewController: UIViewController {
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("新規登録へ", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor.black
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ログインへ", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor.black
        return button
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        self.view.backgroundColor = UIColor.purple
        
        self.view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(moveToRegister), for: UIControl.Event.touchUpInside)
        registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.layer.cornerRadius = 10.0
        
        self.view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(moveToLogin), for: UIControl.Event.touchUpInside)
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 10).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.layer.cornerRadius = 10.0
    }
    
    @objc func moveToRegister() {
        
        let registerView = RegisterViewController()
        self.present(registerView, animated: true, completion: nil)
    }
    
    @objc func moveToLogin() {
        
        let loginView = LoginViewController()
        self.present(loginView, animated: true, completion: nil)
    }
}

