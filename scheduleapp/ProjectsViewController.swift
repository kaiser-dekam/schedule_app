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
    var project_permissions: String
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
var ownerProjects: [String] = []
var guestProjects: [String] = []

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var backgroundImage: UIImageView?
    @IBOutlet weak var projectsBackgroundImage: UIImageView!
    
    @IBOutlet weak var projectsTableView: UITableView!
    
    //TableView Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectViewCell
        cell.project_Label.text = projectArray[indexPath.row].title
        print("Creating Project Cell: Title: \(projectArray[indexPath.row].title) -- Permission: \(projectArray[indexPath.row].project_permissions)")
        cell.projectPermissionLabel.text = projectArray[indexPath.row].project_permissions.uppercased()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentProject_id = projectArray[indexPath.row].project_id
        currentProject_title = projectArray[indexPath.row].title
        currentProject_permissions = projectArray[indexPath.row].project_permissions
        performSegue(withIdentifier: "toEvents", sender: self)
    }
    
//    Deleting Projects
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if projectArray[indexPath.row].project_permissions == "owner" {
            if editingStyle == UITableViewCellEditingStyle.delete {
                let projectIDForDelete: String = projectArray[indexPath.row].project_id
                fireRef!.child("project_data").child(projectIDForDelete).removeValue()
                // Put in error check for deleting event data. It's possible to have a project with no events
                ref!.child("Event_Data").child(projectIDForDelete).removeValue()
                ref!.child("userconfig").child(userID!).child("projects").child("owner").child(projectIDForDelete).removeValue()
                projectArray.removeAll()
                downloadData()
                tableView.reloadData()
            }
        } else {
            let alert = UIAlertController(title: "Unable To Delete", message: "You do not have permission from the owner to delete this project.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .destructive, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
 

    
    func downloadData() {
        
        var isDownloadComplete: Bool = false
        print("Download Data Started")
        var projectPermission = ""
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
                
                if ownerProjects.contains(projectid as! String) {
                    projectPermission = "owner"
                    print("owner projects \(ownerProjects)")
                    print("\(userEmail) is the \(projectPermission) of \(projectid)")
                } else if guestProjects.contains(projectid as! String) {
                    projectPermission = "guest"
                    print("guest projects \(guestProjects)")
                    print("\(userEmail) is the \(projectPermission) of \(projectid)")
                }
                
                var project_Data = projectStruct.init(title: projecttitle as! String, project_id: projectid as! String, project_permissions: projectPermission as! String)
                    
                
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
        // Download OWNED Projects
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
                ownerProjects.append(projectID as! String)
                configArray.append(configData)
            }
            userConfigDownloadCompleted = true
            print("Config Array: \(configArray)")
            print("Finished download of owner configuration")
        }
        // Download GUEST Projects
        print("Downloading Guest Config")
        reference.child("userconfig").child(userID!).child("config-projects").child("guest").observeSingleEvent(of: .value) { (snapshot) in
            // Get User Value
            for project in snapshot.children.allObjects as![DataSnapshot]{
                userConfigDownloadCompleted = false
                let configObject = project.value as? [String: AnyObject]
                let title = configObject?["project_title"]
                let projectID = configObject?["project_id"]
                let ownership = configObject?["permissions"]
                var configData = configStruct.init(title: title as! String, project_id: projectID as! String, ownership: ownership as! String)
                guestProjects.append(projectID as! String)
                configArray.append(configData)
            }
            userConfigDownloadCompleted = true
            print("Owned Projects = \(ownerProjects)")
            print("Guest Projects = \(guestProjects)")
            self.startDownload()
        }
    }
    
 
    
    
    func startDownload () {
        if userConfigDownloadCompleted == true {
            print("+++++++++++++ About to start downloading Data +++++++++++")
            downloadData()
        }
    }

    func clearOldData() {
        configArray.removeAll()
        projectArray.removeAll()
        ownerProjects.removeAll()
        guestProjects.removeAll()
        print("Old Data Cleaned")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearOldData()
        projectsBackgroundImage!.image = UIImage(named: "projects-screen-pastel.png")
        fireRef = Database.database().reference()
        getUserConfig()
        
        
        hideKeyboardWhenTappedAround()
    }
    
}
