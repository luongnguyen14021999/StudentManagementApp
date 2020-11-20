//
//  StudentListViewCell.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 3/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class StudentListViewCell: UITableViewCell {
    

    @IBOutlet weak var imageStudent: UIImageView!
    
    
    
    @IBOutlet weak var lblStudentID: UILabel!
    
    
    @IBOutlet weak var lblFName: UILabel!
    

    
    @IBOutlet weak var lblLName: UILabel!
    
    
    @IBOutlet weak var lblGender: UILabel!
    
    
    @IBOutlet weak var lblCourse: UILabel!
    
    
    @IBOutlet weak var lblAge: UILabel!
    
    
    @IBOutlet weak var lblAddress: UILabel!
    
    var student: StudentEntity? {
        didSet {
            lblStudentID.text = "StudentID: \(student?.studentID ?? "")"
            lblFName.text = "FirstName: \(student?.fname ?? "")"
            lblLName.text = "LastName: \(student?.lname ?? "")"
            lblGender.text = "Gender: \(student?.gender ?? "")"
            lblCourse.text = "Course: \(student?.course ?? "")"
            lblAge.text = "Age: \(student?.age.description ?? "")"
            lblAddress.text = "Address: \(student?.address ?? "")"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
