//
//  InputRecordDetailViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/21.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class InputRecordDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Inputdetail", for: indexPath)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension InputRecordDetailViewController {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
//        tableView.rowHeight = InputRecordDetailTableViewCell.rowHeight
//        tableView.register(InputRecordDetailTableViewCell.nib, forCellReuseIdentifier: InputRecordDetailTableViewCell.reuseIdentifier)

    }
}
