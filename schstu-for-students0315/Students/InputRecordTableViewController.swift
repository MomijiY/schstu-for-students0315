//
//  InputRecordTableViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/16.
//  Copyright © 2020 com.litech. All rights reserved.
// Firebaseはjs2017-の方のプロジェクト

import UIKit
import Firebase

var subjects = String()
var calender = String()
var studyTime = String()
var inputamounts = String()
var inputdescription = String()

class InputRecordTableViewController: UITableViewController {
    
//  @IBOutlet weak var studyLabel: UILabel!
    @IBOutlet weak var subjectsTextField: UITextField!
    @IBOutlet weak var calenderTextField: UITextField!
    @IBOutlet weak var studyTextField: UITextField!
    @IBOutlet weak var AmountsLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var database: Firestore!
    
    var studyTimePicker: UIDatePicker = UIDatePicker()
    var calenderPicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
//        AmountsLabel.text = UserDefaults.standard.object(forKey: "pagecounts") as? String
        
        studyTimePicker.datePickerMode = UIDatePicker.Mode.countDownTimer
        studyTimePicker.timeZone = NSTimeZone.local
        studyTimePicker.locale = Locale.current
        studyTextField.inputView = studyTimePicker
        
        calenderPicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        calenderPicker.timeZone = NSTimeZone.local
        calenderPicker.locale = Locale.current
        calenderTextField.inputView = calenderPicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(studytimedone))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        let ctoolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let cspacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cdoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(calenderdone))
        ctoolbar.setItems([cspacelItem, cdoneItem], animated: true)
        
        subjectsTextField.inputAccessoryView = toolbar
        studyTextField.inputAccessoryView = toolbar
        calenderTextField.inputAccessoryView = ctoolbar
        descriptionTextView.inputAccessoryView = toolbar
        
        configureUI()
    }
    
    //追記
    override func viewWillAppear(_ animated: Bool) {
        AmountsLabel.text = UserDefaults.standard.object(forKey: "pagecounts") as? String
    }

    @objc func studytimedone() {
        subjectsTextField.endEditing(true)
        studyTextField.endEditing(true)
        descriptionTextView.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "h時間m分"
        studyTextField.text = "\(formatter.string(from: studyTimePicker.date))"
    }
    
    @objc func calenderdone() {
        calenderTextField.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日h時m分"
        calenderTextField.text = "\(formatter.string(from: calenderPicker.date))"
    }
}

extension InputRecordTableViewController {
    func saveRecord() {
//
//        let HV = self.storyboard?.instantiateViewController(withIdentifier: "makegroup") as! TmakegroupViewController //error
//        let groupName = HV.groupNameTextField.text
//        let collection = database.collection(groupName!)
        
        let collection = database.collection(classname)
        
        studyTime = studyTextField.text!
        calender = calenderTextField.text!
        inputamounts = AmountsLabel.text!
        subjects = subjectsTextField.text!
        inputdescription = descriptionTextView.text!
        
        UserDefaults.standard.set(subjects, forKey: "subject")
        UserDefaults.standard.set(studyTime, forKey: "studyTime")
        UserDefaults.standard.set(calender, forKey: "calender")
        UserDefaults.standard.set(amounts, forKey: "amounts")
        UserDefaults.standard.set(inputdescription, forKey: "description")
        
        let alert: UIAlertController = UIAlertController(title: "OK", message: "記録の保存が完了しました", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: { action in
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
            )
        )
        present(alert, animated: true, completion: nil)
        let studyData = [
            "studyTime": studyTextField.text!,
            "calender": calenderTextField.text!,
            "description": descriptionTextView.text!,
            "subject": subjectsTextField.text!
        ] as [String: Any]

        collection.document("example").setData(studyData)
    }
}

extension InputRecordTableViewController {
    private func configureUI() {
        tableView.delegate = self
        navigationItem.title = "学習記録"
    }
}

extension InputRecordTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 3:
            self.performSegue(withIdentifier: "toAmounts", sender: nil)
        default:
            break
        }
        switch indexPath.section {
        case 2:
            saveRecord()
        case 3:
            self.performSegue(withIdentifier: "toDetail", sender: nil)
        default:
            break
        }
    }
}
