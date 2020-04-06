//
//  InputRecordDetailTableViewCell.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/21.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class InputRecordDetailTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var studyTimeLabel: UILabel!
    @IBOutlet private weak var amountsLabel: UILabel!
    @IBOutlet private weak var calenderLabel: UILabel!
    
    static let reuseIdentifier = "InputRecordDetailTableViewCell"
    static let rowHeight: CGFloat = 100
    // 正しいファイルを読み込むように引数nibNameに渡す文字列を変更.
    static var nib: UINib {
        return UINib(nibName: "InputRecordDetailTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell() {
//        subjectLabel.text = subjects
//        descriptionLabel.text = inputdescription
//        studyTimeLabel.text = studyTime
//        amountsLabel.text = inputamounts
//        calenderLabel.text = calender
        
        //追加画面で入力した内容を取得する
        if UserDefaults.standard.object(forKey: "subject") != nil {
            subjects = UserDefaults.standard.object(forKey: "subject") as! String
            subjectLabel.text = subjects
        }
        if UserDefaults.standard.object(forKey: "studyTime") != nil {
            studyTime = UserDefaults.standard.object(forKey: "studyTime") as! String
            studyTimeLabel.text = studyTime
        }
        if UserDefaults.standard.object(forKey: "calender") != nil {
            calender = UserDefaults.standard.object(forKey: "calender") as! String
            calenderLabel.text = calender
        }
        if UserDefaults.standard.object(forKey: "amounts") != nil {
            inputamounts = UserDefaults.standard.object(forKey: "amounts") as! String
            amountsLabel.text = inputamounts
        }
        if UserDefaults.standard.object(forKey: "description") != nil {
            inputdescription = UserDefaults.standard.object(forKey: "description") as! String
            descriptionLabel.text = inputdescription
        }
    }
    
}

