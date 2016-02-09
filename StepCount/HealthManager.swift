//
//  HealthManager.swift
//  StepCount
//
//  Created by ultraflex on 1/29/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import Foundation
import HealthKit

class HealthManager {
  
  let healthStore: HKHealthStore? = {
    if HKHealthStore.isHealthDataAvailable() {
      return HKHealthStore()
    } else {
      return nil
    }
  }()

  func askPermission() {
    
    guard let stepsCount = HKQuantityType.quantityTypeForIdentifier(
      HKQuantityTypeIdentifierStepCount) else {
        return
    }
    
    let dataTypesToRead: Set<HKSampleType> = [stepsCount]
    

    healthStore?.requestAuthorizationToShareTypes(nil, readTypes: dataTypesToRead, completion: { (success, error) in
      if success {
        print("SUCCESS")
      } else {
        print(error!.description)
      }
      })
  
  }
  
  
  func fetchDailyStepsWithCompletionHandler (
    completionHandler:(Double?, NSError?)->()) {
      
      let date = NSDate()
      let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
      let components = cal.components([.Day , .Month, .Year ], fromDate: date)
      let newDate = cal.dateFromComponents(components)

      let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
      
      let predicate = NSPredicate(format: "startDate >= %@" ,newDate!)
      
      let query = HKStatisticsQuery(quantityType: sampleType!, quantitySamplePredicate: predicate,
        options: .CumulativeSum)
        { (query, result, error) in
          
          var totalSteps = 0.0
          
          if let sumQuantity = result?.sumQuantity() {
            totalSteps = sumQuantity.doubleValueForUnit(HKUnit.countUnit())
            
          }
          completionHandler(totalSteps, nil)
      }
      
      healthStore?.executeQuery(query)
  }
  
}
