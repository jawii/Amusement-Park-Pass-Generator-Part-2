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
    var entrantType: EntrantType?
    
    init?(entrantInformation: EntrantInformation) throws{
        self.entrantInformation = entrantInformation
        self.entrantType = nil
    }
    
    ///Check if the entrant has birthday. If yes, print text
    ///Used on Swipe - methods
    func checkIfBirthday() -> Void{
        
        if let age = entrantInformation.dateOfBirth {
            let timeNow = Date()
            let dayAndMonthNow = returnDayAndMonth(from: timeNow)
            let birthday = returnDayAndMonth(from: age)
            
            if dayAndMonthNow == birthday {
                print("Happy BirthDay!!")
            }
        }
    }
    
    /// Helper method: Used for birthdaychecking.
    func returnDayAndMonth(from date: Date) -> (day: Int, month: Int) {
        let ageComponents = Calendar.current.dateComponents([.day, .month], from: date)
        return (ageComponents.day!, ageComponents.month!)
    }
    
    ///Check if entrant has access to given area. Returns console prints but in Part II, return boolen value
    func swipeAreaAccess(area: AccessAreas)-> SwipeResult{
        
        checkIfBirthday()
        //Check if swiped area is in accessAreas
        for ownArea in accessAreas {
            if ownArea == area {
                //print("Access granted")
                return .accessGranted
            }
        }
        //print("Access denied")
        return .accessDenied
    }
    
    /// Swipecheck for rideaccess.
    func swipeCheck(accessFor: RideAccess) -> SwipeResult{
        
        
        //check if 5 seconds is passed since last swipe
        let timeNow = Date()
        
        let interval = timeNow.timeIntervalSince(lastTimeswiped)
        
        //print("Last time swiped: \(lastTimeswiped) \nTime now: \(timeNow) \nInterval: \(interval)")
        if interval < 5 {
            return .wait5seconds
        }

        lastTimeswiped = timeNow

        checkIfBirthday()
        
        for access in rideAccess {
            if access == accessFor {
                //print("Access granted")
                return .accessGranted
            }
        }
        //print("Access denied")
        return .accessDenied
    }
    
    ///Swipe for Discount values. Prints them on console.
    func swipeDiscounts() -> (food: Int, merchandice: Int){
        
        checkIfBirthday()
        //lastTimeswiped = Date()
        
        var foodValue: Int = 0
        var merchValue: Int = 0
        
        for discount in discounts{
            switch discount {
            case .food(let value):
                //print("Food discount \(value)%. ")
                foodValue = value
                
            case .merchandice(let value):
                //print("Merchandice discount \(value)%")
                merchValue = value
            }
        }
        
        if(discounts.isEmpty) {
            //print("No discounts")
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

