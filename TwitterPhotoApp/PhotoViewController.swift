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
    var folderNames = [String]()
    
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
        //Realm呼び出し
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData() {
        let folders = Folder.getAll()
        folderNames = folders.map { $0.name }
        self.photoTableView.reloadData()
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
                self.setData()
            } else {
                self.errorAlert(title: "エラー", message: "そのフォルダは既に存在します")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        alert.addTextField { (textField) in textField.placeholder = "例:犬 可愛い" }
        present(alert, animated: true, completion: nil)
    }
    func errorAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath) as! FolderTableViewCell
        cell.folderLabel.text = folderNames[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "編集") {
            (action, indexPath) in
            let alert = UIAlertController(title: "フォルダ名変更", message: "新しいフォルダ名を入力してください", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                let textField = alert.textFields?[0]
                let nowText = self.folderNames[indexPath.row]
                let updateText = textField!.text!
                if !Folder.checkExistFolder(name: nowText) || !Folder.checkExistFolder(name: updateText) {
                    Folder.updateName(name: nowText, newName: updateText)
                    self.setData()
                } else {
                    self.errorAlert(title: "エラー", message: "そのフォルダは既に存在します")
                }
            })
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            alert.addAction(cancelAction)
            alert.addTextField { (textField) in }
            self.present(alert, animated: true, completion: nil)
        }
        let delete = UITableViewRowAction(style: .normal, title: "削除") {
            (action, indexPath) in
            Folder.delete(name: self.folderNames[indexPath.row])
            self.folderNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
        edit.backgroundColor = UIColor.orange
        delete.backgroundColor = UIColor.red
        
        return [delete, edit]
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        photoTableView.setEditing(editing, animated: animated)
    }
}
