//
//  EnterGroupViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/04/07.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class SEnetergroupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupPassTextField: UITextField!
    
    var database: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        
        groupNameTextField.delegate = self
        groupPassTextField.delegate = self
    }
    
    @IBAction func EnterGroup(_ sensder: UIButton) {
        
        let HV = self.storyboard?.instantiateViewController(withIdentifier: "makegroup") as! TmakegroupViewController
//        let groupName = HV.groupNameTextField.text
//        let collection = database.collection(groupName!)
//        let groupNameCollection = database.collectionGroup(HV.groupNameTextField.text!)
        Firestore.firestore().collection("group").document("className").getDocument{ (snap, error) in
            if let error = error {
                fatalError("\(error)")
            }
            guard let data = snap?.data() else { return }
            print(data["className"]!)
            if self.groupNameTextField.text! == data["className"] as! String {
                if self.groupPassTextField.text! != data["classPass"] as! String {
                    print("画面遷移nameOK/passだめ")
                } else {
                let HV = self.storyboard?.instantiateViewController(withIdentifier: "main") as! HomeViewController
                self.present(HV, animated: true, completion: nil)
                print("画面遷移しましょう！")
                }
            } else {
                print("画面遷移NG")
            }
        }
        
        Firestore.firestore().collection("group").document("groupDocument").getDocument{ (snap, error) in
            if let error = error {
                fatalError("\(error)")
            }
            guard let data = snap?.data() else { return }
            print(data["pass"]!)
            if self.groupPassTextField.text! == data["pass"] as! String {
                if self.groupNameTextField.text! != data["name"] as! String {
                    print("画面遷移PassOK/nameだめ")
                }else {
                let HV = self.storyboard?.instantiateViewController(withIdentifier: "main") as! HomeViewController
                self.present(HV, animated: true, completion: nil)
                print("画面遷移しましょう！")
                }
            } else {
                print("画面遷移NG")

            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
