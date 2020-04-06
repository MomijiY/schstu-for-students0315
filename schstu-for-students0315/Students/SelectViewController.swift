//
//  SelectViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/04/01.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {

    @IBOutlet weak var teacherView: UIView!
    @IBOutlet weak var studentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teacherView.layer.cornerRadius = 10
        studentView.layer.cornerRadius = 10
    }

}
