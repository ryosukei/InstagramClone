//
//  PostData.swift
//  Instagram
//
//  Created by 青野　凌介 on 2021/10/25.
//

import UIKit
import Firebase

class PostData: NSObject{
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var comments: [String:String]?
    var isLiked: Bool = false
    
    init(document: QueryDocumentSnapshot){
        self.id = document.documentID
        let postDic = document.data()
        self.name = postDic["name"] as? String
        self.caption = postDic["caption"] as? String
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as?[String]{
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid{
            // ライクの中に自分のidがあるかどうかチェック
            if self.likes.firstIndex(of: myid) != nil{
                self.isLiked = true
            }
        }
        if let comments = postDic["comments"] as?[String:String]{
            self.comments = comments
        }
    }
}
