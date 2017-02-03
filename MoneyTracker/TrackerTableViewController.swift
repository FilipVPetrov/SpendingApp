//
//  TrackerTableViewController.swift
//  MoneyTracker
//
//  Created by Dean Gaffney on 25/11/2016.
//  Copyright © 2016 Dean Gaffney. All rights reserved.
//

import UIKit
import CoreData

class TrackerTableViewController: UITableViewController {
    var selectedTrackerItems = [Item]()
    var trackers = [Tracker]()
    var selectedTracker: Tracker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        
        self.trackers = CoreDataController.retrieveTrackers()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //add navbar items for adding new item and graph action
    override func viewWillAppear(_ animated: Bool) {
        let add = UIBarButtonItem(barButtonSystemItem: .add,target: self,action: #selector(TrackerTableViewController.addTracker))
        self.navigationItem.setRightBarButtonItems([add,editButtonItem], animated: true)
    }


    @IBAction func addTracker(_ sender: Any) {
        let alert = UIAlertController(title: "New name",message:  "Enter a name for your tracker",preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",style: .default){
            [unowned self] action in
            guard let textField = alert.textFields?.first,
                let trackerName = textField.text else{
                    return
            }
            //create new tracker with user input name
            self.trackers.append(CoreDataController.createNewTracker(name: trackerName,creationDate: Date()))
            self.tableView.reloadData()
            CoreDataController.saveContext()
            print("Added new tracker and reloaded table")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert,animated: true)
      
    }
    
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return trackers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TrackerTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TrackerTableViewCell
        
        let tracker = trackers[indexPath.row]
        cell.nameLabel.text = tracker.name
        cell.totalLabel.text = String(format:"€%.2f",CoreDataController.totalCost(tracker: tracker))
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTrackerItems = trackers[indexPath.row].items?.allObjects as! [Item]
        selectedTracker = trackers[indexPath.row]
        //set owning tracker for items
        for item in selectedTrackerItems{
            item.tracker = selectedTracker
        }
        //may need to set items tracker here
        print(selectedTrackerItems)
        super.performSegue(withIdentifier: "ItemTableViewController", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //delete row from data source
            //delete item from owning tracker
            let tracker = trackers[indexPath.row]
            tracker.removeFromItems(tracker.items!)
            trackers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            //delete object from core data and save
            CoreDataController.getContext().delete(tracker)
            CoreDataController.saveContext()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemTableViewController"{
            let viewController = segue.destination as! ItemTableViewController
            viewController.items = selectedTracker?.items?.allObjects as! [Item]
            viewController.tracker = selectedTracker
            print("Should have went to new segue")
            
        }
    }

    
    func loadSampleTrackers(){
        let tracker1 = CoreDataController.createNewTracker(name: "MONEY", creationDate: Date())
        let tracker2 = CoreDataController.createNewTracker(name: "MONEY2", creationDate: Date())
        trackers += [tracker1,tracker2]
    }
    
}
