//
//  LoginViewController.swift
//  basicApp
//
//  Created by 大塚　良 on 2019/06/26.
//  Copyright © 2019 Ryo Otsuka. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    let loginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ログイン"
        label.textColor = UIColor.black
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "メールアドレスを入力してください"
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "パスワードを入力してください"
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitle("ログイン", for: UIControl.State.normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        button.setTitle("キャンセル", for: UIControl.State.normal)
        return button
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        self.view.addSubview(loginView)
        loginView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loginView.widthAnchor.constraint(equalToConstant: 340).isActive = true
        loginView.heightAnchor.constraint(equalTo: loginView.widthAnchor).isActive = true
        loginView.layer.cornerRadius = 10.0
        
        loginView.addSubview(loginLabel)
        loginLabel.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        loginLabel.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 10).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        loginView.addSubview(emailTextField)
        emailTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: loginView.centerYAnchor, constant: -10).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        loginView.addSubview(passwordTextField)
        passwordTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        loginView.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(pushLogin), for: UIControl.Event.touchUpInside)
        loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginButton.layer.cornerRadius = 10.0
        
        loginView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(pushCancel), for: UIControl.Event.touchUpInside)
        cancelButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -5).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @objc func pushCancel(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pushLogin(){
        
        if Auth.auth().currentUser != nil{
            
            print("ログイン済み")
        }else{
            
            guard let email = emailTextField.text, let password = passwordTextField.text else { return }
            
            Auth.auth().signIn(withEmail: email, password: password){ (user, error) in
                if error != nil{
                    print(error)
                    self.errorLogin()
                }else{
                    print("successfully sigin")
                    self.completedLogin()
                }
            }
        }
    }
    
    func completedLogin() {
        
        showAlert(withTitle: "ログイン完了", message: "ログインに成功しました")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.insertTabToViewControllers()
    }
    
    func errorLogin(){
        showAlert(withTitle: "ログインエラー", message: "記載情報が間違えています")
    }
}
