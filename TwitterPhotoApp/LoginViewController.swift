//
//  ViewController.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/11.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //認証ボタンを作成して配置
        let logInButton = TWTRLogInButton { (session, error) in
            if session != nil {
                //認証が成功すれば、Topに繊維
                let next = Tools.nextStoryboard(next: "Navi") as! UINavigationController
                self.present(next, animated: true, completion: nil)
            }
        }
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

