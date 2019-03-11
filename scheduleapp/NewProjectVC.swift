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
    @IBOutlet weak var shareCode: UITextField!
    
    
    @IBOutlet weak var guestShareCode: UITextField!
    
    var projectTitleString: String = ""
    var shareCodeString: String = ""
    
    @IBAction func createProjectButton(_ sender: Any) {

        //Check that values aren't empty
        var shareCodeCheck: String = ""
        
        // Check if Share Code is valid
                    if shareCode.text == "" {
                        //display error message
                    } else {
                        shareCodeCheck = shareCode.text!
                    }
        
        
        if projectTitle != nil && shareCodeCheck.count == 5 {
            projectTitleString = projectTitle.text!
            shareCodeString = shareCode.text!
            currentProject = projectTitleString
        }
    
        let projectID = firebaseRef!.childByAutoId().key
        print("Project ID Generated \(projectID)")
        let projectData = ["project_title": projectTitleString,
                    "share_code": shareCodeString,
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
    
    @IBAction func addGuestProject(_ sender: Any) {
//        var guestCode = guestShareCode.text
//
//        if guestShareCode != nil {
//            firebaseRef.child("projects")
//
        }
    
  
    


    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseRef = Database.database().reference()
        hideKeyboardWhenTappedAround()
    }
    
}
    
    
    
    
    
    
    
    

