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
    //ユーザー名
    var userName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = userName
        
        if let userName = UserDefaults.standard.string(forKey: "userNameKey") {
            nameLabel.text = userName
        } else  {
            nameLabel.text = ""
        }
    }
    
}

extension HomeViewController {
    
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 1:
            self.performSegue(withIdentifier: "toInputRecord", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "", sender: nil)
        default:
            break
        }
    }
}
