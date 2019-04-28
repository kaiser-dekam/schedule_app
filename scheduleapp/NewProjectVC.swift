//
//  NewProjectVC.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 2/7/19.
//  Copyright © 2019 Kaiser De Kam. All rights reserved.
//

import UIKit
import Firebase

var currentProject_id: String = "Testing"
var currentProject_title: String = ""
var currentProject_permissions: String = ""

var firebaseRef: DatabaseReference!

class NewProjectVC: UIViewController {
    @IBOutlet weak var projectTitle: UITextField!
    
    
    
    var projectTitleString: String = ""
    
    @IBAction func createProjectButton(_ sender: Any) {
        
        if projectTitle.text != ""  {
            projectTitleString = projectTitle.text!
            currentProject_title = projectTitleString
        
    
        let projectID = firebaseRef!.childByAutoId().key
        print("Project ID Generated \(projectID)")
        let projectData = ["project_title": projectTitleString,
                    "project_id": projectID!
            ] as [String : Any]
        print(userID!)
        currentProject_id = projectID!
        
        //Add project ownership to userconfig
        let userConfigAddition = ["permissions": "owned",
        "project_title": projectTitleString,
        "project_id" : projectID] as [String: Any]
        
        //Add user configuration and project to firebase
        firebaseRef.child("userconfig").child(userID!).child("config-projects").child("owner").child(currentProject_id).setValue(userConfigAddition)
        print("user permissions saved to firebase")
        firebaseRef.child("project_data").child(projectID!).child("data").setValue(projectData)
        } else {
            print("Project Title was empty")
        }
        
    }
    

    
  
    


    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseRef = Database.database().reference()
        hideKeyboardWhenTappedAround()
        if projectTitleString.count == 6 {
            print("Wedding found")
        }
    }
    
}
    
    
    
    
    
    
    
    

