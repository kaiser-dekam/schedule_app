//
//  LoginViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 8/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var entryPassword: UITextField!
    @IBOutlet weak var entryEmail: UITextField!
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    
    var isSignIn: Bool = true

    //Register vs Login Selector
    @IBAction func signInSelectorChanged(_ sender: Any) {
        // Flip the boolean
        isSignIn = !isSignIn
        
        if isSignIn {
            signInLabel.text = "Sign In"
            loginButton.setTitle("Sign In", for: .normal)
        } else {
            signInLabel.text = "Register"
            loginButton.setTitle("Register", for: .normal)
        }
    }
    @IBAction func submitRegister(_ sender: Any) {
        if let email = entryEmail.text, let pass = entryPassword.text {
        
        
        if isSignIn {
            // Sign in the user with firebase
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if let u = user {
                    // User is found go to home screen
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                } else {
                    // Error, check error and show message
                }
            }
           
        } else {
            // Register user with firebase
            Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                if let u = user {
                    // User is found, go to home screen
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                } else {
                    // Error, check error and show message

                }
            }
        }
    
    }
    
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        loginButton.isEnabled = false
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
