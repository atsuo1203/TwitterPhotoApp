//
//  Tools.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/12.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class Tools: NSObject {
    static func nextStoryboard(next: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: next)
    }
}
