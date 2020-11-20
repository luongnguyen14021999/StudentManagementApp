//
//  ExamFormViewController.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 5/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class ExamFormViewController: UIViewController {
    
    @IBOutlet weak var txtExamName: UITextField!
    
    
    @IBOutlet weak var txtDateTime: UITextField!
    
    
    @IBOutlet weak var txtLocation: UITextField!
    
    
    @IBOutlet weak var txtExamOwner: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
  
    var student: StudentEntity?
    var isUpdate = false
    var indexRow = Int()
    var examDetail: Exam!
    var status: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtExamName.text = examDetail?.nameExam
        self.txtDateTime.text =  examDetail?.dateTime
        self.txtLocation.text = examDetail?.location
        self.txtExamOwner.text = student?.fname
        
        self.txtDateTime.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        
    }
    
    
    
    @objc func tapDone() {
           if let datePicker = self.txtDateTime.inputView as? UIDatePicker { // 2-1
               let dateformatter = DateFormatter() // 2-2
               dateformatter.dateFormat = "dd-MM-yyyy HH:mm"
               self.txtDateTime.text = dateformatter.string(from: datePicker.date) //2-4
           }
           self.txtDateTime.resignFirstResponder() // 2-5
       }
    
    override func viewWillAppear(_ animated: Bool) {
        
          if isUpdate {
              btnSave.setTitle("Update", for: .normal)
          } else {
               btnSave.setTitle("Save", for: .normal)
          }
      }
    
}

extension ExamFormViewController {
    @IBAction func SAVE(_ sender: Any) {
        self.examSaveData()
        self.navigationController?.popViewController(animated: true)
    }
}

extension ExamFormViewController {
   func examSaveData() {
      
      guard let examName = txtExamName.text else { return }
      guard let dateTime = txtDateTime.text else { return }
      guard let location = txtLocation.text else { return }
      guard let examOwner = student?.fname else { return }
      guard let mainStudent = student else { return }
                   
            let examDict = [
                "examName": examName,
                "dateTime": dateTime,
                "location": location,
                "examOwner": examOwner ]
             
                if isUpdate {
                    DatabaseHelper.shareInstance.editExamData(examDict: examDict, index: indexRow)
                    isUpdate = false
                } else {
                    DatabaseHelper.shareInstance.saveExamData(examDict: examDict, student: mainStudent)
                }
   }
}

extension UITextField {
    
   func setInputViewDatePicker(target: Any, selector: Selector) {
       // Create a UIDatePicker object and assign to inputView
       let screenWidth = UIScreen.main.bounds.width
       let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
       datePicker.datePickerMode = .dateAndTime //2
       self.inputView = datePicker //3
       
       // Create a toolbar and assign it to inputAccessoryView
       let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
       let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
       let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
       let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
       toolBar.setItems([cancel, flexible, barButton], animated: false) //8
       self.inputAccessoryView = toolBar //9
   }
   
   @objc func tapCancel() {
       self.resignFirstResponder()
   }
}
