//
//  InputActivityViewController.swift
//  schstu-for-students0315
//
//  Created by 吉川椛 on 2020/03/21.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit
import TagListView
import Firebase
class InputActivityViewController: UIViewController, TagListViewDelegate, UITextFieldDelegate, UIScrollViewDelegate, UITextViewDelegate {
    
    let MARGIN: CGFloat = 10
    let tagListView = TagListView()
    
    var placeholderLabel : UILabel!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        tagTextField.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "活動内容・感想"
        placeholderLabel.sizeToFit()
        contentTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (contentTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !contentTextView.text.isEmpty
        
//         決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        titleTextField.inputAccessoryView = toolbar
        contentTextView.inputAccessoryView = toolbar
        tagTextField.inputAccessoryView = toolbar

        self.setView()
    }
    
    @objc func done() {
        titleTextField.endEditing(true)
        contentTextView.endEditing(true)
        tagTextField.endEditing(true)
        
        if tagTextField.text != nil {
            textFieldShouldReturn(tagTextField)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !contentTextView.text.isEmpty
    }

    
    func setView() {
        view.addSubview(tagListView)
        
        tagListView.frame = CGRect(x: MARGIN, y: 700, width: view.frame.width-MARGIN*2, height: 0)
        
        // タグの削除ボタンを有効に
        tagListView.enableRemoveButton = true

        // 今回は削除ボタン押された時の処理を行う
        tagListView.delegate = self
        
        // タグの見た目を設定
        tagListView.alignment = .left
        tagListView.cornerRadius = 3
        tagListView.textColor = UIColor.black
        tagListView.borderColor = UIColor.lightGray
        tagListView.borderWidth = 1
        tagListView.paddingX = 10
        tagListView.paddingY = 5
        tagListView.textFont = UIFont.systemFont(ofSize: 16)
        tagListView.tagBackgroundColor = UIColor.white

            // タグ削除ボタンの見た目を設定
        tagListView.removeButtonIconSize = 10
        tagListView.removeIconLineColor = UIColor.black

        updateLayout()
    }
    
    // テキストフィールドの完了ボタンが押されたら
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if 0 < tagTextField.text!.count {
            // タグを追加
            tagListView.addTag(tagTextField.text!)

            // テキストフィールドをクリアしてレイアウト調整
            tagTextField.text = nil
            updateLayout()
        }
        return true
    }

    // タグ削除ボタンが押された
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
    // リストからタグ削除
        sender.removeTagView(tagView)
        updateLayout()
    }
    
    func updateLayout() {
        // タグ全体の高さを取得
        tagListView.frame.size = tagListView.intrinsicContentSize

        tagTextField.frame = CGRect(x: MARGIN, y: tagListView.frame.origin.y + tagListView.frame.height + 5, width: view.frame.width-MARGIN*2, height: 40)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let alert: UIAlertController = UIAlertController(title: "OK", message: "記録の保存が完了しました", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: { action in
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
            )
        )
        present(alert, animated: true, completion: nil)
        
        let AcData = [
            "ActivityTitle": titleTextField.text!,
            "ActivityConternt": contentTextView.text!,
//            "ActivityTag": tagListView.textColor
        ] as [String: Any]

        Firestore.firestore().collection("Activity").document("Activitydocuments").setData(AcData)
    }
}
