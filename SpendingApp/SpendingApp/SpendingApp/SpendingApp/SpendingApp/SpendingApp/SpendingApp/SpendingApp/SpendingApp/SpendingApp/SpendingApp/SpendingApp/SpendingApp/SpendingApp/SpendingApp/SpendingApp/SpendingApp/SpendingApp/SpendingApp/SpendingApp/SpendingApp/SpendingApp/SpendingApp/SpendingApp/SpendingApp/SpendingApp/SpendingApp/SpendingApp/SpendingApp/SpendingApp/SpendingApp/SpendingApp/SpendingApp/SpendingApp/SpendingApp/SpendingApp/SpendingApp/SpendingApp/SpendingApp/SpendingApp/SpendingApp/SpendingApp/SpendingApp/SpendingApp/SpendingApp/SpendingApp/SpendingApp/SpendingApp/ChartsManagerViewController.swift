//
//  ChartsManagerViewController.swift
//  MoneyTracker
//
//  Created by Student on 2/1/17.
//  Copyright © 2017 Dean Gaffney. All rights reserved.
//

import UIKit
import Charts

class ChartsManagerViewController: UIViewController {
    var backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Graph"

    }
    
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var PieChartView: PieChartView!
    var months  = [String]()
    var categories = [String]()
    var items = [Item]()
    var values = Array(repeating: 0.0, count: 12)
    var monthlyValues : [String:Double] = ["Jan": 0.0,"Feb": 0.0,"Mar":  0.0,"Apr": 0.0,"May": 0.0,"Jun": 0.0,"Jul": 0.0,"Aug": 0.0,"Sep": 0.0,"Oct": 0.0,"Nov": 0.0,"Dec": 0.0]
    var categoryValues : [String:Double] = ["food": 0.0, "drinks": 0.0, "bills": 0.0, "car": 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        categories = ["food", "drinks", "bills", "car"]
        
        setUpMonthlyDictionary()
        print(monthlyValues)
        setUpValues()
        print("In chart view controller")
        print(items)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpValues(){
        for i in 0..<months.count{
            values[i] = monthlyValues[months[i]]!
        }
    }
    
    func setUpMonthlyDictionary(){
        for i in 0..<items.count{
            //get month string and add to dictionary
            monthlyValues[months[items[i].purchaseMonth-1]] = monthlyValues[months[items[i].purchaseMonth - 1]]! + items[i].cost
        }
        
    }
    func setUpCategoryDictioanry(){
        for i in 0..<items.count{
            //get category string and add to dictionary
           
            
        }
    }
    
    func setChart(category: [String], values: [Double]){
        barChartView.noDataText = "Your items list is empty,no data available for graph"
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<months.count{
            let chartEntry = BarChartDataEntry(x: Double(i),y: values[i])
            
            dataEntries.append(chartEntry)
        }
        
        let barChartDataSet = BarChartDataSet(values: dataEntries, label: "")
        barChartDataSet.stackLabels = months
        barChartDataSet.colors = [UIColor(red: 227/255, green:29/255 , blue: 47/255, alpha: 1)]
        barChartDataSet.valueColors = [UIColor.brown]
        barChartDataSet.barBorderColor = UIColor.brown
        barChartDataSet.valueTextColor = UIColor.brown
        
        barChartView.chartDescription?.text = ""
        barChartView.xAxis.labelTextColor = UIColor.brown
        barChartView.xAxis.gridColor = UIColor.brown
        barChartView.xAxis.axisLineColor = UIColor.brown
        barChartView.leftAxis.labelTextColor = UIColor.brown
        barChartView.rightAxis.labelTextColor = UIColor.brown
        let chartData = BarChartData(dataSet: barChartDataSet)
        barChartView.data = chartData
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easing: ChartEasingOption.easeInBounce as? ChartEasingFunctionBlock)
        
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
