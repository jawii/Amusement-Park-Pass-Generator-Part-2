//
//  EntrantProfiles.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation

//List off AccessAreas
enum AccessAreas: String{
    case amusement = "Amusement Area"
    case kitchen = "Kitchen Area"
    case rideControl = "Ride Control Area"
    case office = "Office Area"
    case maintenance = "Maintenance Area"
}

//List of accesses on rides
enum RideAccess: String{
    case ride = "Entrant can ride"
    case canPassLines = "Entrant can pass lines"
}

enum Discounts {
    case food(Int)
    case merchandice(Int)
}

struct EntrantInformation {
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let dateOfBirth: Date?
    let socialSecurityNumber: String?
    let projectNumber: String?
    let companyName: String?
}

enum SwipeResult {
    case accessGranted
    case accessDenied
    case wait5seconds
}

//Used for labeling the texts and getting the right entrantype
//Also pass - objects has this type
enum EntrantType: String {
    //Guests
    case guestClassic = "Adult Guest"
    case guestVIP = "VIP Guest"
    case guestFreeChild = "Child Guest"
    case guestSeasonPass = "Season Pass Guest"
    case seniorGuest = "Senior Guest"
    //Hourly Employees
    case Employee
    case employeeContract = "Contract Employee"
    case employeeFoodService = "Food Services Employee"
    case employeeRideService = "Ride Services Employee"
    case employeeMaintenance = "Maintenance Employee"
    //other
    case managerShift = "Shift Manager"
    case managerGeneral = "General Manager"
    case managerSenior = "Senior Manager"
    case vendor = "Vendor"
}


//Protocols for all Entrants
protocol EntrantProfile {
    var accessAreas : [AccessAreas] { get }
    var rideAccess: [RideAccess] { get }
    var entrantInformation: EntrantInformation { get }
    var discounts: [Discounts] { get }
    var entrantType: EntrantType? { get }
}

//Protocols for Guests. Leave VIP and Child protocol empty for now...
protocol GuestProfile: EntrantProfile {
    
}
protocol VIPGuestProfile: GuestProfile {
}
protocol FreeChildGuestProfile: GuestProfile {
}

//Protocols for Employees
protocol EmployeeProfile: EntrantProfile {
    
}
protocol EmployeeHourlyProfile: EmployeeProfile{
    
}
protocol ManagerProfile: EntrantProfile {
}
