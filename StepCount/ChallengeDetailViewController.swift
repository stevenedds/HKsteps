//
//  ChallengeDetailViewController.swift
//  StepCount
//
//  Created by ultraflex on 2/11/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit

class ChallengeDetailViewController: UIViewController {

  let healthManager = HealthManager()
  
  @IBOutlet weak var stepsLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      healthManager.askPermission()
      
      
    }

  
  @IBAction func getDataButton() {
    
    getSteps()
  }
  

  func getSteps() {
    healthManager.fetchHourlyStepsWithCompletionHandler { (steps, error) -> () in
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

}
