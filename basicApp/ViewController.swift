//
//  ViewController.swift
//  basicApp
//
//  Created by 大塚　良 on 2019/06/26.
//  Copyright © 2019 Ryo Otsuka. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pushLogout))
    }

    @objc func pushLogout(){
        
        if Auth.auth().currentUser != nil{
            do{
                try Auth.auth().signOut()
                showAlert(withTitle: nil, message: "ログアウトにしました")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.startTutorial()
                
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
}

