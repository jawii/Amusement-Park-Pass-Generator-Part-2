//
//  Guests.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation

import Foundation

class Guest:Entrant, GuestProfile{
    var entrantType = EntrantType.guestClassic
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement]
        self.rideAccess = [.ride]
    }
    
}

class GuestVIP: Guest, VIPGuestProfile{
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        entrantType = EntrantType.guestVIP
        self.rideAccess = [.canPassLines, .ride]
        self.discounts = [.food(10), .merchandice(20)]
    }
}

class GuestFreeChild: Guest, FreeChildGuestProfile{
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        entrantType = EntrantType.guestFreeChild
        
        //Field on part 2 will always produce a date object
        /*
         guard let age = entrantInformation.dateOfBirth else {
         print(EntrantCheckError.invalidAge.rawValue)
         return nil
         }
         */
        
        //check if age under 5
        do {
            try checkcAgeIsOverFice(with: entrantInformation.dateOfBirth!)
        } catch let error as EntrantCheckError{
            print(error.rawValue)
            return nil
        }
        
        entrantType = EntrantType.guestFreeChild
        self.rideAccess = [.ride]
    }
    
    func checkcAgeIsOverFice(with birthday: Date) throws {
        
        let timeNow = Date()
        let calendar = Calendar.current
        var age = calendar.dateComponents([.year], from: birthday, to: timeNow)
        
        //print("Child Age is \(age.year!).")
        if age.year! > 5 {
            throw EntrantCheckError.ageTooHigh
        }
    }
}
