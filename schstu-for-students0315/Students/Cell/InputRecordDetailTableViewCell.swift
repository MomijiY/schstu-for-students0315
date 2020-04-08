//
//  InputRecordDetailTableViewCell.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/21.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import Firebase

class InputRecordDetailTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var studyTimeLabel: UILabel!
    @IBOutlet private weak var amountsLabel: UILabel!
    @IBOutlet private weak var calenderLabel: UILabel!
    
    var database: Firestore!
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
    
    func setupCell(subject: String, description: String, studyTime: String, calendar: String) {
        Firestore.firestore().collection("data").document("example").getDocument{ (snap, error) in
                if let error = error {
                    fatalError("\(error)")
                }
                guard let data = snap?.data() else { return }
                print(data["calender"]!)
                print(data["description"]!)
                print(data["studyTime"]!)
                print(data["subject"]!)
            self.subjectLabel.text = data["subjects"] as? String
            self.descriptionLabel.text = data["description"] as? String
            self.studyTimeLabel.text = data["studyTime"] as? String
            self.calenderLabel.text = data["calender"] as? String
        }
//        subjectLabel.text = subjects
//        descriptionLabel.text = inputdescription
//        studyTimeLabel.text = studyTime
//        amountsLabel.text = inputamounts
//        calenderLabel.text = calender
        
        //追加画面で入力した内容を取得する
//        if UserDefaults.standard.object(forKey: "subject") != nil {
//            subjects = UserDefaults.standard.object(forKey: "subject") as! String
//            subjectLabel.text = subjects
//        }
//        if UserDefaults.standard.object(forKey: "studyTime") != nil {
//            studyTime = UserDefaults.standard.object(forKey: "studyTime") as! String
//            studyTimeLabel.text = studyTime
//        }
//        if UserDefaults.standard.object(forKey: "calender") != nil {
//            calender = UserDefaults.standard.object(forKey: "calender") as! String
//            calenderLabel.text = calender
//        }
//        if UserDefaults.standard.object(forKey: "amounts") != nil {
//            inputamounts = UserDefaults.standard.object(forKey: "amounts") as! String
//            amountsLabel.text = inputamounts
//        }
//        if UserDefaults.standard.object(forKey: "description") != nil {
//            inputdescription = UserDefaults.standard.object(forKey: "description") as! String
//            descriptionLabel.text = inputdescription
//        }
    }
    
}

