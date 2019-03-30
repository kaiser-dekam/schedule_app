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

    @IBOutlet weak var usersEmail: UITextField!
    
    
    @IBAction func addUserToProject(_ sender: Any) {
        // Get users email
//        var testEmail = fireRef.child("users").queryEqual(toValue: "kaiserddekam@gmail.com")
        
//        print(testEmail)

        // Search Users/ for email and get unique userid
        
        // change userconfig with their id and assign owner or guest permissions
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reference = Database.database().reference()
        // Do any additional setup after loading the view.
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
