//
//  ProjectsViewController.swift
//  scheduleapp
//
//  Created by Kaiser De Kam on 2/13/19.
//  Copyright © 2019 Kaiser De Kam. All rights reserved.
//

import UIKit
import Firebase

struct projectStruct {
    var title: String
    var project_id: String
}

struct configStruct {
    var title: String
    var project_id: String
    var ownership: String
}


var fireRef: DatabaseReference!
var projectArray: [projectStruct] = []
var configArray: [configStruct] = []
var userConfigDownloadCompleted: Bool = false

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var projectsTableView: UITableView!
    
    //TableView Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectViewCell
        cell.project_Label.text = projectArray[indexPath.row].title
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentProject = projectArray[indexPath.row].project_id
        performSegue(withIdentifier: "toEvents", sender: self)
    }
    
//    Deleting Projects
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let projectIDForDelete: String = projectArray[indexPath.row].project_id
            print(userID!)
            fireRef!.child("project_data").child(projectIDForDelete).removeValue()
            print("User ID = \(userID!) and projectIDForDelete = \(projectIDForDelete)")
            ref!.child("Event_Data").child(projectIDForDelete).removeValue()
        ref!.child("userconfig").child(userID!).child("projects").child("owner").child(projectIDForDelete).removeValue()
            projectArray.removeAll()
            downloadData()
            tableView.reloadData()

        }
    }
 

    
    func downloadData() {
        
        var isDownloadComplete: Bool = false
        print("Download Data Started")
        var index = 0
        projectArray.removeAll()

        for items in configArray {
        print("Starting Download in Config Array. Index: \(index)")
                let downloadingID = configArray[index].project_id
                print("Starting download for projectID: \(downloadingID)")
                fireRef.child("project_data").child(downloadingID).observeSingleEvent(of: .value) { (snapshot) in
                for project in snapshot.children.allObjects as![DataSnapshot]{
                let projectObject = project.value as? [String: AnyObject]
                let projectid = projectObject?["project_id"]
                let projecttitle = projectObject?["project_title"]
                var project_Data = projectStruct.init(title: projecttitle as! String, project_id: projectid as! String)
                projectArray.append(project_Data)
                print("Finished downloading \(downloadingID) and adding \(project_Data) to projectArray")
                }
                if index == configArray.count {
                    isDownloadComplete = true
                }
                if isDownloadComplete == true {
                    print("Download complete: \(isDownloadComplete)")
                    self.projectsTableView.reloadData()
                }
            }
            index += 1
            print("Repeating through config")
        }
    }
    
    func getUserConfig() {
        // Download owned projects
        configArray.removeAll()
        print("Starting to download user configuration")
        reference.child("userconfig").child(userID!).child("config-projects").child("owner").observeSingleEvent(of: .value) { (snapshot) in
            // Get User Value
            for project in snapshot.children.allObjects as![DataSnapshot]{
                userConfigDownloadCompleted = false
                let configObject = project.value as? [String: AnyObject]
                let title = configObject?["project_title"]
                let projectID = configObject?["project_id"]
                let ownership = configObject?["permissions"]
                var configData = configStruct.init(title: title as! String, project_id: projectID as! String, ownership: ownership as! String)
                configArray.append(configData)
            }
            userConfigDownloadCompleted = true
            print("Config Array: \(configArray)")
            print("Finished download of user configuration")
            self.startDownload()
            
        }
    }
    
    func startDownload () {
        if userConfigDownloadCompleted == true {
            print("+++++++++++++ About to start downloading Data +++++++++++")
            downloadData()
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireRef = Database.database().reference()
        getUserConfig()

        hideKeyboardWhenTappedAround()
    }
    
}
