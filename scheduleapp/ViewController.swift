//
//  ViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 7/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

struct myData {
    var firstRowLabel: String
    var secondRowLabel: String
    var startTimeLabel: String
    var rawStartTime: Date
    var stopTimeLabel: String
    var rawStopTime: Date
    var isSpecialStatus: Bool
    var uniqueID: String
    
}
var userID: String?
var userEmail: String?
var tableData: [myData] = []
var ref: DatabaseReference!
var searchEntry: String?
var detailsIndex = 0
var saveTableData: [myData] = []
var indexForLiveClock: Int = 0

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var eventSearchBar: UISearchBar!
    @IBOutlet weak var headerText: UIButton!
    
    
    
    //----------Organizing Content In Order -----------------
    func orderContent() {
        tableData = tableData.sorted(by: { $0.rawStartTime > $1.rawStartTime })
        tableData = tableData.reversed()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //How many rows in tableview
        return tableData.count
    }
    
   
        
    

    
//----------------------Assigning Content to Cell Elements---------------------
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if (tableData.count >= 2) {
                orderContent()
            }
        
        // TODO: Remove items that don't match search query. ------------
        // https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started
        
        //----------------------------------
        switch tableData[indexPath.row].isSpecialStatus {
        case false:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyViewCell
            cell.lblFirstRow.text = tableData[indexPath.row].firstRowLabel
            cell.lblSecondRow.text = tableData[indexPath.row].secondRowLabel
            cell.lblStartTime.text = tableData[indexPath.row].startTimeLabel
            cell.lblStopTime.text = tableData[indexPath.row].stopTimeLabel
            cell.cellViewLayer.layer.cornerRadius = 8
            cell.cellViewLayer.layer.masksToBounds = true
            tableView.separatorStyle = .singleLine
            
            if (removeOldEvents == true && tableData[indexPath.row].rawStopTime < Date()) {
                cell.lblFirstRow.text = tableData[indexPath.row].firstRowLabel
                cell.lblSecondRow.text = tableData[indexPath.row].secondRowLabel
                cell.lblStartTime.text = tableData[indexPath.row].startTimeLabel
                cell.lblStopTime.text = tableData[indexPath.row].stopTimeLabel
            }
            
                // Check if event is currently occuring. If it is set the background color to green.
                if (Date() > tableData[indexPath.row].rawStartTime && Date() <= tableData[indexPath.row].rawStopTime) {
                    cell.backgroundColor = UIColor.init(red: 110/255, green: 140/255, blue: 132/255, alpha: 1.0)
                    
                }
                //Needs to be massaged - too many events are being highlighted. COlors also need to be adjusted with RGB
                if (tableData[indexPath.row].rawStartTime >= Date() - 6000 && (Date() < tableData[indexPath.row].rawStartTime)) {
                    cell.backgroundColor = UIColor.init(red: 237/255, green: 178/255, blue: 64/255, alpha: 1.0)
                }
            
            
            
                return cell
            
            
        case true:
            //Adding special cell
            let secondaryCell = tableView.dequeueReusableCell(withIdentifier: "MySpecialCell") as! MySpecialCell
            secondaryCell.lblTextSpecial.text = tableData[indexPath.row].firstRowLabel
            secondaryCell.lblTimeSpecial.text = tableData[indexPath.row].startTimeLabel
            if (removeOldEvents == true && tableData[indexPath.row].rawStopTime < Date()) {
                secondaryCell.backgroundColor = UIColor.gray
            }
                return secondaryCell

        }
        
      
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailsIndex = indexPath.row
        saveTableData = tableData
        print(tableData)
        
        performSegue(withIdentifier: "eventDetails", sender: self)
    }
    
