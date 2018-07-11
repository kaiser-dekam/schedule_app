//
//  SecondViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 7/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //Inputs
    @IBOutlet weak var inputOne: UITextField!
    @IBOutlet weak var inputTwo: UITextField!
    
    
    //Add to data
    @IBAction func addItem(_ sender: Any) {
        let inputSourceOne = inputOne.text
        let inputSourceTwo = inputTwo.text
        if (inputSourceOne != "" || inputSourceTwo != "") {
            let newItem = myData(firstRowLabel: inputSourceOne!, secondRowLabel: inputSourceTwo!)
            tableData.append(newItem)
            print(tableData)
            inputOne.text = ""
            inputTwo.text = ""
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

