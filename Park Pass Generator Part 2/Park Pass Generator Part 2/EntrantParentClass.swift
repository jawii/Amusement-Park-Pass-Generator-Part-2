//
//  EntrantParentClass.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation


///Parent Class for all Entrants
class Entrant: EntrantProfile {
    var accessAreas: [AccessAreas] = []
    var rideAccess: [RideAccess] = []
    var discounts: [Discounts] = []
    var entrantInformation: EntrantInformation
    var lastTimeswiped: Date
    
    init?(entrantInformation: EntrantInformation) throws{
        self.entrantInformation = entrantInformation
        
        //creat dummy value for date
        let dateComponents = DateComponents(year: 2018, month: 1, day: 1)
        let calendar = Calendar.current
        self.lastTimeswiped = calendar.date(from: dateComponents)!
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
    func swipeAreaAccess(area: AccessAreas)-> Void{
        
        checkIfBirthday()
        //Check if swiped area is in accessAreas
        for ownArea in accessAreas {
            if ownArea == area {
                print("Access granted")
                //return true
                return
            }
        }
        print("Access denied")
        //return false
    }
    
    /// Swipecheck for rideaccess.
    func swipeCheck(accessFor: RideAccess) -> Void{
        
        //check if 5 seconds is passed since last swipe
        let timeNow = Date()
        let interval = timeNow.timeIntervalSince(lastTimeswiped)
        if interval < 5 {
            print("Please wait 5 seconds to swipe again")
            return
        }
        //set new swipe time
        lastTimeswiped = timeNow
        
        checkIfBirthday()
        
        for access in rideAccess {
            if access == accessFor {
                print("Access granted")
                //return true
                return
            }
        }
        print("Access denied")
        //return false
    }
    
    ///Swipe for Discount values. Prints them on console.
    func swipeDiscounts(){
        
        checkIfBirthday()
        lastTimeswiped = Date()
        
        for discount in discounts{
            switch discount {
            case .food(let value):
                print("Food discount \(value)%. ")
                
            case .merchandice(let value):
                print("Merchandice discount \(value)%")
            }
        }
        
        if(discounts.isEmpty) {
            print("No discounts")
        }
    }
}
