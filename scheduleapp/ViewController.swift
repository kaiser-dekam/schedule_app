//
//  ViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 7/10/18.
//  Copyright © 2018 Kaiser De Kam. All rights reserved.
//

import UIKit

struct myData {
    var firstRowLabel: String
    var secondRowLabel: String
    var startTimeLabel: String
    var rawStartTime: Date
    var stopTimeLabel: String
    var rawStopTime: Date
    var isSpecialStatus: Bool
    var isEventTimeLocked: Bool
    
}
var tableData: [myData] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //How many rows in tableview
        return tableData.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.25 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
        
//----------------------Assigning Content to Cell Elements---------------------
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
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
            return cell
        case true:
            //Adding special cell
            let secondaryCell = tableView.dequeueReusableCell(withIdentifier: "MySpecialCell") as! MySpecialCell
            secondaryCell.lblTextSpecial.text = tableData[indexPath.row].firstRowLabel
            secondaryCell.lblTimeSpecial.text = tableData[indexPath.row].startTimeLabel
            
            return secondaryCell

        }
    }
   

    
    
//   Ability to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete {
            tableData.remove(at: indexPath.row)
            myTableView.reloadData()
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
    
    //Delay button will delay *all* upcoming events by 15 minutes.
    //This needs to be adjustable. Provide an option to the user to choose how long to delay
    
    @IBAction func delayFutureEvents(_ sender: Any) {
       var index = 0
        while index < tableData.count {
            if tableData[index].isEventTimeLocked == true {
                print("LOCKED: The item \(tableData[0].isEventTimeLocked) cannot be delayed.")
            } else {
                var newStartTime:Date
                newStartTime = tableData[index].rawStartTime + 12000
                var newStopTime: Date
                newStopTime = tableData[index].rawStopTime + 12000
                tableData[index].startTimeLabel = timeFormatterFunction(date: newStartTime )
                tableData[index].stopTimeLabel = timeFormatterFunction(date: newStopTime)
                print(newStartTime)
                print(newStopTime)
                print("UNLOCKED: The item \(tableData[0].isEventTimeLocked) was delayed.")
            }
            index+=1
            myTableView.reloadData()
        }
        index = 0
    }
    
    

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func refreshTableView(_ sender: Any) {
        myTableView.reloadData()
        print("TableView Reloaded")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    
}

