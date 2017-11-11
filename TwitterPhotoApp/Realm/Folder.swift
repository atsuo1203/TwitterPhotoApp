//
//  Folder.swift
//  TwitterPhotoApp
//
//  Created by Atsuo Yonehara on 2017/11/12.
//  Copyright © 2017年 Atsuo Yonehara. All rights reserved.
//

import UIKit
import RealmSwift

class Folder: Object {
    @objc dynamic var key = ""
    @objc dynamic var index: Int = 0
    @objc dynamic var name = ""

    override class func primaryKey() -> String {
        return "key"
    }
    
    //名前から主キーを取得する
    static func getKey(name: String) -> String {
        let folders = Folder.getAll()
        var key = ""
        folders.forEach { folder in
            if folder.name == name {
                key = folder.key
            }
        }
        return key
    }
    
    //Folderを作成する(putと組み合わせて使う)
    static func create(name: String) -> Folder {
        let folder = Folder()
        folder.key = UUID().uuidString
        folder.index = nextIndex()
        folder.name = name
        return folder
    }
    
    //Folderを取得する
    static func getFolder(name: String) -> Folder {
        let realm = try! Realm()
        let key = Folder.getKey(name: name)
        return realm.object(ofType: self, forPrimaryKey: key)!
    }

    //Folderの順番を保持するために利用する
    static func nextIndex() -> Int {
        return (getAll().last?.index ?? -1) + 1
    }

    //Folder全取得
    static func getAll() -> [Folder] {
        let realm = try! Realm()
        let folders = realm.objects(Folder.self).sorted(byKeyPath: "index")
        return folders.map { $0 }
    }
    
    //create().put()という形で利用する
    func put() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
    //Folder削除
    static func delete(name: String) {
        let realm = try! Realm()
        let key = Folder.getKey(name: name)
        if let entry = realm.object(ofType: Folder.self, forPrimaryKey: key as AnyObject) {
            try! realm.write {
                realm.delete(entry)
            }
        }
    }
    
    //Folder全削除
    static func deleteAll() {
        Folder.getAll().forEach {
            Folder.delete(name: $0.name)
        }
    }

    //Folderの名前を更新する
    static func updateName(name: String, newName: String) {
        let realm = try! Realm()
        let folder = Folder.getFolder(name: name)

        try! realm.write {
            folder.name = newName
        }
    }
    
    //既にFolderがあるかどうかチェック
    static func checkExistFolder(name: String) -> Bool {
        let folders = getAll()
        var isExist = false
        folders.forEach { (folder) in
            if folder.name == name {
                isExist = true
            }
        }
        return isExist
    }
}

