//
//  DetailViewController.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/12.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.navigationItem.title!)
        getSantaGirls()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSantaGirls() {
        let client = TWTRAPIClient()
        let endpoint = "https://api.twitter.com/1.1/search/tweets.json"
        let params = [
            "q": "#サンタコス -割 -Set -メイド風 -アクセント -点セット -お買い得 -#子供 -#マンチカン -#サンタ衣装 -#コスチューム -#sugar filter:images exclude:retweets ",
            "lang": "ja",
            "count": "5",
            ]
        var clientError : NSError?
        let request = client.urlRequest(withMethod: "GET", url: endpoint, parameters: params, error: &clientError)
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
            } else{
                let json = JSON(data: data!)
                for tweet in json["statuses"].array! {
                    if let imageURL = tweet["entities"]["media"][0]["media_url"].string {
                        //                        self.images.append(imageURL)
                        //                        self.collectionView.reloadData()
                        print(imageURL)
                    }
                }}}
    }
}
