//
//  DatabaseHelper.swift
//  Assignment2
//
//  Created by Nguyen Dinh Luong on 3/10/20.
//  Copyright © 2020 Nguyen Dinh Luong. All rights reserved.
//

import UIKit
import CoreData
class DatabaseHelper: NSObject {
    
    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveStudentData(studentDict: [String:Any]) {
        let student = NSEntityDescription.insertNewObject(forEntityName: "StudentEntity", into: context) as! StudentEntity
        student.studentID = (studentDict["studentID"] as! String)
        student.fname = (studentDict["studentFName"] as! String)
        student.lname = (studentDict["studentLName"] as! String)
        student.gender = (studentDict["studentGender"] as! String)
        student.course = (studentDict["studentCourse"] as! String)
        student.age = (studentDict["studentAge"] as! Int16)
        student.address = (studentDict["studentAddress"] as! String)
        
        do {
            try context.save()
            print("Save sucessfully")
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentEntity")
            //request.predicate = NSPredicate(format: "age = %@", "12")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                   print(data.value(forKey: "address") as! String)
              }
                
            } catch {
                print("Failed")
            }
        } catch let err {
            print("student save error :- \(err.localizedDescription)")
        }
    }
    
    func getAllStudentData() -> [StudentEntity] {
        var arrStudent = [StudentEntity]()
        let fetchRequets = NSFetchRequest<NSManagedObject>(entityName: "StudentEntity")
        
        do {
            arrStudent = try context.fetch(fetchRequets) as! [StudentEntity]
        } catch let err {
            print("Error in college fetch :- \(err.localizedDescription)")
        }
        return arrStudent
    }
    
    func deleteStudentData(index: Int) ->[StudentEntity] {
        var studentData = self.getAllStudentData()
        context.delete(studentData[index])
        studentData.remove(at: index)
        
        do {
            try context.save()
        } catch let err {
            print("delete student data :- \(err.localizedDescription)")
        }
        return studentData
    }
    
    func editStudentData(studentDict: [String: Any], index: Int) {
        let student = self.getAllStudentData()
        student[index].studentID = (studentDict["studentID"] as! String)
        student[index].fname = (studentDict["studentFName"] as! String)
        student[index].lname = (studentDict["studentLName"] as! String)
        student[index].gender = (studentDict["studentGender"] as! String)
        student[index].course = (studentDict["studentCourse"] as! String)
        student[index].age = (studentDict["studentAge"] as! Int16)
        student[index].address = (studentDict["studentAddress"] as! String)
        
        do {
            try context.save()
        } catch {
            print("error in edit data")
        }
    }
    
    func saveExamData(examDict: [String:String], student:StudentEntity) {
        let exam = NSEntityDescription.insertNewObject(forEntityName: "Exam", into: context) as! Exam
        exam.nameExam = examDict["examName"]
        exam.dateTime = examDict["dateTime"]
        exam.location = examDict["location"]
        exam.examOwner = examDict["examOwner"]
        exam.students = student
        do {
            try context.save()
            print("Save sucessfully")
        } catch let err {
            print("student save error :- \(err.localizedDescription)")
        }
    }
    
    func getAllExamData() -> [Exam] {
        var arrExam = [Exam]()
        let fetchRequets = NSFetchRequest<NSManagedObject>(entityName: "Exam")
        
        do {
            arrExam = try context.fetch(fetchRequets) as! [Exam]
        } catch let err {
            print("Error in college fetch :- \(err.localizedDescription)")
        }
        return arrExam
    }
    
       func deleteExamData(index: Int) ->[Exam] {
           var examData = self.getAllExamData()
           context.delete(examData[index])
           examData.remove(at: index)
           
           do {
               try context.save()
           } catch let err {
               print("delete student data :- \(err.localizedDescription)")
           }
           return examData
       }
       
       func editExamData(examDict: [String: String], index: Int) {
           let exam = self.getAllExamData()
           exam[index].nameExam = examDict["examName"]
           exam[index].dateTime = examDict["dateTime"]
           exam[index].location = examDict["location"]
           exam[index].examOwner = examDict["examOwner"]
           do {
               try context.save()
           } catch {
               print("error in edit data")
           }
       }
}
