//
//  SettingsViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 8/11/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

var removeOldEvents: Bool = true

class SettingsViewController: UIViewController {
    @IBOutlet weak var outletSwitch: UISwitch!
    
    @IBAction func removeOldEventsSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            removeOldEvents = true
            print("Switch is on")
        } else if sender.isOn == false {
            removeOldEvents = false
            print("Switch is off")
        }
    
        }
    
    @IBAction func deleteData(_ sender: Any) {
        tableData.removeAll()
        ref!.child(userID!).removeValue()
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logout", sender: sender)
            }
        catch {
            print(error)
        }
    }
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
        if removeOldEvents == true {
            outletSwitch.isOn = true
        } else {
            outletSwitch.isOn = false
        }
        
        
        
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
