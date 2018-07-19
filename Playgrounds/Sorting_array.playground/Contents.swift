//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct myData {
    var firstRowLabel: String
    var secondRowLabel: String
    var startTimeLabel: String
    var rawStartTime: Date
}

let date = Date()
let calendar = Calendar.current
let hour = calendar.component(.hour, from: date)
let minutes = calendar.component(.minute, from: date)


var tableData: [myData] = []

let newItem = myData(firstRowLabel: "Kaiser", secondRowLabel: "De Kam", startTimeLabel: "3:00", rawStartTime: date)
let secondItem = myData(firstRowLabel: "Hannah", secondRowLabel: "De Kam", startTimeLabel: "3:00", rawStartTime: date + 5000)
let thirdItem = myData(firstRowLabel: "Jody", secondRowLabel: "De Kam", startTimeLabel: "3:00", rawStartTime: date + 10000)

//---------------------------------------------------------
func orderContent() {
    
    var tempArray: [myData] = []

        let highestTime = tableData.max { a, b in a.rawStartTime < b.rawStartTime}
        tempArray.append(highestTime!)
        print(highestTime!)
}

orderContent()

