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
            } else if entrantInformation.socialSecurityNumber == "" {
                throw EntrantCheckError.invalidSNN
            } else if entrantInformation.dateOfBirth == nil {
                throw EntrantCheckError.invalidAge
            } else if entrantInformation.streetAddress == "" {
                throw EntrantCheckError.invalidStreetAddress
            }
        } catch let error as EntrantCheckError {
            //print("Error for creating pass for Employee:")
            //print(error.rawValue)
            throwAlert(with: error.rawValue, title: "Invalid Data")
            return nil
        }
        self.rideAccess = [.ride]
        self.discounts = [.food(15), .merchandice(25)]
    }
}


class EmployeeHourlyFoodServices: Employee, EmployeeHourlyProfile {
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .kitchen]
        self.entrantType = EntrantType.employeeFoodService
    }
}

class EmployeeHourlyRideServices: Employee, EmployeeHourlyProfile {
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .rideControl]
        self.entrantType = EntrantType.employeeRideService
    }
}

class EmployeeHourlyMaintenance: Employee, EmployeeHourlyProfile {
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .kitchen, .rideControl, .maintenance]
        self.entrantType = EntrantType.employeeMaintenance
    }
}

class EmployeeContract: Employee, EmployeeHourlyProfile {
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        
        do {
            if entrantInformation.projectNumber == "" {
                throw EntrantCheckError.invalidProjectNumber
            }
        } catch let error as EntrantCheckError {
            //print("Error for creating pass for Employee:")
            //print(error.rawValue)
            throwAlert(with: error.rawValue, title: "Invalid Data")
            return nil
        }
        
        switch entrantInformation.projectNumber {
        case "1001": self.accessAreas = [.amusement, .rideControl]
        case "1002": self.accessAreas = [.amusement, .rideControl, .maintenance, .office]
        case "1003": self.accessAreas = [.amusement, .rideControl, .kitchen, .maintenance, .office]
        case "2001": self.accessAreas = [.office]
        case "2002": self.accessAreas = [.kitchen, .maintenance, .office]
        default: self.accessAreas = []
        }
        self.discounts = [.food(0), .merchandice(0)]
        self.rideAccess = []
        self.entrantType = EntrantType.employeeContract
        
    }
}

///Manager is like an Employee
class ManagerGeneral: Employee, ManagerProfile {
    
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .kitchen, .office, .rideControl, .maintenance]
        self.discounts = [.food(25), .merchandice(25)]
        self.entrantType = EntrantType.managerGeneral
    }
}

class ManagerShift: Employee, ManagerProfile {
    
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        self.accessAreas = [.amusement, .kitchen, .office, .rideControl, .maintenance]
        self.discounts = [.food(25), .merchandice(25)]
        self.entrantType = EntrantType.managerShift
    }
}
class ManagerSenior: Employee, ManagerProfile {
    
    
    override init?(entrantInformation: EntrantInformation) throws{
        try super.init(entrantInformation: entrantInformation)
        
        self.accessAreas = [.amusement, .kitchen, .office, .rideControl, .maintenance]
        self.discounts = [.food(25), .merchandice(25)]
        self.entrantType = EntrantType.managerSenior
    }
}



class Vendor: Entrant {
    
    override init?(entrantInformation: EntrantInformation) throws {
        
        try super.init(entrantInformation: entrantInformation)
        
        // Check that there is no empty strings for information
        // No need to check the nil because textfield returns always atleast empty string.
        do {
            if entrantInformation.firstName == "" {
                throw EntrantCheckError.invalidFirstName
            } else if entrantInformation.lastName == "" {
                throw EntrantCheckError.invalidLastName
            } else if entrantInformation.companyName == "" {
                throw EntrantCheckError.invalidCompanyName
            }
        } catch let error as EntrantCheckError {
            //print("Error for creating pass for Vendor:")
            //print(error.rawValue)
            throwAlert(with: error.rawValue, title: "Invalid Data")
            return nil
        }
        
        
        switch entrantInformation.companyName {
        case "Acme": self.accessAreas = [.kitchen]
        case "Orkin": self.accessAreas = [.amusement, .rideControl, .kitchen]
        case "Fedex": self.accessAreas = [.maintenance, .office]
        case "NW Electrical": self.accessAreas = [.amusement, .rideControl, .kitchen, .maintenance, .office]
        default: self.accessAreas = []
        }
        
        self.discounts = [.food(0), .merchandice(0)]
        self.rideAccess = []
        self.entrantType = EntrantType.vendor
    }
}

