//
//  ViewController.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 18/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // Main entrant buttons
    @IBOutlet weak var guestBtn: UIButton!
    @IBOutlet weak var employeeBtn: UIButton!
    @IBOutlet weak var managerBtn: UIButton!
    @IBOutlet weak var vendorBtn: UIButton!
    
    // Entrantypes (6 buttons)
    @IBOutlet var entrantTypes: [UIButton]!
    
    
    // Info text fields
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var ssnTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var stateNameTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    @IBOutlet var entranInfoLabelTexts: [UITextField]!
    
    // Keep track of current entrant
    var currentEntrant: EntrantType? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide all entrant buttons
        for btn in entrantTypes {
            btn.isHidden = true
            //setup buttons
            
        }
        
        //disable all textfields
        for label in entranInfoLabelTexts {
            label.isEnabled = false
            label.backgroundColor = UIColor.lightGray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// Generate Pass Button
    @IBAction func generatePass(_ sender: UIButton) {
        // If no entrant selected, return
        if currentEntrant == nil {
            return
        }
        
        //Try to form date from dateOfBirthTextField.
        let birthDateString = dateOfBirthTextField.text
        //Skip if empty string
        var finalBirthDate: Date? = nil
        if birthDateString != "" {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "fi")
            dateFormatter.dateFormat = "MM-dd-yyyy"
            
            guard let birthdayDate = dateFormatter.date(from:birthDateString!) else{
                Alert.showBasic(title: "Date format", message: "Please give date of birth in format MM-DD-YYYY", vc: self)
                return
            }
            
            finalBirthDate = birthdayDate
        }
        
        let entrantInformation = EntrantInformation(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetAddressTextField.text, city: cityNameTextField.text, state: stateNameTextField.text, zipCode: zipCodeTextField.text, dateOfBirth: finalBirthDate, socialSecurityNumber: ssnTextField.text, projectNumber: projectTextField.text, companyName: companyNameTextField.text)
        
        
        //create entrant
        var entrantObject: Entrant?
        
        currentEntrant = (currentEntrant as! EntrantType)
        
        if currentEntrant = EntrantType.guestFreeChild {
            entrantObject = try? GuestFreeChild(entrantInformation: entrantInformation)
        }
        


    }
    
    /// Populate data button
    @IBAction func populateData(_ sender: UIButton) {
    }
    
    /// Guest pass generator button
    @IBAction func mainEntrantSelect(_ sender: UIButton){
        
        let button = sender
    
        guestBtn.isSelected = false
        employeeBtn.isSelected = false
        managerBtn.isSelected = false
        vendorBtn.isSelected = false
        
        for btn in entrantTypes {
            btn.isHidden = true
            btn.alpha = 0
            btn.isSelected = false
            
        }
        delayOnMainThread(seconds: 0.25, action: {
            for btn in self.entrantTypes {
                UIView.animate(withDuration: 0.2) {
                    btn.alpha = 1
                }
            }
        })
        
        button.isSelected = true
        
        switch button {
        case guestBtn:
            entrantTypes[0].setTitle(EntrantType.guestFreeChild.rawValue, for: .normal)
            entrantTypes[0].isHidden = false
            entrantTypes[1].setTitle(EntrantType.guestVIP.rawValue, for: .normal)
            entrantTypes[1].isHidden = false
            entrantTypes[2].setTitle(EntrantType.seniorGuest.rawValue, for: .normal)
            entrantTypes[2].isHidden = false
            entrantTypes[3].setTitle(EntrantType.guestClassic.rawValue, for: .normal)
            entrantTypes[3].isHidden = false
            entrantTypes[4].setTitle(EntrantType.guestSeasonPass.rawValue, for: .normal)
            entrantTypes[4].isHidden = false
            entrantTypes[5].isHidden = true
        case employeeBtn:
            entrantTypes[0].isHidden = false
            entrantTypes[0].setTitle(EntrantType.employeeFoodService.rawValue, for: .normal)
            entrantTypes[1].isHidden = false
            entrantTypes[1].setTitle(EntrantType.employeeRideService.rawValue, for: .normal)
            entrantTypes[2].isHidden = false
            entrantTypes[2].setTitle(EntrantType.employeeMaintenance.rawValue, for: .normal)
            entrantTypes[3].isHidden = false
            entrantTypes[3].setTitle(EntrantType.employeeContract.rawValue, for: .normal)
            entrantTypes[4].isHidden = true
            entrantTypes[5].isHidden = true
        case managerBtn:
            entrantTypes[0].isHidden = false
            entrantTypes[0].setTitle(EntrantType.managerGeneral.rawValue, for: .normal)
            entrantTypes[1].isHidden = false
            entrantTypes[1].setTitle(EntrantType.managerShift.rawValue, for: .normal)
            entrantTypes[2].isHidden = false
            entrantTypes[2].setTitle(EntrantType.managerSenior.rawValue, for: .normal)
            entrantTypes[3].isHidden = true
            entrantTypes[4].isHidden = true
            entrantTypes[5].isHidden = true
        case vendorBtn:
            entrantTypes[0].isHidden = false
            entrantTypes[0].setTitle(EntrantType.vendor.rawValue, for: .normal)
            entrantTypes[1].isHidden = true
            entrantTypes[2].isHidden = true
            entrantTypes[3].isHidden = true
            entrantTypes[4].isHidden = true
            entrantTypes[5].isHidden = true
        default:
            print("Something is wrong!")
        }
    }
    
    @IBAction func entrantSelect(_ sender: UIButton) {
        
        let button = sender
    
        //enable all textfields
        for label in entranInfoLabelTexts {
            label.isEnabled = true
            label.backgroundColor = UIColor.white
        }
        
        //deselect all and set current button active
        for btn in entrantTypes { btn.isSelected = false }
        button.isSelected = true
        
        
        // Get the current entranttype. Wrap by force because its 101% sure that the titlelabel text has entranttypes raw values
        let entrantType : EntrantType = EntrantType(rawValue: (button.titleLabel?.text)!)!
        currentEntrant = entrantType
        
        // If entrant is not an contract Employee, hide the project number label
        if entrantType != .employeeContract {
            projectTextField.backgroundColor = UIColor.lightGray
            projectTextField.isEnabled = false
        }
        // If entrant is not an Vendor, hide the Company name
        if entrantType != .vendor {
            companyNameTextField.backgroundColor = UIColor.lightGray
            companyNameTextField.isEnabled = false
        }
    }
    
    
    /// Adds delay
    func delayOnMainThread(seconds: Double, action:(() -> ())!) {
        
        let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64( seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            action()
        })
        
        let queue = DispatchQueue(label: "com.test.myqueue")
        queue.async {}
    }
}








