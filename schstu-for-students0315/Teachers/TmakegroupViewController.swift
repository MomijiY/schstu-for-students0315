//
//  TmakegroupViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/04/07.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

var classname = String()

class TmakegroupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupPassTextField: UITextField!
    
    var database: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        groupNameTextField.delegate = self
        groupPassTextField.delegate = self
        
        groupNameTextField.text = UserDefaults.standard.object(forKey: "className") as? String
        groupPassTextField.text = UserDefaults.standard.object(forKey: "classPass") as? String
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        groupNameTextField.text = UserDefaults.standard.object(forKey: "className") as? String
        groupPassTextField.text = UserDefaults.standard.object(forKey: "classPass") as? String
    }
    
    @IBAction func makeGroupButton() {
        
        let groupName = self.groupNameTextField.text
        let collection = database.collection(groupName!)
        
        let group = [
            "className": groupName!,
            "classPass": groupPassTextField.text!
        ] as [String:Any]
        
        collection.document("className").setData(group){ err in
            if let err = err {
                print("error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        classname.append(groupNameTextField.text!)
        UserDefaults.standard.set(groupNameTextField.text, forKey: "className")
        UserDefaults.standard.set(groupPassTextField.text, forKey: "classPass")
        
        groupNameTextField.text = UserDefaults.standard.object(forKey: "className") as? String
        groupPassTextField.text = UserDefaults.standard.object(forKey: "classPass") as? String
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
