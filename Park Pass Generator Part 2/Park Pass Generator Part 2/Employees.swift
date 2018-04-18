//
//  Employees.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation

/// Parent class for all employees.
class Employee: Entrant {
    
    override init?(entrantInformation: EntrantInformation) throws {
        
        try super.init(entrantInformation: entrantInformation)
        
        // Check that there is no empty strings for information
        // No need to check the nil because textfield returns always atleast empty string.
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
            }
        } catch let error as EntrantCheckError {
            print("Error for creating pass for Employee:")
            print(error.rawValue)
            return nil
        }
        self.rideAccess = [.ride]
        self.discounts = [.food(15), .merchandice(25)]
    }
}


class EmployeeHourlyFoodServices: Employee, EmployeeHourlyProfile {
    var entrantType = EntrantType.employeeFoodService
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .kitchen]
    }
}

class EmployeeHourlyRideServices: Employee, EmployeeHourlyProfile {
    var entrantType = EntrantType.employeeRideService
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .rideControl]
    }
}

class EmployeeHourlyMaintenance: Employee, EmployeeHourlyProfile {
    var entrantType = EntrantType.employeeMaintenance
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .kitchen, .rideControl, .maintenance]
    }
}


///Manager is like an Employee
class Manager: Employee, ManagerProfile {
    var entrantType = EntrantType.manager
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .kitchen, .office, .rideControl, .maintenance]
        self.discounts = [.food(25), .merchandice(25)]
    }
}
