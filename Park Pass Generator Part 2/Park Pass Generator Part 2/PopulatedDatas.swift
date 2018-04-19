//
//  PopulatedDatas.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation
import UIKit

//Tags
//#0 dateofbirth
//#1 SSN
//#2 Project#
//#3 Firstname
//#4 lastname
//#5 company
//#6 street address
//#7 city
//#8 state
//#9 zipcode

// Populates Datas for Entrant Info
func POPULATEDATAS(with entrantType: EntrantType, labels: [UITextField]){
    //print(entrantType)
    //print(labels)
    var entrantInfo: [Int: String] = [:]
    
    switch entrantType {
    case .guestFreeChild: entrantInfo = [0: "04-19-2017"]
    case .guestClassic: entrantInfo = [:]
    case .guestVIP: entrantInfo = [:]
    case .seniorGuest: entrantInfo = [3: "Oldie", 4: "Goldie", 0: "07-22-1920"]
    case .guestSeasonPass: entrantInfo = [3: "Reginald", 4: "Hereford", 6: "StreetRoad 2", 7: "Mikkintong", 8: "Statelandia", 9: "90810", 0: "01-02-1984"]
    case .vendor: entrantInfo = [3: "Vendorman", 4: "LastName", 5: "Fedex", 0: "06-22-1970"]
    case .employeeFoodService: entrantInfo = [0: "07-22-1990", 3: "Jaakko", 4: "Kenttä", 7: "Oulu", 8: "Oulu", 9: "940123", 1: "122-34-5123", 6: "Rabbitroad 2"]
    case .employeeMaintenance: entrantInfo = [0: "12-22-1995", 3: "Saara", 4: "Kenttä", 7: "Lipsum", 8: "Lapsum", 9: "1230123", 1: "332-54-5223", 6: "Wolfroad 4"]
    case .employeeRideService: entrantInfo = [0: "07-22-1990", 3: "Eevi", 4: "Field", 7: "Oulu", 8: "Oulu", 9: "940123", 1: "122-34-5223", 6: "Lionvalley 2"]
    case .employeeContract: entrantInfo = [0: "07-22-1990", 3: "Eevi", 4: "Field", 7: "Oulu", 8: "Oulu", 9: "940123", 1: "122-34-5223", 6: "Lionvalley 2", 2: "2001"]
    case .managerShift: entrantInfo = [0: "07-22-1990", 3: "Et", 4: "Stark", 7: "Oulu", 8: "Oulu", 9: "940123", 1: "122-34-5123", 6: "Roarroad 12"]
    case .managerSenior: entrantInfo = [0: "07-22-1990", 3: "Jaakko", 4: "Stark", 7: "Oulu", 8: "Oulu", 9: "940123", 1: "122-34-5123", 6: "Hellotie 2"]
    case .managerGeneral: entrantInfo = [0: "07-22-1990", 3: "Jaakko", 4: "Field", 7: "Oulu", 8: "Oulu", 9: "940123", 1: "122-34-5123", 6: "Example 2"]
    default: print("wrong")
    }
    
    for label in labels {
        if let text = entrantInfo[label.tag] {
            label.text = text
        }
    }
}

