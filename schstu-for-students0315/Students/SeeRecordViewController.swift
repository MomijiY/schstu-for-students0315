//
//  SeeRecordViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/04/08.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class SeeRecordViewController: UITableViewController {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var studyTimeLanel: UILabel!
    @IBOutlet weak var descriptioinTextView: UITextView!
    @IBOutlet weak var amountsLabel: UILabel!
    @IBOutlet weak var calendarLabel: UILabel!
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    var subject: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = subject
        Firestore.firestore().collection("data").document("example").getDocument{ (snap, error) in
                if let error = error {
                    fatalError("\(error)")
                }
                guard let data = snap?.data() else { return }
            self.subjectLabel.text = data["subject"] as? String
            self.studyTimeLanel.text = data["studyTime"] as? String
            self.amountsLabel.text = data["amounts"] as? String
            self.calendarLabel.text = data["calender"] as? String
            self.descriptioinTextView.text = data["description"] as? String
        }
        
        let dtoolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let dspacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let ddoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(descriptiondone))
        dtoolbar.setItems([dspacelItem, ddoneItem], animated: true)

        descriptioinTextView.inputAccessoryView = dtoolbar
        
        // Do any additional setup after loading the view.
    }
    
    @objc func descriptiondone() {
        descriptioinTextView.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 0{
            return nil
        }
        if indexPath.row == 1 {
            return nil
        }
        if indexPath.row == 2 {
            return nil
        }
        if indexPath.section == 1 {
            return nil
        }
        return indexPath
    }
}
