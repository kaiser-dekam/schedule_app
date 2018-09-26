import UIKit


var projects = Dictionary<String, Any>()

var projectsArray = [[String:Any]]()

//Dummy data to take place of the schedule
struct Event {
    var type = "Wedding"
    var Day_of_week = "Wednesday"
}
var newEvent = Event(type: "Wedding", Day_of_week: "Saturday")

//Creates project(dictionary) including the schedule while adding data for Access Code and Date.
projects = ["Schedule": newEvent, "Date": 12, "AccessCode": "D6S8S"]



//Adds project to the project array? Not 100% sure on the process here yet. Also, needs to be done in the right order to keep data straight.
var newProject = projects
projectsArray.append(newProject)


//Grab Access Code from Dictionary (And check it against a static value)
func getScheduleFromAccessCode() {
    let AccessCode = projects["AccessCode"] as! String
    print(AccessCode)
    if AccessCode == "D6S8S" {
        print("We've got the access code")
    }
    
}
getScheduleFromAccessCode()




