//
//  ViewController.swift
//  StepCount
//
//  Created by ultraflex on 1/29/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  
  
  let healthManager = HealthManager()
  var progress : KDCircularProgress!
  
  var stepGoal = 0.0
  var stepsTaken = 0.0 {
    didSet {
      stepsTakenLabel.text = "\(Int(stepsTaken)) steps"
    }
  }
  
  @IBOutlet weak var stepGoalTextField: UITextField!
  @IBOutlet weak var stepsTakenLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(white: 0.25, alpha: 1)
    
    healthManager.askPermission()
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    
    progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    progress.startAngle = -90
    progress.progressThickness = 0.2
    progress.trackThickness = 0.6
    progress.clockwise = true
    progress.gradientRotateSpeed = 1
    progress.roundedCorners = false
    progress.glowMode = .Forward
    progress.glowAmount = 0.9
    progress.setColors(UIColor.cyanColor() ,UIColor.whiteColor(), UIColor.magentaColor(), UIColor.whiteColor(), UIColor.orangeColor())
    progress.center = CGPoint(x: view.center.x, y: view.center.y + 25)
    view.addSubview(progress)
    
    getSteps()
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidLoad()
    
  }
  
  func getSteps() {
    healthManager.fetchDailyStepsWithCompletionHandler { (steps, error) -> () in
      if error != nil {
        print(error?.localizedDescription)
        
      } else {
        if let steps = steps {
          dispatch_async(dispatch_get_main_queue(), {
            
            self.stepsTaken = steps
          })
        }
      }
    }
  }
  
  func animateToAngle() -> Int {
    if stepsTaken / stepGoal >= 1 {
      stepsTakenLabel.text = "GOAL!"
      return 360
    } else {
      stepsTakenLabel.text = "\(Int(stepsTaken)) steps"
      return Int(360 * (stepsTaken / stepGoal))
    }
    
  }
  
  func animateButton() {
    progress.animateFromAngle(0, toAngle: animateToAngle(), duration: 5) { completed in
      if completed {
        print("animation stopped, completed")
      } else {
        print("animation stopped, was interrupted")
      }
    }
  }
  
  @IBAction func goalDidEndEditing() {
    
    if stepGoalTextField.text != nil && Int(stepGoalTextField.text!)! > 0 && stepGoalTextField.text != "GOAL!" {
      stepGoal = Double(stepGoalTextField.text!)!
      self.animateButton()

    }

  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
}


