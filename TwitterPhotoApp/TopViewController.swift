//
//  TopViewController.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/11.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import TwitterKit

class TopViewController: UIViewController {
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var photoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定
        setGesture()
        
        let client = TWTRAPIClient()
        client.loadUser(withID: TwitterTools.userID()) { (user, error) -> Void in
            print(user!.profileImageURL)
            print(user!.profileImageLargeURL)
            self.navigationItem.title = user!.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ジェスチャーをセット
    func setGesture(){
        let logoutGesture = UITapGestureRecognizer(target: self, action: #selector(self.logoutTapped))
        self.logoutView.addGestureRecognizer(logoutGesture)
        
        let photoGesture = UITapGestureRecognizer(target: self, action: #selector(self.photoTapped))
        self.photoView.addGestureRecognizer(photoGesture)
        
    }
    
    //ジェスチャーのアクションまとめ
    @objc func logoutTapped(){
        TwitterTools.logout()
        let next = Tools.nextStoryboard(next: "Login") as! LoginViewController
        self.present(next, animated: true, completion: nil)
    }
    @objc func photoTapped(){
        let next = Tools.nextStoryboard(next: "Photo") as! PhotoViewController
        self.navigationController?.pushViewController(next, animated: true)
//        self.present(next, animated: true, completion: nil)
    }
    
}
