//
//  ListTimelineViewController.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/12.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import TwitterKit

class ListTimelineViewController: TWTRTimelineViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient(userID: TwitterTools.userID())
        self.dataSource = TWTRUserTimelineDataSource(screenName: "TimeLine", userID: TwitterTools.userID(), apiClient: client, maxTweetsPerRequest: 10, includeReplies: false, includeRetweets: false)
    }
}
