//
//  ExamDetailViewController.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 5/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class ExamDetailViewController: UITableViewController {
    
    
    @IBOutlet weak var lblExamName: UILabel!
    
    
    @IBOutlet weak var lblDateTime: UILabel!
    
    
    @IBOutlet weak var lblLocation: UILabel!
    
    
    @IBOutlet weak var lblExamOwner: UILabel!
    
    
    
    
    var examDetail: Exam?
    var indexRow = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         lblExamName.text = "\(examDetail?.nameExam ?? "")"
         lblDateTime.text = "\(examDetail?.dateTime ?? "")"
         lblLocation.text = "\(examDetail?.location ?? "")"
         lblExamOwner.text = "\(examDetail?.examOwner ?? "")"
    }

    
    
    @IBAction func btnEditClick(_ sender: Any) {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let studentDate = dateFormatter.date(from: examDetail!.dateTime!)
        var msg = "Current Exam"
        let startDateComparisionResult:ComparisonResult = todaysDate.compare(studentDate as! Date)

        if (startDateComparisionResult == ComparisonResult.orderedAscending || startDateComparisionResult == ComparisonResult.orderedSame)
        {
            msg = "Current Exam"
            let alert = UIAlertController(title: "Exam Status", message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if startDateComparisionResult == ComparisonResult.orderedDescending
        {
            msg = "Past Exam"
            let alert = UIAlertController(title: "Exam Status", message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
