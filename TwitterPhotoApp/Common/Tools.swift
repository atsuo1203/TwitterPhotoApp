//
//  Tools.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/12.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import SafariServices

class Tools: NSObject {
    static func nextStoryboard(next: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: next)
    }
    
    static func showWebView(viewController: AnyObject, targetURL: String) {
        let url = URL(string: targetURL)!
        let webView = SFSafariViewController(url: url)
        viewController.present(webView, animated: true, completion: nil)
    }
}
