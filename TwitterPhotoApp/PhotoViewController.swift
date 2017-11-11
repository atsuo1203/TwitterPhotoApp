//
//  PhotoViewController.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/12.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ナビゲーションアイテム設定
        self.navigationItem.title = "フォトビューワ"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< 戻る", style: .plain, target: self, action: #selector(self.back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_add"), style: .plain, target: self, action: #selector(self.alert))
        //テーブルdelegate設定
        self.photoTableView.delegate = self
        self.photoTableView.dataSource = self
        self.photoTableView.register(UINib.init(nibName: "FolderCell", bundle: nil), forCellReuseIdentifier: "FolderCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //戻るを押した時の処理
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //+ボタンを押した時の処理
    @objc func alert(){
        let alert = UIAlertController(title: "ファイル作成", message: "見たい写真のワードを入力してください", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let textField = alert.textFields?[0]
            let text = textField!.text!
            //Folderが無ければ作成、あればalert
            if !Folder.checkExistFolder(name: text) {
                Folder.create(name: text).put()
            } else {
                let alert2 = UIAlertController(title: "エラー", message: "そのフォルダは既に存在します", preferredStyle: .alert)
                let defaultAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert2.addAction(defaultAction2)
                self.present(alert2, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        alert.addTextField { (textField) in textField.placeholder = "例:犬 可愛い" }
        present(alert, animated: true, completion: nil)
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Folder.getAll().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath) as! FolderTableViewCell
        cell.folderLabel.text = "犬"
        return cell
    }
}
