//
//  THomeTableViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/04/02.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class THomeViewController: UITableViewController {
    
    static func instance() -> HomeViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! HomeViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "ログアウト", message: "ログアウトしてもいいですか？", preferredStyle: .alert)
        let LogoutAction = UIAlertAction(title: "ログアウト", style: .destructive, handler: { (UIAlertAction) in
                        let FirebaseAuth = Auth.auth()
            do {
              try FirebaseAuth.signOut()
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
            self.performSegue(withIdentifier: "toLogin", sender: nil)
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: { (UIAlertAction) in
            print("「いいえ」が選択されました！")
        })
        alert.addAction(LogoutAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension THomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            showAlert()
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
