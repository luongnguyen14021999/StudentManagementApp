//
//  StudentDetailViewController.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 4/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class StudentDetailViewController: UITableViewController {
    
    @IBOutlet weak var lblStudentID: UILabel!
    
    @IBOutlet weak var lblFName: UILabel!
    
    @IBOutlet weak var lblLName: UILabel!
    
    @IBOutlet weak var lblGender: UILabel!
    
    @IBOutlet weak var lblCourse: UILabel!
    
    @IBOutlet weak var lblAge: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblExam: UILabel!
    
    var studentDetail: StudentEntity?
    var indexRow = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblStudentID.text = "\(studentDetail?.studentID ?? "")"
        lblFName.text = "\(studentDetail?.fname ?? "")"
        lblLName.text = "\(studentDetail?.lname ?? "")"
        lblGender.text = "\(studentDetail?.gender ?? "")"
        lblCourse.text = "\(studentDetail?.course ?? "")"
        lblAge.text = "\(studentDetail?.age.description ?? "")"
        lblAddress.text = "\(studentDetail?.address ?? "")"
        if let exams = studentDetail?.exams?.allObjects as? [Exam] {
            lblExam.text = "\(exams.count) exams"
        } else {
            lblExam.text = "0 exam"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lblStudentID.text = "\(studentDetail?.studentID ?? "")"
        lblFName.text = "\(studentDetail?.fname ?? "")"
        lblLName.text = "\(studentDetail?.lname ?? "")"
        lblGender.text = "\(studentDetail?.gender ?? "")"
        lblCourse.text = "\(studentDetail?.course ?? "")"
        lblAge.text = "\(studentDetail?.age.description ?? "")"
        lblAddress.text = "\(studentDetail?.address ?? "")"
        if let exams = studentDetail?.exams?.allObjects as? [Exam] {
            lblExam.text = "\(exams.count) exams"
        } else {
            lblExam.text = "0 exam"
        }
    }
    

    @IBAction func btnEditClick(_ sender: Any) {
        let formVc = self.storyboard?.instantiateViewController(identifier: "StudentFormViewController") as! StudentFormViewController
        formVc.isUpdate = true
        formVc.studentDetails = studentDetail
        formVc.indexRow = indexRow
        self.navigationController?.pushViewController(formVc, animated:false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 7) {
        let sb = UIStoryboard(name:"Main", bundle: nil)
                  
        let examListScreen = sb.instantiateViewController(identifier: "ExamListViewController") as! ExamListViewController
            examListScreen.student = studentDetail
        self.navigationController?.pushViewController(examListScreen, animated: true)
        }
        
        if (indexPath.row == 6) {
        let sb = UIStoryboard(name:"Main", bundle: nil)
                  
        let mapScreen = sb.instantiateViewController(identifier: "MapViewController") as! MapViewController
        
        mapScreen.address = studentDetail?.address
        
        self.navigationController?.pushViewController(mapScreen, animated: true)
        }
    }
}
