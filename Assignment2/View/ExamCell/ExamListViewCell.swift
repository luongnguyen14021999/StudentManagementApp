//
//  ExamListViewCell.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 5/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class ExamListViewCell: UITableViewCell {
    
    @IBOutlet weak var lblExamName: UILabel!
    
    
    @IBOutlet weak var lblDateTime: UILabel!
    
    
     @IBOutlet weak var lblLocation: UILabel!
    
    
    @IBOutlet weak var lblExamOwner: UILabel!
    
    
    
    
    var exam: Exam? {
        didSet {
            lblExamName.text = "Exam name: \(exam?.nameExam ?? "")"
            lblDateTime.text = "Date&Time: \(exam?.dateTime ?? "")"
            lblLocation.text = "Location: \(exam?.location ?? "")"
            lblExamOwner.text = "Exam Owner: \(exam?.examOwner ?? "")"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
