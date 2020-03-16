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
    
    @IBOutlet weak var AmountsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AmountsLabel.text = UserDefaults.standard.object(forKey: "pagecounts") as? String
        
    }

}

extension InputRecordTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 5:
            self.performSegue(withIdentifier: "toAmounts", sender: nil)
        default:
            break
        }
    }
}
