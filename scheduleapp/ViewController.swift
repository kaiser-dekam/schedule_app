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
}
var tableData: [myData] = []


//https://peterwitham.com/swift-archives/intermediate/creating-and-using-ios-prototype-cells-with-swift/

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var myTableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //How many rows in tableview
        return tableData.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! MyViewCell
        
        cell.lblFirstRow.text = tableData[indexPath.row].firstRowLabel
        cell.lblSecondRow.text = tableData[indexPath.row].secondRowLabel
    
        return cell
    }
    
   //Ability to edit/delete
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    {
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            list.remove(at: indexPath.row)
//            myTableView.reloadData()
//        }
//    }
//
//    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
        print("Reload ran")
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

