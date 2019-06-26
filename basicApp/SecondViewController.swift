//
//  SecondViewController.swift
//  basicApp
//
//  Created by 大塚　良 on 2019/06/26.
//  Copyright © 2019 Ryo Otsuka. All rights reserved.
//

import UIKit
import WebKit


class SecondViewController: UIViewController {
    
    static var pushURL: String?
    
    let webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let safeArea = self.view.safeAreaLayoutGuide
        self.view.addSubview(webView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: webView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: safeArea, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: webView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: safeArea, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: webView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: safeArea, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: webView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: safeArea, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
        ])
        
        loadWebView()
    }
    
    func loadWebView(){
        
        if SecondViewController.pushURL == nil{
            let appleURL =  URL(string: "https://www.apple.com/jp/")
            let urlReq = URLRequest(url: appleURL!)
            webView.load(urlReq)
            
        }else{
            let appleURL =  URL(string: SecondViewController.pushURL!)
            let urlReq = URLRequest(url: appleURL!)
            webView.load(urlReq)
        }
    }
}
