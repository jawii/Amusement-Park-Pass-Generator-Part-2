//
//  PassGeneratorViewController.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 19/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit
//import Twinkle


class PassGeneratorViewController: UIViewController {
    
    
    var entrant: Entrant?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    
    @IBOutlet weak var canRideLabel: UILabel!
    @IBOutlet weak var foodDiscountLabel: UILabel!
    @IBOutlet weak var merchDisountLabel: UILabel!
    
    @IBOutlet weak var accessTest: UIView!
    @IBOutlet weak var accessTestString: UILabel!
    
    @IBOutlet weak var birthDayLabel: UILabel!
    @IBOutlet weak var dateOfVisitLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let entrant = entrant else {
            fatalError()
        }
        birthDayLabel.isHidden = true
        //generate pass names
        setupPass(for: entrant)
    }
    
    func setupPass(for entrant: Entrant){
        
        
        // Make name if given
        var nameString = ""
        if let firstName = entrant.entrantInformation.firstName {
            nameString += firstName + " "
        }
        if let lastName = entrant.entrantInformation.lastName {
            nameString += lastName
        }
        if nameString == " " {
            nameLabel.isHidden = true
        } else {
            nameLabel.text = nameString
        }
        
        //make project and company names
        if entrant.entrantInformation.projectNumber == "" {
            projectNameLabel.isHidden = true
        } else {
            projectNameLabel.text = "Project: " + entrant.entrantInformation.projectNumber!
        }
        
        if entrant.entrantInformation.companyName == "" {
            companyNameLabel.isHidden = true
        } else {
            companyNameLabel.text = entrant.entrantInformation.companyName
        }
        
        // Make entrantype
        if let entrantType =  entrant.entrantType {
            passTypeLabel.text = entrantType.rawValue + " Pass"
        } else {
            passTypeLabel.isHidden = true
        }
        
        // Make Ride
        /*
        let canRide = entrant.swipeCheck(accessFor: .ride)
        if canRide {
            canRideLabel.text = "Unlimited rides"
        } else {
            canRideLabel.text = "No ride access"
        }
        */
        canRideLabel.isHidden = true
        
        //Discounts
        let discountValues = entrant.swipeDiscounts()
        foodDiscountLabel.text = "\(discountValues.food) % food discount"
        merchDisountLabel.text = "\(discountValues.merchandice) % merchandice discount"
        
        //check if birthday
        let isBirthday = entrant.checkIfBirthday()
        if isBirthday {
            birthDayLabel.isHidden = false
        }
        
        //display date of visit label to vendor
        if entrant.entrantType == .vendor {
            dateOfVisitLabel.text = entrant.dateOfVisit.toString(dateFormat: "MM-dd-yyyy")
        } else {
            dateOfVisitLabel.isHidden = true
        }
    }
    
    @IBAction func testAccess(_ sender: UIButton) {
        
        var accessArea: AccessAreas?
        var access: RideAccess?
        
        switch sender.tag {
        case 0: accessArea = .amusement
        case 1: accessArea = .kitchen
        case 2: accessArea = .rideControl
        case 3: accessArea = .maintenance
        case 4: accessArea = .office
        case 5: access = .canPassLines
        case 6: access = .ride
        default: print("no tags found"); return
        }
        

        var resultForSwipe: SwipeResult = SwipeResult.accessDenied
        
        if let access = access{
            resultForSwipe = entrant!.swipeCheck(accessFor: access)
        }
        if let accessArea = accessArea {
            resultForSwipe = entrant!.swipeAreaAccess(area: accessArea)
        }
        
        var color: UIColor
        var accessText: String
        switch resultForSwipe {
        case .accessGranted:
            color = #colorLiteral(red: 0, green: 0.895901978, blue: 0, alpha: 1)
            accessText = "Access Granted"
            AudioProvider.playSound(named: .accessGranted)
        case .accessDenied:
            color = #colorLiteral(red: 0.9639720321, green: 0, blue: 0, alpha: 1)
            accessText = "Access Denied"
            AudioProvider.playSound(named: .accessDenied)
        case .wait5seconds:
            color = #colorLiteral(red: 0.9010917544, green: 0.7810741067, blue: 0, alpha: 1)
            accessText = "Please wait 5 seconds to swipe again"
        }
        accessTestString.text = accessText

        UIView.animate(withDuration: 0.25, animations: {
            self.accessTest.backgroundColor = color
        }, completion: nil)
        
        delayOnMainThread(seconds: 0.25, action: {
            UIView.animate(withDuration: 0.25, animations: {
                self.accessTest.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }, completion: nil)
        })
    }
    
    @IBAction func createNewPas(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
