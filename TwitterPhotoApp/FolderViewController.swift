//
//  mainViewController.swift
//  TwittermainApp
//
//  Created by Atsuo Yonehara on 2017/11/12.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit

class FolderViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    var folderNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ナビゲーションアイテム設定
        self.navigationItem.title = "フォトビューワ"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_add"), style: .plain, target: self, action: #selector(self.alert))
        //テーブルdelegate設定
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.register(UINib.init(nibName: "FolderCell", bundle: nil), forCellReuseIdentifier: "FolderCell")
        //サイズ調整
        self.mainTableView.estimatedRowHeight = 200
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
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
        self.mainTableView.reloadData()
    }
    
    //+ボタンを押した時の処理
    @objc func alert(){
        let alert = UIAlertController(title: "ファイル作成", message: "見たい写真のワードを入力してください", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let textField = alert.textFields?[0]
            let text = textField!.text!
            //Folderが無ければ作成、あればalert
            let check = Folder.checkExistFolder(name: text)
            if  !check.0 {
                Folder.create(name: text).put()
                self.setData()
            } else {
                self.errorAlert(title: "エラー", message: check.1)
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

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath) as! FolderTableViewCell
        cell.folderLabel.text = folderNames[indexPath.row]
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next = Tools.nextStoryboard(next: "Detail") as! DetailViewController
        next.navigationItem.title = folderNames[indexPath.row]
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "編集") {
            (action, indexPath) in
            let alert = UIAlertController(title: "フォルダ名変更", message: "新しいフォルダ名を入力してください", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                let textField = alert.textFields?[0]
                let nowText = self.folderNames[indexPath.row]
                let updateText = textField!.text!
                let check = Folder.checkExistFolder(name: nowText)
                let check2 = Folder.checkExistFolder(name: updateText)
                if !check.0 || !check2.0 {
                    Folder.updateName(name: nowText, newName: updateText)
                    self.setData()
                } else {
                    self.errorAlert(title: "エラー", message: check.1)
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
        mainTableView.setEditing(editing, animated: animated)
    }
}
