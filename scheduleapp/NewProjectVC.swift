//
//  NewProjectVC.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 2/7/19.
//  Copyright © 2019 Kaiser De Kam. All rights reserved.
//

import UIKit
import Firebase

var currentProject: String = "Testing"

var firebaseRef: DatabaseReference!

class NewProjectVC: UIViewController {
    @IBOutlet weak var projectTitle: UITextField!
    
    
    
    var projectTitleString: String = ""
    
    @IBAction func createProjectButton(_ sender: Any) {

 
        
        
        if projectTitle != nil  {
            projectTitleString = projectTitle.text!
            currentProject = projectTitleString
        }
    
        let projectID = firebaseRef!.childByAutoId().key
        print("Project ID Generated \(projectID)")
        let projectData = ["project_title": projectTitleString,
                    "project_id": projectID!
            ] as [String : Any]
        print(userID!)
        currentProject = projectID!
        
        //Add project ownership to userconfig
        let userConfigAddition = ["permissions": "owned",
        "project_title": projectTitleString,
        "project_id" : projectID] as [String: Any]
        
        //Add user configuration and project to firebase
        firebaseRef.child("userconfig").child(userID!).child("config-projects").child("owner").child(currentProject).setValue(userConfigAddition)
        print("user permissions saved to firebase")
        firebaseRef.child("project_data").child(projectID!).child("data").setValue(projectData)
    }
    

    
  
    


    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseRef = Database.database().reference()
        hideKeyboardWhenTappedAround()
    }
    
}
    
    
    
    
    
    
    
    

