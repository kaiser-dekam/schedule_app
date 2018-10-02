//
//  SecondViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 7/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit

var recentLocations: [String] = []
class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Inputs
    @IBOutlet weak var inputOne: UITextField!
    @IBOutlet weak var inputTwo: UITextField!
    
    //Labels
    @IBOutlet weak var recentLocationsPicker: UIPickerView!
    @IBOutlet weak var recentLocationReadOut: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var recentButton: UIButton!
    
    //Variables
    var recentLocationsIndex = 0

    
    @IBOutlet var createView: UIView!
    var titleEditingDidChange: Bool = false
    @IBAction func titleChanged(_ sender: Any) {
//        createView.layer.backgroundColor = #colorLiteral(red: 1, green: 0.3921568627, blue: 0.4274509804, alpha: 1)
    }
    
    
    
    
    //START TIME PICKER
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
    
    //-----------------------STOP TIME PICKER ------------------------
    
    //TIME PICKER
    
    @IBOutlet weak var timeInputStop: UITextField!
    let stopTimePicker = UIDatePicker()
    
    func createStopDatePicker(){
        //format the display of timepicker
        stopTimePicker.datePickerMode = .time
        
        //assign Date picker to our textfield
        timeInputStop.inputView = stopTimePicker
        
        // create a toolbar
        let stopToolbar = UIToolbar()
        stopToolbar.sizeToFit()
        
        //add a done button on the toolbar
        let doneStopButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(stopDoneClicked))
        stopToolbar.setItems([doneStopButton], animated: true)
        timeInputStop.inputAccessoryView = stopToolbar
    }
    @objc func stopDoneClicked() {
        //format the date display in textfield
        let stopTimeFormatter = DateFormatter()
        stopTimeFormatter.timeStyle = .short
        stopTimeFormatter.dateStyle = .none
        timeInputStop.text = stopTimeFormatter.string(from: stopTimePicker.date)
        
        //End Picker window
        self.view.endEditing(true)

    }
    
    

    
    //----------Organizing Content In Order -----------------
    
    func orderContent() {
        tableData = tableData.sorted(by: { $0.rawStartTime > $1.rawStartTime })
        tableData = tableData.reversed()
 }
    
    //----------Add locations to recently used list----------

    func addToRecentLocations(location:String) {
        if recentLocations.contains(location) {
            print("Already available in recent locations")
        } else {
            recentLocations.append(location)
            print("------------ Added to recent locations. Recent locations now include = \(recentLocations)")
        }
    }
    

    @IBAction func nextRecentLocation(_ sender: Any) {
        print("The recent locations INDEX is ....\(recentLocationsIndex)")
        inputTwo.text = recentLocations[recentLocationsIndex]
        recentLocationsIndex = recentLocationsIndex + 1
        if recentLocationsIndex >= recentLocations.count || recentLocationsIndex <= 10 {
            recentLocationsIndex = 0
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return recentLocations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recentLocations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        recentLocationReadOut.text = recentLocations[row]
        
    }
    
    
    
    
    
    
    
    
    //Switch Element to show/hide stop time also assign special status
    var isSingleTimeEvent: Bool = false
    @IBAction func specialStatusSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            isSingleTimeEvent = true
            timeInputStop.isHidden = true
            print("Switch is on")
        } else if sender.isOn == false {
            isSingleTimeEvent = false
            timeInputStop.isHidden = false
            print("Switch is off")
        }
        
    }
    
    // Switch controlling whether an event time is locked
    var eventLockStatus: Bool = false
    @IBAction func lockEventValueChanged(_ sender: UISwitch) {
        if sender.isOn == true {
            eventLockStatus = true
            print("Event is locked")
        } else if sender.isOn == false {
            eventLockStatus = false
            print("Event is not locked")
        }
    }
    
    
    //---------Add to data-----------------------------------
    @IBAction func addItem(_ sender: Any) {
        let inputSourceOne = inputOne.text
        let inputSourceTwo = inputTwo.text
        let inputTimeStart = timeInputStart.text
        let inputTimeStop = timeInputStop.text
        
        
        
        if (inputSourceOne != "" && inputTimeStart != "") {
            print(isSingleTimeEvent)
           
            switch isSingleTimeEvent {
            case true:
                let newItem = myData(firstRowLabel: inputSourceOne!, secondRowLabel: inputSourceTwo!, startTimeLabel: inputTimeStart!, rawStartTime: timePicker.date, stopTimeLabel: inputTimeStop!, rawStopTime: stopTimePicker.date, isSpecialStatus: true, isEventTimeLocked: eventLockStatus)
                tableData.append(newItem)
            case false:
                let newItem = myData(firstRowLabel: inputSourceOne!, secondRowLabel: inputSourceTwo!, startTimeLabel: inputTimeStart!, rawStartTime: timePicker.date, stopTimeLabel: inputTimeStop!, rawStopTime: stopTimePicker.date, isSpecialStatus: false, isEventTimeLocked: eventLockStatus)
                tableData.append(newItem)
            }
            
            
            
            if (tableData.count >= 2) {
                orderContent()
            }
            addToRecentLocations(location: inputSourceTwo!)
            inputOne.text = ""
            inputTwo.text = ""
            timeInputStart.text = ""
            timeInputStop.text = ""
//            createView.layer.backgroundColor = #colorLiteral(red: 0, green: 0.8134917422, blue: 0.05527941153, alpha: 1)
            print(tableData)
        }
        
        
        
        
    }

    
    @IBAction func enterDemoData(_ sender: Any) {
        let demoTime = Date()
        let demoData: [myData]
        tableData = [myData(firstRowLabel: "Getting Ready", secondRowLabel: "Home", startTimeLabel: "10:30 AM", rawStartTime: demoTime, stopTimeLabel: "11:00 AM", rawStopTime: demoTime + 8000, isSpecialStatus: false, isEventTimeLocked: false),
                     myData(firstRowLabel: "Bride Get's Dressed", secondRowLabel: "Home", startTimeLabel: "11:30 AM", rawStartTime: demoTime + 5000, stopTimeLabel: "12:00PM", rawStopTime: demoTime + 10000, isSpecialStatus: true, isEventTimeLocked: false),
                    myData(firstRowLabel: "Getting Ready", secondRowLabel: "Home", startTimeLabel: "10:30 AM", rawStartTime: demoTime, stopTimeLabel: "11:00 AM", rawStopTime: demoTime + 11000, isSpecialStatus: false, isEventTimeLocked: false),
                    myData(firstRowLabel: "Bride Get's Dressed", secondRowLabel: "Home", startTimeLabel: "11:30 AM", rawStartTime: demoTime + 5000, stopTimeLabel: "12:00PM", rawStopTime: demoTime + 12000, isSpecialStatus: false, isEventTimeLocked: false)
                    ]
        orderContent()
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

