//
//  IncomeViewController.swift
//  MoneyTracker
//
//  Created by Student on 2/3/17.
//  Copyright © 2017 Dean Gaffney. All rights reserved.
//

import UIKit

class IncomeViewController: UIViewController , UITextFieldDelegate {

   
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var income: Income?
    
   
   
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Add Income"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
         self.navigationController?.navigationBar.barTintColor = UIColor(red: 42/255, green:48/255 , blue: 56/255, alpha: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        amountTextField.delegate = self
        dateTextField.delegate = self
        
        if let income = income{
            amountTextField.text = String(format: "%.2f", income.amount!)
            dateTextField.text = String(format: "%d%d%d", income.date!)
        }
        
        let formatter = DateFormatter()
        let date = Date()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        let formattedDate = formatter.string(from: date)
        let dateComponents = formattedDate.components(separatedBy: "/")
        dateTextField.text = formattedDate
        // to check dateComponents
        saveButton.isEnabled = (isAllFieldsFilled()) ? true : false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func isAllFieldsFilled() ->Bool{
        return
            !(amountTextField.text?.isEmpty)! &&
            !(dateTextField.text?.isEmpty)!
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddItemMode = presentingViewController is UINavigationController
        if isPresentingInAddItemMode{
            dismiss(animated: true, completion: nil)
        }else{
            navigationController!.popViewController(animated: true)
        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
