//
//  NotificationDetailViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/18.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class NotificationDetailViewController: UIViewController {
    
    var databaseRef: DatabaseReference!
    
        static func instance() -> NotificationDetailViewController {
        let vc = UIStoryboard(name: "NotificationDetail", bundle: nil).instantiateInitialViewController() as! NotificationDetailViewController
        return vc
    }
    
    @IBOutlet weak var notificationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        databaseRef = Database.database().reference()
        
        databaseRef.observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
                let currentText = self.notificationLabel.text
                self.notificationLabel.text = (currentText ?? "") + "\n\(name) : \(message)"
            }
        })
    }

}
