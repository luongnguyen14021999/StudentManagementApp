//
//  StudentFormViewController.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 3/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class StudentFormViewController: UIViewController {
    
    
    @IBOutlet weak var txtStudentID: UITextField!
    
    
    @IBOutlet weak var txtFName: UITextField!
    
    
    @IBOutlet weak var txtLName: UITextField!
    
    
    @IBOutlet weak var segmentGender: UISegmentedControl!
    
    
    @IBOutlet weak var txtCourse: UITextField!
    
    
    @IBOutlet weak var ageStepper: UIStepper!
    
    
    @IBOutlet weak var txtAddress: UITextField!
    
    
    @IBOutlet weak var labelAge: UILabel!
    
    
    @IBOutlet weak var btnSave: UIButton!
    
    var isUpdate = false
    var indexRow = Int()
    var studentDetails: StudentEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageStepper.wraps = true
        ageStepper.autorepeat = true
        ageStepper.maximumValue = 100
        ageStepper.minimumValue = 1
        self.txtStudentID.text = studentDetails?.studentID
        self.txtFName.text =  studentDetails?.fname
        self.txtLName.text = studentDetails?.lname
        if(studentDetails?.gender == "Male") {
            self.segmentGender.titleForSegment(at: 0)
        } else {
            self.segmentGender.titleForSegment(at: 1)
        }
        self.txtCourse.text = studentDetails?.course
        self.labelAge.text = "Age: \(studentDetails?.age.description ?? "")"
        self.txtAddress.text = studentDetails?.address
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isUpdate {
            btnSave.setTitle("Update", for: .normal)
        } else {
             btnSave.setTitle("Save", for: .normal)
        }
    }
    
    
    @IBAction func GET_AGE(_ sender: Any) {
        labelAge.text = "Age: "+(Int16)(ageStepper.value).description
    }
}

extension StudentFormViewController {
    @IBAction func SAVE(_ sender: Any) {
        self.studentSaveData()
        self.navigationController?.popViewController(animated: true)
    }
}

extension StudentFormViewController {
    func studentSaveData() {
        guard let studentID = txtStudentID.text else { return }
        guard let fname = txtFName.text else { return }
        guard let lname = txtLName.text else { return }
        guard let gender =  segmentGender.titleForSegment(at:segmentGender.selectedSegmentIndex) else { return }
        guard let course = txtCourse.text else { return }
        guard let age: Int16 = (Int16)(ageStepper.value) else {return}
        guard let address = txtAddress.text else { return }
        
        let studentDict = [
            "studentID": studentID,
            "studentFName": fname,
            "studentLName": lname,
            "studentGender": gender,
            "studentCourse": course,
            "studentAge": age,
            "studentAddress": address
            ] as [String : Any]
        
        if isUpdate {
            DatabaseHelper.shareInstance.editStudentData(studentDict: studentDict,index: indexRow)
            isUpdate = false
        } else {
            DatabaseHelper.shareInstance.saveStudentData(studentDict: studentDict)
        }
    }
 }
