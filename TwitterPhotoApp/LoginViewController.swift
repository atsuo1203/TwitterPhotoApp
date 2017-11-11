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
        
        let isLogin = Twitter.sharedInstance().sessionStore.hasLoggedInUsers()
        print(isLogin)
        
        //認証ボタンを作成して配置
        let logInButton = TWTRLogInButton { (session, error) in
            if session != nil {
                print(session?.userName ?? "session")
                let storyboard = self.storyboard
                let next = storyboard?.instantiateViewController(withIdentifier: "Navi") as! UINavigationController
                self.present(next, animated: true, completion: nil)
            } else {
                print(error?.localizedDescription ?? "error")
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

