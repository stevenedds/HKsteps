//
//  HealthManager.swift
//  StepCount
//
//  Created by ultraflex on 1/29/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import Foundation
import HealthKit

var GlobalMainQueue: dispatch_queue_t {
  return dispatch_get_main_queue()
}

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
  
  
  func fetchHourlyStepsWithCompletionHandler(completionHandler:(HourlyData?, NSError?)->()) {
    
    var data = HourlyData()
    
    let date = NSDate()
    let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let components = cal.components([.Day , .Month, .Year ], fromDate: date)
    let newDate = cal.dateFromComponents(components)
    
    var storedError: NSError!
    let queryGroup = dispatch_group_create()
    
    
    for hour in 1...24 {
      if hour == 1 {
        
        let endHour = newDate?.dateByAddingTimeInterval(60*60)
        let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        let predicate = NSPredicate(format: "startDate >= %@ AND startDate < %@" ,newDate!, endHour!)
        let query = HKStatisticsQuery(quantityType: sampleType!, quantitySamplePredicate: predicate, options: .CumulativeSum) {
          (query, result, error) in
          
          var totalSteps = 0.0
          
          if let sumQuantity = result?.sumQuantity() {
            
            totalSteps = sumQuantity.doubleValueForUnit(HKUnit.countUnit())
            
            data.hour1 = totalSteps
          }
        }
        
        healthStore?.executeQuery(query)
        
      } else {
        
      }
      let startHour = newDate?.dateByAddingTimeInterval( Double(hour - 1) * (60*60) )
      let endHour = newDate?.dateByAddingTimeInterval( Double(hour) * (60*60) )
      let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
      
      let predicate = NSPredicate(format: "startDate >= %@ AND startDate < %@" ,startHour!, endHour!)
      
      let query = HKStatisticsQuery(quantityType: sampleType!, quantitySamplePredicate: predicate, options: .CumulativeSum) { (query, result, error) in
      
        var totalSteps = 0.0
        

        if let sumQuantity = result?.sumQuantity() {
          
          totalSteps = sumQuantity.doubleValueForUnit(HKUnit.countUnit())
          switch hour {
            
          case 2:
            data.hour2 = totalSteps
          case 3:
            data.hour3 = totalSteps
          case 4:
            data.hour4 = totalSteps
          case 5:
            data.hour5 = totalSteps
          case 6:
            data.hour6 = totalSteps
          case 7:
            data.hour7 = totalSteps
          case 8:
            data.hour8 = totalSteps
          case 9:
            data.hour9 = totalSteps
          case 10:
            data.hour10 = totalSteps
          case 11:
            data.hour11 = totalSteps
          case 12:
            data.hour12 = totalSteps
          case 13:
            data.hour13 = totalSteps
          case 14:
            data.hour14 = totalSteps
          case 15:
            data.hour15 = totalSteps
          case 16:
            data.hour16 = totalSteps
          case 17:
            data.hour17 = totalSteps
          case 18:
            data.hour18 = totalSteps
          case 19:
            data.hour19 = totalSteps
          case 20:
            data.hour20 = totalSteps
          case 21:
            data.hour21 = totalSteps
          case 22:
            data.hour22 = totalSteps
          case 23:
            data.hour23 = totalSteps
          case 24:
            data.hour24 = totalSteps
          default:
            break
          }

        }
        dispatch_group_leave(queryGroup)
      }

      dispatch_group_enter(queryGroup)

      healthStore?.executeQuery(query)
    }
    dispatch_group_notify(queryGroup, GlobalMainQueue) {
      completionHandler(data,nil)
    }
  }

  
//  func OLDfetchHourlyStepsWithCompletionHandler (completionHandler:(HourlyData?, NSError?)->()) {
//      
//      var data = HourlyData()
//      let date = NSDate()
//      let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//      let components = cal.components([.Day , .Month, .Year ], fromDate: date)
//      let newDate = cal.dateFromComponents(components)
//      
//      var storedError: NSError!
//      let queryGroup = dispatch_group_create()
//      
//      for hour in 1...24 {
//        
//        if hour == 1 {
//          
//          let endHour = newDate?.dateByAddingTimeInterval(60*60)
//          let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
//          let predicate = NSPredicate(format: "startDate >= %@ AND startDate < %@" ,newDate!, endHour!)
//          let query = HKStatisticsQuery(quantityType: sampleType!, quantitySamplePredicate: predicate, options: .CumulativeSum) {
//            (query, result, error) in
//              
//              var totalSteps = 0.0
//              
//              if let sumQuantity = result?.sumQuantity() {
//                
//                totalSteps = sumQuantity.doubleValueForUnit(HKUnit.countUnit())
//                
//                data.hour1 = totalSteps
//              }
//          }
//          
//          healthStore?.executeQuery(query)
//          
//        } else {
//          
//          let startHour = newDate?.dateByAddingTimeInterval( Double(hour - 1) * (60*60) )
//          
//          let endHour = newDate?.dateByAddingTimeInterval( Double(hour) * (60*60) )
//          
//          let sampleType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
//          
//          let predicate = NSPredicate(format: "startDate >= %@ AND startDate < %@" ,startHour!, endHour!)
//          
//          let query = HKStatisticsQuery(quantityType: sampleType!, quantitySamplePredicate: predicate, options: .CumulativeSum) {
//            (query, result, error) in
//              var totalSteps = 0.0
//              if let sumQuantity = result?.sumQuantity() {
//                
//                totalSteps = sumQuantity.doubleValueForUnit(HKUnit.countUnit())
//                
//                switch hour {
//                  
//                case 2:
//                  data.hour2 = totalSteps
//                case 3:
//                  data.hour3 = totalSteps
//                case 4:
//                  data.hour4 = totalSteps
//                case 5:
//                  data.hour5 = totalSteps
//                case 6:
//                  data.hour6 = totalSteps
//                case 7:
//                  data.hour7 = totalSteps
//                case 8:
//                  data.hour8 = totalSteps
//                case 9:
//                  data.hour9 = totalSteps
//                case 10:
//                  data.hour10 = totalSteps
//                case 11:
//                  data.hour11 = totalSteps
//                case 12:
//                  data.hour12 = totalSteps
//                case 13:
//                  data.hour13 = totalSteps
//                case 14:
//                  data.hour14 = totalSteps
//                case 15:
//                  data.hour15 = totalSteps
//                case 16:
//                  data.hour16 = totalSteps
//                case 17:
//                  data.hour17 = totalSteps
//                case 18:
//                  data.hour18 = totalSteps
//                case 19:
//                  data.hour19 = totalSteps
//                case 20:
//                  data.hour20 = totalSteps
//                case 21:
//                  data.hour21 = totalSteps
//                case 22:
//                  data.hour22 = totalSteps
//                case 23:
//                  data.hour23 = totalSteps
//                case 24:
//                  data.hour24 = totalSteps
//                default:
//                  break
//                }
//              }
//            dispatch_group_leave(queryGroup)
//
//          }
//          
//          dispatch_group_enter(queryGroup)
//
//          healthStore?.executeQuery(query)
//          
//            completionHandler(data,nil)
//        }
//        
//      }
//      
//      
//    
//      
//  }
}
