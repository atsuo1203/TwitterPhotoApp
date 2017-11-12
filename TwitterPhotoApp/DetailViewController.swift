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
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var imageURLs = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        getRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getRequest() {
        let client = TWTRAPIClient()
        let endpoint = "https://api.twitter.com/1.1/search/tweets.json"
        let params = [
            "q": self.navigationItem.title! + " filter:images exclude:retweets ",
            "lang": "ja",
            "count": "10",
            ]
        var clientError : NSError?
        let request = client.urlRequest(withMethod: "GET", url: endpoint, parameters: params, error: &clientError)
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
            } else{
                let json = JSON(data: data!)
                for tweet in json["statuses"].array! {
                    //print(tweet["entities"]["media"][0]["expanded_url"].string!)
                    if let imageURL = tweet["entities"]["media"][0]["media_url"].string {
                        self.imageURLs.append(imageURL)
                        self.mainCollectionView.reloadData()
                    }
                }
            }}
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageURLs.count
    }
    
    //cellのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 100
        let height: CGFloat = 120
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.mainCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        let url = URL(string: self.imageURLs[indexPath.row])!
        let imageData = try? Data.init(contentsOf: url)
        cell.imageView.image = UIImage(data: imageData!)
        return cell
    }
    
    
}
