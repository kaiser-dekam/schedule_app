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
}
var tableData: [myData] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var myTableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //How many rows in tableview
        return tableData.count
    }

  
    
//----------------------Assigning Content to Cell Elements---------------------
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyViewCell
        cell.lblFirstRow.text = tableData[indexPath.row].firstRowLabel
        cell.lblSecondRow.text = tableData[indexPath.row].secondRowLabel
        cell.lblStartTime.text = tableData[indexPath.row].startTimeLabel
        cell.lblStopTime.text = tableData[indexPath.row].stopTimeLabel
        tableView.separatorStyle = .none
        return cell
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
        myTableView.reloadData()
        print("TableView was reloaded")

    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.bringSubview(toFront: addButton);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

