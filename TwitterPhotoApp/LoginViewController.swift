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
    @IBOutlet weak var notLoginView: UIView!
    
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
        
        //ジェスチャーセット
        setGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ジェスチャーをセット
    func setGesture(){
        let notLoginGesture = UITapGestureRecognizer(target: self, action: #selector(self.notLogoutTapped))
        self.notLoginView.addGestureRecognizer(notLoginGesture)
    }
    
    //notLoginViewを押した時の処理
    @objc func notLogoutTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let folderViewController = storyboard.instantiateViewController(withIdentifier: "Folder") as! FolderViewController
        let navigationController = UINavigationController(rootViewController: folderViewController)
        navigationController.title = "フォトビューワ"
        self.present(navigationController, animated: true, completion: nil)
    }


}

