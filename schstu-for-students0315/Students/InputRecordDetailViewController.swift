//
//  InputRecordDetailViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/21.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class InputRecordDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var database: Firestore!
    
    var selectedSubject: String = ""
    var selectedST: String = ""
    var selectedCalendar: String = ""
    var selectedAmounts: String = ""
    var selectedDescription: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InputRecordDetailTableViewCell.reuseIdentifier, for: indexPath) as! InputRecordDetailTableViewCell
        tableView.register(InputRecordDetailTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(InputRecordDetailTableViewCell.self))

//        let HV = self.storyboard?.instantiateViewController(withIdentifier: "makegroup") as! TmakegroupViewController
//        let groupName = HV.groupNameTextField.text
//        let collection = database.collection(groupName!)
        
        Firestore.firestore().collection("data").document("example").getDocument{ (snap, error) in
                if let error = error {
                    fatalError("\(error)")
                }
                guard let data = snap?.data() else { return }
                print(data["calender"]!)
                print(data["description"]!)
                print(data["studyTime"]!)
                print(data["subject"]!)
                print(data["amounts"]!)
            cell.setupCell(subject: data["subject"] as! String,
                           description: data["description"] as! String,
                           studyTime: data["studyTime"] as! String,
                           calendar: data["calender"] as! String,
                           amounts: data["amounts"] as! String)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Firestore.firestore().collection("data").document("example").getDocument{ (snap, error) in
                if let error = error {
                    fatalError("\(error)")
                }
                guard let data = snap?.data() else { return }
            self.selectedSubject = data["subject"] as! String
            self.selectedST = data["studyTime"] as! String
            self.selectedAmounts = data["amounts"] as! String
            self.selectedCalendar = data["calender"] as! String
            self.selectedDescription = data["description"] as! String
            
            if self.selectedSubject != nil {
                self.performSegue(withIdentifier: "toSeeRecordDetail",sender: nil)
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
//           if (segue.identifier == "toDetailSubjects") {
//            let detailVC: SeeRecordViewController = (segue.destination as? SeeRecordViewController)!
//            detailVC.subjectLabel.text = selectedSubject
//            detailVC.studyTimeLanel.text = selectedST
//            detailVC.amountsLabel.text = selectedAmounts
//            detailVC.calendarLabel.te/Users/momiji/Downloads/schstu-for-students0315/schstu-for-students0315/Students/SelectViewController.swiftxt = selectedCalendar
//            detailVC.descriptioinTextView.text = selectedDescription
//           }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        configureTableView()
        Firestore.firestore().collection("data").document("example").getDocument{ (snap, error) in
                if let error = error {
                    fatalError("\(error)")
                }
                guard let data = snap?.data() else { return }
                print(data["calender"]!)
                print(data["description"]!)
                print(data["studyTime"]!)
                print(data["subject"]!)
        }
    }

}

extension InputRecordDetailViewController {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.tableFooterView = UIView()
//        tableView.rowHeight = InputRecordDetailTableViewCell.rowHeight
//        tableView.register(InputRecordDetailTableViewCell.nib, forCellReuseIdentifier: InputRecordDetailTableViewCell.reuseIdentifier)

    }
}
