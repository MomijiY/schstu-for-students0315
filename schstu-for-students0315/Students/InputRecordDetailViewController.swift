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
            cell.setupCell(subject: data["subject"] as! String,
                           description: data["description"] as! String,
                           studyTime: data["studyTime"] as! String,
                           calendar: data["calender"] as! String)
        }
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        configureTableView()
        Firestore.firestore().collection("data").document("example").getDocument{ (snap, error) in
                if let error = error {
                    fatalError("\(error)")
                }
                guard let data = snap?.data() else { return }
//                print(data["calender"]!)
//                print(data["description"]!)
//                print(data["studyTime"]!)
//                print(data["subject"]!)
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
