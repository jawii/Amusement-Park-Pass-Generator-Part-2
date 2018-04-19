//
//  PassGeneratorViewController.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 19/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit

class PassGeneratorViewController: UIViewController {
    
    
    var entrant: Entrant?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var projectNameLabel: UILabel!
    
    
    @IBOutlet weak var canRideLabel: UILabel!
    @IBOutlet weak var foodDiscountLabel: UILabel!
    @IBOutlet weak var merchDisountLabel: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let entrant = entrant else {
            fatalError()
        }
        
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
        if nameString == "" {
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
        let canRide = entrant.swipeCheck(accessFor: .ride)
        if canRide {
            canRideLabel.text = "Unlimited rides"
        } else {
            canRideLabel.text = "No ride access"
        }
        
        //Discounts
        let discountValues = entrant.swipeDiscounts()
        foodDiscountLabel.text = "\(discountValues.food) % food discount"
        merchDisountLabel.text = "\(discountValues.merchandice) % merchandice discount"
    }
    
    

    @IBAction func createNewPas(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
