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
    
    
    //     =======================
    //       TIME PICKER -> START
    //     =======================
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
    
    //     =======================
    //       TIME PICKER -> STOP
    //     =======================
    @IBOutlet weak var timeInputStop: UITextField!
    let stopTimePicker = UIDatePicker()
    
    func createStopDatePicker() {
        stopTimePicker.datePickerMode = .time
        
        timeInputStop.inputView = stopTimePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneEditingButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonClicked))
        toolbar.setItems([doneEditingButton], animated: true)
        timeInputStop.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonClicked() {
        //formatting the time display
        let stopTimeFormatter = DateFormatter()
        stopTimeFormatter.timeStyle = .short
        stopTimeFormatter.dateStyle = .none
        timeInputStop.text = stopTimeFormatter.string(from: stopTimePicker.date)
        
        //End Picker window
        self.view.endEditing(true)
        print(timeInputStop.text!)
    }
    
    
    
 
    
//     =======================
//          Adding data
//     =======================
    @IBAction func addItem(_ sender: Any) {
        let inputSourceOne = inputOne.text
        let inputSourceTwo = inputTwo.text
        let inputTimeStart = timeInputStart.text
        let inputTimeStop = timeInputStop.text
        
        
        if (inputSourceOne != "" || inputSourceTwo != "" || inputTimeStart != "" || inputTimeStop != "") {
            let newItem = myData(firstRowLabel: inputSourceOne!, secondRowLabel: inputSourceTwo!, startTimeLabel: inputTimeStart!, stopTimeLabel: inputTimeStop!)
            tableData.append(newItem)
            print(tableData)
            inputOne.text = ""
            inputTwo.text = ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDatePicker()
        createStopDatePicker()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

