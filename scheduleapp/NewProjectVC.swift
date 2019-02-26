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
        let projectData = ["project_title": projectTitleString,
                    "share_code": shareCodeString,
                    "project_id": projectID!
            ] as [String : Any]
        print(userID!)
        firebaseRef.child("projects").child(userID!).child(projectID!).setValue(projectData)
        currentProject = projectID!
    }
    
    
    


    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseRef = Database.database().reference()
        hideKeyboardWhenTappedAround()
    }
    
}
    
    
    
    
    
    
    
    

