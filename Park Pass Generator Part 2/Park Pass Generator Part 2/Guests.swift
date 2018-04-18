//
//  Guests.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation
import UIKit

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
        
        guard entrantInformation.dateOfBirth != nil else {
            //print(EntrantCheckError.invalidAge.rawValue)
            throwAlert(with: EntrantCheckError.invalidAge.rawValue, title: "Invalid data")
            return nil
        }
        
        //check if age under 5
        do {
            try checkcAgeIsOverFice(with: entrantInformation.dateOfBirth!)
        } catch let error as EntrantCheckError{
            print(error.rawValue)
            throwAlert(with: error.rawValue, title: "Invalid age")
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

class GuestSeasonPass: Guest {
    
    override init?(entrantInformation: EntrantInformation) throws {
        try super.init(entrantInformation: entrantInformation)
        
        do {
            if entrantInformation.firstName == "" {
                throw EntrantCheckError.invalidFirstName
            } else if entrantInformation.lastName == "" {
                throw EntrantCheckError.invalidLastName
            } else if entrantInformation.state == "" {
                throw EntrantCheckError.invalidState
            } else if entrantInformation.zipCode == "" {
                throw EntrantCheckError.invalidZipCode
            } else if entrantInformation.city == "" {
                throw EntrantCheckError.invalidCity
            } else if entrantInformation.dateOfBirth == nil {
                throw EntrantCheckError.invalidAge
            }
        } catch let error as EntrantCheckError {
//          print("Error for creating pass for Season Guest:")
//          print(error.rawValue)
            throwAlert(with: error.rawValue, title: "Invalid Data")
            return nil
        }
        
        
        self.rideAccess = [.canPassLines, .ride]
        self.discounts = [.food(10), .merchandice(20)]
        self.entrantType = EntrantType.guestSeasonPass
    }
}

class GuestSenior: Guest {
    
    override init?(entrantInformation: EntrantInformation) throws {
        try super.init(entrantInformation: entrantInformation)
        
        do {
            if entrantInformation.firstName == "" {
                throw EntrantCheckError.invalidFirstName
            } else if entrantInformation.lastName == "" {
                throw EntrantCheckError.invalidLastName
            } else if entrantInformation.dateOfBirth == nil {
                throw EntrantCheckError.invalidAge
            }
        } catch let error as EntrantCheckError {
            //print("Error for creating pass for Season Guest:")
            //print(error.rawValue)
            throwAlert(with: error.rawValue, title: "Invalid Data")
            return nil
        }
        
        
        self.rideAccess = [.canPassLines, .ride]
        self.discounts = [.food(10), .merchandice(10)]
        self.entrantType = EntrantType.seniorGuest
    }
}















