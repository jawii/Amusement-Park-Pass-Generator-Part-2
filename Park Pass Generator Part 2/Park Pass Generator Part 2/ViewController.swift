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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "passGenerator" {
            let controller = segue.destination as! PassGeneratorViewController
            controller.entrant = sender as? Entrant
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
        
        
        // Try to form date from dateOfBirthTextField.
        var finalBirthDate: Date? = nil
        let birthDateString = dateOfBirthTextField.text
        // Skip if empty string
        if birthDateString != "" {
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "fi")
            dateFormatter.dateFormat = "MM-dd-yyyy"
            
            guard let birthdayDate = dateFormatter.date(from:birthDateString!) else{
                Alert.showBasic(title: "Date format error", message: "Please give date of birth in format MM-DD-YYYY", vc: self)
                return
            }
            
            finalBirthDate = birthdayDate
        }
        
        // Check that rest is ok
        if !isUserInputValid() {
            return
        }
        
        let entrantInformation = EntrantInformation(firstName: firstNameTextField.text, lastName: lastNameTextField.text, streetAddress: streetAddressTextField.text, city: cityNameTextField.text, state: stateNameTextField.text, zipCode: zipCodeTextField.text, dateOfBirth: finalBirthDate, socialSecurityNumber: ssnTextField.text, projectNumber: projectTextField.text, companyName: companyNameTextField.text)
        
        
        //create entrant
        var entrantObject: Entrant?
        //let currentEntrantType = currentEntrant as EntrantType!
        
        if currentEntrant == .guestFreeChild {
            entrantObject = try! GuestFreeChild(entrantInformation: entrantInformation)
        } else if currentEntrant == .guestClassic  {
            entrantObject = try! Guest(entrantInformation: entrantInformation)
        } else if currentEntrant == .guestVIP {
            entrantObject = try! GuestVIP(entrantInformation: entrantInformation)
        } else if currentEntrant == .guestSeasonPass {
            entrantObject = try! GuestSeasonPass(entrantInformation: entrantInformation)
        } else if currentEntrant == .seniorGuest {
            entrantObject = try! GuestSenior(entrantInformation: entrantInformation)
        } else if currentEntrant == .employeeContract {
            entrantObject = try! EmployeeContract(entrantInformation: entrantInformation)
        } else if currentEntrant == .employeeFoodService {
            entrantObject = try! EmployeeHourlyFoodServices(entrantInformation: entrantInformation)
        } else if currentEntrant == .employeeRideService {
            entrantObject = try! EmployeeHourlyRideServices(entrantInformation: entrantInformation)
        } else if currentEntrant == .employeeMaintenance {
            entrantObject = try! EmployeeHourlyMaintenance(entrantInformation: entrantInformation)
        } else if currentEntrant == .managerShift {
            entrantObject = try! ManagerShift(entrantInformation: entrantInformation)
        } else if currentEntrant == .managerGeneral {
            entrantObject = try! ManagerGeneral(entrantInformation: entrantInformation)
        } else if currentEntrant == .managerSenior {
            entrantObject = try! ManagerSenior(entrantInformation: entrantInformation)
        } else if currentEntrant == .vendor {
            entrantObject = try! Vendor(entrantInformation: entrantInformation)
        } else {
            return
        }
        
        self.performSegue(withIdentifier: "passGenerator", sender: entrantObject)
    }
    
    /// Populate data button
    @IBAction func populateData(_ sender: UIButton) {
        if currentEntrant == nil {
            return
        }
        POPULATEDATAS(with: currentEntrant!, labels: entranInfoLabelTexts)
    }
    
    /// Set ups the entrant buttons
    @IBAction func mainEntrantSelect(_ sender: UIButton){
        
        currentEntrant = nil
        
        //clear info labels
        clearInfoLabels()
        //disable all textfields
        for label in entranInfoLabelTexts {
            label.isEnabled = false
            label.backgroundColor = UIColor.lightGray
        }
        
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
        // Add delay so that button reordering wont show
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
        
        clearInfoLabels()
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
        // If its a crash, it's a bug :)
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
    
    /// Clear textFields
    func clearInfoLabels() {
        for label in entranInfoLabelTexts {
            label.text = ""
        }
    }
    
    /// Checks the user inputs. Returns true if all ok
    func isUserInputValid() -> Bool{
        
        //check SSN contains 9 digits. (wikipedia)
        let ssnString = ssnTextField.text?.replacingOccurrences(of: "-", with: "")
        
        if (ssnString?.count)! > 1 {
            if let ssnString = ssnString {
                if ssnString.count != 9 {
                    Alert.showBasic(title: "Invalid SSN", message: "Please give Social Security Number in format ###-##-####", vc: self)
                    return false
                }
            }
        }
        // Check Projectnumber
        if (projectTextField.text?.count)! > 1 {
            guard Int(projectTextField.text!) != nil else {
                Alert.showBasic(title: "Invalid Project Number", message: "Project number is not an number", vc: self)
                return false
            }
        }
        
        // Check zipcode
        if (zipCodeTextField.text?.count)! > 1 {
            guard Int(zipCodeTextField.text!) != nil else {
                Alert.showBasic(title: "Invalid Zip Code", message: "Zip Code number is not an number", vc: self)
                return false
            }
        }
        
        //check that input lengths are not over 20 characters
        for label in entranInfoLabelTexts {
            if (label.text?.count)! > 20 {
                Alert.showBasic(title: "Too long inputs", message: "Please shorten each input for pass. (Less than 20 characters).", vc: self)
                return false
            }
        }
        return true
        
        
    }
}








