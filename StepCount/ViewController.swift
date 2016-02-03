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
  
  override func viewDidLoad() {
    super.viewDidLoad()

  healthManager.askPermission()
  }

  func getSteps() {
    healthManager.fetchDailyStepsWithCompletionHandler { (steps, error) -> () in
      if error != nil {
        print(error?.localizedDescription)
        
      } else {
        
        if let steps = steps {
          dispatch_async(dispatch_get_main_queue(), {
            
            self.stepsLabel.text = "\(steps)"
            })
        }
      }
    }
  }
  
  @IBAction func getDataButton() {

    getSteps()
  }
  
}


