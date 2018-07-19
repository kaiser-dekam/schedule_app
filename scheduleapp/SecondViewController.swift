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

    }
    
    //----------Organizing Content In Order -----------------
    
    func orderContent() {
        tableData = tableData.sorted(by: { $0.rawStartTime > $1.rawStartTime })
        tableData = tableData.reversed()
 }
    
    //----------Add locations to recently used list----------

    var recentLocations: [String] = []
    func addToRecentLocations(location:String) {
        if recentLocations.contains(location) {
            print("Already available in recent locations")
        } else {
            recentLocations.append(location)
            print("Added to recent locations. Recent locations now include = \(recentLocations)")
        }
    }

    
    //---------Add to data-----------------------------------
    @IBAction func addItem(_ sender: Any) {
        let inputSourceOne = inputOne.text
        let inputSourceTwo = inputTwo.text
        let inputTimeStart = timeInputStart.text


        
        if (inputSourceOne != "" && inputTimeStart != "") {
            let newItem = myData(firstRowLabel: inputSourceOne!, secondRowLabel: inputSourceTwo!, startTimeLabel: inputTimeStart!, rawStartTime: timePicker.date)
            
            tableData.append(newItem)
            if (tableData.count >= 2) {
                orderContent()
            }
            addToRecentLocations(location: inputSourceTwo!)
            inputOne.text = ""
            inputTwo.text = ""
            timeInputStart.text = ""
            print(tableData)
        }
    }

    
    @IBAction func enterDemoData(_ sender: Any) {
        let demoTime = Date()
//        var demoData: [myData]
            tableData = [myData(firstRowLabel: "Getting Ready", secondRowLabel: "Home", startTimeLabel: "10:30 AM", rawStartTime: demoTime),
                    myData(firstRowLabel: "Bride Get's Dressed", secondRowLabel: "Home", startTimeLabel: "11:30 AM", rawStartTime: demoTime + 5000),
                    myData(firstRowLabel: "Guys Arrive", secondRowLabel: "Hotel", startTimeLabel: "12:30 PM", rawStartTime: demoTime + 10000),
                    myData(firstRowLabel: "Guys Get Dressed", secondRowLabel: "Hotel", startTimeLabel: "1:30 PM", rawStartTime: demoTime + 13000),
                    myData(firstRowLabel: "Groomsmen Photos", secondRowLabel: "Woods", startTimeLabel: "2:30 PM", rawStartTime: demoTime + 14000),
                    myData(firstRowLabel: "Bridesmaids Photos", secondRowLabel: "Woods", startTimeLabel: "3:00 PM", rawStartTime: demoTime + 15000),
                    myData(firstRowLabel: "First Look", secondRowLabel: "Bridge", startTimeLabel: "3:30 PM", rawStartTime: demoTime + 16000),
                    myData(firstRowLabel: "Ceremony", secondRowLabel: "Grounds", startTimeLabel: "4:30 PM", rawStartTime: demoTime + 17000),
                    myData(firstRowLabel: "Reception", secondRowLabel: "Venue", startTimeLabel: "5:30 PM", rawStartTime: demoTime + 18000),
                    myData(firstRowLabel: "Speeches", secondRowLabel: "Venue", startTimeLabel: "6:30 PM", rawStartTime: demoTime + 19000),
                    myData(firstRowLabel: "Send Off", secondRowLabel: "Venue", startTimeLabel: "10:30 PM", rawStartTime: demoTime + 23000),
                    myData(firstRowLabel: "Dancing", secondRowLabel: "Venue", startTimeLabel: "8:30 PM", rawStartTime: demoTime + 20000),]
        orderContent()
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

