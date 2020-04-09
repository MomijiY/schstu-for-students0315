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
        let subtoolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let subspacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let subdoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(subjectdone))
        subtoolbar.setItems([subspacelItem, subdoneItem], animated: true)
        
        let stoolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let sdoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(studytimedone))
        stoolbar.setItems([spacelItem, sdoneItem], animated: true)
        
        let ctoolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let cspacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cdoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(calenderdone))
        ctoolbar.setItems([cspacelItem, cdoneItem], animated: true)
        
        let dtoolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let dspacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let ddoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(descriptiondone))
        dtoolbar.setItems([dspacelItem, ddoneItem], animated: true)
        
        subjectsTextField.inputAccessoryView = subtoolbar
        studyTextField.inputAccessoryView = stoolbar
        calenderTextField.inputAccessoryView = ctoolbar
        descriptionTextView.inputAccessoryView = dtoolbar
        
        configureUI()
    }
    
    //追記
    override func viewWillAppear(_ animated: Bool) {
        AmountsLabel.text = UserDefaults.standard.object(forKey: "pagecounts") as? String
    }
    
    @objc func subjectdone() {
        subjectsTextField.endEditing(true)
    }

    @objc func studytimedone() {
        studyTextField.endEditing(true)
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
    
    @objc func descriptiondone() {
        descriptionTextView.endEditing(true)
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
        
        let alert: UIAlertController = UIAlertController(title: "記録の保存が完了しました。",
                                                         message: "", preferredStyle: .alert)
        let spaceAlertS: UIAlertController = UIAlertController(title: "教科名を記入してください。", message: "", preferredStyle: .alert)
        
        let spaceAlertST: UIAlertController = UIAlertController(title: "勉強時間を記入してください。", message: "", preferredStyle: .alert)
        let spaceAlertC: UIAlertController = UIAlertController(title: "日時を記入してください。", message: "", preferredStyle: .alert)
        
        if subjectsTextField.text == "" {
            spaceAlertS.addAction(
                UIAlertAction(title: "OK", style: .default, handler: nil)
            )
            present(spaceAlertS, animated: true, completion: nil)
        } else if calenderTextField.text == "" {
            spaceAlertC.addAction(
                UIAlertAction(title: "OK", style: .default, handler: nil)
            )
            present(spaceAlertC, animated: true, completion: nil)
        } else if studyTextField.text == "" {
            spaceAlertST.addAction(
                UIAlertAction(title: "OK", style: .default, handler: nil)
            )
            present(spaceAlertST, animated: true, completion: nil)
        } else {
            alert.addAction(
                UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
                )
            )
            present(alert, animated: true, completion: nil)
        }
        let studyData = [
            "studyTime": studyTextField.text!,
            "calender": calenderTextField.text!,
            "description": descriptionTextView.text!,
            "subject": subjectsTextField.text!,
            "amounts": AmountsLabel.text!
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
