//
//  CommentViewController.swift
//  Instagram
//
//  Created by 青野　凌介 on 2021/10/25.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    var postId: String!
    @IBOutlet weak var textFieldView: UITextField!
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func handleSubmitButton(_ sender: Any) {
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        if let submitText = textFieldView.text {
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postId)
            // ユーザーの名前を取得
            let userName = Auth.auth().currentUser?.displayName
            let commentData:Dictionary = ["name":userName,"content":submitText]
            // 更新データを作成する
            let updateValue = FieldValue.arrayUnion([commentData])
            postRef.updateData(["comments":updateValue])
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            // 投稿処理が完了したので先頭画面に戻る
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }else{
            SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
            return
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
