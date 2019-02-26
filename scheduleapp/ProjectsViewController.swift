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


var fireRef: DatabaseReference!
//var projectArray:[projectStruct] = []
var projectArray: [projectStruct] = []



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
        currentProject = projectArray[indexPath.row].title
        performSegue(withIdentifier: "toEvents", sender: self)
    }
    
//    Deleting Projects
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let projectIDForDelete: String = projectArray[indexPath.row].project_id
            print(userID!)
            fireRef!.child("projects").child(userID!).child(projectIDForDelete).removeValue()
            projectArray.removeAll()
            downloadData()
            tableView.reloadData()

        }
    }
 

    
    func downloadData() {
        projectArray.removeAll()
        fireRef.child("projects").child("\(userID!)").observeSingleEvent(of: .value) { (snapshot) in
            // Get User Value
                for project in snapshot.children.allObjects as![DataSnapshot]{
                    print("inside snapshot")
                    let projectObject = project.value as? [String: AnyObject]
                    let title = projectObject?["project_title"]
                    let projectID = projectObject?["project_id"]
                    
                    var project_Data = projectStruct.init(title: title as! String, project_id: projectID as! String)
                    projectArray.append(project_Data)
                    print(projectArray)
            }
            // change to projectTableView
            self.projectsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fireRef = Database.database().reference()
        downloadData()
        hideKeyboardWhenTappedAround()
    }
    
}
