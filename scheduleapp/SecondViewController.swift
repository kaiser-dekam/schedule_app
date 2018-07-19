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
    
    
    //TIME PICKER
    @IBOutlet weak var timeInputStart: UITextField! //datePickerTF
    let timePicker = UIDatePicker()

    func createDatePicker(){
        //format the display of timepicker
        timePicker.datePickerMode = .time
        
        //assign Date picker to our textfield
        timeInputStart.inputView = timePicker
        
        // create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a done button on the toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        timeInputStart.inputAccessoryView = toolbar
        
        }
    @objc func doneClicked() {
        //format the date display in textfield
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateStyle = .none
        timeInputStart.text = timeFormatter.string(from: timePicker.date)

        //End Picker window
        self.view.endEditing(true)
        print(timeInputStart.text!)

    }
    
    
    //----------Organizing Content In Order -----------------
    
    func orderContent() {
        
        tableData = tableData.sorted(by: { $0.rawStartTime > $1.rawStartTime })
        tableData = tableData.reversed()
//        var tempArray: [myData] = []
//        let largestTime = tableData.max {a, b in a.rawStartTime < b.rawStartTime}
//        tempArray.append(largestTime!)
       
    }
    
    
    
    
    //---------Add to data-----------------------------------
    @IBAction func addItem(_ sender: Any) {
        let inputSourceOne = inputOne.text
        let inputSourceTwo = inputTwo.text
        let inputTimeStart = timeInputStart.text

//        let startTime =
//        let stopTime =
        
        if (inputSourceOne != "" || inputSourceTwo != "" || inputTimeStart != "") {
            let newItem = myData(firstRowLabel: inputSourceOne!, secondRowLabel: inputSourceTwo!, startTimeLabel: inputTimeStart!, rawStartTime: timePicker.date)
            
            tableData.append(newItem)
            if (tableData.count >= 2) {
                orderContent()
            }
            print("Current Data is \(tableData)")
            inputOne.text = ""
            inputTwo.text = ""
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDatePicker()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

