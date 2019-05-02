import UIKit

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
