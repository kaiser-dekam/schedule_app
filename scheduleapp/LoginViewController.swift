//
//  LoginViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 8/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var entryPassword: UITextField!
    @IBOutlet weak var entryEmail: UITextField!
    
    
    @IBAction func passwordStarted(_ sender: Any) {
        //Method from Enter Button
         print("textField: \(entryPassword.text!)")
        
        if (entryPassword.text?.count)! <= 3 {
            loginButton.isHidden = true
            print("Background color changed?")
        }  else {
            loginButton.isHidden = false
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
