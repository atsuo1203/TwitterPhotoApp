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
        // Do any additional setup after loading the view.
        
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
        //TwitterTools.logout()
        print("logout")
    }
    @objc func photoTapped(){
        print("photo")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
