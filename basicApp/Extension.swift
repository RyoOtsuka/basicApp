//
//  Extension.swift
//  basicApp
//
//  Created by 大塚　良 on 2019/06/26.
//  Copyright © 2019 Ryo Otsuka. All rights reserved.
//

import UIKit


extension UIViewController{
    
    func showAlert(withTitle title: String?, message: String?, actions: [UIAlertAction] = [], completion:  (() -> Swift.Void)? = nil, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if (actions.count == 0) {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handler))
        } else {
            actions.forEach({alert.addAction($0)})
        }
        
        present(alert, animated: true, completion: completion)
        // 20秒アクションがなければ閉じる
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 20) { [weak alert] in
            alert?.dismiss(animated: true, completion: nil)
        }
    }
}
