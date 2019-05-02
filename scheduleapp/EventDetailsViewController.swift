//
//  EventDetailsViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 4/28/19.
//  Copyright © 2019 Kaiser De Kam. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class EventDetailsViewController: ViewController {
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var stopTime: UILabel!
    @IBOutlet weak var notesText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventTitle.text = saveTableData[detailsIndex].firstRowLabel
        eventLocation.text = saveTableData[detailsIndex].secondRowLabel
        startTime.text = saveTableData[detailsIndex].startTimeLabel
        stopTime.text = saveTableData[detailsIndex].stopTimeLabel
//        notesText.text = tableData[detailsIndex].eventNotes
        // Do any additional setup after loading the view.
    }
    



}
