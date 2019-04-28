//
//  SecondViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 7/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit
import Firebase

var recentLocations: [String] = []
class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Firebase
    var ref: DatabaseReference!
    
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
    var startTimeInt: Int = 0
    var stopTimeInt: Int = 0
   
    var startTimeDateConverted: Date?
    var stopTimeDateConverted: Date?
//---------------------------------------------------------------------

    
    
    
//-----------------------START TIME PICKER ------------------------
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
        startTimeInt = convertTimeToInt(time: timePicker.date)
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
        stopTimeInt = convertTimeToInt(time: stopTimePicker.date)
        timeInputStop.text = stopTimeFormatter.string(from: stopTimePicker.date)

        //End Picker window
        self.view.endEditing(true)

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
        if recentLocationsIndex == 0 {
        } else {
        inputTwo.text = recentLocations[recentLocationsIndex]
        if recentLocationsIndex >= recentLocations.count || recentLocationsIndex <= 10 {
            recentLocationsIndex = 0
            }

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
           
            switch isSingleTimeEvent {
            case true:
            //Add Item to Local dictionary/struct
                let uniqueEventID = ref!.childByAutoId().key

                
                let newItem = myData(firstRowLabel: inputSourceOne!, secondRowLabel: inputSourceTwo!, startTimeLabel: inputTimeStart!, rawStartTime: timePicker.date, stopTimeLabel: inputTimeStop!, rawStopTime: stopTimePicker.date, isSpecialStatus: true, uniqueID: uniqueEventID!)
                tableData.append(newItem)
            //Add Items to FIREBASE
                //assign unique id number to event
                
                let data = ["Title": inputSourceOne!,
                            "location": inputSourceTwo!,
                            "start_time":startTimeInt,
                            "stop_time":stopTimeInt,
                            "special_status": true,
                            "uniqueID": uniqueEventID!,
                            "project": currentProject_id
                    ] as [String : Any]
                self.ref.child("Event_Data").child(currentProject_id).child("Events").child(uniqueEventID!).setValue(data)

                
            case false:
            //Add Item to Local dictionary/struct

                let uniqueEventID = ref!.childByAutoId().key

                let newItem = myData(firstRowLabel: inputSourceOne!, secondRowLabel: inputSourceTwo!, startTimeLabel: inputTimeStart!, rawStartTime: timePicker.date, stopTimeLabel: inputTimeStop!, rawStopTime: stopTimePicker.date, isSpecialStatus: false, uniqueID: uniqueEventID!)
                tableData.append(newItem)
            //Add Item to FIREBASE
                let data = ["Title": inputSourceOne!,
                            "location": inputSourceTwo!,
                            "start_time":startTimeInt,
                            "stop_time":stopTimeInt,
                            "special_status": false,
                            "uniqueID": uniqueEventID!,
                            "project": currentProject_id
                    ] as [String : Any]
//                self.ref.child(userID!).child("Events").child(uniqueEventID!).setValue(data)
                
                //Save new path for events... see Bear note
                self.ref.child("Event_Data").child(currentProject_id).child("Events").child(uniqueEventID!).setValue(data)
            }
            
            
            
           
            addToRecentLocations(location: inputSourceTwo!)
            recentLocationsIndex = recentLocationsIndex + 1
            inputOne.text = ""
            inputTwo.text = ""
            timeInputStart.text = ""
            timeInputStop.text = ""
        }
    }


//---------CONVERT TIME PICKER TO INT--------------------------------
    func convertTimeToInt(time: Date)-> Int {
        let timeInterval = time.timeIntervalSince1970
        let myInt = Int(timeInterval)
        print("Time has been converted from \(time) to \(myInt)")
        return myInt
    }
    
//---------CONVERT INT to DATE --------------------------------
    func convertIntegerToDate(timeInt: Int) -> Date {
        let timeIntervalReturn = Double(timeInt)
        let myConvertedDate = Date(timeIntervalSince1970: timeIntervalReturn)
        print("Time integer has been converted from \(timeInt) to \(myConvertedDate)")
        return myConvertedDate
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDatePicker()
        createStopDatePicker()

        ref = Database.database().reference()
        
        hideKeyboardWhenTappedAround()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

