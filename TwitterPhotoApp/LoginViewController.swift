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
        // Do any additional setup after loading the view, typically from a nib.
        if Twitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            print("Is Login")
        }else {
            print("In not login")
        }
        let logInButton = TWTRLogInButton { (session, error) in
            if session != nil {
//                print("aaaaaaaaaaaaaaaaaaaaaaaaa")
//                print(session?.userName ?? "session")
                let story = self.storyboard
                let next = story?.instantiateViewController(withIdentifier: "Top") as! TopViewController
                self.navigationController?.pushViewController(next, animated: true)
            } else {
//                print("bbbbbbbbbbbbbbbbbbbbbbbb")
//                print(error?.localizedDescription ?? "error")
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

