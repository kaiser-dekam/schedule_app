//
//  InviteUserAccessVC.swift
//  scheduleapp
//
//  Created by Kaiser DeKam on 3/12/19.
//  Copyright © 2019 Kaiser De Kam. All rights reserved.
//

import UIKit
import Firebase

var firRef: DatabaseReference!


class InviteUserAccessVC: UIViewController {
    
    @IBOutlet weak var permissionDescription: UITextView!
    var getEmail: String = " "
    var getUserID: String = " "
    var makeOwner: Bool = true
    @IBOutlet weak var usersEmail: UITextField!
    
    @IBAction func permissionSwitch(_ sender: Any) {
        makeOwner = !makeOwner
        
        if makeOwner {
            permissionDescription.text = "Making this person an owner gives them the ability to delete and edit your project. \r\n Are you sure you want to do that?"
            
        } else if !makeOwner {
            permissionDescription.text = "Making this person a guest user only gives them the ability to view your project."
        }
        
    }
    
    
    @IBAction func addUserToProject(_ sender: Any) {
        // Get users email
        var userToAdd:String = usersEmail.text!
        
        var cleanedEmailForUserToAdd = userToAdd.replacingOccurrences(of: "@", with: "_at_")
        cleanedEmailForUserToAdd = cleanedEmailForUserToAdd.replacingOccurrences(of: ".", with: "_dot_")
        print("Entered email has been cleaned to: \(cleanedEmailForUserToAdd)")
        userToAdd = cleanedEmailForUserToAdd
        print("\(userToAdd) : Cleaned")
        
        // Search Users/ for email and get unique userid
        fireRef.child("useremails").child("\(userToAdd)").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                print("children count = \(snapshot.childrenCount). Getting email next.")
                
                for emails in snapshot.children.allObjects as![DataSnapshot]{
                    let emailObject = emails.value as? [String: AnyObject]
                    print(emailObject)
                    let receivedEmail = emailObject?["user-email"]
                    let receivedUserId = emailObject?["user-id"]
                    
                    self.getEmail = receivedEmail as! String
                    self.getUserID = receivedUserId as! String
                    print("received UserID: \(self.getUserID)")
                    print("received Email: \(self.getEmail)")
                    
                    // If makeOwner(true) then do code below
                    if self.makeOwner == true { fireRef.child("userconfig").child("\(self.getUserID)").child("config-projects").child("owner").child("\(currentProject_id)").setValue(["permissions": "owned","project_id" : currentProject_id, "project_title" : currentProject_title] as [String: Any])
                    } else {
                fireRef.child("userconfig").child("\(self.getUserID)").child("config-projects").child("guest").child("\(currentProject_id)").setValue(["permissions": "guest", "project_id" : currentProject_id, "project_title" : currentProject_title] as [String: Any])
                    }
            }
            }
        }
        //1. Get users ID from now receivedEmail
        
        
        
        
        print("After writing to database... getUserID = \(getUserID)")
        // ISSUE: receivedUserID above is returning nil - need to get that value out of the block of code above
        
     
    }
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reference = Database.database().reference()
        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
        firRef = Database.database().reference()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
