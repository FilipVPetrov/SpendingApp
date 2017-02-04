//
//  ItemViewController.swift
//  MoneyTracker
//
//  Created by Student on 2/3/17.
//  Copyright © 2017 Dean Gaffney. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var canelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var item: Item?
    var tracker: Tracker?
    

    
        
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Add Item"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 42/255, green:48/255 , blue: 56/255, alpha: 1)

        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

       //set up text field delegates
        nameTextField.delegate = self
        categoryTextField.delegate = self
        costTextField.delegate = self
        dateTextField.delegate = self
        
        if let item = item{
            navigationItem.title = item.name
            nameTextField.text = item.name
            categoryTextField.text = String(item.category!)
            costTextField.text = String(format: "%.2f",item.cost)
            dateTextField.text = String(format: "%d/%d/%d", item.purchaseDay,item.purchaseMonth,item.purchaseYear)
        }
        
        var seguedTracker = tracker{
            didSet{
                tracker = seguedTracker
            }
        }
        //set up date text field automatically
        let formatter = DateFormatter()
        let date = Date()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        let formattedDate = formatter.string(from: date)
        let dateComponents = formattedDate.components(separatedBy: "/")
        print(dateComponents)
        dateTextField.text =
            "\(dateComponents[1])/\(dateComponents[0])/\(dateComponents[2])"
        //enable save button only if field is not empty
        saveButton.isEnabled = (isAllFieldsFilled()) ? true : false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      //  saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = nameTextField.text
        saveButton.isEnabled = (isAllFieldsFilled()) ? true : false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //checks if all fields are filled in
    func isAllFieldsFilled()->Bool{
        return !(nameTextField.text?.isEmpty)! &&
               !(categoryTextField.text?.isEmpty)! &&
               !(dateTextField.text?.isEmpty)! &&
               !(costTextField.text?.isEmpty)!
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as! UIBarButtonItem === saveButton){
            // initalise properties of the object
            let name = nameTextField.text ?? ""
            let cost = costTextField.text ?? "0.0"
            let category = categoryTextField.text ?? "Misc"
            item = CoreDataController.createNewItem(name: name, cost: Double(cost)!, purchaseDate: Date(),category: category,owningTracker: tracker!)
        }
    }
    
    
    //on cancel button pressed
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddItemMode = presentingViewController is UINavigationController
        if isPresentingInAddItemMode{
            dismiss(animated: true, completion: nil)
        }else{
            navigationController!.popViewController(animated: true)
        }
    }
       

}
