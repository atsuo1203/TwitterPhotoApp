//
//  TwitterTools.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/11.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterTools: NSObject {
    static func logout(){
        let store = Twitter.sharedInstance().sessionStore
        if let userId = store.session()?.userID {
            store.logOutUserID(userId)
            print("logout")
        }
    }
    static func logout(user_id: String){
        Twitter.sharedInstance().sessionStore.logOutUserID(user_id)
        print("logout")
    }
    static func userID() -> String {
        guard let id = Twitter.sharedInstance().sessionStore.session()?.userID else {
            return ""
        }
        return id
    }
}
