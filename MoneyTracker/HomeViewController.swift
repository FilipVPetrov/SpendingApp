//
//  HomeViewController.swift
//  MoneyTracker
//
//  Created by Dean Gaffney on 26/11/2016.
//  Copyright © 2016 Dean Gaffney. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 42/255, green:48/255 , blue: 56/255, alpha: 1)

        /*backgroundImage.image = UIImage(named: Bundle.main.path(forResource: "Money Tracker Pages-01",ofType: ".png")!)
        self.view.insertSubview(backgroundImage, at: 0)*/
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
