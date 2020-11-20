//
//  MainViewController.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 5/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func GOTO_LISTSTUDENTS(_ sender: Any) {
       let liststudentVc = self.storyboard?.instantiateViewController(identifier: "StudentListViewController") as! StudentListViewController
       liststudentVc.textLabel = "LIST STUDENTS"
       self.navigationController?.pushViewController(liststudentVc, animated: false)
    }
    
    @IBAction func GOTO_EXAMS(_ sender: Any) {
        let liststudentVc = self.storyboard?.instantiateViewController(identifier: "StudentListViewController") as! StudentListViewController
        liststudentVc.textLabel = "Choose a student in lists to manipulate exams!"
        self.navigationController?.pushViewController(liststudentVc, animated: false)
    }
    
    
    @IBAction func GOTO_LISTIMAGES(_ sender: Any) {
        
        let sb = UIStoryboard(name:"Main", bundle: nil)
        
        let imageScreen = sb.instantiateViewController(identifier: "ImageViewController")
        
        self.navigationController?.pushViewController(imageScreen, animated: true)
    }
}
