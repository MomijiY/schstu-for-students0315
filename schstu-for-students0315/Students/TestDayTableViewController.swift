//
//  TestDayTableViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/17.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class TestDayTableViewController: UITableViewController {
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var goalTextField1: UITextField!
    @IBOutlet weak var goalTextField2: UITextField!
    @IBOutlet weak var goalTextField3: UITextField!

    var database: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        if UserDefaults.standard.object(forKey: "dateTextField") as? String == nil {
            dateTextField.text = ""
        } else {
            dateTextField.text = UserDefaults.standard.object(forKey: "dateTextField") as? String
        }
        if UserDefaults.standard.object(forKey: "goalTextField1") as? String == nil {
            goalTextField1.text = ""
        } else {
            goalTextField1.text = UserDefaults.standard.object(forKey: "goalTextField1") as! String
        }
        if UserDefaults.standard.object(forKey: "goalTextField2") as? String == nil {
            goalTextField2.text = ""
        } else {
            goalTextField2.text! = UserDefaults.standard.object(forKey: "goalTextField2") as! String
        }
        if UserDefaults.standard.object(forKey: "goalTextField3") as? String == nil {
            goalTextField2.text = ""
        } else {
        goalTextField3.text! = UserDefaults.standard.object(forKey: "goalTextField3") as! String
        }
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        goalTextField1.inputAccessoryView = toolbar
        goalTextField2.inputAccessoryView = toolbar
        goalTextField3.inputAccessoryView = toolbar
    }

    @objc func done() {
        dateTextField.endEditing(true)
        goalTextField1.endEditing(true)
        goalTextField2.endEditing(true)
        goalTextField3.endEditing(true)
        
    }

}

extension TestDayTableViewController {
    func saveTestDay() {
        
        let HV = self.storyboard?.instantiateViewController(withIdentifier: "makegroup") as! TmakegroupViewController
        let groupName = HV.groupNameTextField.text
        let collection = database.collection(groupName!)
        
        UserDefaults.standard.set(dateTextField.text, forKey: "dateTextField")
        UserDefaults.standard.set(goalTextField1.text, forKey: "goalTextField1")
        UserDefaults.standard.set(goalTextField2.text, forKey: "goalTextField2")
        UserDefaults.standard.set(goalTextField3.text, forKey: "goalTextField3")

        let alert: UIAlertController = UIAlertController(title: "OK", message: "記録の保存が完了しました", preferredStyle: .alert)

        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: { action in         self.performSegue(withIdentifier: "TesttoHome", sender: nil)
            }
            )
        )
        present(alert, animated: true, completion: nil)
        let testData = [
            "goal1": goalTextField1.text!,
            "goal2": goalTextField2.text!,
            "goal3": goalTextField3.text!
        ] as [String: Any]
        collection.document("testdocuments").setData(testData)
    }
}

extension TestDayTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 2:
            saveTestDay()
        default:
            break
        }
    }
}
