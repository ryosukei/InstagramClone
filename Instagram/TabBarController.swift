//
//  TabBarController.swift
//  Instagram
//
//  Created by 青野　凌介 on 2021/10/22.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        self.tabBar.barTintColor = UIColor(red:0.96,green: 0.91,blue: 0.87,alpha: 1)
        // UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理する。
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    // タブバーのアイコンがタップされた時に呼ばれるdelegateメソッドを処理する。
    // true→タブ切り替えが行われる
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if(viewController is ImageSelectViewController){
            // ImageSelectViewControllerは、タブ切り替えではなくモーダル画面遷移する
            let imageSelectViewController = storyboard!.instantiateViewController(withIdentifier: "ImageSelect")
            present(imageSelectViewController, animated: true)
            return false
        }else{
            return true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        // ログインしてない時
        if Auth.auth().currentUser == nil{
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
        }
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
