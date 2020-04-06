//
//  NotificationsTableViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/17.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class NotificationViewController: UIViewController {
    
    var database: Firestore!
    
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var notificationLabel: UILabel!

    var databaseRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationButton.layer.cornerRadius = 10
        commentButton.layer.cornerRadius = 10
        
        database.collection("teacher_data").document("noti").getDocument { (snap, error) in
            if let error = error {
                fatalError("\(error)")
                
            }
            guard let data = snap?.data() else { return }
            print(data["noti"]!)
            
            self.notificationLabel.text = data["noti"] as? String
            }
    }

    @IBAction func notificationButton(_ sender: UIButton) {
        let vc = NotificationDetailViewController.instance()
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension NotificationViewController {
    private func configureTableView() {
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        notificationTableView.tableFooterView = UIView()
        notificationTableView.rowHeight = NotificationTableViewCell.rowHeight
        notificationTableView.register(NotificationTableViewCell.nib, forCellReuseIdentifier: NotificationTableViewCell.reuseIdentifier)

    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.accessibilityElementCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseIdentifier, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let memo = indexPath.row
        let vc = NotificationDetailViewController.instance()
        navigationController?.pushViewController(vc, animated: true)
    }

}
