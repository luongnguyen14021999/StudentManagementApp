//
//  ExamListViewController.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 5/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class ExamListViewController: UIViewController {
    
    @IBOutlet weak var examListTableView: UITableView!
    
    var arrExam = [Exam]()
    var student: StudentEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        examListTableView.dataSource = self
        examListTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrExam = DatabaseHelper.shareInstance.getAllExamData()
        self.examListTableView.reloadData()
    }
    
    @IBAction func ADD_EXAM(_ sender: Any) {
        let examVc = self.storyboard?.instantiateViewController(identifier: "ExamFormViewController") as! ExamFormViewController
        examVc.student = student
        self.navigationController?.pushViewController(examVc, animated:false)
    }
    
}


extension ExamListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrExam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExamListViewCell", for: indexPath) as! ExamListViewCell
        cell.exam = arrExam[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let examDetailVc = self.storyboard?.instantiateViewController(identifier: "ExamDetailViewController") as! ExamDetailViewController
        examDetailVc.examDetail = arrExam[indexPath.row]
        examDetailVc.indexRow = indexPath.row
        self.navigationController?.pushViewController(examDetailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrExam = DatabaseHelper.shareInstance.deleteExamData(index: indexPath.row)
            self.examListTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
