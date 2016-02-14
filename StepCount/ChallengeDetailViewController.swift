//
//  ChallengeDetailViewController.swift
//  StepCount
//
//  Created by ultraflex on 2/11/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit
import Charts

class ChallengeDetailViewController: UIViewController {

  let purple = UIColor(red: 78/255, green: 112/255, blue: 239/255, alpha: 1)
  let white = UIColor.whiteColor()
  let backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 253/255, alpha: 1)

  
  let healthManager = HealthManager()
  
  var hourlyTimes = HourlyData()
  
  @IBOutlet weak var lineChartView: LineChartView!
  
  @IBOutlet weak var stepsLabel: UILabel!
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      healthManager.askPermission()
      
      getSteps()

    }

  

  func getSteps() {
    
    healthManager.fetchDailyStepsWithCompletionHandler { (daily, error) -> () in
      if error != nil {
        print(error?.localizedDescription)
        
      } else {
        if let dailySteps = daily {
          dispatch_async(dispatch_get_main_queue(), {
            
            self.stepsLabel.text = "\(dailySteps) steps today"
          })
          
        }
      }
      
      
      
    }
    
    healthManager.fetchHourlyStepsWithCompletionHandler { (hourly, error) -> () in
      if error != nil {
        print(error?.localizedDescription)
        
      } else {
        
        self.hourlyTimes = hourly!
        
        let hours = Array(1...24).map { Double($0) }
        
        let steps = [self.hourlyTimes.hour1, self.hourlyTimes.hour2, self.hourlyTimes.hour3, self.hourlyTimes.hour4, self.hourlyTimes.hour5, self.hourlyTimes.hour6, self.hourlyTimes.hour7, self.hourlyTimes.hour8, self.hourlyTimes.hour9, self.hourlyTimes.hour10, self.hourlyTimes.hour11, self.hourlyTimes.hour12, self.hourlyTimes.hour13, self.hourlyTimes.hour14, self.hourlyTimes.hour15, self.hourlyTimes.hour16, self.hourlyTimes.hour17, self.hourlyTimes.hour18, self.hourlyTimes.hour19, self.hourlyTimes.hour20, self.hourlyTimes.hour21, self.hourlyTimes.hour22, self.hourlyTimes.hour23, self.hourlyTimes.hour24]
        
        self.setChart(hours, values: steps)
      }
    }
  }
  
  func setChart(dataPoints: [Double], values: [Double]) {
    
    var dataEntries: [ChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
      dataEntries.append(dataEntry)
    }
    
    
    let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "steps")
    let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
    lineChartView.data = lineChartData
    lineChartView.descriptionText = ""
    lineChartView.backgroundColor = backgroundColor

    lineChartDataSet.colors = [purple]
    lineChartDataSet.drawCirclesEnabled = false
    
  }

}
