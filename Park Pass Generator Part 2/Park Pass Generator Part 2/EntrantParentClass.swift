//
//  EntrantParentClass.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation
import UIKit


///Parent Class for all Entrants
class Entrant: EntrantProfile {
    var accessAreas: [AccessAreas] = []
    var rideAccess: [RideAccess] = []
    var discounts: [Discounts] = []
    var entrantInformation: EntrantInformation
    var lastTimeswiped = Date().addingTimeInterval(-5) {
        didSet {
//            print("Time now: \(Date())")
//            print("DidSet: \(self.lastTimeswiped)")
//
//            print(Date().addingTimeInterval(-5))
//            print(Date())
        }
    }
    let dateOfVisit = Date()
    var entrantType: EntrantType?
    
    init?(entrantInformation: EntrantInformation) throws{
        self.entrantInformation = entrantInformation
        self.entrantType = nil
    }
    
    ///Check if the entrant has birthday. If yes, print text
    ///Used on Swipe - methods
    func checkIfBirthday() -> Bool{
        
        if let age = entrantInformation.dateOfBirth {
            let timeNow = Date()
            let dayAndMonthNow = returnDayAndMonth(from: timeNow)
            let birthday = returnDayAndMonth(from: age)
            
            if dayAndMonthNow == birthday {
                return true
            }
        }
        return false
    }
    
    /// Helper method: Used for birthdaychecking.
    func returnDayAndMonth(from date: Date) -> (day: Int, month: Int) {
        let ageComponents = Calendar.current.dateComponents([.day, .month], from: date)
        return (ageComponents.day!, ageComponents.month!)
    }
    
    ///Check if entrant has access to given area.
    func swipeAreaAccess(area: AccessAreas)-> SwipeResult{
        //Check if swiped area is in accessAreas
        for ownArea in accessAreas {
            if ownArea == area {
                return .accessGranted
            }
        }
        return .accessDenied
    }
    
    /// Swipecheck for rideaccess.
    func swipeCheck(accessFor: RideAccess) -> SwipeResult{
        
        // Check if 5 seconds is passed since last swipe
        let timeNow = Date()
        let interval = timeNow.timeIntervalSince(lastTimeswiped)
        if interval < 5 {
            return .wait5seconds
        }
        lastTimeswiped = timeNow

        for access in rideAccess {
            if access == accessFor {
                return .accessGranted
            }
        }
        return .accessDenied
    }
    
    ///Swipe for Discount values. Prints them on console.
    func swipeDiscounts() -> (food: Int, merchandice: Int){

        var foodValue: Int = 0
        var merchValue: Int = 0
        
        for discount in discounts{
            switch discount {
            case .food(let value):
                foodValue = value
            case .merchandice(let value):
                merchValue = value
            }
        }
        return (food: foodValue, merchandice: merchValue)
        
    }
    
    func throwAlert(with message: String, title: String) {
        // Add alert if there is controller
        if let topController = UIApplication.topViewController() {
            Alert.showBasic(title: title, message: message, vc: topController )
        }
    }
}

