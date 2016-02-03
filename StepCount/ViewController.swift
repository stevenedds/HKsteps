//
//  ViewController.swift
//  StepCount
//
//  Created by ultraflex on 1/29/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
  @IBOutlet weak var stepsLabel: UILabel!
  
  
  let healthManager = HealthManager()
  
  var totalSteps = 0.0 {
    didSet {
      stepsLabel.text = "\(totalSteps)"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

  healthManager.askPermission()
  }

  let completion: ((Double?, NSError?) -> ()) = {
    (success, error) -> Void in
    
    if success == nil {
      print("You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: \(error). If you're using a simulator, try it on a device.")
      return
    }

    let steps = success!
    // i'm able to print the number of steps
    print(steps)
    
    dispatch_async(dispatch_get_main_queue()) {

    // i thin the Label should be updated here, but cant figure out how to do it
    }
  }

  @IBAction func getDataButton() {
    healthManager.fetchDailyStepsWithCompletionHandler(completion)

  }
  
}


