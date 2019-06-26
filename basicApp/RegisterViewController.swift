//
//  RegisterViewController.swift
//  basicApp
//
//  Created by 大塚　良 on 2019/06/26.
//  Copyright © 2019 Ryo Otsuka. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    var ref: DatabaseReference?
    
    let registerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "新規登録"
        label.textColor = UIColor.black
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "ニックネームを入力してください"
        return textField
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
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.setTitle("登録", for: UIControl.State.normal)
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
        
        self.view.addSubview(registerView)
        registerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        registerView.widthAnchor.constraint(equalToConstant: 340).isActive = true
        registerView.heightAnchor.constraint(equalTo: registerView.widthAnchor).isActive = true
        registerView.layer.cornerRadius = 10.0
        
        registerView.addSubview(registerLabel)
        registerLabel.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
        registerLabel.topAnchor.constraint(equalTo: registerView.topAnchor, constant: 10).isActive = true
        registerLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        registerView.addSubview(nameTextField)
        nameTextField.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 64).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        registerView.addSubview(emailTextField)
        emailTextField.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        registerView.addSubview(passwordTextField)
        passwordTextField.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        registerView.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(pushRegister), for: UIControl.Event.touchUpInside)
        registerButton.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: registerView.bottomAnchor, constant: -40).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        registerButton.layer.cornerRadius = 10.0
        
        registerView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(pushCancel), for: UIControl.Event.touchUpInside)
        cancelButton.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: registerView.bottomAnchor, constant: -5).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @objc func pushCancel(){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pushRegister(){
        
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if error != nil{
                
                print(error)
                return
            }else{
                print("Successfully signUp")
                self.completedRegisteer()
            }
            
            guard let user = authResult?.user else { return }
            self.ref = Database.database().reference()
            self.ref!.child("users").child(user.uid).setValue(["name": name,"email": email]){
                
                (error:Error?, ref:DatabaseReference) in
                
                if let error = error {
                    
                    print("Data could not be saved: \(error).")
                } else {
                    
                    print("Data saved successfully!")
                }
            }
        }
    }
    
    func completedRegisteer() {
        
        showAlert(withTitle: "登録完了", message: "登録完了いたしました")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.insertTabToViewControllers()
    }
}