//   Ability to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let eventIDForDelete: String = tableData[indexPath.row].uniqueID
            print("Unique ID for deletion \(eventIDForDelete)")
            tableData.remove(at: indexPath.row)
            ref!.child("Event_Data").child(currentProject_id).child("Events").child(eventIDForDelete).removeValue()
            tableView.reloadData()
            
            
        }    
    }
    

    
    //------------------Highlighting cell when active--------------

    override func viewDidAppear(_ animated: Bool) {
//        myTableView.reloadData()
        print("TableView was reloaded")

    }

    //Change Swipe to delete background color and text
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletebutton = UITableViewRowAction(style: .default, title: "Delete") {
            (action, indexPath) in tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: indexPath)
            return
        }

        let swipeColor = UIColor.init(red: 109/255, green: 109/255, blue: 109/255, alpha: 1.0)
        deletebutton.backgroundColor = swipeColor
        deletebutton.title = "Remove"
        return [deletebutton]
    }
    
 
    //Format Time Data for Delaying
    func timeFormatterFunction(date:Date) -> String {
        let newString: String
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeFormatter.dateStyle = .none
        newString = timeFormatter.string(from: date)
        
        return newString
    }

    func downloadFirebaseData() {
        tableData.removeAll()
        ref.child("Event_Data").child(currentProject_id).child("Events").observeSingleEvent(of: .value) { (snapshot) in
            // Get User Value
            
            if snapshot.childrenCount > 0 {
                tableData.removeAll()
                
                for events in snapshot.children.allObjects as![DataSnapshot]{
                    let eventObject = events.value as? [String: AnyObject]
                    let title = eventObject?["Title"] //Need to change to lowercase
                    let location = eventObject?["location"]
                    let special = eventObject?["special_status"]
                    let startTimeData = eventObject?["start_time"]
                    let stopTimeData = eventObject?["stop_time"]
                    let uniqueEventID = eventObject?["uniqueID"]
                    
                    
                    func convertIntegerToDate(timeInt: Int) -> Date {
                        let timeIntervalReturn = Double(timeInt)
                        let myConvertedDate = Date(timeIntervalSince1970: timeIntervalReturn)
//                        print("Time integer has been converted from \(timeInt) to \(myConvertedDate)")
                        return myConvertedDate
                    }
                    
                    // Convert Int to Date
                    var convertedStartTimeDate = convertIntegerToDate(timeInt: startTimeData as! Int)
                    var convertedStopTimeDate = convertIntegerToDate(timeInt: stopTimeData as! Int)
                   
                    // Convert Date to String
                    func convertDateToString(useTime: Date)-> String {
                    let stringTimeFormatter = DateFormatter()
                    stringTimeFormatter.timeStyle = .short
                    stringTimeFormatter.dateStyle = .none
//                    var stringStartTime = convertTimeToInt(time: timePicker.date)
                    let convertedTime:String = stringTimeFormatter.string(from: useTime)
                        return convertedTime
                    }
                    
                    let startTimeString = convertDateToString(useTime: convertedStartTimeDate)
                    let stopTimeString = convertDateToString(useTime: convertedStopTimeDate)
                    

                    
                    let event = myData.init(firstRowLabel: title as! String, secondRowLabel: location as! String, startTimeLabel: startTimeString, rawStartTime: convertedStartTimeDate, stopTimeLabel: stopTimeString, rawStopTime: convertedStopTimeDate, isSpecialStatus: special as! Bool, uniqueID: uniqueEventID as! String)
                    tableData.append(event)
                    print("Reloading TableView")
                    self.reloadTableViewFunction()
                }
            }
        }
    }
    
    
    @IBAction func refreshData(_ sender: Any) {
        downloadFirebaseData()
        reloadTableViewFunction()
    }
    
  
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.timerInterval), userInfo: nil, repeats: true)
        
    }
    @objc func timerInterval()
    {
       reloadTableViewFunction()
        indexForLiveClock = indexForLiveClock + 1
       showLiveClock()
    
    }
    

    
    func reloadTableViewFunction() {
        if myTableView != nil {
        myTableView.reloadData()
    } else {
        print("myTableView is nil")
        }
    }
    
    func showLiveClock() {
        if indexForLiveClock > 5 {
            // ---------------- TODO: Time Formatter to display clock time instead of text below
            
            let clockFormatter = DateFormatter()
            clockFormatter.timeStyle = .short
            clockFormatter.dateStyle = .none
//            stopTimeInt = convertTimeToInt(time: stopTimePicker.date)
//            timeInputStop.text = stopTimeFormatter.string(from: stopTimePicker.date)
            var clockTime = clockFormatter.string(from: Date())
            headerText.setTitle("\(clockTime)", for: .normal)

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        downloadFirebaseData()
        scheduledTimerWithTimeInterval()
        showLiveClock()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
