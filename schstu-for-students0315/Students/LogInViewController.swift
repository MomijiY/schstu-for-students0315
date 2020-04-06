//
//  LogInViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/15.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {

     var acount: FirebaseApp!
    
    var auth: Auth?
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    var isFirst = true // 最初の処理かどうか
    
    @IBAction private func didTapSignUpButton() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let name = nameTextField.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let user = result?.user {
                let req = user.createProfileChangeRequest()
                req.displayName = name
                req.commitChanges() { [weak self] error in
                    guard let self = self else { return }
                    if error == nil {
                        user.sendEmailVerification() { [weak self] error in
                            guard let self = self else { return }
                            if error == nil {
                                // 仮登録完了画面へ遷移する処理
                                // サインアップ完了のフラグを保持する
                                UserDefaults.standard.set(true, forKey: "appSignUpStatusKey")
                                UserDefaults.standard.synchronize()
                            }
                            self.showErrorIfNeeded(error)
                        }
                    }
                    self.showErrorIfNeeded(error)
                }
            }
            self.showErrorIfNeeded(error)
        }
        // サインアップ完了のフラグを保持する
        UserDefaults.standard.set(true, forKey: "appSignUpStatusKey")
        // ユーザー名を保存する
        UserDefaults.standard.set(name, forKey: "userNameKey")
        UserDefaults.standard.synchronize()
        if (email == "" || password == "" || name == "") {
            let message = "全てのフォームに記入して下さい。"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard errorOrNil != nil else { return }
        let message = "エラーが起きました" // ここは後述しますが、とりあえず固定文字列
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    // AccountViewControllerの想定です
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth = Auth.auth()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
