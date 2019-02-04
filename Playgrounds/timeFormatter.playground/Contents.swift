import UIKit


// Get current time + 5000 seconds
//var currentTime = Date()
//var advancedTime = currentTime + 5000

// Create time formatter
//var formatter = DateFormatter()
//formatter.timeStyle = .short
//formatter.dateStyle = .none
//formatter.dateFormat = "HH:MM"

//time = formatter.date(from: currentTime)
//var stringTime = formatter.string(from: currentTime)

// timeInputStop.text = stopTimeFormatter.string(from: stopTimePicker.date)

//print("Converted: \(stringTime)")
//print("RAW: \(currentTime)")

//Converted -> String?!










//----------------------Convert Date to Int
//Reference: https://stackoverflow.com/questions/39934057/convert-date-to-integer-in-swift

let setDate = Date()


// convert Date to TimeInterval (typealias for Double)
print("Date is set to \(setDate)")
let timeInterval = setDate.timeIntervalSince1970

// convert to Integer
let myInt = Int(timeInterval)

print("Int is saved as \(myInt)")
//----------------------Convert Int to Date----------------------
// convert Int to Double
let timeIntervalReturn = Double(myInt)

// create NSDate from Double (NSTimeInterval)
let myNSDate = Date(timeIntervalSince1970: timeIntervalReturn)

print("Date is resaved as \(myNSDate)")











