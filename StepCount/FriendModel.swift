//
//  FriendModel.swift
//  StepCount
//
//  Created by ultraflex on 2/8/16.
//  Copyright © 2016 ultraflex. All rights reserved.
//

import Foundation

struct Friend {
  let name: String
  var steps: String
  var image: String
}

extension Friend {
  
  static let friends = [steve, ryan, max]
  
  static let steve = Friend(
    name:"steven edds",
    steps: "8,275",
    image: "steve.jpg")
  
  static let ryan = Friend(
    name: "ryan gunn",
    steps: "7,509",
    image: "ryan.png")
  
  static let max = Friend(
    name: "max",
    steps: "4,378",
    image: "max.png")
}

let friends = [
  Friend(name: "steve", steps: "8,240", image: "steve.jpg"),
  Friend(name: "ryan", steps: "7,509", image: "ryan.png"),
  Friend(name: "max", steps: "4,374", image: "max.png")]


struct HourlyData {
  var hour1 = 0.0
  var hour2 = 0.0
  var hour3 = 0.0
  var hour4 = 0.0
  var hour5 = 0.0
  var hour6 = 0.0
  var hour7 = 0.0
  var hour8 = 0.0
  var hour9 = 0.0
  var hour10 = 0.0
  var hour11 = 0.0
  var hour12 = 0.0
  var hour13 = 0.0
  var hour14 = 0.0
  var hour15 = 0.0
  var hour16 = 0.0
  var hour17 = 0.0
  var hour18 = 0.0
  var hour19 = 0.0
  var hour20 = 0.0
  var hour21 = 0.0
  var hour22 = 0.0
  var hour23 = 0.0
  var hour24 = 0.0
}