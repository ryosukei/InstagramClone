//
//  PostViewController.swift
//  Instagram
//
//  Created by 青野　凌介 on 2021/10/22.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController {
    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextField!
    @IBAction func handlePostBtn(_ sender: Any) {
        // 画像をjpegにする
        let imageData = image.jpegData(compressionQuality: 0.75)
        // 画像と投稿データの保存場所を定義
        let postRef = Firestore.firestore().collection("posts").document()
        let imageRef = Storage.storage().reference().child("images").child(postRef.documentID + ".jpg")
        SVProgressHUD.show()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(imageData!, metadata: metadata){(metadata, error) in
            if error != nil{
                print(error!)
                SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                UIApplication.shared.windows.first{$0.isKeyWindow}?.rootViewController?.dismiss(animated: true, completion: nil)
                return
            }
            // firestoreに投稿データを保存
            let name = Auth.auth().currentUser?.displayName
            let postDic = [
                "name": name!,
                "caption": self.textView.text!,
                "date": FieldValue.serverTimestamp(),
            ] as [String: Any]
            postRef.setData(postDic)
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            // 投稿処理が完了したので先頭画面に戻る
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func handleCancelBtn(_ sender: Any) {
        // 加工画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
