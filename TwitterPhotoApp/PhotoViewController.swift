//
//  PhotoViewController.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/12.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ナビゲーションアイテム設定
        self.navigationItem.title = "フォトビューワ"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< 戻る", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_add"), style: .plain, target: self, action: #selector(self.alert))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func alert(){
        let alert = UIAlertController(title: "ファイル作成", message: "見たい写真のワードを入力してください", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let textField = alert.textFields?[0]
            let text = textField!.text!
            print(text)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        alert.addTextField { (textField) in
            textField.placeholder = "例:犬 可愛い"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}
