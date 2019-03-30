//
//  LoginViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 8/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

var reference: DatabaseReference!


class LoginViewController: UIViewController {

    struct userConfig {
        var email:String
        var ownedProjects:[String]
        var guestProjects:[String]
    }
    
    
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var entryPassword: UITextField!
    @IBOutlet weak var entryEmail: UITextField!
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    
    var isSignIn: Bool = true
    var shareCode: String = ""

    //Register vs Login Selector
    @IBAction func signInSelectorChanged(_ sender: Any) {
        // Flip the boolean
        isSignIn = !isSignIn
        
        if isSignIn {
            signInLabel.text = "Welcome Back."
            loginButton.setTitle("LOGIN", for: .normal)
        } else {
            signInLabel.text = "Let's Get Started."
            loginButton.setTitle("REGISTER", for: .normal)
        }
    }
    @IBAction func submitRegister(_ sender: Any) {
        if let email = entryEmail.text, let pass = entryPassword.text {
        
        
        if isSignIn {
            // Sign in the user with firebase
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if let u = user {
                    // User is found go to home screen
                    self.getUserId()
                    self.performSegue(withIdentifier: "goToProjects", sender: self)
            
                } else {
                    // Error, check error and show message
                    // TODO: Provide more specific messaging for different errors
                    let alert = UIAlertController(title: "Problem Logging In", message: "Check Email and Password. If problem persists check that you have a network connection", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .destructive, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)

                }
            }
           
        } else {
            // Register user with firebase
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                if let u = user {
                    // User is found, go to home screen
                    self.getUserId()
                    reference!.child("users").child(userID!).setValue(["user-email": email, "user-id": userID])
                    self.performSegue(withIdentifier: "goToProjects", sender: self)
                } else {
                    // Error, check error and show message
                    // TODO: Provide more specific messaging for different errors
                    let alert = UIAlertController(title: "Problem Creating Account", message: "Check Email and Password. If problem persists check that you have a network connection", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .destructive, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)

                }
            }
        }
    
    }
    
       
    }
    

    
    
    func getUserId() {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            print("User ID Received")
        }
        userID = user?.uid
        userEmail = user?.email
    }
    
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reference = Database.database().reference()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
