//
//  ItemTableViewController.swift
//  MoneyTracker
//
//  Created by Student on 2/3/17.
//  Copyright © 2017 Dean Gaffney. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var tracker: Tracker?
    //items from selected tracker to display
    var items = [Item]()
    var seguedItems = [Item](){
        didSet{
            items = seguedItems
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
               print("Loaded sample items")
      print("Tracker in ItemViewController  \(tracker?.name)")
    }
    
    //add navbar items for adding new item and graph action
    override func viewWillAppear(_ animated: Bool) {
        let add = UIBarButtonItem(barButtonSystemItem: .add,target: self,action: #selector(ItemTableViewController.addItemButtonPressed))
        let action = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ItemTableViewController.graphButtonPressed))
        //let income = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action:
        //    #selector(ItemTableViewController.incomeButtonPressed))
        self.navigationItem.setRightBarButtonItems([add, action, editButtonItem], animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChartViewController"{
            let viewController = segue.destination as! ChartViewController
            viewController.items = items
            print("Should have went to chart view controller")
        }else if segue.identifier == "showDetail"{
            let itemViewController = segue.destination as! ItemViewController
            if let selectedCell = sender as? ItemTableViewCell{
                let indexPath = tableView.indexPath(for: selectedCell)
                let selectedItem = items[(indexPath?.row)!]
                itemViewController.item = selectedItem
                itemViewController.tracker = tracker
            }
        }else if segue.identifier == "ItemViewController"{
            let navViewController = segue.destination as! UINavigationController
            let addViewController = navViewController.topViewController as! ItemViewController
            addViewController.tracker = tracker
            print("Segued to item view controller to add item")
        }
        /*else if segue.identifier == "IncomeViewController" {
            _ = segue.destination as! IncomeViewController
        }*/
    }

    
    func graphButtonPressed(){
        print("Graph button pressed")
        performSegue(withIdentifier: "ChartViewController", sender: self)
    }
    
    func addItemButtonPressed(){
        print("Clicked add item button")
        //perform a segue into a new view where user fills out details of the item
        performSegue(withIdentifier: "ItemViewController", sender: self)
        print("Made it to Add Item Controller") 
    }
    func incomeButtonPressed() {
        print("Clicked income item button")
        performSegue(withIdentifier: "IncomeViewController", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ItemTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ItemTableViewCell
        
        let item = items[indexPath.row]
        cell.itemNameLabel.text = item.name
        cell.itemCostLabel.text = String(format:"€%.2f",item.cost)
        cell.itemCategoryLabel.text = String(item.category!)
        cell.purchaseDateLabel.text = String(format: "%d/%d/%d",item.purchaseDay,item.purchaseMonth,item.purchaseYear)        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //delete row from data source
            //delete item from owning tracker
            let item = items[indexPath.row]
            item.tracker?.removeFromItems(item)
            items.remove(at: indexPath.row)
          
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataController.saveContext()
        }
       
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: Navigation
    @IBAction func unwindToTrackerList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? ItemViewController, let item = sourceViewController.item{
            
            //update item
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                tracker?.removeFromItems(items[selectedIndexPath.row])
                items[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
            //add a new item and add the item to the trackers list of items
                let newIndexPath = IndexPath(row: items.count, section: 0)
                items.append(item)
                tracker?.addToItems(item)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            //save items
            print("In unwind made it to save")
            CoreDataController.saveContext()
        }
    }
}
