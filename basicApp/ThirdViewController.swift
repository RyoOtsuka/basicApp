//
//  ThirdViewController.swift
//  basicApp
//
//  Created by 大塚　良 on 2019/06/26.
//  Copyright © 2019 Ryo Otsuka. All rights reserved.
//

import UIKit
import Firebase


class ThirdViewController: UIViewController {
    
    var label1: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ロード中..."
        return label
    }()
    
    var label2: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ロード中..."
        return label
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        self.view.addSubview(label1)
        label1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -30).isActive = true
        
        self.view.addSubview(label2)
        label2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30).isActive = true
        
        fetchUserData()
    }
    
    func fetchUserData() {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("users").child(userID)
        ref.queryOrderedByKey().observeSingleEvent(of: .value, with: {
            (snapshot) in
            
            let value = snapshot.value as? NSDictionary
                
            let email = value?["email"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
                
            self.label1.text = name
            self.label2.text = email
        })
    }
}
