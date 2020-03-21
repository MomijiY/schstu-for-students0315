//
//  HomeViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/15.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var testDayLabel: UILabel!
    
    //ユーザー名
    var userName: String = ""
    
    
    static func instance() -> HomeViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! HomeViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = userName
        testDayLabel.text = UserDefaults.standard.object(forKey: "dateTextField") as? String
        if let userName = UserDefaults.standard.string(forKey: "userNameKey") {
            nameLabel.text = userName
        } else  {
            nameLabel.text = ""
        }
    }
    
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 1:
            self.performSegue(withIdentifier: "toInputRecord", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "toNotification", sender: nil)
        case 3:
            self.performSegue(withIdentifier: "toInputActivity", sender: nil)
        case 4:
            self.performSegue(withIdentifier: "toTestDay", sender: nil)
        default:
            break
        }
    }
}
