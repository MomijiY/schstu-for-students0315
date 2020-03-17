//
//  AmountsTableViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/16.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

var amounts = [String]()

class AmountsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var AmountsLabel: UILabel!
    @IBOutlet weak var AmoutntsPickerView: UIPickerView!
    
    
    let saveData: UserDefaults = UserDefaults.standard
    let pageArray = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"]

    override func viewDidLoad() {
        super.viewDidLoad()
        AmoutntsPickerView.delegate = self
        AmoutntsPickerView.dataSource = self
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return pageArray.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return pageArray[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        AmountsLabel.text = ("\(pageArray[row])ページ")
        amounts = [AmountsLabel.text!]
        saveData.set(AmountsLabel.text, forKey: "pagecounts")
        
    }

}
