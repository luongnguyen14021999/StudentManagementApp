//
//  StudentListViewController.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 3/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class StudentListViewController: UIViewController {
    
    
    @IBOutlet weak var studentListTableView: UITableView!
    
    @IBOutlet weak var notification: UILabel!
    
    var textLabel: String!
    
    var arrStudent = [StudentEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        studentListTableView.dataSource = self
        studentListTableView.delegate = self
        notification.text = textLabel
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.arrStudent = DatabaseHelper.shareInstance.getAllStudentData()
         self.studentListTableView.reloadData()
    }
    
    @IBAction func ADD_STUDENT(_ sender: Any) {
        let examVc = self.storyboard?.instantiateViewController(identifier: "StudentFormViewController") as! StudentFormViewController
        self.navigationController?.pushViewController(examVc, animated:false)
    }
    
}

extension StudentListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentListViewCell", for: indexPath) as! StudentListViewCell
        cell.student = arrStudent[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentDetailVc = self.storyboard?.instantiateViewController(identifier: "StudentDetailViewController") as! StudentDetailViewController
        studentDetailVc.studentDetail = arrStudent[indexPath.row]
        studentDetailVc.indexRow = indexPath.row
        self.navigationController?.pushViewController(studentDetailVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrStudent = DatabaseHelper.shareInstance.deleteStudentData(index: indexPath.row)
            self.studentListTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
