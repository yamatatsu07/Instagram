//
//  CommentViewController.swift
//  Instagram
//
//  Created by 山崎 達也 on 2018/05/13.
//  Copyright © 2018年 tatsuya.yamasaki2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var postData: PostData!

    @IBAction func handlePostButton(_ sender: UIButton) {
        
        let name = Auth.auth().currentUser?.displayName
        let text = textField.text!
        let comment = "\(name!) : \(text)"
        
        // Firebaseに保存するデータの準備
        postData.comments.append(comment)
        
        // 辞書を作成してFirebaseに保存する
        let comments = ["comments": postData.comments]
        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
        postRef.updateChildValues(comments)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 全てのモーダルを閉じる
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
