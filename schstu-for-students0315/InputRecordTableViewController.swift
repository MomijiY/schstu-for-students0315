//
//  InputRecordTableViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/16.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class InputRecordTableViewController: UITableViewController {
    
//  @IBOutlet weak var studyLabel: UILabel!
    @IBOutlet weak var studyTextField: UITextField!
    @IBOutlet weak var calenderTextField: UITextField!
    @IBOutlet weak var AmountsLabel: UILabel!
    
    var studyTimePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AmountsLabel.text = UserDefaults.standard.object(forKey: "pagecounts") as? String
        
        studyTimePicker.datePickerMode = UIDatePicker.Mode.countDownTimer
        studyTimePicker.timeZone = NSTimeZone.local
        studyTimePicker.locale = Locale.current
        studyTextField.inputView = studyTimePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(studytimedone))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        studyTextField.inputAccessoryView = toolbar
    }

    @objc func studytimedone() {
        studyTextField.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "h時間m分"
        studyTextField.text = "\(formatter.string(from: studyTimePicker.date))"
    }
}

extension InputRecordTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 4:
            self.performSegue(withIdentifier: "toAmounts", sender: nil)
        default:
            break
        }
    }
}
