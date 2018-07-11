//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct myStruct {
    var firstRowLabel: String
    var secondRowLabel: String
}

  var tableData: [myStruct] = []


tableData = [
    myStruct(firstRowLabel: "The first row", secondRowLabel: "Hello"),
    myStruct(firstRowLabel: "The second row", secondRowLabel: "There"),
    myStruct(firstRowLabel: "Third and final row", secondRowLabel: "https://peterwitham.com")
]

var newItem = myStruct(firstRowLabel: "Kaiser", secondRowLabel: "De Kam")

tableData.append(newItem)

tableData


